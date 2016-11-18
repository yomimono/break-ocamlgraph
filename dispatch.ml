module Make (S : V1_LWT.STACKV4)
            (C: V1_LWT.CONSOLE) 
            = struct
  let main _stack console  =
    C.log console "booted up dispatch" >>= fun () ->
    Lwt.return_unit
end
