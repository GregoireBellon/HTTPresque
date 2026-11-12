(** Set of Reusable Testables. *)

open Httpresque

val method_ : Method.t Alcotest.testable
(** [method_] is a testable for {!type:Method.t}. *)

val response : Response.t Alcotest.testable
(** [response] is a testable for {!type:Response.t}. *)
