(*
   Copyright 2008-2014 Nikhil Swamy and Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)

module FStar.SeqProperties

#set-options "--max_fuel 0 --initial_fuel 0 --initial_ifuel 0 --max_ifuel 0"
open FStar.Seq

let indexable (#a:Type) (s:Seq.seq a) (j:int) = 0 <= j /\ j < Seq.length s

val append_inj_l: #a:Type -> s1:seq a -> s2:seq a -> t1:seq a -> t2:seq a{length s1 = length t1 /\ equal (append s1 s2) (append t1 t2)} -> i:nat{i < length s1}
  -> Lemma (index s1 i == index t1 i)
let append_inj_l #a s1 s2 t1 t2 i =
  assert (index s1 i == (index (append s1 s2) i));
  assert (index t1 i == (index (append t1 t2) i))

val append_inj_r: #a:Type -> s1:seq a -> s2:seq a -> t1:seq a -> t2:seq a{length s1 = length t1 /\ length s2 = length t2 /\ equal (append s1 s2) (append t1 t2)} -> i:nat{i < length s2}
  -> Lemma (ensures  (index s2 i == index t2 i))
let append_inj_r #a s1 s2 t1 t2 i =
  assert (index s2 i == (index (append s1 s2) (i + length s1)));
  assert (index t2 i == (index (append t1 t2) (i + length t1)))

val append_length_disj: #a:Type -> s1:seq a -> s2:seq a -> t1:seq a -> t2:seq a {(length s1 = length t1 \/ length s2 = length t2) /\ (equal (append s1 s2) (append t1 t2))}
  -> Lemma (ensures (length s1 = length t1 /\ length s2 = length t2))
let append_length_disj #a s1 s2 t1 t2 =
  cut (length (append s1 s2) == length s1 + length s2);
  cut (length (append t1 t2) == length t1 + length t2)

val append_inj: #a:Type -> s1:seq a -> s2:seq a -> t1:seq a -> t2:seq a {length s1 = length t1 \/ length s2 = length t2}
  -> Lemma (requires (equal (append s1 s2) (append t1 t2)))
           (ensures (equal s1 t1 /\ equal s2 t2))
let append_inj #a s1 s2 t1 t2 =
  append_length_disj s1 s2 t1 t2;
  FStar.Classical.forall_intro #(i:nat{i < length s1}) #(fun i -> index s1 i == index t1 i) (append_inj_l s1 s2 t1 t2);
  FStar.Classical.forall_intro #(i:nat{i < length s2}) #(fun i -> index s2 i == index t2 i) (append_inj_r s1 s2 t1 t2)

val head: #a:Type -> s:seq a{length s > 0} -> Tot a
let head #a s = index s 0

val tail: #a:Type -> s:seq a{length s > 0} -> Tot (seq a)
let tail #a s = slice s 1 (length s)

val cons: #a:Type -> a -> seq a -> Tot (seq a)
let cons #a x s = append (create 1 x) s

val split: #a:Type -> s:seq a -> i:nat{(0 <= i /\ i <= length s)} -> Tot (seq a * seq a)
let split #a s i = slice s 0 i, slice s i (length s)

val split_charac : #a:Type -> s:seq a -> i:nat{(0 <= i /\ i <= length s)} -> Lemma
  (ensures (append (fst (split s i)) (snd (split s i)) == s))
let split_charac #a s i =
  cut (equal (append (fst (split s i)) (snd (split s i)))  s)

val split_eq: #a:Type -> s:seq a -> i:nat{(0 <= i /\ i <= length s)} -> Pure
  (seq a * seq a)
  (requires True)
  (ensures (fun x -> (append (fst x) (snd x) == s)))
let split_eq #a s i =
  let x = split s i in
  split_charac s i;
  x

val count : #a:eqtype -> a -> s:seq a -> Tot nat (decreases (length s))
let rec count #a x s =
  if length s = 0 then 0
  else if head s = x
  then 1 + count x (tail s)
  else count x (tail s)

val mem: #a:eqtype -> a -> seq a -> Tot bool
let mem #a x l = count x l > 0

val swap: #a:Type -> s:seq a -> i:nat{i<length s} -> j:nat{j<length s} -> Tot (seq a)
let swap #a s i j = upd (upd s j (index s i)) i (index s j)

(* TR: slice_append -> append_slice *)
val append_slice: #a:Type -> s1:seq a{length s1 >= 1} -> s2:seq a -> Lemma
  (ensures (equal (append s1 s2) (append (slice s1 0 1) (append (slice s1 1 (length s1)) s2))))
let append_slice #a s1 s2 = ()

val append_cons_head_tail: #a:Type -> s1:seq a{length s1 > 0} -> s2:seq a -> Lemma
  (requires True)
  (ensures (equal (append s1 s2) (cons (head s1) (append (tail s1) s2))))
let rec append_cons_head_tail #a s1 s2 = ()

(* TR: lemma_tl -> tail_cons *)

val tail_cons: #a:Type -> hd:a -> tl:seq a -> Lemma
  (ensures (equal (tail (cons hd tl)) tl))
let tail_cons #a hd tl = ()

val sorted: #a:Type
          -> (a -> a -> Tot bool)
          -> s:seq a
          -> Tot bool (decreases (length s))
let rec sorted #a f s =
  if length s <= 1
  then true
  else let hd = head s in
       f hd (index s 1) && sorted f (tail s)

(* TR: lemma_append_count -> count_append *)

#set-options "--max_fuel 1 --initial_fuel 1"
val count_append: #a:eqtype -> lo:seq a -> hi:seq a -> Lemma
  (requires True)
  (ensures (forall x. count x (append lo hi) = (count x lo + count x hi)))
  (decreases (length lo))
let rec count_append #a lo hi =
  if length lo = 0
  then cut (equal (append lo hi) hi)
  else (cut (equal (cons (head lo) (append (tail lo) hi))
                (append lo hi));
        count_append (tail lo) hi;
        let tl_l_h = append (tail lo) hi in
        let lh = cons (head lo) tl_l_h in
        cut (equal (tail lh) tl_l_h))

(* TR: what is the purpose of the following _aux lemma? Should we swap
them and make the _aux version private? *)

val count_append_aux: #a:eqtype -> x:a -> lo:seq a -> hi:seq a -> Lemma
  (requires True)
  (ensures (count x (append lo hi) = (count x lo + count x hi)))
let count_append_aux #a x lo hi = count_append lo hi

val mem_inversion: #a:eqtype -> s:seq a{length s > 0} -> Lemma
  (ensures (forall x. mem x s = (x=head s || mem x (tail s))))
let mem_inversion #a s = ()

val mem_count: #a:eqtype -> s:seq a -> f:(a -> Tot bool) -> Lemma
  (requires (forall (i:nat{i<length s}). f (index s i)))
  (ensures (forall (x:a). mem x s ==> f x))
  (decreases (length s))
let rec mem_count #a s f =
  if length s = 0
  then ()
  else (let t = i:nat{i<length (tail s)} in
        cut (forall (i:t). index (tail s) i = index s (i + 1));
        mem_count (tail s) f)

val count_slice: #a:eqtype -> s:seq a -> i:nat{i<=length s} -> Lemma
  (requires True)
  (ensures (forall x. count x s = count x (slice s 0 i) + count x (slice s i (length s))))
  (decreases (length s))
let count_slice #a s i =
  cut (equal s (append (slice s 0 i) (slice s i (length s))));
  count_append (slice s 0 i) (slice s i (length s))

type total_order (a:eqtype) (f: (a -> a -> Tot bool)) =
    (forall a. f a a)                                           (* reflexivity   *)
    /\ (forall a1 a2. (f a1 a2 /\ a1<>a2)  <==> not (f a2 a1))  (* anti-symmetry *)
    /\ (forall a1 a2 a3. f a1 a2 /\ f a2 a3 ==> f a1 a3)        (* transitivity  *)
type tot_ord (a:eqtype) = f:(a -> a -> Tot bool){total_order a f}

val sorted_append_cons: #a:eqtype
                      -> f:(a -> a -> Tot bool){total_order a f}
                      -> lo:seq a{sorted f lo}
                      -> pivot:a
                      -> hi:seq a{sorted f hi}
                      -> Lemma (requires (forall y. (mem y lo ==> f y pivot)
                                                 /\ (mem y hi ==> f pivot y)))
                               (ensures (sorted f (append lo (cons pivot hi))))
                               (decreases (length lo))
let rec sorted_append_cons #a f lo pivot hi =
  if length lo = 0
  then (cut (equal (append lo (cons pivot hi)) (cons pivot hi));
        cut (equal (tail (cons pivot hi)) hi))
  else (sorted_append_cons f (tail lo) pivot hi;
        append_cons_head_tail lo (cons pivot hi);
        tail_cons (head lo) (append (tail lo) (cons pivot hi)))

#set-options "--max_fuel 1 --initial_fuel 1"
val split_5 : #a:Type -> s:seq a -> i:nat -> j:nat{i < j && j < length s} -> Pure (seq (seq a))
  (requires True)
  (ensures (fun x ->
            ((length x = 5)
             /\ (s == append (index x 0) (append (index x 1) (append (index x 2) (append (index x 3) (index x 4)))))
             /\ equal (index x 0) (slice s 0 i)
             /\ equal (index x 1) (slice s i (i+1))
             /\ equal (index x 2) (slice s (i+1) j)
             /\ equal (index x 3) (slice s j (j + 1))
             /\ equal (index x 4) (slice s (j + 1) (length s)))))
let split_5 #a s i j =
  let frag_lo, rest  = split_eq s i in
  let frag_i,  rest  = split_eq rest 1 in
  let frag_mid,rest  = split_eq rest (j - (i + 1)) in
  let frag_j,frag_hi = split_eq rest 1 in
  upd (upd (upd (upd (create 5 frag_lo) 1 frag_i) 2 frag_mid) 3 frag_j) 4 frag_hi
#reset-options

val swap_permutes_aux_frag_eq: #a:Type -> s:seq a -> i:nat{i<length s} -> j:nat{i <= j && j<length s}
                          -> i':nat -> j':nat{i' <= j' /\ j'<=length s /\
                                              (j < i'  //high slice
                                              \/ j' <= i //low slice
                                              \/ (i < i' /\ j' <= j)) //mid slice
                                              }
                          -> Lemma (ensures (slice s i' j' == slice (swap s i j) i' j'
                                            /\ slice s i (i + 1) == slice (swap s i j) j (j + 1)
                                            /\ slice s j (j + 1) == slice (swap s i j) i (i + 1)))
