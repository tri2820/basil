#let toc() = {
  v(110pt)

  context {
    let outline-ignore-numbers = query(<outline-ignore-number>)

    let fill = box(width: 1fr, repeat[.])
    let tab = "\t"
    let last_level = state("last_level", 0)
    show outline.entry: it => context {
      last_level.update(_ => it.level)

      let ignore = it.element in outline-ignore-numbers

      // if it.level == 1 and not ignore { v(50pt) }
      set text(size: 14pt, weight: "bold") if it.level == 1
      let heading_i_or_ignored = if ignore [] else [#it.body.children.at(0)]
      let content = if ignore and not it.body.has("children") [#it.body] else [#it.body.children.at(2)]
      let filler = if ignore [#h(1fr)] else [#fill]
      let above = if it.level == 1 and last_level.get() >= 1 [ #v(1em) ]
      [#above #heading_i_or_ignored #content #filler #it.page]
    }
    outline(
      title: "Table of Contents",
      indent: n => n * [#h(1.5em)],
    )
  }
}
