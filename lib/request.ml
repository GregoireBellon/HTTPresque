

let rec handle_request (server: Server.server) (client: Unix.file_descr * Unix.sockaddr) =
  let (sock, addr) = client in
  let time_start_ms = (Sys.time () *. 1000.) in
  print_endline ("Got a new connection from " ^ (Server.string_of_sockaddr addr) );
  let bytes = Bytes.create 1000 in
  let read = Unix.read sock bytes 0 1000 in

  print_endline ("read " ^ string_of_int(read) ^ " from client");
  let response = Response.build_response { message=(Some "OK"); status=(Some 200); body=Some("Hello"); reason=(Some "OK"); } |> Buffer.to_bytes in
  let _ = Unix.write sock  response 0 (Bytes.length response) in
  let time_end_ms = (Sys.time () *. 1000.) in
  print_endline ("wrote " ^ (Bytes.to_string response));
  print_endline ("handle request in " ^ (string_of_float (time_start_ms -. time_end_ms)) ^ " ms" );
  Unix.close sock

let rec accept_next_request (server: Server.server) =
  let client = Unix.accept server.socket in
  handle_request server client;
  accept_next_request server
