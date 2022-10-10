{
  let illegal_character loc char =
    Error.error loc "illegal character '%c'" char
}

let spaces = [' ' '\t']+
let comment = '#' [^ '\n']*
let num = ['0'-'9']+ ('.' ['0'-'9']+)?
let id = ['a'-'z' 'A'-'Z']+ ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
  | spaces     { token lexbuf }
  | comment    { token lexbuf }
  | '\n'       { Lexing.new_line lexbuf; token lexbuf }
  | '+'        { Parser.PLUS }
  | '-'        { Parser.MINUS }
  | '*'        { Parser.TIMES }
  | '/'        { Parser.DIV }
  | '('        { Parser.LPAREN }
  | ')'        { Parser.RPAREN }
  | ','        { Parser.COMMA }
  | ';'        { Parser.SEMICOLON }
  | ":="       { Parser.ASSIGN }
  | "print"    { Parser.PRINT }
  | num as lxm { Parser.NUM (float_of_string lxm) }
  | id as lxm  { Parser.ID (Symbol.symbol lxm) }
  | eof        { Parser.EOF }
  | _          { illegal_character
                   (Location.curr_loc lexbuf)
                   (Lexing.lexeme_char lexbuf 0) }
