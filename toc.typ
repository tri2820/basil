#let toc() = {
  v(110pt)

  context {
    let dots = box(width: 1fr, repeat[.])

    let last_level = state("last_level", 0)
    show outline.entry: it => context {
      last_level.update(_ => it.level)
      let ignore = it.element.fields().at("label", default: none) == <outline-ignore-number>
      set text(size: 14pt, weight: "bold") if it.level == 1
      let heading_i_or_ignored = if ignore [] else [#it.body.children.at(0)]
      let content = if ignore and not it.body.has("children") [#it.body] else [#it.body.children.at(2)]
      let filler = if it.level == 1 [#h(1fr)] else [#dots]
      let above = if it.level == 1 and last_level.get() >= 1 [ #v(1em) ]
      [#above #heading_i_or_ignored #content #filler #it.page]
    }
    outline(
      title: "Table of Contents",
      indent: n => n * [#h(1.5em)],
    )
  }
}
