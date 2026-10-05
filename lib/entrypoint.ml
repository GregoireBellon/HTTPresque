
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


let run_server (server: server) =
  Unix.bind server.socket server.addr;
  Unix.listen server.socket server.max_concurrent;
  print_endline "Server is now running and ready to accept connections"
(* TODO: actually accept connections and stop lying like that*)