let swap_permutes_aux_frag_eq #a s i j i' j' =
  cut (equal (slice s i' j') (slice (swap s i j) i' j'));
  cut (equal (slice s i (i + 1))  (slice (swap s i j) j (j + 1)));
  cut (equal (slice s j (j + 1))  (slice (swap s i j) i (i + 1)))

//#set-options "--max_fuel 1 --initial_fuel 1 --initial_ifuel 0 --max_ifuel 0 --z3timeout 10"
#set-options "--z3timeout 10"
val swap_permutes_aux: #a:eqtype -> s:seq a -> i:nat{i<length s} -> j:nat{i <= j && j<length s} -> x:a -> Lemma
  (requires True)
  (ensures (count x s = count x (swap s i j)))
let swap_permutes_aux #a s i j x =
  if j=i
  then cut (equal (swap s i j) s)
  else begin
      let s5 = split_5 s i j in
      let frag_lo, frag_i, frag_mid, frag_j, frag_hi =
        index s5 0, index s5 1, index s5 2, index s5 3, index s5 4 in
      count_append_aux x frag_lo (append frag_i (append frag_mid (append frag_j frag_hi)));
      count_append_aux x frag_i (append frag_mid (append frag_j frag_hi));
      count_append_aux x frag_mid (append frag_j frag_hi);
      count_append_aux x frag_j frag_hi;

      let s' = swap s i j in
      let s5' = split_5 s' i j in
      let frag_lo', frag_j', frag_mid', frag_i', frag_hi' =
        index s5' 0, index s5' 1, index s5' 2, index s5' 3, index s5' 4 in

      swap_permutes_aux_frag_eq s i j 0 i;
      swap_permutes_aux_frag_eq s i j (i + 1) j;
      swap_permutes_aux_frag_eq s i j (j + 1) (length s);

      count_append_aux x frag_lo (append frag_j (append frag_mid (append frag_i frag_hi)));
      count_append_aux x frag_j (append frag_mid (append frag_i frag_hi));
      count_append_aux x frag_mid (append frag_i frag_hi);
      count_append_aux x frag_i frag_hi
  end

