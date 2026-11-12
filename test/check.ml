let for_all ?(msg = "All parties should be satisfied") predicate list =
  Alcotest.check' ~msg Alcotest.bool ~expected:true
    ~actual:(List.for_all predicate list)
