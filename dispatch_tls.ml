module Make (S : V1_LWT.STACKV4)
            (K1 : V1_LWT.KV_RO)
            (C: V1_LWT.CONSOLE) 
            (K2 : V1_LWT.KV_RO)
            (K3 : V1_LWT.KV_RO)
            = struct
  let main _stack _k1 console _k2 _k3 =
    C.log console "booted up dispatch_tls";
    Lwt.return_unit
end
