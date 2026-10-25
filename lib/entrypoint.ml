open Response

type server = {
  socket: Unix.file_descr;
  addr: Unix.sockaddr;
  max_concurrent: int;
}

(* link: https://ocaml.org/manual/5.5/api/Unix.html *)
let getServer addr_string port =
  let socket = (Unix.socket PF_INET SOCK_STREAM 0) in
  let addr = Unix.inet_addr_of_string addr_string in
  {
    socket;
    addr =  Unix.ADDR_INET (addr , port);
      max_concurrent = 100;
  }

let string_of_sockaddr = function
  | Unix.ADDR_UNIX s -> "Unix("^s^")"
  | Unix.ADDR_INET (addr, port) -> "Inet(" ^(Unix.string_of_inet_addr addr) ^ ":" ^ string_of_int port ^ ")"


let rec handle_request (server: server) (client: Unix.file_descr * Unix.sockaddr) =
  let (sock, addr) = client in
  let time_start_ms = (Sys.time () *. 1000.) in
  print_endline ("Got a new connection from " ^ (string_of_sockaddr addr) );
  let bytes = Bytes.create 1000 in
  let read = Unix.read sock bytes 0 1000 in

  print_endline ("read " ^ string_of_int(read) ^ " from client");
  let response = Response.build_response { message=(Some "OK"); status=(Some 200); body=Some("Hello"); reason=(Some "OK"); } |> Buffer.to_bytes in
  let _ = Unix.write sock  response 0 (Bytes.length response) in
  let time_end_ms = (Sys.time () *. 1000.) in
  print_endline ("wrote " ^ (Bytes.to_string response));
  print_endline ("handle request in " ^ (string_of_float (time_start_ms -. time_end_ms)) ^ " ms" );
  Unix.close sock

let rec accept_next_request (server: server) =
  let client = Unix.accept server.socket in
  handle_request server client;
  accept_next_request server

let run_server (server: server) =
  Unix.bind server.socket server.addr;
  Unix.listen server.socket server.max_concurrent;
  "Server is now running and ready to accept connections on " ^ (string_of_sockaddr server.addr) |> print_endline;
  accept_next_request server
