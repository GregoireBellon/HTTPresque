let run_server (server : Server.server) =
  Unix.bind server.socket server.addr;
  Unix.listen server.socket server.max_concurrent;
  "Server is now running and ready to accept connections on "
  ^ Server.string_of_sockaddr server.addr
  |> print_endline;
  Request.accept_next_request server
