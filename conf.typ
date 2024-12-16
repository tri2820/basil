#let conf(
  title: none,
  author: (),
  abstract: [],
  hand_in_date: none,
  doc,
) = {
  set page(paper: "a4")
  set page(numbering: "i")

  show heading.where(level: 1): it => [
    #set align(right)
    #set text(13pt, weight: "regular")
    #set text(size: 20pt, font: "Nimbus Sans")
    *#it.body*
  ]


  // <Cover page>
  place(
    left + top,
    image("./images/unibas.svg", width: 140pt),
  )


  [
    #set align(center)
    #align(horizon)[
      #text(size: 26pt, font: "Nimbus Sans", [*#title*])
    ]

    Scientific Writing Seminar Final Paper

    #v(80pt)


    Natural Science Faculty of the University of Basel \
    Department of Mathematics and Computer Sciences

    #v(30pt)

    Examiner: Prof. Dr. Craig Hamilton \
    Supervisor: Dr. Tanja Schindler

    #v(30pt)

    #author.name \
    #link("mailto:" + author.email) \
    #author.matriculation_number \

    #align(bottom)[
      #hand_in_date
    ]
  ]

  pagebreak()
  // </Cover Page>


  // <Abstract>

  [= Abstract <outside>]
  abstract
  pagebreak()
  // </Abstract>


  // <Table of Contents>
  context {
    let outsides = query(<outside>)


    let fill = box(width: 1fr, repeat[.])
    let tab = "\t"
    show outline.entry: it => {
      let ignore = it.element in outsides
      if it.level == 1 {
        v(10pt)
      }

      set text(size: 14pt) if it.level == 1

      let page = it.page
      if it.body.has("children") {
        let maybe_heading_i = if ignore [#h(0.5em) #tab] else [#it.body.children.at(0)]

        if it.level == 1 [* #maybe_heading_i #h(0.5em) #tab #it.body.children.at(2) #h(1fr) #page*] else [#maybe_heading_i #h(0.5em) #tab #it.body.children.at(2) #fill #page]
      } else [*#h(1.5em) #it.body #h(1fr) #it.page*]
    }
    outline(title: "Table of Contents", indent: n => [#h(1.5em) #tab #tab #tab])
  }
  // </Table of Contents>


  set page(header: context [
    #box(
      stroke: (
        bottom: black,
      ),
      inset: (
        bottom: 6pt,
      ),
    )[
      #title
      #h(1fr)
      #counter(page).display()
    ]
  ])


  set par(justify: true)
  set heading(numbering: "1.1")
  set page(numbering: "1")
  counter(page).update(1)


  doc
}