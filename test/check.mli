(** A set of utility functions for describing [checks]. *)

val for_all : ?msg:string -> ('a -> bool) -> 'a list -> unit
(** [for_all ?msg predicate list] ensures that all elements of [list] satisfy
    the [predicate]. *)
