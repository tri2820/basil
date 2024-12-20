#import "../chapter.typ": chapter;

#show: chapter

= Implementation

== Model Overview

In our model, each third-party app corresponds 1:1 to a dedicated sandbox, making it particularly well-suited for collaboration platforms where users can have multiple apps running simultaneously. Each sandbox is an isolated environment that limits the third-party app to a controlled subset of sensitive resources. These resources can be owned by the browser (e.g., the DOM, web APIs like camera, cookies, and network), the business (e.g., proprietary data), or the platform itself. Access to these resources is governed by the sandbox's permissions, which are granted by the platform, IT administrators, or end users. Resource access is transparent to the platform, which can revoke permissions at any time, and usage can be introspected. The sandbox model is illustrated in @fig-sandbox.

#figure(
  image("../images/fig_sandbox.svg", width: 80%),
  caption: [
    Isolating third-party apps within a sandbox with controlled access to platform resources. Third-party code with potential harm is safely contained within the sandbox.
  ],
) <fig-sandbox>

The sandbox also distorts the functionality of several web APIs to enhance security and improve the development experience through isomorphism. For example, the JavaScript code snippet shown in @fig-distorted-web-apis appears similar to that of a normal web app, but behaves differently within the sandbox:

#figure(
  kind: "snippet",
  supplement: "Snippet",
  box(
    stroke: (
      top: 0.1mm,
      bottom: 0.1mm,
    ),
    inset: 1em,
    raw(
      block: true,
      "// fetch is distorted to automatically checks the domain against a whitelist
const response = await fetch('https://example.com/api/reservations')
const data = await response.json()
// localStorage.setItem is distorted to prevent storing the data
// forwarding it instead to a separate data store
// Each app then has a non-conflicting, isolated data store
localStorage.setItem('data', JSON.stringify(data))
// getElementById is distorted to query only elements
// under a specific DOM node granted to the sandbox
const element = document.getElementById('app')
// element.innerHTML is distorted to sanitize the HTML before setting
element.innerHTML = JSON.stringify(data)",
      lang: "javascript",
    ),
  ),
  caption: [
    Example of how web APIs are distorted within the sandbox to prevent dangerous dynamic content, isolate apps from each other, and prevent UI style leaks.
  ],
) <fig-distorted-web-apis>

The list of distortions is not exhaustive and will be expanded as new web APIs emerge. Since automatically introducing an undistorted API could pose a security risk, each version of the sandbox maintains a list of supported APIs and only exposes those to the third-party app.

== Technologies Used

Under the hood, the sandbox treats each app as a collection of HTML, CSS, and JavaScript files, each with its own security requirements. This is illustrated in @fig-implementation. Several different technologies are combined to achieve the desired sandboxing functionality.

#figure(
  image("../images/fig_sandbox_implementation.svg", width: 80%),
  caption: [
    Technologies used for each component of the sandbox model. HTML, CSS, and JavaScript are stored within the sandbox (inside the membrane) and secured using Shadow DOM and Secure ECMAScript. Access to sensitive resources (outside the membrane) is safeguarded using distortion techniques.
  ],
) <fig-implementation>

