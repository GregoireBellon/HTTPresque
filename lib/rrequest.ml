type t = {
    meth : Method.t
  ; target : Target.t
  ; headers : Headers.t
  ; version : string
  ; body : string
}

type error = Method_error of Method.error | Syntax_error of string

(* NOTE: The applicative trick described in Pidgin. *)

let ( let+ ) x f = Result.map f x

let ( and+ ) x y =
  match (x, y) with
  | Ok x, Ok y -> Ok (x, y)
  | Error a, Error b -> Error (a @ b)
  | Error a, _
  | _, Error a ->
      Error a

let validate_method x =
  x
  |>
  (* NOTE: The trick is, here, to use a list for errors in order to have more than
     just one error. *)
  Method.from_string
  |> Result.map_error (fun x -> [ Method_error x ])

let validated_version x =
  (* TODO: To be implemented *)
  Ok x

let validated_target x =
  (* TODO: To be implemented *)
  Ok (Target.absolute x)

let validate_headers () =
  (* TODO: To be implemented *)
  Ok Headers.empty

let from_string input =
  match String.split_on_char ' ' input with
  | [ meth; target; version ] ->
      (* NOTE: Here we can use our bindings operators: [let+] and [and+] to
         build a product. Here every steps is computed independently
         and merged at the end of the pipeline (in contrast to monadic
         validation). It is called Applicative Validation and mostly
         described here:
         https://www.staff.city.ac.uk/~ross/papers/Applicative.html

      *)
      let+ meth = validate_method meth
      and+ version = validated_version version
      and+ target = validated_target target
      and+ headers = validate_headers () in
      {
        meth
      ; version
      ; target
      ; headers
      ; body = (* TODO: To be implemented *) ""
      }
  | _ ->
      (* NOTE: since we are collecting more errors. we need to lift our syntax
         error into a list. An other approach will be to have a
         distinction between [parsing error] (a single value) and
         [validation error] (a list of errors).

         But I let you make your own experiments ;)
      *)
      Error [ Syntax_error input ]