#set-options "--max_fuel 0 --initial_fuel 0"
type permutation (a:eqtype) (s1:seq a) (s2:seq a) =
       (forall i. count i s1 = count i s2)
val permutation_swap: #a:eqtype -> s:seq a -> i:nat{i<length s} -> j:nat{i <= j && j<length s} -> Lemma
  (permutation a s (swap s i j))
let permutation_swap #a s i j = FStar.Classical.forall_intro #a #(fun x -> count x s = count x (swap s i j)) (swap_permutes_aux s i j)


#set-options "--max_fuel 1 --initial_fuel 1"
val permutation_cons: #a:eqtype -> tl:seq a -> s:seq a{length s > 0} ->
         Lemma (requires (permutation a tl (tail s)))
               (ensures (permutation a (cons (head s) tl) s))
let permutation_cons #a tl s = tail_cons (head s) tl

#set-options "--max_fuel 2 --initial_fuel 2"
val mem_append : #a:eqtype -> s1:seq a -> s2:seq a
      -> Lemma (ensures (forall x. mem x (append s1 s2) <==> (mem x s1 || mem x s2)))
let mem_append #a s1 s2 = count_append s1 s2

(* TR: use of `cons' here is misleading, since `cons' does not appear
       in statement. Maybe use _l/_r? *)

