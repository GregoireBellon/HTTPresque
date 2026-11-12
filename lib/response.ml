type t = {
    status : int
  ; message : string option
  ; reason : string
  ; body : string
}

let make ?message ?(body = "") ?(reason = "OK") status =
  (* NEXT: Proper validation here. It is a temporary implementation. *)
  { status; message; body; reason }

let default =
  (* NOTE: Using options seems a bit excessive to me, since we kind of
     require ourselves to always have default values, right? So here
     we're already providing them. *)
  make 200

let equal { status; message; reason; body } other =
  (* NOTE: We deconstruct the first record to ensure, as we proceed with
     the implementation, that we examine all fields of a record in an
     equality function. So if, for some obscure reason, we add a field
     to [t], we use the type checker as a safety net. *)
  Int.equal status other.status
  && Option.equal String.equal message other.message
  && String.equal reason other.reason
  && String.equal body other.body

let http_version = "1.1"

let in_buffer buff { status; reason; body; message = _ } =
  let () = Buffer.add_string buff "HTTP/" in
  let () =
    (* NOTE: Since you seem to want to use buffers, we're avoiding
       unnecessary memory allocation from concatenation here. But it's
       probably negligible. *)
    Buffer.add_string buff http_version
  in
  let () = Buffer.add_char buff ' ' in
  let () = Buffer.add_string buff (string_of_int status) in
  let () = Buffer.add_char buff ' ' in
  let () = Buffer.add_string buff reason in
  let () = Buffer.add_string buff "\r\n" in
  (* add the headers here *)
  let () = Buffer.add_string buff "\r\n" in
  let () = Buffer.add_string buff body in
  ()

let to_empty_buffer response =
  let buff = Buffer.create 512 in
  let () = in_buffer buff response in
  buff

let to_string response = response |> to_empty_buffer |> Buffer.contents
