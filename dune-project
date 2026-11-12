(lang dune 3.24)

(name httpresque)

(generate_opam_files)

(source
 (github GregoireBellon/HTTPresque))
 (authors "Gregoire Bellon <gregoire.bellon@outlook.fr>")
 (maintainers "Gregoire Bellon <gregoire.bellon@outlook.fr>")
 (license Apache-2.0)

 (package
  (name httpresque)
  (synopsis "Presque an HTTP server")
  (description "A toy project following the codecrafter HTTP server tracks.")
  (depends
   (ocaml (>= 5.3.0))
   (alcotest :with-test)
   (utop :with-dev-setup)
   (ocp-indent :with-dev-setup)
   (ocamlformat :with-dev-setup)
   (ocaml-lsp-server :with-dev-setup)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