val mem_slice_cons: #a:eqtype -> s:seq a -> i:nat -> j:nat{i < j && j <= length s}
  -> Lemma (ensures (forall x. mem x (slice s i j) <==> (x = index s i || mem x (slice s (i + 1) j))))
let mem_slice_cons #a s i j =
  cut (equal (slice s i j) (append (create 1 (index s i)) (slice s (i + 1) j)));
  mem_append (create 1 (index s i)) (slice s (i + 1) j)

val mem_slice_snoc: #a:eqtype -> s:seq a -> i:nat -> j:nat{i < j && j <= length s}
  -> Lemma (ensures (forall x. mem x (slice s i j) <==> (x = index s (j - 1) || mem x (slice s i (j - 1)))))
let mem_slice_snoc #a s i j =
  cut (equal (slice s i j) (append (slice s i (j - 1)) (create 1 (index s (j - 1)))));
  mem_append (slice s i (j - 1)) (create 1 (index s (j - 1)))

val ordering_lo_snoc: #a:eqtype -> f:tot_ord a -> s:seq a -> i:nat -> j:nat{i <= j && j < length s} -> pv:a
   -> Lemma (requires ((forall y. mem y (slice s i j) ==> f y pv) /\ f (index s j) pv))
            (ensures ((forall y. mem y (slice s i (j + 1)) ==> f y pv)))
let ordering_lo_snoc #a f s i j pv =
  cut (equal (slice s i (j + 1)) (append (slice s i j) (create 1 (index s j))));
  mem_append (slice s i j) (create 1 (index s j))

val ordering_hi_cons: #a:eqtype -> f:tot_ord a -> s:seq a -> back:nat -> len:nat{back < len && len <= length s} -> pv:a
   -> Lemma (requires ((forall y. mem y (slice s (back + 1) len) ==> f pv y) /\ f pv (index s back)))
            (ensures ((forall y. mem y (slice s back len) ==> f pv y)))
let ordering_hi_cons #a f s back len pv =
  cut (equal (slice s back len) (append (create 1 (index s back)) (slice s (back + 1) len)));
  mem_append (create 1 (index s back)) (slice s (back + 1) len)

#set-options "--max_fuel 0 --initial_fuel 0"
val swap_frame_lo : #a:Type -> s:seq a -> lo:nat -> i:nat{lo <= i} -> j:nat{i <= j && j < length s}
     -> Lemma (ensures (slice s lo i == slice (swap s i j) lo i))
let swap_frame_lo #a s lo i j = cut (equal (slice s lo i) (slice (swap s i j) lo i))

val swap_frame_lo' : #a:Type -> s:seq a -> lo:nat -> i':nat {lo <= i'} -> i:nat{i' <= i} -> j:nat{i <= j && j < length s}
     -> Lemma (ensures (slice s lo i' == slice (swap s i j) lo i'))
let swap_frame_lo' #a s lo i' i j = cut (equal (slice s lo i') (slice (swap s i j) lo i'))

val swap_frame_hi : #a:Type -> s:seq a -> i:nat -> j:nat{i <= j} -> k:nat{j < k} -> hi:nat{k <= hi /\ hi <= length s}
     -> Lemma (ensures (slice s k hi == slice (swap s i j) k hi))
