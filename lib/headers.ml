(* NOTE: We use a map, but it's not really that important. *)

module M = Map.Make (String)

type t = string list M.t

let normalize_name = String.lowercase_ascii
let empty = M.empty

let add ~key ~value map =
  (* NOTE: We can use [::] for reverse adding, but:
     https://grim.cargocut.org/a/rev-list.html *)
  M.update (normalize_name key)
    (function
      | None -> Some [ value ]
      | Some previous -> Some (previous @ [ value ]))
    map
