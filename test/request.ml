open Httpresque.Request

let pp_http_method fmt = function
  | Get -> Format.pp_print_string fmt "Get"
  | Head -> Format.pp_print_string fmt "Head"
  | Post -> Format.pp_print_string fmt "Post"
  | Put -> Format.pp_print_string fmt "Put"
  | Delete -> Format.pp_print_string fmt "Delete"
  | Connect -> Format.pp_print_string fmt "Connect"
  | Option -> Format.pp_print_string fmt "Option"
  | Trace -> Format.pp_print_string fmt "Trace"

let pp_parsing_error fmt = function
  | Invalid_token s -> Format.fprintf fmt "Invalid_token %S" s
  | Invalid_syntax s -> Format.fprintf fmt "Invalid_syntax %S" s

let parsing_error_testable =
  Alcotest.testable pp_parsing_error ( = )

let http_method_testable =
  Alcotest.testable pp_http_method ( = )

let pp_request_target fmt = function
  | Origin target -> Format.fprintf fmt "Origin %S" target
  | Absolute target -> Format.fprintf fmt "Absolute %S" target
  | Authority -> Format.pp_print_string fmt "Authority"
  | Asterix -> Format.pp_print_string fmt "Asterix"

let request_target_testable =
  Alcotest.testable pp_request_target ( = )

let pp_request fmt req =
  Format.fprintf fmt
    "{ hmethod = %a; target = %a; version = %S }"
    pp_http_method req.hmethod
    pp_request_target req.target
    req.version

let request_testable =
  Alcotest.testable pp_request ( = )

let pp_parsing_error fmt = function
  | Invalid_token s -> Format.fprintf fmt "Invalid_token %S" s
  | Invalid_syntax s -> Format.fprintf fmt "Invalid_syntax %S" s

let parsing_error_testable =
  Alcotest.testable pp_parsing_error ( = )

let parsing_errors_testable =
  Alcotest.list parsing_error_testable


let test_get_request_line () =
  Alcotest.(check (result request_testable (list parsing_error_testable)))
    "valid GET request line"
    (Ok {
      hmethod = Get;
      target = Absolute "/";
      version = "HTTP/1.1";
    })
    (parse_request_line "GET / HTTP/1.1")


let test_get () =
  Alcotest.(check (result http_method_testable parsing_error_testable)) "Valid get" (Ok Get) (http_method_of_str "GET")
let test_head () =
  Alcotest.(check (result http_method_testable parsing_error_testable)) "Valid head" (Ok Head) (http_method_of_str "HEAD")
let test_post () =
  Alcotest.(check (result http_method_testable parsing_error_testable)) "Valid post" (Ok Post) (http_method_of_str "POST")
let test_put () =
  Alcotest.(check (result http_method_testable parsing_error_testable)) "Valid put" (Ok Put) (http_method_of_str "PUT")


let test_valid_request () =
  Alcotest.(check (result http_method_testable parsing_error_testable)) "Valid put" (Ok Put) (http_method_of_str "PUT")

let () =
  let open Alcotest in
  run "requests parsing" [
      "http method", [
          test_case "GET " `Quick test_get;
          test_case "HEAD " `Quick test_head;
          test_case "POST " `Quick test_post;
          test_case "PUT " `Quick test_put;
        ];
        "request line", [
          test_case "Valid GET " `Quick test_get_request_line;
        ]
    ]
