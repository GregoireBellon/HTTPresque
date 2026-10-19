
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

let rec accept_next_request (server: server) =
  let (_, addr)= Unix.accept server.socket in
  print_endline ("Got a new connection from " ^ (string_of_sockaddr addr) );
  accept_next_request server

let run_server (server: server) =
  Unix.bind server.socket server.addr;
  Unix.listen server.socket server.max_concurrent;
  print_endline "Server is now running and ready to accept connections";
  accept_next_request server
