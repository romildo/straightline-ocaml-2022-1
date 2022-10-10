(* symbol: a type to efficiently represent identifiers *)

(* representing a symbol *)
type symbol = string * int
     [@@deriving show]

(* a reference holding the next available symbol number *)
let nextsym = ref 0

(* initial size for the hash table *)
let size_hint = 128

(* a hash table to hold the known symbols *)
let hashtable = Hashtbl.create size_hint

(* get the name of a symbol *)
let name (s, _) = s

(* make a symbol from a given name *)
let symbol name =
  match Hashtbl.find_opt hashtable name with
  | Some number -> (name, number)
  | None ->
     let number = !nextsym in
     nextsym := number + 1;
     Hashtbl.add hashtable name number;
     (name, number)

(* make a new symbol with an arbitrary unique name *)
let new_symbol s = symbol (Printf.sprintf "%s_%d" s !nextsym)

(* print a symbol *)
let pp_symbol ppf s =
  Format.fprintf ppf "\"%s\"" (name s)

(* symbol table *)
module Table = Map.Make(
  (* purely applicative (no side-effects) association tables over ordered types *)
  struct
    type t = symbol
    let compare (_,n1) (_,n2) = compare n1 n2
  end
  )

type 'a table = 'a Table.t

(* the empty symbol table *)
let empty = Table.empty

(* enter a symbol into a symbol table *)
let enter = Table.add

(* look for a symbol in a symbol table *)
let look = Table.find_opt
