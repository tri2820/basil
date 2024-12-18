#import "../chapter.typ": chapter;

#show: chapter

= Implementation

== Model Overview

Each sandbox is an isolated environment that limits third-party apps to a controlled subset of sensitive resources. These resources are owned by the browser (e.g., the DOM, web APIs like camera, cookies, and network), the business (e.g., proprietary data), or the platform itself. Access to these resources is governed by the sandbox's permissions, which are granted by the platform, IT administrators, or end users. Resource usage is transparent to the platform, which can introspect or revoke access at any time.

A platform can run multiple sandboxes simultaneously, each with its own set of resources and policies. This model is particularly well-suited for collaboration platforms, where each instance of a third-party app operates within its own sandbox.

#figure(
  image("../images/fig_sandbox.svg", width: 80%),
  caption: [
    Isolating third-party apps within a sandbox, with controlled access to platform resources.
  ],
)

The sandbox also distorts the functionality of several web APIs to enhance security and improve the development experience through isomorphism. For example, the following JavaScript code snippet appears similar to that of a normal web app, but behaves differently within the sandbox:


#raw(
  "
// fetch is distorted to automatically checks the domain against a whitelist
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
element.innerHTML = JSON.stringify(data)
",
  lang: "javascript",
)

The list of distortions is not exhaustive and will be expanded as new web APIs emerge. Since automatically introducing an undistorted API could pose a security risk, each version of the sandbox maintains a list of supported APIs and only exposes those to the third-party app.

== Technolgies Used

Under the hood, the sandbox treats each app as a collection of HTML, CSS, and JavaScript files, each with its own security requirements. Several different technologies are combined to achieve the desired sandboxing functionality.

#figure(
  image("../images/fig_sandbox_implementation.svg", width: 80%),
  caption: [
    Technologies corresponding to each part of the sandbox model.
  ],
)

=== For HTML and CSS
For HTML and CSS, Shadow DOM @Krause2021 is used to prevent style leakage from the app to the platform. Shadow DOM is a browser-native feature that allows the creation of an isolated UI environment for each app, as also used by Web Components @10_1007_3_540_47961_9_5. Each sandbox has access to a shadow root node that it fully controls. Necessary distortions are implemented to stop querying elements outside the shadow root (e.g., via `shadowRoot.ownerDocument`).

=== For JavaScript

For JavaScript, the sandbox uses the Secure ECMAScript (SES) library by EndoJS @endojs to lock down global prototypes (preventing prototype pollution attacks) and create a compartment where access to web APIs is disabled by default and can only be enabled via endowments. Unlike iframes or Web Workers, SES does not require a separate thread to run the code. Instead, the code runs in the same main thread as the platform, making it more efficient and avoiding communication overhead while allowing shared object address space.

=== For Resource Access

To enable granting and revoking access to resources, as well as applying distortions, the sandbox uses the Membrane defensive programming pattern @jaradin2005capability. The Membrane pattern is simpler than other capability-based security measures, automatically covers all web APIs via deep annotation, and remains theoretically secure @Gorla_2005. When implemented in JavaScript, the pattern leverages ES6 proxies: by exposing only the proxy instead of the underlying resource object, the sandbox can distort certain operations on the object through the proxy's handler. Any object returned as a result of these operations is also wrapped in a proxy @keil2015transparentobjectproxiesjavascript.

== Developer Experience

We aim to deliver a developer experience that closely resembles a typical web app. To this end, the sandbox takes further steps to ensure a seamless workflow:

- Instead of requiring a manifest file to define which entry points to load, the index HTML file is parsed to find entry points. This means external files are fetched, while inline CSS and JS are sanitized and evaluated.

- Dynamic imports and ES modules are supported, as they are the primary mechanism for development servers (e.g., Vite) to load and replace code (e.g., hot module replacement, or HMR). Since JavaScript dynamic imports are part of the JavaScript specification (not a web API), this is implemented by analyzing the source code and replacing the import statement with a function call. This function fetches the file and returns an ES module object.

As a result, the developer experience is virtually identical to that of a normal web app. Developers can utilize familiar tools and frameworks without modification and can seamlessly open a localhost development port, enabling the platform to load the application directly from the local environment.