let swap_frame_hi #a s i j k hi = cut (equal (slice s k hi) (slice (swap s i j) k hi))

val swap_slice_commute  : #a:Type -> s:seq a -> start:nat -> i:nat{start <= i} -> j:nat{i <= j} -> len:nat{j < len && len <= length s}
    -> Lemma (ensures (slice (swap s i j) start len == (swap (slice s start len) (i - start) (j - start))))
let swap_slice_commute #a s start i j len = cut (equal (slice (swap s i j) start len) (swap (slice s start len) (i - start) (j - start)))

val permutation_slice : #a:eqtype -> s:seq a -> start:nat -> i:nat{start <= i} -> j:nat{i <= j} -> len:nat{j < len && len <= length s}
   -> Lemma (ensures (permutation a (slice s start len) (slice (swap s i j) start len)))
let permutation_slice #a s start i j len =
  swap_slice_commute s start i j len;
  permutation_swap (slice s start len) (i - start) (j - start)

#set-options "--initial_fuel 0 --max_fuel 0"
(* replaces the [i,j) sub-sequence of s1 with the corresponding sub-sequence of s2 *)
val splice: #a:Type -> s1:seq a -> i:nat -> s2:seq a{length s1=length s2} -> j:nat{i <= j /\ j <= (length s2)} -> Tot (seq a)
let splice #a s1 i s2 j = Seq.append (slice s1 0 i) (Seq.append (slice s2 i j) (slice s1 j (length s1)))

val splice_refl : #a:Type -> s:seq a -> i:nat -> j:nat{i <= j && j <= length s}
  -> Lemma
  (ensures (s == splice s i s j))
let splice_refl #a s i j = cut (equal s (splice s i s j))

val splice_swap : #a:Type -> s:seq a -> start:nat -> i:nat{start <= i} -> j:nat{i <= j} -> len:nat{j < len && len <= length s}
   -> Lemma
        (ensures (swap s i j == splice s start (swap s i j) len))
let splice_swap #a s start i j len = cut (equal (swap s i j) (splice s start (swap s i j) len))

(* TR: the names of the following 2 are dubious *)

val slice_splice_l: #a:Type -> s1:seq a -> s2:seq a{length s1 = length s2} -> i:nat -> j:nat{i <= j} -> m:nat{j <= m} -> n:nat{m < n && n <= length s1}
  -> Lemma
  (requires (s1 == (splice s2 i s1 j)))
  (ensures  ((slice s1 m n == slice s2 m n) /\ (index s1 m == index s2 m)))
let slice_splice_l #a s1 s2 i j m n =
  cut (equal (slice s1 m n) (slice s2 m n))

val slice_splice_r: #a:Type -> s1:seq a -> s2:seq a{length s1 = length s2} -> i:nat -> j:nat{i <= j} -> m:nat{j < m} -> n:nat{m <= n && n <= length s1}
  -> Lemma
  (requires (s1 == (splice s2 m s1 n)))
  (ensures  ((slice s1 i j == slice s2 i j) /\ (index s1 j == index s2 j)))
let slice_splice_r #a s1 s2 i j m n =
  cut (equal (slice s1 i j) (slice s2 i j))

val tail_slice: #a:Type -> s:seq a -> i:nat -> j:nat{i < j && j <= length s}
  -> Lemma
  (ensures (tail (slice s i j) == slice s (i + 1) j))
let tail_slice #a s i j =
  cut (equal (tail (slice s i j)) (slice s (i + 1) j))

val splice_le_r : #a:Type -> s1:seq a -> s2:seq a{length s1 = length s2} -> i:nat -> j:nat -> k:nat{i <= j && j <= k && k <= length s1}
  -> Lemma
  (requires (s1 == splice s2 i s1 j))
  (ensures (s1 == splice s2 i s1 k))
let splice_le_r #a s1 s2 i j k = cut (equal s1 (splice s2 i s1 k))

val splice_ge_l : #a:Type -> s1:seq a -> s2:seq a{length s1 = length s2} -> i:nat -> j:nat -> k:nat{i <= j && j <= k && k <= length s1}
  -> Lemma
  (requires (s1 == splice s2 j s1 k))
  (ensures (s1 == splice s2 i s1 k))
let splice_ge_l #a s1 s2 i j k = cut (equal s1 (splice s2 i s1 k))

