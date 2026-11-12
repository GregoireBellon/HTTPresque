(* https://www.rfc-editor.org/info/rfc9110/#name-methods *)

type parsing_error = Invalid_token of string | Invalid_syntax of string
type http_method = Get | Head | Post | Put | Delete | Connect | Option | Trace

let http_method_of_str = function
  | "GET" -> Ok Get
  | "HEAD" -> Ok Head
  | "POST" -> Ok Post
  | "PUT" -> Ok Put
  | "DELETE" -> Ok Delete
  | "CONNECT" -> Ok Connect
  | "OPTION" -> Ok Option
  | "TRACE" -> Ok Trace
  | _ -> Error (Invalid_token "Expected a valid HTTP method")

type request_target =
  | Origin of string
  | Absolute of string
  | Authority
  | Asterix

type headers = (string * string) list
type t = { hmethod : http_method; target : request_target; version : string }

(* https://datatracker.ietf.org/doc/html/rfc9112#name-request-line *)
let parse_request_line inp =
  match String.split_on_char ' ' inp with
  | [ met; tar; ver ] ->
      let parsed_method = http_method_of_str met in
      let parsed_tar = Ok tar in
      let parsed_ver = Ok ver in

      let errs =
        []
        |> Utils.collect_errs parsed_method
        |> Utils.collect_errs parsed_tar
        |> Utils.collect_errs parsed_ver
      in
      if errs = [] then
        Ok
          {
            hmethod = Result.get_ok parsed_method
          ; target = Absolute (Result.get_ok parsed_tar)
          ; version = Result.get_ok parsed_ver
          }
      else Error errs
  | _ ->
      Error
        [
          Invalid_syntax
            "Expected `method SP request-target SP HTTP-version` kind of \
             response"
        ]

let parse_headers (_headers_str : string) =
  (* let rec parse_next curr_headers remaining_str = () in *)
  (* String.split_on_char "" *)
  (* turn the str into a string seq  *)
  (* turn the str seq into string pair *)
  []

(* type t =

} *)

let handle_request (_server : Server.server)
    (client : Unix.file_descr * Unix.sockaddr) =
  let sock, addr = client in
  let time_start_ms = Sys.time () *. 1000. in
  print_endline ("Got a new connection from " ^ Server.string_of_sockaddr addr);
  let bytes = Bytes.create 1000 in
  let read = Unix.read sock bytes 0 1000 in

  print_endline ("read " ^ string_of_int read ^ " from client");
  let response =
    Response.make ~message:"OK" ~body:"Hello" ~reason:"OK" 200
    |> Response.to_empty_buffer
    |> Buffer.to_bytes
  in
  let _ = Unix.write sock response 0 (Bytes.length response) in
  let time_end_ms = Sys.time () *. 1000. in
  print_endline ("wrote " ^ Bytes.to_string response);
  print_endline
    ("handle request in "
    ^ string_of_float (time_start_ms -. time_end_ms)
    ^ " ms");
  Unix.close sock

let rec accept_next_request (server : Server.server) =
  let client = Unix.accept server.socket in
  handle_request server client;
  accept_next_request server
