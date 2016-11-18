module Make (S : V1_LWT.STACKV4)
            (C: V1_LWT.CONSOLE) 
            (K2 : V1_LWT.KV_RO)
            (K3 : V1_LWT.KV_RO)
            = struct
  let main _stack console _k2 _k3 =
    C.log console "booted up dispatch" >>= fun () ->
    Lwt.return_unit
end
