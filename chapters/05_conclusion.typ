#import "../chapter.typ": chapter;
#show: chapter

= Conclusion
In conclusion, the sandbox implementation has successfully met its objectives. We have demonstrated the platform’s ability to isolate third-party applications while supporting the efficient execution of complex applications. This is all done while providing third-party developers with first-class support for their preferred frameworks.

Nevertheless, several areas present opportunities for improvement. One challenge is the caching of large libraries, such as React, which are shared across multiple applications. Implementing a caching strategy could significantly reduce load times and enhance overall performance. On top of that, we could accelerate the SES module transformation process by offloading it to a separate thread, further improving load time.

Looking ahead, future work on benchmarking is essential. While initial tests using manual interactions show promising results, establishing clear benchmarks—such as frames per second (FPS) for rendering or the number of iterations for data processing—would provide a more objective basis for assessing performance and pinpointing areas for further optimization. We also plan to explore security from a new angle by revisiting the integration of WebAssembly with Membrane. This approach could help address WebAssembly’s current limitation regarding direct DOM access. Finally, we aim to expand the scope of our security measures by defining precise data models, role-based access policies, and user consent prompts—allowing users to make well-informed decisions.

As we move forward, the sandbox model will continue to evolve, adapting to the changing needs of both platform & third-party developers.
