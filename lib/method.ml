type t =
  | (* NOTE: Maybe an opportunity to mine Polymorphic Variant here:
       https://ocaml.org/manual/5.5/polyvariant.html *)
    Get
  | Head
  | Post
  | Put
  | Delete
  | Connect
  | Options
  | Trace

(* NOTE: Just having one error is maybe bit a little bit excessive, but
   if we decide to add new cases, it is already supported. *)
type error = Unknown of string

let from_string str =
  (* NOTE: We first normalize the method, for case-insensitive reason. *)
  match String.(trim @@ lowercase_ascii str) with
  | "get" -> Ok Get
  | "head" -> Ok Head
  | "post" -> Ok Post
  | "put" -> Ok Put
  | "delete" -> Ok Delete
  | "connect" -> Ok Connect
  | "options" -> Ok Options
  | "trace" -> Ok Trace
  | _ ->
      (* NOTE: we keep using [str] to be sure to report the proper input *)
      Error (Unknown str)

(* NOTE: Here is [function] properly used. *)
let to_string = function
  | Get -> "GET"
  | Head -> "HEAD"
  | Post -> "POST"
  | Put -> "PUT"
  | Delete -> "DELETE"
  | Connect -> "CONNECT"
  | Options -> "OPTIONS"
  | Trace -> "TRACE"

let equal a b =
  match (a, b) with
  | Get, Get
  | Head, Head
  | Post, Post
  | Put, Put
  | Delete, Delete
  | Connect, Connect
  | Options, Options
  | Trace, Trace ->
      true
  | Get, _
  | Head, _
  | Post, _
  | Put, _
  | Delete, _
  | Connect, _
  | Options, _
  | Trace, _ ->
      (* NOTE: Ensure exhaustivity of equality function. For the same reason of
         the usage of deconstructed records in [Response.equal]. Maybe
         excessive but hey. See:
         https://tarides.com/blog/2024-05-29-effective-ml-through-merlin-s-destruct-command/ *)
      false

let error_equal a b =
  match (a, b) with
  | Unknown a, Unknown b -> String.equal a b

let error_to_string = function
  | Unknown m -> "Unknown method: " ^ m
