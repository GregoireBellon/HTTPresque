(** Describes an HTTP response. *)

(** {1 Types} *)

type t
(** A type that describes an HTTP response. *)

(** {1 Building response} *)

val default : t
(** [default] is a default response. *)

val make : ?message:string -> ?body:string -> ?reason:string -> int -> t
(** [message ?message ?body ?reason status] build a new response. *)

(** {1 Rendering responses} *)

val in_buffer : Buffer.t -> t -> unit
(** [in_buffer buff response] modifies the buffer [buff] to insert the
    representation [string] of the given response into it. *)

val to_empty_buffer : t -> Buffer.t
(** [to_empty_buffer response] builds the response from an empty buffer. *)

(** {1 Misc} *)

val equal : t -> t -> bool
(** [equal r1 r2] equality between {!type:t}. *)

val to_string : t -> string
(** [to_string response] converts the [response] to a string. *)
