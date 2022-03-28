(* main *)

let () =
  PrintBox_text.output stdout (Totree.stm_to_tree Examples.prog6);
  print_newline ();
  print_string "max args: ";
  print_int (Maxargs.maxargs Examples.prog6);
  print_newline ()