=== For HTML and CSS
For HTML and CSS, Shadow DOM@Krause2021 is used to prevent style leakage from the app to the platform. Shadow DOM is a browser-native feature that facilitates the creation of an isolated UI environment for each app, as seen in Web Components@10_1007_3_540_47961_9_5. Each sandbox has access to a shadow root node that it fully controls. Necessary distortions are implemented to prevent querying elements outside the shadow root (e.g., via #raw("shadowRoot.ownerDocument")).

=== For JavaScript

For JavaScript, the sandbox utilizes the Secure ECMAScript (SES) library by EndoJS@endojs to secure global prototypes, preventing prototype pollution attacks. SES creates a compartment where access to web APIs is disabled by default, with access only granted through explicit endowments. Unlike iframes or Web Workers, SES does not require a separate thread to execute code. Instead, the code runs within the same main thread as the platform, offering improved efficiency by avoiding communication overhead and enabling shared object address space.

=== For Resource Access

To enable granting and revoking access to resources, as well as applying distortions, the sandbox employs the Membrane defensive programming pattern@jaradin2005capability. The Membrane pattern is simpler than other capability-based security measures, automatically scales to cover all web APIs via deep annotation, while remains theoretically secure@Gorla_2005. When implemented in JavaScript, the pattern leverages ES6 proxies@ecma262_2020: by exposing only the proxy instead of the underlying resource object, the sandbox can distort certain operations on the object through the proxy's handler. Any object returned as a result of these operations is also wrapped in a proxy@keil2015transparentobjectproxiesjavascript.

== Improved Developer Workflow

We aim to provide a developer experience that closely resembles working with a typical web app. To achieve this, the sandbox takes additional steps to ensure a seamless workflow:

1. Rather than requiring a manifest file to define entry points, the index HTML file is parsed to identify them. Once the entry points are obtained, external files are fetched, while inline CSS and JavaScript are sanitized and evaluated.

2. Dynamic imports and ES modules@ecma262_2020 are supported, as they are the primary mechanisms for development servers (e.g., Vite) to load and replace code, such as through Hot Module Replacement (HMR). Since JavaScript dynamic imports are part of the ECMAScript Language specification@ecma262_2020, their implementation involves analyzing the source code and replacing the `import` statement with a function call#footnote[The distortion mechanism only works on resources, such as web APIs, and not on language features. Modifying language features requires altering the source code before importing it into the sandbox.]. This function fetches the file and returns an ES module object.

As a result, the developer experience remains nearly identical to that of a traditional web application. Developers can use familiar tools and frameworks, without any modification, and can load the application directly into the sandbox from the local environment via localhost ports. All safeguard mechanisms are abstracted from the codebase.

== Workaround for SES Limitations

At the time of writing, there are several key issues with SES that we have encountered and implemented workarounds for. These issues have been reported to the SES repository and are expected to be resolved in future versions of the library. Currently, the versions that we are using are `ses@1.9.1` and `@endo/module-source@1.1.2`. Since SES is still actively evolving and may not be fully stable, this section highlights common pitfalls encountered when implementing a sandbox model with SES, along with the workarounds we've applied to address them downstream.

Our workarounds are integrated into the sandbox's transform and sanitization process, which occurs before the code is executed within the SES compartment. Notably, this may reduce the security guarantees provided by SES, as SES itself does not rely on the parser’s correctness. However, this approach allows us to implement a functional sandbox while keeping the attack surface to a minimum.

The issues and corresponding workarounds are as follows:

1. _Assigning to Empty Objects Error_: The creation of an empty object using the syntax `{}` results in an object with the prototype `Object.prototype` instead of `null`. This is considered a security risk as it allows for prototype pollution attacks. By default, SES hardens the Object prototype, so attempting to assign fields to the prototype of objects results in an exception. The official response from the SES team is that this is a known issue#footnote("https://github.com/endojs/endo/discussions/1855") and a fundamental flaw in JavaScript itself, not SES. SES advises developers to flag libraries with this issue and work with the library maintainers to make their code more secure. Since a sandbox aims to be developer-friendly, we could not expect developers to address this issue directly. Therefore, we implemented a workaround to automatically replace all instances of `{}` with `Object.create(null)`.

2. _Babel Transformation Errors_: This issue relates to SES’s inability to process default destructuring syntax#footnote("https://github.com/endojs/endo/issues/2633") and `import.meta._`#footnote("https://github.com/endojs/endo/issues/2649"). We implemented a workaround to replace all instances of default destructuring with the equivalent syntax and to replace all instances of `import.meta._` with a function call to obtain the correct value.

3. _HTML Comments_: Due to the similarity between the syntax of HTML comments and the JavaScript syntax `<!--`, SES uses special regular expressions to distinguish them#footnote("https://github.com/endojs/endo/blob/master/packages/ses/error-codes/SES_HTML_COMMENT_REJECTED.md"). This feature however is not supported when evaluating ES Module code. Our sandbox relied heavily on loading the modules to support hot module reloading during the third-party app development workflow. As a result, we had to move this component downstream and modify it to meet our needs.

As mentioned, while these workarounds are practical, they do lower the security guarantees. We are mindful of this and are looking forward to the SES team resolving these issues in future releases.
