open Httpresque

let method_ =
  (* NOTE: [method] is a reserved keyword in OCaml so usually we use [meth]
     or the suffix [_]. *)
  let pp ppf m = Format.fprintf ppf "%s" (Method.to_string m)
  and eq = Method.equal in
  Alcotest.testable pp eq

let response =
  let pp ppf r = Format.fprintf ppf "%s" (Response.to_string r)
  and eq = Response.equal in
  Alcotest.testable pp eq
