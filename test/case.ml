let for_all ?(speed = `Quick) ?(name = "for all") ?msg predicate list =
  Alcotest.test_case name speed (fun () -> Check.for_all ?msg predicate list)
