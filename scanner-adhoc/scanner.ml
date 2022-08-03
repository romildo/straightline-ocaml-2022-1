(* scanner for the straigh-line programming language *)

type token =
  | TokSemicolumn
  | TokId of string
  | TokAssign
  | TokPrint
  | TokLParen
  | TokRParen
  | TokComma
  | TokNum of int
  | TokPlus
  | TokMinus
  | TokTimes
  | TokDiv
  | TokEOF

let string_of_token tok =
  match tok with
  | TokSemicolumn -> "TokSemicolumn"
  | TokId x -> "TokId[" ^ x ^ "]"
  | TokAssign -> "TokAssign"
  | TokPrint -> "TokAssign"
  | TokLParen -> "TokLParen"
  | TokRParen -> "TokRParen"
  | TokComma -> "TokComma"
  | TokNum x -> "TokNum[" ^ string_of_int x ^ "]"
  | TokPlus -> "TokPlus"
  | TokMinus -> "TokMinus"
  | TokTimes -> "TokTimes"
  | TokDiv -> "TokDiv"
  | TokEOF -> "TokEOF"

type scanner_buffer =
  { mutable buffer : char list;
    channel : in_channel
  }

let get_char sbuffer =
  match sbuffer.buffer with
  | c::cs ->
     sbuffer.buffer <- cs;
     Some c
  | [] ->
     try
       Some (input_char sbuffer.channel)
     with
       End_of_file -> None

let unget_char sbuffer c =
  sbuffer.buffer <- c :: sbuffer.buffer

let scanner_buffer_from_channel channel =
  { buffer = []; channel = channel }

let is_digit c =
  '0' <= c && c <= '9'

let is_letter c =
  'a' <= c && c <= 'z'  ||  'A' <= c && c <= 'Z'

let rec get_token f =
  match get_char f with
  | None -> TokEOF
  | Some x ->
     match x with
     | ' '
     | '\n'
     | '\t' -> get_token f
     | '#' ->
        let rec loop () =
          match get_char f with
          | Some y when y <> '\n' -> loop ()
          | _ -> get_token f
        in
        loop ()
     | '(' -> TokLParen
     | ')' -> TokRParen
     | ';' -> TokSemicolumn
     | ',' -> TokComma
     | _ when is_digit x ->
        let buffer = Buffer.create 1 in
        Buffer.add_char buffer x;
        let rec loop () =
          match get_char f with
          | Some y ->
             if is_digit y then
               ( Buffer.add_char buffer y;
                 loop ()
               )
             else
               ( unget_char f y;
                 TokNum (int_of_string (Buffer.contents buffer))
               )
          | None ->
             TokNum (int_of_string (Buffer.contents buffer))
        in
        loop ()
     (* add operators, identifiers, etc *)
     | _ ->
        print_string "unexpected char: ";
        print_char x;
        print_newline ();
        get_token f
