(** Set of Reusable Testables. *)

open Httpresque

val method_ : Method.t Alcotest.testable
(** [method_] is a testable for {!type:Method.t}. *)

val method_result : (Method.t, Method.error) result Alcotest.testable
(** [method_result] is a testable for validated {!type:Method.t}. *)

val response : Response.t Alcotest.testable
(** [response] is a testable for {!type:Response.t}. *)
