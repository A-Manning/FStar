module FStar.DM4F.Heap.IntStoreFixed

open FStar.Seq

let store_size = 10

abstract type id : eqtype = i:nat{i < store_size}
abstract type heap : eqtype = h:seq int{length h < store_size}

let to_id (n:nat{n < store_size}) : id = n

let index (h:heap) (i:id) : Tot int = index h i
let sel = index
let upd (h:heap) (i:id) (x:int) : Tot heap = let h1 = upd h i x in assert (length h1 = store_size) ; h1

let create (x:int) : Tot heap = create #int store_size x

abstract val lemma_index_upd1: s:heap -> n:id -> v:int -> Lemma
  (requires True)
  (ensures (index (upd s n v) n == v))
  [SMTPat (index (upd s n v) n)]
let lemma_index_upd1 s n v = lemma_index_upd1 #int s n v

abstract val lemma_index_upd2: s:heap -> n:id -> v:int -> i:id{i<>n} -> Lemma
  (requires True)
  (ensures (index (upd s n v) i == index s i))
  [SMTPat (index (upd s n v) i)]
let lemma_index_upd2 s n v i = lemma_index_upd2 #int s n v i