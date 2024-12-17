#import "../chapter.typ": chapter;

#show: chapter

= Introduction

#lorem(50)


#figure(
  image("../images/fig_data_silos.svg", width: 60%),
  caption: [
    The Marketing department struggles to combine three different data sources for a new advertising campaign
  ],
)

#lorem(50)


#show table.cell.where(y: 0): strong
#text(font: "Nimbus Sans")[
  #table(
    columns: 4,
    fill: (_, y) => if y == 0 { rgb("D9D9D9") },
    table.header[Platform][Supported][Deep Integration][Can be Developed with a Niche Framework],
    [ClickUp], [No], [No], [Does not Appy],
    [Monday.com], [No], [No], [Does not Appy],
    [Lark], [No], [No], [Does not Appy],
    [Asana], [No], [No], [Does not Appy],
    [Salesforce Lightning Platform], [No], [No], [Does not Appy],
    // ... the remaining cells
  )


]
== Background
#lorem(200)

== Problem Statement
#lorem(200)

== Objectives and Contributions
#lorem(200)
