module Make (S : V1_LWT.STACKV4)
            (K1 : V1_LWT.KV_RO)
            (C: V1_LWT.CONSOLE) 
            (K2 : V1_LWT.KV_RO)
            (K3 : V1_LWT.KV_RO)
            (CLOCK : V1_LWT.PCLOCK)
            = struct
  let main _stack _k1 console _k2 _k3 _clock =
    C.log console "booted up dispatch_tls";
    Lwt.return_unit
end
