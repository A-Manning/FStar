module Platform.Tcp

open FStar.All

open FStar.HyperHeap

open Platform.Bytes
open Platform.Error

assume new type networkStream: Type0
assume new type tcpListener: Type0

assume HasEq_networkStream: hasEq networkStream

(* This library is used by miTLS; for now we model external calls as
   stateful but with no effect on the heap; we could be more precise,
   e.g. specify that they modify some private network region, and that
   networkStream should not be accessed after an error. *)

effect EXT (a:Type) = ST a
  (requires (fun _ -> True)) 
  (ensures (fun h0 _ h1 -> h0==h1))

(* Server side *)

assume val listen: string -> nat -> EXT tcpListener
assume val acceptTimeout: nat -> tcpListener -> EXT networkStream
assume val accept: tcpListener -> EXT networkStream
assume val stop: tcpListener -> EXT unit

(* Client side *)

assume val connectTimeout: nat -> string -> nat -> EXT networkStream
assume val connect: string -> nat -> EXT networkStream

(* Input/Output *)

assume val recv: networkStream -> max:nat -> EXT (optResult string (b:bytes {length b <= max}))
assume val send: networkStream -> bytes -> EXT (optResult string unit)
assume val close: networkStream -> EXT unit

(* Create a network stream from a given stream.
   Only used by the application interface TLSharp. *)
(* assume val create: System.IO.Stream -> NetworkStream*)

 
