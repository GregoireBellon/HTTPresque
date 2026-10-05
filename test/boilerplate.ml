
let test_lowercase () =
  Alcotest.(check string) "same string" "hello!" (String.lowercase_ascii "hELLO!")

let test_capitalize () =
  Alcotest.(check string) "same string" "World." (String.capitalize_ascii "world.")

let test_str_concat () =
  Alcotest.(check string) "same string" "foobar" (String.concat "" ["foo"; "bar"])

let test_list_concat () =
  Alcotest.(check (list int)) "same lists" [1; 2; 3] (List.append  [1] [2; 3])

(* Run it *)
let () =
  let open Alcotest in
  run "boilerplate-tests" [
      "string-case", [
          test_case "Lower case"     `Quick test_lowercase;
          test_case "Capitalization" `Quick test_capitalize;
        ];
      "string-concat", [ test_case "String mashing" `Quick test_str_concat  ];
      "list-concat",   [ test_case "List mashing"   `Slow  test_list_concat ];
    ]
