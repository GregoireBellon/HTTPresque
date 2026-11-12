type t = Origin of string | Absolute of string | Authority | Asterix

let equal a b =
  match (a, b) with
  | Origin a, Origin b
  | Absolute a, Absolute b ->
      String.equal a b
  | Authority, Authority
  | Asterix, Asterix ->
      true
  | Origin _, _
  | Absolute _, _
  | Authority, _
  | Asterix, _ ->
      false

(* NOTE: Work in progress for the moment. *)

let origin x = Origin x
let absolute x = Absolute x
let authority = Authority
let asterix = Asterix
