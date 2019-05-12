module FStar.BinaryTree

type t (a:Type) =
    | Leaf
    | Node: v:a
            -> l:t a
            -> r:t a
            -> t a

// Size of a Binary Tree
val size(#a:Type): t a -> nat
let rec size #_ t =
    match t with
    | Leaf -> 0
    | Node _ l r -> size l + size r + 1
