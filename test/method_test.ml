open struct
  (* NOTE: This is a common practice that saves us from having to create
     [mli] files that only expose the [cases] function. In [open
     struct .. end], we verify that all tests are exported. An unused
     test case will trigger a warning. *)

  open Httpresque

  let is expected meth =
    match Method.from_string meth with
    | Ok x -> Method.equal x expected
    | _ -> false

  let get_from_string =
    Case.for_all ~name:"check get" (is Method.Get)
      [ "get"; "GET"; "  Get"; "  GeT "; "gET" ]

  let head_from_string =
    Case.for_all ~name:"check head" (is Method.Head)
      [ "head"; "HEAD"; "  Head"; "  heAD "; "heaD" ]

  let post_from_string =
    Case.for_all ~name:"check post" (is Method.Post)
      [ "post"; "POST"; "  Post"; "  pOsT "; "posT" ]

  let put_from_string =
    Case.for_all ~name:"check put" (is Method.Put)
      [ "put"; "PUT"; "  Put"; "  pUt "; "puT" ]

  let delete_from_string =
    Case.for_all ~name:"check delete" (is Method.Delete)
      [ "delete"; "DELETE"; "  Delete"; "  dElEtE "; "deletE" ]

  let connect_from_string =
    Case.for_all ~name:"check connect" (is Method.Connect)
      [ "connect"; "CONNECT"; "  Connect"; "  cOnNeCt "; "connecT" ]

  let options_from_string =
    Case.for_all ~name:"check options" (is Method.Options)
      [ "options"; "OPTIONS"; "  Options"; "  oPtIoNS "; "optioNs" ]

  let trace_from_string =
    Case.for_all ~name:"check trace" (is Method.Trace)
      [ "trace"; "TRACE"; "  Trace"; "  tRaCe "; "tracE" ]

  let invalid_from_string =
    let open Alcotest in
    test_case "check invalid methods" `Quick (fun () ->
        let expected =
          [ "asdhsa"; "other"; "foo"; "  BaR" ]
          |> List.map (fun x -> Error (Method.Unknown x))
        and actual =
          List.map Method.from_string [ "asdhsa"; "other"; "foo"; "  BaR" ]
        in
        check'
          (list Testable.method_result)
          ~msg:"Should reach validation errors" ~expected ~actual)
end

let cases =
  ( "Method"
  , [
      get_from_string
    ; head_from_string
    ; post_from_string
    ; put_from_string
    ; delete_from_string
    ; connect_from_string
    ; options_from_string
    ; trace_from_string
    ; invalid_from_string
    ] )
