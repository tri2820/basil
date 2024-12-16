#let toc() = {
  v(15%)

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
}