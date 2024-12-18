#import "../chapter.typ": chapter;

#show: chapter.with(alphabet_header: true)

= Bibliography <outline-ignore-number>

#bibliography("../bib.bib", title: none)

