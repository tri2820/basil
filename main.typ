#import "conf.typ": conf

#show: conf.with(
  title: "Sandbox Implementation for an Enterprise SuperApp",
  subtitle: "Scientific Writing Seminar Final Paper",
  department: [Natural Science Faculty of the University of Basel \
    Department of Mathematics and Computer Sciences
  ],
  supervisors: [
    Examiner: Prof. Dr. Craig Hamilton \
    Supervisor: Dr. Tanja Schindler
  ],
  abstract: lorem(40),
  author: (
    name: "Tri Nguyen",
    matriculation_number: "24-065-948",
    email: "tri.nguyen@unibas.ch",
  ),
  hand_in_date: "20th December 2024",
  chapters: (
    "chapters/01_introduction.typ",
    "chapters/02_enterprise_superapp.typ",
    "chapters/03_sandbox_implementation.typ",
    "chapters/04_membrane.typ",
    "chapters/05_experiments.typ",
    "chapters/06_bibliography.typ",
    "chapters/07_appendix.typ",
  ),
)
