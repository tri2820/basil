#import "toc.typ": toc

#let conf(
  title: none,
  subtitle: none,
  department: none,
  supervisors: none,
  author: (),
  abstract: [],
  hand_in_date: none,
  chapters: (),
  doc,
) = {
  set page(paper: "a4")


  show heading.where(level: 1): it => [
    #set align(right)
    #set text(13pt, weight: "regular")
    #set text(size: 20pt, font: "Nimbus Sans")
    *#it.body*
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
  v(15%)
  [= Abstract <outside>]
  v(3em)
  abstract
  pagebreak()

  // Table of Contents
  toc()
  pagebreak()


  set par(justify: true)
  set heading(numbering: "1.1")
  set page(numbering: none)
  counter(page).update(1)

  for (i, chapter) in chapters.enumerate() {
    include (chapter)
  }

  doc
}