#import "toc.typ": toc

#let template(
  title: none,
  subtitle: none,
  department: none,
  supervisors: none,
  author: (),
  abstract: none,
  hand_in_date: none,
  chapters: (),
  doc,
) = {
  set page(paper: "a4")


  show heading.where(level: 1): it => [
    #set align(right)
    #set text(size: 20pt, font: "Nimbus Sans")
    #block(below: 2.5em)[
      *#it.body*
    ]
  ]


  show heading.where(level: 2): it => [
    #set text(size: 14pt, font: "Nimbus Sans")
    #block(below: 1em, above: 2.5em)[
      *#it*
    ]
  ]

  show heading.where(level: 3): it => [
    #set text(size: 10pt, font: "Nimbus Sans")
    #block(below: 1em, above: 2.5em)[
      *#it*
    ]
  ]


  // Cover
  place(
    left + top,
    image("./images/unibas.svg", width: 140pt),
  )
  [
    #set align(center)
    #align(horizon)[
      #text(size: 26pt, font: "Nimbus Sans", [*#title*])
    ]

    #subtitle
    #v(80pt)


    #department
    #v(30pt)

    #supervisors
    #v(30pt)

    #author.name \
    #link("mailto:" + author.email) \
    #author.matriculation_number \

    #align(bottom)[
      #hand_in_date
    ]
  ]

  pagebreak()


  // Abstract
  set page(numbering: "i")
  v(110pt)
  include (abstract)
  pagebreak()

  // Table of Contents
  toc()
  pagebreak()

  set par(justify: true, leading: 0.85em, spacing: 2em)
  set heading(numbering: "1.1")

  show figure: it => [
    #show par: it => [
      #set align(left)
      #it
    ]
    #it
  ]

  show raw.where(block: true): code => {
    show raw.line: line => {
      text(fill: gray)[#line.number]
      h(1em)
      line.body
    }
    code
  }


  set page(numbering: none)
  counter(page).update(1)

  for (i, chapter) in chapters.enumerate() {
    include (chapter)
  }

  doc
}
