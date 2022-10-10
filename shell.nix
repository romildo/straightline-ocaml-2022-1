{ nixpkgs ? import <nixpkgs> {} } :

let
  inherit (nixpkgs) pkgs;
  ocamlPackages = pkgs.ocamlPackages;
  #ocamlPackages = pkgs.ocamlPackages_latest;
  dune = pkgs.dune_3;

in
pkgs.stdenv.mkDerivation {
  name = "my-ocaml-env";
  buildInputs = [
    ### basic
    ocamlPackages.findlib # essential
    ocamlPackages.ocaml
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    dune

    ### aditional
    ocamlPackages.printbox
    ocamlPackages.printbox-text
    ocamlPackages.ppxlib
    ocamlPackages.ppx_import
    ocamlPackages.ppx_deriving
    ocamlPackages.menhir

    pkgs.rlwrap

    # (pkgs.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    #   dune
    # ])))

    pkgs.vscode
  ];
}
