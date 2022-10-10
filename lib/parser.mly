// parser.mly

%{
  open Ast
%}

%token                 EOF
%token                 PLUS
%token                 MINUS
%token                 TIMES
%token                 DIV
%token                 LPAREN
%token                 RPAREN
%token                 COMMA
%token                 SEMICOLON
%token                 ASSIGN
%token                 PRINT
%token <float>         NUM
%token <Symbol.symbol> ID

%start <stm>           program

%%

program:
 | x=stm EOF { x }
 ;

stm:
 | a=stm SEMICOLON b=stm { CompoundStm (a, b) }
 | x=ID ASSIGN e=exp { AssignStm (x, e) }
 | PRINT LPAREN l=exp_list RPAREN { PrintStm l }
 ;

exp:
 | x=ID { IdExp x }
 | x=NUM { NumExp x }
 | a=exp PLUS b=exp { OpExp (Plus, a, b) }
 | a=exp MINUS b=exp { OpExp (Minus, a, b) }
 | a=exp TIMES b=exp { OpExp (Times, a, b) }
 | a=exp DIV b=exp { OpExp (Div, a, b) }
 | LPAREN s=stm COMMA e=exp RPAREN { EseqExp (s, e) }
 ;

exp_list:
 | e=exp { [e] }
 | e=exp COMMA l=exp_list { e::l }
 ;
