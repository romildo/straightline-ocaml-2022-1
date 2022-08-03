(* scan a source program and print the tokens found *)

let main () =
  let channel =
    if Array.length Sys.argv = 2 then
      (* a file name was given in the command line *)
      open_in Sys.argv.(1)
    else
      (* use standard input *)
      stdin
  in

  let buf = Scanner.scanner_buffer_from_channel channel in

  let rec go () =
    let t = Scanner.get_token buf in
    print_endline (Scanner.string_of_token t);
    if t <> TokEOF then
      go ()
  in
  go ()

let _ = main ()
