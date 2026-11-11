let collect_errs res errs = match res with
  Ok _ -> errs
  | Error e -> e::errs

let to_noption result = function
  | Ok _ -> None
  | Error e -> Some e