val splice_trans : #a:Type -> s1:seq a -> s2:seq a -> s3:seq a{length s1 = length s2 /\ length s2 = length s3} -> i:nat -> j:nat{i <= j && j <= length s1}
  -> Lemma
  (requires ((s1 == splice s2 i s1 j) /\ s2 == splice s3 i s2 j))
  (ensures (s1 == splice s3 i s1 j))
let splice_trans #a s1 s2 s3 i j = cut (equal s1 (splice s3 i s1 j))

val permutation_slice_ge_l: #a:eqtype -> s1:seq a -> s2:seq a{length s1 = length s2} -> i:nat -> j:nat -> k:nat{i <= j /\ j <= k /\ k <= length s1}
  -> Lemma
  (requires (s1 == splice s2 j s1 k /\ permutation a (slice s2 j k) (slice s1 j k)))
  (ensures (permutation a (slice s2 i k) (slice s1 i k)))
let permutation_slice_ge_l #a s1 s2 i j k =
  cut (equal (slice s2 i k) (append (slice s2 i j)
                                 (slice s2 j k)));
  cut (equal (slice s1 i k) (append (slice s2 i j)
                                 (slice s1 j k)));
  count_append (slice s2 i j) (slice s2 j k);
  count_append (slice s2 i j) (slice s1 j k)

val permutation_slice_le_r: #a:eqtype -> s1:seq a -> s2:seq a{length s1 = length s2} -> i:nat -> j:nat -> k:nat{i <= j /\ j <= k /\ k <= length s1}
  -> Lemma
  (requires (s1 == splice s2 i s1 j /\ permutation a (slice s2 i j) (slice s1 i j)))
  (ensures (permutation a (slice s2 i k) (slice s1 i k)))
let permutation_slice_le_r #a s1 s2 i j k =
  cut (equal (slice s2 i k) (append (slice s2 i j)
                                 (slice s2 j k)));
  cut (equal (slice s1 i k) (append (slice s1 i j)
                                 (slice s2 j k)));
  count_append (slice s2 i j) (slice s2 j k);
  count_append (slice s1 i j) (slice s2 j k)

val permutation_slice_trans: #a:eqtype -> s1:seq a -> s2:seq a -> s3:seq a{length s1 = length s2 /\ length s2 = length s3} -> i:nat -> j:nat{i<=j && j <= length s1}
 -> Lemma
  (requires (permutation a (slice s1 i j) (slice s2 i j)
             /\ permutation a (slice s2 i j) (slice s3 i j)))
  (ensures (permutation a (slice s1 i j) (slice s3 i j)))
let permutation_slice_trans #a s1 s2 s3 i j = ()


(*New addtions, please review*)

val snoc : #a:Type -> seq a -> a -> Tot (seq a)
let snoc #a s x = Seq.append s (Seq.create 1 x)

#set-options "--initial_fuel 2 --max_fuel 2"
val mem_snoc : #a:eqtype -> s:FStar.Seq.seq a -> x:a ->
   Lemma (ensures (forall y. mem y (snoc s x) <==> mem y s \/ x=y))
let mem_snoc #a s x = count_append s (Seq.create 1 x)

#set-options "--initial_ifuel 1 --max_ifuel 1 --initial_fuel 0 --max_fuel 0"
type found (i:nat) = True
val find_aux : #a:Type -> f:(a -> Tot bool) -> l:seq a
                   -> ctr:nat{ctr <= Seq.length l}
                   -> Pure (option a)
                      (requires (forall (i:nat{ i < Seq.length l /\ i >= ctr}).
                                        not (f (Seq.index l i) )))
                      (ensures (function 
                                  | None -> forall (i:nat{i < Seq.length l}).  not (f (Seq.index l i))
                                  | Some x -> f x /\  (exists (i:nat{i < Seq.length l}). {:pattern (found i)}
							    found i /\
                                                            x == Seq.index l i)))

let rec find_aux #a f l ctr =
  match ctr with
  | 0 -> None
  | _ -> let i = ctr - 1 in
  if f (Seq.index l i)
  then (
     cut (found i);
     Some (Seq.index l i))
  else find_aux f l i

val find: #a:Type -> f:(a -> Tot bool) -> l:seq a ->
                     Pure (option a)
                          (requires True)
                          (ensures (function
                                      | None -> forall (i:nat{i < Seq.length l}). not (f (Seq.index l i))
                                      | Some x -> f x /\ (exists (i:nat{i < Seq.length l}).{:pattern (found i)}
                                                          found i /\ x == Seq.index l i)))

