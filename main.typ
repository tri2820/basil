#import "template.typ": template;

#show: template.with(
  title: "Sandbox Implementation for Enterprise Collaboration Platforms",
  subtitle: "Scientific Writing Seminar Paper",
  department: [Natural Science Faculty of the University of Basel \
    Department of Mathematics and Computer Science
  ],
  supervisors: [
    Examiner: Prof. Dr. Craig Hamilton \
    Supervisor: Dr. Tanja Schindler
  ],
  abstract: "chapters/00_abstract.typ",
  author: (
    name: "Tri Nguyen",
    matriculation_number: "24-065-948",
    email: "tri.nguyen@unibas.ch",
  ),
  hand_in_date: "20th December 2024",
  chapters: (
    "chapters/01_introduction.typ",
    "chapters/02_related_work.typ",
    "chapters/03_implementation.typ",
    "chapters/04_evaluation.typ",
    "chapters/05_conclusion.typ",
    "chapters/06_bibliography.typ",
  ),
)
