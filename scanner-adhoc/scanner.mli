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

type scanner_buffer

val string_of_token : token -> string
val scanner_buffer_from_channel : in_channel -> scanner_buffer
val get_token : scanner_buffer -> token