let find #a f l =
  find_aux f l (Seq.length l)

#set-options "--initial_ifuel 1 --max_ifuel 1 --initial_fuel 1 --max_fuel 1"
val mem_index: #a:eqtype -> s:seq a -> n:nat{n < Seq.length s} -> 
    Lemma (requires True)
	  (ensures (mem (Seq.index s n) s))
	  (decreases n)
	  [SMTPat (mem (Seq.index s n) s)]
let rec mem_index #a s n = 
  if n = 0 then ()
  else let tl = tail s in
       mem_index tl (n - 1)

module L = FStar.List.Tot

val seq_to_list: #a:Type -> s:seq a -> Tot (l:list a{L.length l = length s}) (decreases (length s))
let rec seq_to_list #a s =
  if length s = 0 then []
  else index s 0::seq_to_list (slice s 1 (length s))

(* TR: the following would clash with [Seq.of_list] if seq_ removed! *)

val seq_of_list: #a:Type -> l:list a -> Tot (s:seq a{L.length l = length s})
let rec seq_of_list #a l =
  match l with
  | [] -> empty #a
  | hd::tl -> create 1 hd @| seq_of_list tl

(* TR: I have not renamed the following lemmas, because of the dubious
   status of [seq_of_list] above. *)

val lemma_seq_list_bij: #a:Type -> s:seq a -> Lemma
  (requires (True))
  (ensures  (seq_of_list (seq_to_list s) == s))
  (decreases (length s))
let rec lemma_seq_list_bij #a s =
  if length s = 0 then (
    Seq.eq_intro s (seq_of_list (seq_to_list s))
  )
  else (
    lemma_seq_list_bij (slice s 1 (length s));
    eq_intro s (seq_of_list (seq_to_list s))
  )

val lemma_index_is_nth: #a:Type -> s:seq a -> i:nat{i < length s} -> Lemma
  (requires True)
  (ensures  (L.index (seq_to_list s) i == index s i))
  (decreases i)
let rec lemma_index_is_nth #a s i =
  if i = 0 then ()
  else (
    lemma_index_is_nth (slice s 1 (length s)) (i-1)
  )

////////////////////////////////////////////////////////////////////////////////
//s `contains` x : Type0
//    An undecidable version of `mem`, 
//    for when the sequence payload is not an eqtype
////////////////////////////////////////////////////////////////////////////////
abstract let contains (#a:Type) (s:seq a) (x:a) : Tot Type0 = 
  exists (k:nat). k < Seq.length s /\ Seq.index s k == x
    
let contains_intro (#a:Type) (s:seq a) (k:nat) (x:a)
  : Lemma (k < Seq.length s /\ Seq.index s k == x
	    ==>
	   s `contains` x)
  = ()

let contains_elim (#a:Type) (s:seq a) (x:a)
  : Lemma (s `contains` x
	    ==>
	  (exists (k:nat). k < Seq.length s /\ Seq.index s k == x))
  = ()

private let intro_append_contains_from_disjunction (#a:Type) (s1:seq a) (s2:seq a) (x:a)
    : Lemma (requires s1 `contains` x \/ s2 `contains` x)
   	    (ensures (append s1 s2) `contains` x)
    = let open FStar.Classical in 
      let open FStar.Squash in
      if excluded_middle (s1 `contains` x) 
      then ()
      else let s = append s1 s2 in
	   exists_elim (s `contains` x) (get_proof (s2 `contains` x)) (fun k -> 
           assert (Seq.index s (Seq.length s1 + k) == x))

let append_contains_equiv (#a:Type) (s1:seq a) (s2:seq a) (x:a)
  : Lemma ((append s1 s2) `contains` x
	    <==>
  	   (s1 `contains` x \/ s2 `contains` x))
  = FStar.Classical.move_requires (intro_append_contains_from_disjunction s1 s2) x

val contains_snoc : #a:Type -> s:FStar.Seq.seq a -> x:a ->
   Lemma (ensures (forall y. (snoc s x) `contains` y  <==> s `contains` y \/ x==y))
let contains_snoc #a s x =
  FStar.Classical.forall_intro (append_contains_equiv s (Seq.create 1 x))
