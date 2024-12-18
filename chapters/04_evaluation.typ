#import "../chapter.typ": chapter;

#show: chapter

= Evaluation
We developed a demonstration collaboration platform to evaluate the performance and security of the sandbox model. This platform served as an experimental environment, enabling us to test various sandbox configurations and assess their effectiveness in isolating application functionality within a controlled and secure framework.

The platform successfully supports loading large-scale applications that utilize a diverse set of web APIs. The sandbox model ensures effective isolation of the application’s functionality, limiting its access to a predefined subset of the platform's resources.

#figure(
  grid(
    columns: 2, // 2 means 2 auto-sized columns
    gutter: 2mm, // space between columns
    image("../images/fig_demo_platform_a.png"),
    image("../images/fig_demo_platform_b.png")
  ),
  caption: "Demo platform, with the sandbox model successfully isolates third-party applications",
)

The platform, hosted at #link("https://thirdcloud.org"), includes the following features:

- *Development Port Communication*: The platform sucessfully communicates with the development server running on #link("localhost:3000").
- *Universal Framework Compatibility*: It is fully compatible with modern frontend development tools, such as Vite + React template.
- *Hot Module Replacement (HMR)*: The platform supports Hot Module Replacement, allowing for real-time updates during development without requiring full page reloads.
- *Multi-Application Support*: The platform enables the simultaneous execution of multiple applications within distinct sandboxed environments.
- *Security Safeguards*: The platform successfully secures dangerous browser APIs. All APIs tested were successfully distorted.

Despite these strengths, the platform exhibits a notable limitation in its initial load time. During the first load, the application experiences a delay of approximately 5 to 10 seconds. This delay is primarily caused by the overhead associated with fetching large libraries and converting source code into Secure ECMAScript (SES)-compatible modules. Consequently, the platform becomes unresponsive to user interactions, such as mouse clicks or keyboard input, during this period.

Further research and optimization are required to improve the platform's performance, particularly in terms of load time. This also points to the need for more control over the runtime configuration of third-party applications (e.g., maximum stack size, RAM, CPU allocation).


// == Performance
// <TODO>
