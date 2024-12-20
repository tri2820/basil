#import "../chapter.typ": chapter;

#show: chapter

= Evaluation
For evaluation, we developed a demo collaboration platform to test the sandbox model's security and performance, with screenshots provided in @fig-screenshots. This platform served as an experimental and controlled environment, allowing us to explore various sandbox configurations and assess their effectiveness in isolating application functionality. The platform hosts four distinct placeholder apps—Chat Hub, Project Management, Notes, and Whiteboard—each running on a different development port. The applications are simple but developed to demonstrate unique requirements of each business case, like drag-and-drop items in the Whiteboard app or typing in the Notes app. This diverse set of third-party apps demonstrates the platform's ability to cover all use cases and efficiently run multiple applications simultaneously using the sandbox model. The platform is hosted at #link("https://thirdcloud.org") to replicate the environment of real-world platforms.

#figure(
  grid(
    columns: 2, // 2 means 2 auto-sized columns
    gutter: 2mm, // space between columns
    image("../images/fig_demo_platform_a.png"),
    image("../images/fig_demo_platform_b.png")
  ),
  caption: "Demonstration of the platform, where the sandbox model effectively isolates third-party applications. The currently displayed application, built using the React + Vite template, is fully interactive, with animations and static assets loading correctly.",
) <fig-screenshots>

By introducing the distortion rules and requesting resources from within the sandbox, we successfully achieved the intended result of catching and preventing all illegal invocations. Testing various interactions—such as button clicks, keyboard inputs, popup open/close actions, and browser alerts—revealed that the safeguarding mechanisms do not interfere with the rendering engine or interactions with the app. Additionally, all static assets, such as image files, work surprisingly well out-of-the-box. This is a free consequence of the development server loading them as ES modules, which the sandbox supports, and the sandbox being able to map the fetch request to the correct port. These results demonstrate the platform's potential to effectively support large-scale, production-ready applications that utilize a diverse set of web APIs.

We have also successfully loaded all four apps to the platform at the same time. The sandbox running on a production domain does not pose any challenge in loading the development ports, except in the case of Brave Browser #footnote("https://brave.com"), where the Brave Shield feature has to be disabled to communicate with localhost. The platform supports Hot Module Replacement, with real-time updates during development without full page reload.

Despite these strengths, the platform exhibits a notable limitation in its initial load time. During the first load, the application experiences a delay of approximately 5 to 10 seconds. This delay is primarily caused by the overhead associated with fetching large libraries and converting source code into Secure ECMAScript (SES)-compatible modules. Consequently, the platform becomes totally unresponsive to user interactions, such as mouse clicks or keyboard input, during this period.

In summary, the sandbox model effectively isolates the application’s functionality, limiting its access to a predefined subset of the platform's resources. Further research and optimization are required to improve the platform's performance, particularly in terms of load time. This also points to the need for more control over the runtime configuration of third-party applications (e.g., maximum stack size, RAM, CPU allocation).
