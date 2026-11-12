open Httpresque

let method_ =
  (* NOTE: [method] is a reserved keyword in OCaml so usually we use [meth]
     or the suffix [_]. *)
  let pp ppf m = Format.fprintf ppf "%s" (Method.to_string m)
  and eq = Method.equal in
  Alcotest.testable pp eq

let method_result =
  let err =
    let pp ppf m = Format.fprintf ppf "%s" (Method.error_to_string m)
    and eq = Method.error_equal in
    Alcotest.testable pp eq
  in
  Alcotest.result method_ err

let response =
  let pp ppf r = Format.fprintf ppf "%s" (Response.to_string r)
  and eq = Response.equal in
  Alcotest.testable pp eq
