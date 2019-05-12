module FStar.Array_

module BT = FStar.BinaryTree
module Br = FStar.BraunTree

abstract type t (a:Type) =
    | Mk: Br.t a -> t a

abstract val size (#a:Type): t a -> nat
abstract let size #_ (Mk arr) = BT.size arr

abstract type sized (a:Type) (n:nat) = arr:t a{size arr == n}

#set-options "--lax"
//This private primitive is used internally by the
//compiler to translate array constants
//with a desugaring-time check of the size of the array,
//rather than an expensive verifiation check.
//Since it is marked private, client programs cannot call it directly
//Since it is marked unfold, it eagerly reduces,
//eliminating the verification overhead of the wrapper.
//The technique is the same as in the FStar.Int* and FStar.UInt* modules.
private unfold
val __binaryTree_to_sizedArray(#a:Type):
    sz:nat -> BT.t a -> sized a sz
private unfold
let __binaryTree_to_sizedArray #_ size t = Mk t
#reset-options
