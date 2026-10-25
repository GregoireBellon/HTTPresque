type t = {
  status: int option;
  message: string option;
  reason: string option;
  body: string option;
}

let t_default = {
  status = None;
  message = None;
  body = None;
  reason = None;
}

let http_version = "1.1"

let build_response (response: t) =
  let buff = Buffer.create 512 in
  let buff_add_space b = Buffer.add_char b ' ' in
  Buffer.add_string buff ("HTTP/" ^ http_version) ;
  buff_add_space buff;
  Buffer.add_string buff (response.status |> Option.map string_of_int |> Option.value ~default:"200" );
  buff_add_space buff;
  Buffer.add_string buff (Option.value response.reason ~default:"OK");
  Buffer.add_string buff "\r\n";
  (* add the headers here *)
  Buffer.add_string buff "\r\n";
  Buffer.add_string buff (Option.value ~default:"" response.body);
  buff
