#import "../chapter.typ": chapter;
#show: chapter

= Discussion
The demonstration platform successfully isolates third-party applications, but there are key areas for improvement.

Firstly, one challenge is caching heavy libraries, such as React, shared among multiple apps. Implementing a caching strategy would reduce load times and improve overall performance. Additionally, the SES module transformation is currently slow. Offloading this task to a separate thread could speed up the process and reduce delays during the initial load.

Secondly, we plan to revisit integrating WebAssembly (WASM) with Membrane, which could help overcome WASM’s limitation of direct access to the DOM, enhancing its usability for more complex applications.

Thirdly, we aim to define precise data models and access policies. These policies will specify which resources third-party applications can access, with granular permissions based on the application’s role or the user’s consent. The platform will include UI prompts with visual indicators of the data being requested, enabling users to make informed decisions. This approach will ensure that only necessary resources are accessed while preventing unauthorized interactions or data leaks.

In summary, while the sandbox implementation is effective and meets the defined objectives, there remain opportunities to further enhance its performance, flexibility, and security.
