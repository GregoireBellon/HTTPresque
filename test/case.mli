(** A set of utility functions for describing [test_cases]. *)

val for_all :
     ?speed:Alcotest.speed_level
  -> ?name:string
  -> ?msg:string
  -> ('a -> bool)
  -> 'a list
  -> unit Alcotest.test_case
(** [for_all ?speed ?name ?msg predicate list] a test case that ensures that all
    elements of [list] satisfy the [predicate]. *)
