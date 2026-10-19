type t = {
  status: int option;
  message: string option
}

let build_response (response: t) =
  "HTTP/1.1 "^ (response.status |> Option.value ~default:200 |> string_of_int) ^ " " ^ "OK" ^"\r\n\r\n"
