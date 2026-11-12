(** Describes a list of headers *)

(** {1 Types} *)

type t
(** The type that describes the set of headers associated with a request. *)

(** {1 Building} *)

val empty : t
(** Describes an empty set of headers. *)

val add : key:string -> value:string -> t -> t
(** [add ~key ~value headers] returns a new [headers] object to which the
    [key, value] pair has been added. *)
