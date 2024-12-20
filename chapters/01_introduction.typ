#import "../chapter.typ": chapter;

#show: chapter

= Introduction

== Background
One of the most pervasive challenges faced by organizations is the existence of data silos—disconnected, fragmented pockets of information that reside in isolated platforms or applications. Data silos present significant challenges for knowledge workers, who often find themselves navigating a maze of isolated data sets, each requiring manual coordination between teams@Shahrokni2015BeyondIS.


#figure(
  image("../images/fig_data_silos.svg", width: 60%),
  caption: [
    The Marketing Department struggles to combine three different data sources for a new advertising campaign.
  ],
) <fig-marketing>

To illustrate the impact of data silos, consider a typical scenario within an organization, as shown in @fig-marketing. The Marketing Department may want to launch a new advertising campaign but only has access to Google Analytics, a tool that provides user behavior data. To obtain a broader understanding of customer profiles and the issues customers are facing, they must contact the Sales and Customer Service departments—each of which stores its data on different platforms. The result is a cumbersome process of collecting and consolidating data from three different sources—a process fraught with delays and coordination challenges.

This has led to many organizations turning to _collaboration platforms_ as a lightweight and user-friendly approach to solving the data silos problem. Collaboration platforms bring together a suite of tools—such as messaging app, project management tools, wiki, meeting scheduler, and CRM#footnote[Customer Relationship Management] software—into a unified space@Manko. This integration makes it easier for teams to share and access the data they need without navigating multiple systems or encountering fragmentation.

== Motivation

Many collaboration platforms, in order to address a wide range of business use cases, invite third-party developers to build and integrate their applications into the platform. However, due to high security requirements@7975779 and the challenges of implementing a robust sandbox system, these platforms often resort to restricting third-party app functionalities. As a result, these apps typically store core logic and data outside the platform, have limited control over the platform's UI#footnote[User Interface], and require developers to invest effort in learning niche, platform-specific frameworks. An overview is shown in @table-platforms. Data silos persist because data is still not centralized, but merely shared through APIs#footnote("Application Programming Interface"), which does not solve the problem of fragmented access.

Thus, these apps neither extend the platform's functionality in a meaningful way nor are they easy to develop. Implementing a sandbox system that satisfies both security and developer experience requirements would enable the platform to offer a more flexible runtime environment for third-party developers, which in turn would enhance its ability to solve the data silos problem.

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

      [Lark#footnote("https://larksuite.com")], [Low], [Limited (pre-made blocks)], [No],
      [ClickUp], [Moderate], [No customization], [Yes (via API calls)],
      [Monday.com], [Moderate], [Limited (pre-made blocks)], [Yes (via API calls)],
      [Asana#footnote("https://asana.com")], [High (via Work Graph\u{00AE})], [Limited (pre-made blocks)], [No],
      [Salesforce#footnote("https://salesforce.com")], [High (via Standard Objects)], [Full customization], [No],
    )
  ],
  caption: [
    Overview of third-party app support across collaboration platforms: Most platforms offer limited UI customization or require a specialized development framework.
  ],
) <table-platforms>


#heading(level: 2, "Objective & Key goals")

The primary objective of this work is to develop a secure, browser-based sandbox solution that addresses the challenges of integrating third-party apps within collaboration platforms. The lack of existing solutions presents a significant barrier for platform developers seeking secure and flexible third-party app integration. The sandbox model aims to achieve several key goals:

1. *Protection of critical resources*: Any potentially harmful code is confined within a controlled environment, preventing third-party apps from executing unauthorized actions. Essential platform resources are safeguarded from third-party code, ensuring system integrity.

2. *Ease of third-party app development*: The model supports universal frameworks like React, Angular, or Vue and includes development features such as HMR#footnote("Hot Module Reload"). It is designed with data access and UI customization capabilities in mind.

3. *Performance*: The sandbox does not degrade platform performance and remains close to the performance of native, unsandboxed code.














