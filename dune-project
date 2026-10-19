(lang dune 3.21)

(name httpresque)

(generate_opam_files true)

(source
(github username/reponame))
(authors "Author Name <gregoire.bellon@outlook.fr>")
(maintainers "Maintainer Name <maintainer@example.com>")
(license Apache-2.0)
(documentation https://url/to/documentation)
(package
 (name httpresque)
 (synopsis "Presque an HTTP server")
 (description "A toy project following the codecrafter HTTP server tracks.")
 (depends ocaml
        (alcotest :with-test)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
