#let chapter(
  title: none,
  outside: false,
  doc,
) = {
  set page(
    header: context {
      // here()
      let headings = query(selector(heading.where(level: 1)).after(here()))
      if headings.len() > 0 {
        let heading = headings.first()
        let h_loc = heading.location().page()
        if (h_loc == here().page()) {
          // no-op
        } else {
          box(
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
        }
      }
    },
  )


  v(15%)

  let chapter_i = counter("chapter")
  chapter_i.step()
  align(right)[
    #block()[
      #text(size: 120pt, font: "Nimbus Sans", weight: "bold", fill: rgb("#b3b3b3"))[
        #context chapter_i.display("1")
      ]
    ]
  ]

  [
    #heading[#title]
    #if outside { label("outside") } else [#none]
  ]

  v(3em)

  doc
}
