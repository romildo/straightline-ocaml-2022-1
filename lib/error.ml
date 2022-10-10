(* helper functions for reporting errors *)

exception Error of (Location.t * string)

(* report an error at a given location in the source code *)

let error loc fmt =
  Format.ksprintf (fun msg -> raise (Error (loc, msg))) fmt

(* report a fatal error *)

let fatal fmt =
  Format.ksprintf failwith fmt

(* register a custom printer for errors *)

let () =
  Printexc.register_printer
    (function
     | Error (loc, msg) ->
        Some (Format.asprintf "%a error: %s" Location.pp_location loc msg)
     | _ ->
        None (* for other exceptions *)
    )
