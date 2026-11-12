let collect_errs res errs =
  match res with
  | Ok _ -> errs
  | Error e -> e :: errs

let to_noption = function
  (* KLUDGE: since [let x = function ...] is [let x y = match y with ...]
       the [result] params seems not used. So I guess, the correct
       implementation is this one. But not sure the function is really
       useful for the moment ? *)
  | Ok _ -> None
  | Error e -> Some e
