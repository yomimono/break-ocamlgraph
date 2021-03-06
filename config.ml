(*
 * Copyright (c) 2015 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Mirage

let tls_key =
  let doc = Key.Arg.info
      ~doc:"Enable serving the website over https. Do not forget to put certificates in tls/"
      ~docv:"BOOL" ~env:"TLS" ["tls"]
  in
  Key.(create "tls" Arg.(opt ~stage:`Configure bool false doc))

let fs_key = Key.(value @@ kv_ro ())

let secrets_key = Key.(value @@ kv_ro ~group:"secrets" ())
let secrets = generic_kv_ro ~key:secrets_key "tls"

let http =
  foreign  "Dispatch.Make"
    (console @-> job)

let https =
  foreign "Dispatch_tls.Make"
    ~deps:[abstract nocrypto]
    (kv_ro @-> console @-> job)


let dispatch = if_impl (Key.value tls_key)
    (** With tls *)
    (https $ secrets)

    (** Without tls *)
    (http)

let () =
  let tracing = None in
  (* let tracing = mprof_trace ~size:10000 () in *)
  register ?tracing "minimized_www" [
    dispatch $ default_console
  ]
