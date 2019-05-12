module FStar.BraunTree

module BT = FStar.BinaryTree

val invariant(#a:Type): BT.t a -> Type0
let rec invariant #_ t =
    match t with
    | BT.Leaf -> True
    | BT.Node _ l r -> BT.size r + 1 >= BT.size l
                    /\ BT.size l <= BT.size r
                    /\ invariant l
                    /\ invariant r

type t (a:Type) = t:BT.t a{invariant t}

(* Used by the compiler for array literals:
   Generates a braun tree with size n without the expensive check *)
