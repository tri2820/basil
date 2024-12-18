#import "../chapter.typ": chapter;

#show: chapter

= Introduction
One of the most pervasive challenges faced by organizations is the existence of data silos—disconnected, fragmented pockets of information that reside in isolated platforms or applications. Data silos present significant challenges for knowledge workers, who often find themselves navigating a maze of isolated data sets, each requiring manual coordination between teams.


#figure(
  image("../images/fig_data_silos.svg", width: 60%),
  caption: [
    The Marketing Department struggles to combine three different data sources for a new advertising campaign.
  ],
)

To illustrate the impact of data silos, consider a typical scenario within an organization. The Marketing Department may want to launch a new advertising campaign but only has access to Google Analytics, a tool that provides user behavior data. To obtain a broader understanding of customer profiles and the issues customers are facing, they must contact the Sales and Customer Service departments—each of which stores its data on different platforms. The result is a cumbersome process of collecting and consolidating data from three different sources—a process fraught with delays and coordination challenges.

This has led to many organizations turning to _collaboration platforms_ as a lightweight and user-friendly approach to solving the data silos problem.

== Background

Collaboration platforms bring together a suite of tools—such as messaging apps, project management tools, wikis, meeting schedulers, and CRMs—into a unified space. This integration makes it easier for teams to share and access the data they need without navigating multiple systems or encountering fragmentation.

Many collaboration platforms, in order to cover a wide range of business use cases, invite third-party developers to build and integrate their applications into the platform. However, due to the difficulty of implementing a properly secure sandbox system, these platforms often resort to restricting third-party app functionalities instead. As a result, these apps typically store core logic and data outside the platform, have limited control over the platform's user interface (UI), and require developers to learn niche, platform-specific frameworks.

Thus, these apps neither extend the platform's functionalities in a meaningful way nor are they easy to develop.

#show table.cell.where(y: 0): it => [
  // #set text(font: "Nimbus Sans")
  #it
]

#figure(
  par(justify: false)[
    #table(
      columns: 4,
      fill: (_, y) => if y == 0 { rgb("D9D9D9") },
      table.header[Platform][Third-Party Data Integration Capability][UI Customization][Platform-agnostic Development Framework],

      [Lark], [Low], [Limited (pre-made blocks)], [No],
      [ClickUp], [Moderate], [No customization], [Yes (via API calls)],
      [Monday.com], [Moderate], [Limited (pre-made blocks)], [Yes (via API calls)],
      [Asana], [High (via Work Graph\u{00AE})], [Limited (pre-made blocks)], [No],
      [Salesforce], [High (via Standard Objects)], [Full customization], [No],
    )
  ],
  caption: [
    Overview of third-party app support across collaboration platforms.
  ],
)


== Objectives

The primary objective of this work is to develop a secure, browser-based sandbox solution that addresses the challenges of integrating third-party apps within collaboration platforms. The lack of existing solutions creates a significant barrier for platform developers seeking secure and flexible third-party app integration.

The sandbox model aims to achieve several key goals:

- *Protection of critical resources*: Any potentially harmful code is confined within a controlled environment, preventing third-party apps from executing unauthorized actions. Essential platform resources are protected from third-party code, ensuring system integrity.

- *Ease of third-party app development*: Supports universial frameworks like React, Angular, or Vue with development features like Hot Module Reload (HMR). The model is designed with data access and UI customization capabilities in mind.

- *Performance*: The sandbox does not degrade the platform and remains close to the performance of native, unsandboxed code.












