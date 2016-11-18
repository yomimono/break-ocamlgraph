module Make
            (C: V1_LWT.CONSOLE) 
            = struct
  let main console  =
    C.log console "booted up dispatch" >>= fun () ->
    Lwt.return_unit
end
