(** Describes the request target. *)

(* NOTE: Not particularly useful for the moment, but kept to be compliant
   with the first implementation. *)

(** {1 Types} *)

type t
(** The type that describes a request target. *)

(** {1 Building targets} *)

val origin : string -> t
val absolute : string -> t
val authority : t
val asterix : t

(** {1 Misc} *)

val equal : t -> t -> bool
(** {equal t1 t2} equality between {!val:t}. *)
