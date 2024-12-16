#let conf(
  title: none,
  author: (),
  abstract: [],
  hand_in_date: none,
  doc,
) = {
  set page(paper: "a4")

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

  heading(outlined: false)[Abstract]
  abstract
  pagebreak()
  // </Abstract>


  // <Table of Contents>

  // heading[
  //   Table of Contents
  // ]

  // context {
  //   let chapters = query(
  //     heading.where(
  //       // level: 1,
  //       outlined: true,
  //     ),
  //   )

  //   for (i, chapter) in chapters.enumerate() {
  //     let loc = chapter.location()
  //     let p = loc.page-numbering()


  //     let fill = box(width: 1fr, repeat[.])
  //     if not p == none {
  //       let nr = numbering(
  //         p,
  //         ..counter(page).at(loc),
  //       )
  //       // [#chapter.body #h(1fr) #nr \ ]
  //       // [#chapter. #chapter.body #fill #nr \ ]
  //       [[ #chapter.fields() ] #chapter.body #fill #nr \ ]
  //       // type(chapter)
  //     }
  //   }
  // }
  //


  let fill = box(width: 1fr, repeat[.])
  let tab = "\t"
  show outline.entry: it => {
    if it.level == 1 {
      v(10pt)
      text(size: 14pt)[*#it.body.children.at(0) #h(0.5em) #tab #it.body.children.at(2) #h(1fr) #it.page*]
    } else {
      text(size: 12pt)[#it.body.children.at(0) #h(0.5em) #tab #it.body.children.at(2) #fill #it.page]
    }
  }
  outline(title: "Table of Contents", indent: n => [#h(1.5em) #tab #tab #tab])

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

  // counter(page).update(1)
  // set page(numbering: "1")
  set par(justify: true)


  set heading(numbering: "1.1")

  doc
}