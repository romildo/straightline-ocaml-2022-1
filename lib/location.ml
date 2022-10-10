(* handling locations in source code *)

module L = Lexing

(* type for position in source code, borrowed from the standard library *)
type position = Lexing.position

(* type for location, containing starting and ending positions *)
type t = position * position

(* initializing *)

(* a dummy location *)
let dummy =
  (L.dummy_pos, L.dummy_pos)

(* get the current location from a lexical buffer *)
let curr_loc lexbuf =
  (L.lexeme_start_p lexbuf, L.lexeme_end_p lexbuf)

(* pretty print a position *)
let pp_position ppf pos =
  Format.fprintf ppf
    "%s:%i.%i"
    pos.L.pos_fname
    pos.L.pos_lnum
    (pos.L.pos_cnum - pos.L.pos_bol)

(* pretty print a location *)
let pp_location ppf (left, right) =
  if left.L.pos_fname = right.L.pos_fname then
    Format.fprintf ppf
      "%s:%i.%i-%i.%i"
      left.L.pos_fname
      left.L.pos_lnum
      (left.L.pos_cnum - left.L.pos_bol)
      right.L.pos_lnum
      (right.L.pos_cnum - right.L.pos_bol)
  else
    Format.fprintf ppf
      "%a-%a"
      pp_position left
      pp_position right

(* a value annotated with a location *)
type 'a loc = (t [@printer pp_location]) * 'a
     [@@deriving show]

(* annotate a value with a given location *)
let mkloc loc x = (loc, x)

(* annotate a value with a dummy location *)
let mknoloc x = mkloc dummy x

(* get the location of an annotated value with a location *)
let loc (location, _) = location
