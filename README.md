# The *straightline* programming language

**Straightline** is a micro programming language used in the book series [Modern Compiler Implementation](http://www.cs.princeton.edu/~appel/modern/) by Andrew Appel.

# Grammar

- The syntax of the language is given by a context free grammar.
- Only the production rules are explicitly given.
- The sets of terminals and non-terminals are obtained from the rules.
- The initial symbol is the non-terminal on the left side of the first production rule.

## Production rules

_Stm_ → _Stm_ `;` _Stm_  
_Stm_ → `id` `:=` _Exp_  
_Stm_ → `print` `(` _ExpList_ `)`  
_Exp_ → `id`  
_Exp_ → `num`  
_Exp_ → _Exp_ _Binop_ _Exp_  
_Exp_ → `(` _Stm_ `,` _Exp_ `)`  
_ExpList_ → _Exp_  
_ExpList_ → _Exp_ `,` _ExpList_  
_Binop_ → `+`  
_Binop_ → `-`  
_Binop_ → `*`  
_Binop_ → `/`  

## Operator Precedence and Associativity

In order to resolve possible conflicts during syntactic analysis, the following relation of operator precedence and associativity, in descending order, should be observed:

| operators | associativity |
|-|-|
|`*` `/`|left|
|`+` `-`|left|
|`:=`|right|

## Lexical symbols

- Spaces, newlines, and tabulators are **white spaces**.
- **Comments** starts with `#` and extends to the end of the line.
- A **numerical literal** is a sequence of one or more digits.
- An **identifier** is a sequence of one or more letters, digits and underscores, beginning with a letter, that is not a keyword.
- The **keywords** are: `print`.
- The **operators** are: `:=`, `+`, `-`, `*` and `/`.
- The **special symbols** are: `,`, `;`, `(` and `)`.

# Example

```
a := 5 + 3;
b := ( print(a, a-1), 10*a );
print(b)
```

