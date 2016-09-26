module QuickSort.Seq
open FStar.Seq
open FStar.SeqProperties

(* the last recursive call to partition fails for me if I use the F# version
   of F* and and the option here:
#set-options "--max_fuel 0 --initial_fuel 0 --initial_ifuel 0 --max_ifuel 0" *)

(* CH: this is needed on my machine, intermittent failures otherwise *)
#reset-options "--z3timeout 60"

val partition: #a:eqtype -> f:(a -> a -> Tot bool){total_order a f}
    -> s:seq a -> pivot:nat{pivot < length s} -> back:nat{pivot <= back /\ back < length s} ->
       Pure (seq a * seq a)
         (requires (forall (i:nat{i < length s}).
                                 ((i <= pivot ==> f (index s i) (index s pivot))
                                  /\ (back < i  ==> f (index s pivot) (index s i)))))
         (ensures (fun res ->
                     (fun lo hi p ->
                         (length lo + length hi = length s)
                      /\ (length hi > 0)
                      /\ (index hi 0 = p)
                      /\ (forall x. (mem x hi ==> f p x)
                                 /\ (mem x lo ==> f x p)
                                 /\ (count x s = count x hi + count x lo)))
                     (fst res)
                     (snd res)
                     (index s pivot)))
         (decreases (back - pivot))
let rec partition #a f s pivot back =
  if pivot=back
  then (count_slice s pivot;
        let lo = slice s 0 pivot in
        let hi = slice s pivot (length s) in
        mem_count lo (fun x -> f x (index s pivot));
        mem_count hi (f (index s pivot));
        (lo, hi))
  else let next = index s (pivot + 1) in
       let p = index s pivot in
       if f next p
       then let s' = swap s pivot (pivot + 1) in  (* the pivot moves forward *)
            let _ = permutation_swap s pivot (pivot + 1) in
            partition f s' (pivot + 1) back
       else let s' = swap s (pivot + 1) back in (* the back moves backward *)
            let _ = permutation_swap s (pivot + 1) back in
            let res = (* admit() *) partition f s' pivot (back - 1) in
            res        

#reset-options

#set-options "--initial_fuel 1 --max_fuel 1 --initial_ifuel 1 --max_ifuel 1"
val sort: #a:eqtype -> f:(a -> a -> Tot bool){total_order a f}
       -> s1:seq a
       -> Tot (s2:seq a{sorted f s2 /\ permutation a s1 s2})
              (decreases (length s1))
let rec sort #a f s =
  if length s <= 1 then s
  else let lo, hi = partition f s 0 (length s - 1) in
       let pivot = head hi in

       let hi_tl = tail hi in
       let l = sort f lo in
       let h = sort f hi_tl in

       let result = Seq.append l (cons pivot h) in

       sorted_append_cons f l pivot h;
       count_append l (cons pivot h);
       permutation_cons h hi;

       result



