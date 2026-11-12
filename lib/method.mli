(** Describes the HTTP method. *)

(** {1 Types} *)

(* NOTE: Here, the type isn't abstract (or private) because you can't
   really construct invalid methods; in this design, there's no need
   to guard against their construction. In the future, we could
   imagine having [query] (or even [Other of string]). Something like:

   https://github.com/cargocut/highway/blob/main/lib/highway/method.ml
*)

(** A type that describes what an HTTP method can be. *)
type t = Get | Head | Post | Put | Delete | Connect | Options | Trace

(** Errors that can occurs during method validation. See {!val:from_string}. *)
type error = Unknown of string

(** {1 Misc} *)

val from_string : string -> (t, error) result
(** [from_string str] try to build a {!type:t} from a [str] representation. *)

val to_string : t -> string
(** [to_string meth] render the given [meth] to a suitable [string]. *)

val equal : t -> t -> bool
(** [equal m1 m2] equality between [m1] and [m2]. *)

(** {2 Errors} *)

val error_equal : error -> error -> bool
(** [error_equal e1 e2] equalities betweens errors *)

val error_to_string : error -> string
(** [error_to_string err] give string representation for [err]. *)
