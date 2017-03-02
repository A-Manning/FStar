open Prims
let qual_id: FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident =
  fun lid  ->
    fun id  ->
      let uu____7 =
        FStar_Ident.lid_of_ids
          (FStar_List.append lid.FStar_Ident.ns [lid.FStar_Ident.ident; id]) in
      FStar_Ident.set_lid_range uu____7 id.FStar_Ident.idRange
let mk_discriminator: FStar_Ident.lident -> FStar_Ident.lident =
  fun lid  ->
    FStar_Ident.lid_of_ids
      (FStar_List.append lid.FStar_Ident.ns
         [FStar_Ident.mk_ident
            ((Prims.strcat FStar_Ident.reserved_prefix
                (Prims.strcat "is_"
                   (lid.FStar_Ident.ident).FStar_Ident.idText)),
              ((lid.FStar_Ident.ident).FStar_Ident.idRange))])
let is_name: FStar_Ident.lident -> Prims.bool =
  fun lid  ->
    let c =
      FStar_Util.char_at (lid.FStar_Ident.ident).FStar_Ident.idText
        (Prims.parse_int "0") in
    FStar_Util.is_upper c
let arg_of_non_null_binder uu____25 =
  match uu____25 with
  | (b,imp) ->
      let uu____30 = FStar_Syntax_Syntax.bv_to_name b in (uu____30, imp)
let args_of_non_null_binders:
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.term* FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.collect
         (fun b  ->
            let uu____43 = FStar_Syntax_Syntax.is_null_binder b in
            if uu____43
            then []
            else (let uu____50 = arg_of_non_null_binder b in [uu____50])))
let args_of_binders:
  FStar_Syntax_Syntax.binders ->
    ((FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list*
      (FStar_Syntax_Syntax.term* FStar_Syntax_Syntax.aqual) Prims.list)
  =
  fun binders  ->
    let uu____64 =
      FStar_All.pipe_right binders
        (FStar_List.map
           (fun b  ->
              let uu____86 = FStar_Syntax_Syntax.is_null_binder b in
              if uu____86
              then
                let b =
                  let uu____96 =
                    FStar_Syntax_Syntax.new_bv None
                      (Prims.fst b).FStar_Syntax_Syntax.sort in
                  (uu____96, (Prims.snd b)) in
                let uu____97 = arg_of_non_null_binder b in (b, uu____97)
              else
                (let uu____105 = arg_of_non_null_binder b in (b, uu____105)))) in
    FStar_All.pipe_right uu____64 FStar_List.unzip
let name_binders:
  FStar_Syntax_Syntax.binder Prims.list ->
    (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.mapi
         (fun i  ->
            fun b  ->
              let uu____145 = FStar_Syntax_Syntax.is_null_binder b in
              if uu____145
              then
                let uu____148 = b in
                match uu____148 with
                | (a,imp) ->
                    let b =
                      let uu____154 =
                        let uu____155 = FStar_Util.string_of_int i in
                        Prims.strcat "_" uu____155 in
                      FStar_Ident.id_of_text uu____154 in
                    let b =
                      {
                        FStar_Syntax_Syntax.ppname = b;
                        FStar_Syntax_Syntax.index = (Prims.parse_int "0");
                        FStar_Syntax_Syntax.sort =
                          (a.FStar_Syntax_Syntax.sort)
                      } in
                    (b, imp)
              else b))
let name_function_binders t =
  match t.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
      let uu____183 =
        let uu____186 =
          let uu____187 =
            let uu____195 = name_binders binders in (uu____195, comp) in
          FStar_Syntax_Syntax.Tm_arrow uu____187 in
        FStar_Syntax_Syntax.mk uu____186 in
      uu____183 None t.FStar_Syntax_Syntax.pos
  | uu____212 -> t
let null_binders_of_tks:
  (FStar_Syntax_Syntax.typ* FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____232  ->
            match uu____232 with
            | (t,imp) ->
                let uu____239 =
                  let uu____240 = FStar_Syntax_Syntax.null_binder t in
                  FStar_All.pipe_left Prims.fst uu____240 in
                (uu____239, imp)))
let binders_of_tks:
  (FStar_Syntax_Syntax.typ* FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____266  ->
            match uu____266 with
            | (t,imp) ->
                let uu____279 =
                  FStar_Syntax_Syntax.new_bv
                    (Some (t.FStar_Syntax_Syntax.pos)) t in
                (uu____279, imp)))
let binders_of_freevars:
  FStar_Syntax_Syntax.bv FStar_Util.set ->
    FStar_Syntax_Syntax.binder Prims.list
  =
  fun fvs  ->
    let uu____286 = FStar_Util.set_elements fvs in
    FStar_All.pipe_right uu____286
      (FStar_List.map FStar_Syntax_Syntax.mk_binder)
let mk_subst s = [s]
let subst_of_list:
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.subst_t
  =
  fun formals  ->
    fun actuals  ->
      if (FStar_List.length formals) = (FStar_List.length actuals)
      then
        FStar_List.fold_right2
          (fun f  ->
             fun a  ->
               fun out  ->
                 (FStar_Syntax_Syntax.NT ((Prims.fst f), (Prims.fst a))) ::
                 out) formals actuals []
      else failwith "Ill-formed substitution"
let rename_binders:
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.subst_t
  =
  fun replace_xs  ->
    fun with_ys  ->
      if (FStar_List.length replace_xs) = (FStar_List.length with_ys)
      then
        FStar_List.map2
          (fun uu____354  ->
             fun uu____355  ->
               match (uu____354, uu____355) with
               | ((x,uu____365),(y,uu____367)) ->
                   let uu____372 =
                     let uu____377 = FStar_Syntax_Syntax.bv_to_name y in
                     (x, uu____377) in
                   FStar_Syntax_Syntax.NT uu____372) replace_xs with_ys
      else failwith "Ill-formed substitution"
let rec unmeta: FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun e  ->
    let e = FStar_Syntax_Subst.compress e in
    match e.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e,_)|FStar_Syntax_Syntax.Tm_ascribed
      (e,_,_) -> unmeta e
    | uu____402 -> e
let rec univ_kernel:
  FStar_Syntax_Syntax.universe -> (FStar_Syntax_Syntax.universe* Prims.int) =
  fun u  ->
    match u with
    | FStar_Syntax_Syntax.U_unknown 
      |FStar_Syntax_Syntax.U_name _
       |FStar_Syntax_Syntax.U_unif _|FStar_Syntax_Syntax.U_zero  ->
        (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_succ u ->
        let uu____413 = univ_kernel u in
        (match uu____413 with | (k,n) -> (k, (n + (Prims.parse_int "1"))))
    | FStar_Syntax_Syntax.U_max uu____420 ->
        failwith "Imposible: univ_kernel (U_max _)"
    | FStar_Syntax_Syntax.U_bvar uu____424 ->
        failwith "Imposible: univ_kernel (U_bvar _)"
let constant_univ_as_nat: FStar_Syntax_Syntax.universe -> Prims.int =
  fun u  -> let uu____430 = univ_kernel u in Prims.snd uu____430
let rec compare_univs:
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.int =
  fun u1  ->
    fun u2  ->
      match (u1, u2) with
      | (FStar_Syntax_Syntax.U_bvar _,_)|(_,FStar_Syntax_Syntax.U_bvar _) ->
          failwith "Impossible: compare_univs"
      | (FStar_Syntax_Syntax.U_unknown ,FStar_Syntax_Syntax.U_unknown ) ->
          Prims.parse_int "0"
      | (FStar_Syntax_Syntax.U_unknown ,uu____443) -> - (Prims.parse_int "1")
      | (uu____444,FStar_Syntax_Syntax.U_unknown ) -> Prims.parse_int "1"
      | (FStar_Syntax_Syntax.U_zero ,FStar_Syntax_Syntax.U_zero ) ->
          Prims.parse_int "0"
      | (FStar_Syntax_Syntax.U_zero ,uu____445) -> - (Prims.parse_int "1")
      | (uu____446,FStar_Syntax_Syntax.U_zero ) -> Prims.parse_int "1"
      | (FStar_Syntax_Syntax.U_name u1,FStar_Syntax_Syntax.U_name u2) ->
          FStar_String.compare u1.FStar_Ident.idText u2.FStar_Ident.idText
      | (FStar_Syntax_Syntax.U_name uu____449,FStar_Syntax_Syntax.U_unif
         uu____450) -> - (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif uu____453,FStar_Syntax_Syntax.U_name
         uu____454) -> Prims.parse_int "1"
      | (FStar_Syntax_Syntax.U_unif u1,FStar_Syntax_Syntax.U_unif u2) ->
          let uu____463 = FStar_Unionfind.uvar_id u1 in
          let uu____465 = FStar_Unionfind.uvar_id u2 in uu____463 - uu____465
      | (FStar_Syntax_Syntax.U_max us1,FStar_Syntax_Syntax.U_max us2) ->
          let n1 = FStar_List.length us1 in
          let n2 = FStar_List.length us2 in
          if n1 <> n2
          then n1 - n2
          else
            (let copt =
               let uu____487 = FStar_List.zip us1 us2 in
               FStar_Util.find_map uu____487
                 (fun uu____493  ->
                    match uu____493 with
                    | (u1,u2) ->
                        let c = compare_univs u1 u2 in
                        if c <> (Prims.parse_int "0") then Some c else None) in
             match copt with | None  -> Prims.parse_int "0" | Some c -> c)
      | (FStar_Syntax_Syntax.U_max uu____503,uu____504) ->
          - (Prims.parse_int "1")
      | (uu____506,FStar_Syntax_Syntax.U_max uu____507) ->
          Prims.parse_int "1"
      | uu____509 ->
          let uu____512 = univ_kernel u1 in
          (match uu____512 with
           | (k1,n1) ->
               let uu____517 = univ_kernel u2 in
               (match uu____517 with
                | (k2,n2) ->
                    let r = compare_univs k1 k2 in
                    if r = (Prims.parse_int "0") then n1 - n2 else r))
let eq_univs:
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.bool
  =
  fun u1  ->
    fun u2  ->
      let uu____530 = compare_univs u1 u2 in
      uu____530 = (Prims.parse_int "0")
let ml_comp:
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax ->
    FStar_Range.range -> FStar_Syntax_Syntax.comp
  =
  fun t  ->
    fun r  ->
      FStar_Syntax_Syntax.mk_Comp
        {
          FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_unknown];
          FStar_Syntax_Syntax.effect_name =
            (FStar_Ident.set_lid_range FStar_Syntax_Const.effect_ML_lid r);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = [FStar_Syntax_Syntax.MLEFFECT]
        }
let comp_effect_name c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp c -> c.FStar_Syntax_Syntax.effect_name
  | FStar_Syntax_Syntax.Total uu____557 -> FStar_Syntax_Const.effect_Tot_lid
  | FStar_Syntax_Syntax.GTotal uu____563 ->
      FStar_Syntax_Const.effect_GTot_lid
let comp_flags c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total uu____581 -> [FStar_Syntax_Syntax.TOTAL]
  | FStar_Syntax_Syntax.GTotal uu____587 -> [FStar_Syntax_Syntax.SOMETRIVIAL]
  | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.flags
let comp_set_flags:
  FStar_Syntax_Syntax.comp ->
    FStar_Syntax_Syntax.cflags Prims.list ->
      (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax
  =
  fun c  ->
    fun f  ->
      let comp_to_comp_typ c =
        match c.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Comp c -> c
        | FStar_Syntax_Syntax.Total (t,u_opt)|FStar_Syntax_Syntax.GTotal
          (t,u_opt) ->
            let uu____623 =
              let uu____624 = FStar_Util.map_opt u_opt (fun x  -> [x]) in
              FStar_Util.dflt [] uu____624 in
            {
              FStar_Syntax_Syntax.comp_univs = uu____623;
              FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
              FStar_Syntax_Syntax.result_typ = t;
              FStar_Syntax_Syntax.effect_args = [];
              FStar_Syntax_Syntax.flags = (comp_flags c)
            } in
      let uu___175_634 = c in
      let uu____635 =
        let uu____636 =
          let uu___176_637 = comp_to_comp_typ c in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___176_637.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___176_637.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___176_637.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args =
              (uu___176_637.FStar_Syntax_Syntax.effect_args);
            FStar_Syntax_Syntax.flags = f
          } in
        FStar_Syntax_Syntax.Comp uu____636 in
      {
        FStar_Syntax_Syntax.n = uu____635;
        FStar_Syntax_Syntax.tk = (uu___175_634.FStar_Syntax_Syntax.tk);
        FStar_Syntax_Syntax.pos = (uu___175_634.FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.vars = (uu___175_634.FStar_Syntax_Syntax.vars)
      }
let comp_to_comp_typ:
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c -> c
    | FStar_Syntax_Syntax.Total (t,Some u)|FStar_Syntax_Syntax.GTotal
      (t,Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | uu____662 ->
        failwith "Assertion failed: Computation type without universe"
let is_named_tot c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp c ->
      FStar_Ident.lid_equals c.FStar_Syntax_Syntax.effect_name
        FStar_Syntax_Const.effect_Tot_lid
  | FStar_Syntax_Syntax.Total uu____675 -> true
  | FStar_Syntax_Syntax.GTotal uu____681 -> false
let is_total_comp c =
  FStar_All.pipe_right (comp_flags c)
    (FStar_Util.for_some
       (fun uu___163_699  ->
          match uu___163_699 with
          | FStar_Syntax_Syntax.TOTAL |FStar_Syntax_Syntax.RETURN  -> true
          | uu____700 -> false))
let is_total_lcomp: FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun c  ->
    (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
       FStar_Syntax_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___164_705  ->
               match uu___164_705 with
               | FStar_Syntax_Syntax.TOTAL |FStar_Syntax_Syntax.RETURN  ->
                   true
               | uu____706 -> false)))
let is_tot_or_gtot_lcomp: FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun c  ->
    ((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
        FStar_Syntax_Const.effect_Tot_lid)
       ||
       (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
          FStar_Syntax_Const.effect_GTot_lid))
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___165_711  ->
               match uu___165_711 with
               | FStar_Syntax_Syntax.TOTAL |FStar_Syntax_Syntax.RETURN  ->
                   true
               | uu____712 -> false)))
let is_partial_return c =
  FStar_All.pipe_right (comp_flags c)
    (FStar_Util.for_some
       (fun uu___166_725  ->
          match uu___166_725 with
          | FStar_Syntax_Syntax.RETURN |FStar_Syntax_Syntax.PARTIAL_RETURN 
              -> true
          | uu____726 -> false))
let is_lcomp_partial_return: FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun c  ->
    FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
      (FStar_Util.for_some
         (fun uu___167_731  ->
            match uu___167_731 with
            | FStar_Syntax_Syntax.RETURN |FStar_Syntax_Syntax.PARTIAL_RETURN 
                -> true
            | uu____732 -> false))
let is_tot_or_gtot_comp c =
  (is_total_comp c) ||
    (FStar_Ident.lid_equals FStar_Syntax_Const.effect_GTot_lid
       (comp_effect_name c))
let is_pure_effect: FStar_Ident.lident -> Prims.bool =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Tot_lid) ||
       (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_PURE_lid))
      || (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Pure_lid)
let is_pure_comp c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total uu____758 -> true
  | FStar_Syntax_Syntax.GTotal uu____764 -> false
  | FStar_Syntax_Syntax.Comp ct ->
      ((is_total_comp c) ||
         (is_pure_effect ct.FStar_Syntax_Syntax.effect_name))
        ||
        (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
           (FStar_Util.for_some
              (fun uu___168_772  ->
                 match uu___168_772 with
                 | FStar_Syntax_Syntax.LEMMA  -> true
                 | uu____773 -> false)))
let is_ghost_effect: FStar_Ident.lident -> Prims.bool =
  fun l  ->
    ((FStar_Ident.lid_equals FStar_Syntax_Const.effect_GTot_lid l) ||
       (FStar_Ident.lid_equals FStar_Syntax_Const.effect_GHOST_lid l))
      || (FStar_Ident.lid_equals FStar_Syntax_Const.effect_Ghost_lid l)
let is_pure_or_ghost_comp c =
  (is_pure_comp c) || (is_ghost_effect (comp_effect_name c))
let is_pure_lcomp: FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun lc  ->
    ((is_total_lcomp lc) || (is_pure_effect lc.FStar_Syntax_Syntax.eff_name))
      ||
      (FStar_All.pipe_right lc.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___169_792  ->
               match uu___169_792 with
               | FStar_Syntax_Syntax.LEMMA  -> true
               | uu____793 -> false)))
let is_pure_or_ghost_lcomp: FStar_Syntax_Syntax.lcomp -> Prims.bool =
  fun lc  ->
    (is_pure_lcomp lc) || (is_ghost_effect lc.FStar_Syntax_Syntax.eff_name)
let is_pure_or_ghost_function: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____800 =
      let uu____801 = FStar_Syntax_Subst.compress t in
      uu____801.FStar_Syntax_Syntax.n in
    match uu____800 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____804,c) -> is_pure_or_ghost_comp c
    | uu____816 -> true
let is_lemma: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____820 =
      let uu____821 = FStar_Syntax_Subst.compress t in
      uu____821.FStar_Syntax_Syntax.n in
    match uu____820 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____824,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct ->
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Syntax_Const.effect_Lemma_lid
         | uu____837 -> false)
    | uu____838 -> false
let head_and_args:
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax*
      ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax* FStar_Syntax_Syntax.aqual) Prims.list)
  =
  fun t  ->
    let t = FStar_Syntax_Subst.compress t in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head,args) -> (head, args)
    | uu____884 -> (t, [])
let un_uinst: FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun t  ->
    let t = FStar_Syntax_Subst.compress t in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_uinst (t,uu____899) ->
        FStar_Syntax_Subst.compress t
    | uu____904 -> t
let is_smt_lemma: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____908 =
      let uu____909 = FStar_Syntax_Subst.compress t in
      uu____909.FStar_Syntax_Syntax.n in
    match uu____908 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____912,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct when
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Syntax_Const.effect_Lemma_lid
             ->
             (match ct.FStar_Syntax_Syntax.effect_args with
              | _req::_ens::(pats,uu____928)::uu____929 ->
                  let pats' = unmeta pats in
                  let uu____960 = head_and_args pats' in
                  (match uu____960 with
                   | (head,uu____971) ->
                       let uu____986 =
                         let uu____987 = un_uinst head in
                         uu____987.FStar_Syntax_Syntax.n in
                       (match uu____986 with
                        | FStar_Syntax_Syntax.Tm_fvar fv ->
                            FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Syntax_Const.cons_lid
                        | uu____991 -> false))
              | uu____992 -> false)
         | uu____998 -> false)
    | uu____999 -> false
let is_ml_comp c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Comp c ->
      (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.effect_name
         FStar_Syntax_Const.effect_ML_lid)
        ||
        (FStar_All.pipe_right c.FStar_Syntax_Syntax.flags
           (FStar_Util.for_some
              (fun uu___170_1013  ->
                 match uu___170_1013 with
                 | FStar_Syntax_Syntax.MLEFFECT  -> true
                 | uu____1014 -> false)))
  | uu____1015 -> false
let comp_result c =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total (t,_)|FStar_Syntax_Syntax.GTotal (t,_) -> t
  | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.result_typ
let set_result_typ c t =
  match c.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Total uu____1059 -> FStar_Syntax_Syntax.mk_Total t
  | FStar_Syntax_Syntax.GTotal uu____1065 -> FStar_Syntax_Syntax.mk_GTotal t
  | FStar_Syntax_Syntax.Comp ct ->
      FStar_Syntax_Syntax.mk_Comp
        (let uu___177_1072 = ct in
         {
           FStar_Syntax_Syntax.comp_univs =
             (uu___177_1072.FStar_Syntax_Syntax.comp_univs);
           FStar_Syntax_Syntax.effect_name =
             (uu___177_1072.FStar_Syntax_Syntax.effect_name);
           FStar_Syntax_Syntax.result_typ = t;
           FStar_Syntax_Syntax.effect_args =
             (uu___177_1072.FStar_Syntax_Syntax.effect_args);
           FStar_Syntax_Syntax.flags =
             (uu___177_1072.FStar_Syntax_Syntax.flags)
         })
let is_trivial_wp c =
  FStar_All.pipe_right (comp_flags c)
    (FStar_Util.for_some
       (fun uu___171_1085  ->
          match uu___171_1085 with
          | FStar_Syntax_Syntax.TOTAL |FStar_Syntax_Syntax.RETURN  -> true
          | uu____1086 -> false))
let primops: FStar_Ident.lident Prims.list =
  [FStar_Syntax_Const.op_Eq;
  FStar_Syntax_Const.op_notEq;
  FStar_Syntax_Const.op_LT;
  FStar_Syntax_Const.op_LTE;
  FStar_Syntax_Const.op_GT;
  FStar_Syntax_Const.op_GTE;
  FStar_Syntax_Const.op_Subtraction;
  FStar_Syntax_Const.op_Minus;
  FStar_Syntax_Const.op_Addition;
  FStar_Syntax_Const.op_Multiply;
  FStar_Syntax_Const.op_Division;
  FStar_Syntax_Const.op_Modulus;
  FStar_Syntax_Const.op_And;
  FStar_Syntax_Const.op_Or;
  FStar_Syntax_Const.op_Negation]
let is_primop_lid: FStar_Ident.lident -> Prims.bool =
  fun l  ->
    FStar_All.pipe_right primops
      (FStar_Util.for_some (FStar_Ident.lid_equals l))
let is_primop f =
  match f.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Tm_fvar fv ->
      is_primop_lid (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
  | uu____1108 -> false
let rec unascribe: FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun e  ->
    let e = FStar_Syntax_Subst.compress e in
    match e.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_ascribed (e,uu____1114,uu____1115) ->
        unascribe e
    | uu____1134 -> e
let rec ascribe t k =
  match t.FStar_Syntax_Syntax.n with
  | FStar_Syntax_Syntax.Tm_ascribed (t',uu____1166,uu____1167) ->
      ascribe t' k
  | uu____1186 ->
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed (t, k, None))
        None t.FStar_Syntax_Syntax.pos
type eq_result =
  | Equal
  | NotEqual
  | Unknown
let uu___is_Equal: eq_result -> Prims.bool =
  fun projectee  ->
    match projectee with | Equal  -> true | uu____1203 -> false
let uu___is_NotEqual: eq_result -> Prims.bool =
  fun projectee  ->
    match projectee with | NotEqual  -> true | uu____1207 -> false
let uu___is_Unknown: eq_result -> Prims.bool =
  fun projectee  ->
    match projectee with | Unknown  -> true | uu____1211 -> false
let rec eq_tm:
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> eq_result =
  fun t1  ->
    fun t2  ->
      let t1 = unascribe t1 in
      let t2 = unascribe t2 in
      let equal_if uu___172_1231 = if uu___172_1231 then Equal else Unknown in
      let equal_iff uu___173_1236 = if uu___173_1236 then Equal else NotEqual in
      let eq_and f g = match f with | Equal  -> g () | uu____1250 -> Unknown in
      match ((t1.FStar_Syntax_Syntax.n), (t2.FStar_Syntax_Syntax.n)) with
      | (FStar_Syntax_Syntax.Tm_name a,FStar_Syntax_Syntax.Tm_name b) ->
          equal_if (FStar_Syntax_Syntax.bv_eq a b)
      | (FStar_Syntax_Syntax.Tm_fvar f,FStar_Syntax_Syntax.Tm_fvar g) ->
          let uu____1255 = FStar_Syntax_Syntax.fv_eq f g in
          equal_if uu____1255
      | (FStar_Syntax_Syntax.Tm_uinst (f,us),FStar_Syntax_Syntax.Tm_uinst
         (g,vs)) ->
          let uu____1268 = eq_tm f g in
          eq_and uu____1268
            (fun uu____1269  ->
               let uu____1270 = eq_univs_list us vs in equal_if uu____1270)
      | (FStar_Syntax_Syntax.Tm_constant c,FStar_Syntax_Syntax.Tm_constant d)
          ->
          let uu____1273 = FStar_Const.eq_const c d in equal_iff uu____1273
      | (FStar_Syntax_Syntax.Tm_uvar
         (u1,uu____1275),FStar_Syntax_Syntax.Tm_uvar (u2,uu____1277)) ->
          let uu____1302 = FStar_Unionfind.equivalent u1 u2 in
          equal_if uu____1302
      | (FStar_Syntax_Syntax.Tm_app (h1,args1),FStar_Syntax_Syntax.Tm_app
         (h2,args2)) ->
          let uu____1338 = eq_tm h1 h2 in
          eq_and uu____1338 (fun uu____1339  -> eq_args args1 args2)
      | (FStar_Syntax_Syntax.Tm_type u,FStar_Syntax_Syntax.Tm_type v) ->
          let uu____1342 = eq_univs u v in equal_if uu____1342
      | (FStar_Syntax_Syntax.Tm_meta (t1,uu____1344),uu____1345) ->
          eq_tm t1 t2
      | (uu____1350,FStar_Syntax_Syntax.Tm_meta (t2,uu____1352)) ->
          eq_tm t1 t2
      | uu____1357 -> Unknown
and eq_args:
  FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.args -> eq_result =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ((a,uu____1381)::a1,(b,uu____1384)::b1) ->
          let uu____1422 = eq_tm a b in
          (match uu____1422 with
           | Equal  -> eq_args a1 b1
           | uu____1423 -> Unknown)
      | uu____1424 -> Unknown
and eq_univs_list:
  FStar_Syntax_Syntax.universes ->
    FStar_Syntax_Syntax.universes -> Prims.bool
  =
  fun us  ->
    fun vs  ->
      ((FStar_List.length us) = (FStar_List.length vs)) &&
        (FStar_List.forall2 eq_univs us vs)
let rec unrefine: FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun t  ->
    let t = FStar_Syntax_Subst.compress t in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____1438) ->
        unrefine x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t,uu____1444,uu____1445) -> unrefine t
    | uu____1464 -> t
let rec is_unit: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1468 =
      let uu____1469 = unrefine t in uu____1469.FStar_Syntax_Syntax.n in
    match uu____1468 with
    | FStar_Syntax_Syntax.Tm_type uu____1472 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) ||
          (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid)
    | FStar_Syntax_Syntax.Tm_uinst (t,uu____1475) -> is_unit t
    | uu____1480 -> false
let rec non_informative: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1484 =
      let uu____1485 = unrefine t in uu____1485.FStar_Syntax_Syntax.n in
    match uu____1484 with
    | FStar_Syntax_Syntax.Tm_type uu____1488 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid))
          || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.erased_lid)
    | FStar_Syntax_Syntax.Tm_app (head,uu____1491) -> non_informative head
    | FStar_Syntax_Syntax.Tm_uinst (t,uu____1507) -> non_informative t
    | FStar_Syntax_Syntax.Tm_arrow (uu____1512,c) ->
        (is_tot_or_gtot_comp c) && (non_informative (comp_result c))
    | uu____1524 -> false
let is_fun: FStar_Syntax_Syntax.term -> Prims.bool =
  fun e  ->
    let uu____1528 =
      let uu____1529 = FStar_Syntax_Subst.compress e in
      uu____1529.FStar_Syntax_Syntax.n in
    match uu____1528 with
    | FStar_Syntax_Syntax.Tm_abs uu____1532 -> true
    | uu____1547 -> false
let is_function_typ: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____1551 =
      let uu____1552 = FStar_Syntax_Subst.compress t in
      uu____1552.FStar_Syntax_Syntax.n in
    match uu____1551 with
    | FStar_Syntax_Syntax.Tm_arrow uu____1555 -> true
    | uu____1563 -> false
let rec pre_typ: FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term =
  fun t  ->
    let t = FStar_Syntax_Subst.compress t in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____1569) ->
        pre_typ x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t,uu____1575,uu____1576) -> pre_typ t
    | uu____1595 -> t
let destruct:
  FStar_Syntax_Syntax.term ->
    FStar_Ident.lident ->
      ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax* FStar_Syntax_Syntax.aqual) Prims.list
        Prims.option
  =
  fun typ  ->
    fun lid  ->
      let typ = FStar_Syntax_Subst.compress typ in
      let uu____1609 =
        let uu____1610 = un_uinst typ in uu____1610.FStar_Syntax_Syntax.n in
      match uu____1609 with
      | FStar_Syntax_Syntax.Tm_app (head,args) ->
          let head = un_uinst head in
          (match head.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               FStar_Syntax_Syntax.fv_eq_lid tc lid -> Some args
           | uu____1648 -> None)
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc lid -> Some []
      | uu____1664 -> None
let lids_of_sigelt:
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.list =
  fun se  ->
    match se with
    | FStar_Syntax_Syntax.Sig_let (_,_,lids,_,_)
      |FStar_Syntax_Syntax.Sig_bundle (_,_,lids,_) -> lids
    | FStar_Syntax_Syntax.Sig_inductive_typ (lid,_,_,_,_,_,_,_)
      |FStar_Syntax_Syntax.Sig_effect_abbrev (lid,_,_,_,_,_,_)
       |FStar_Syntax_Syntax.Sig_datacon (lid,_,_,_,_,_,_,_)
        |FStar_Syntax_Syntax.Sig_declare_typ (lid,_,_,_,_)
         |FStar_Syntax_Syntax.Sig_assume (lid,_,_,_)
        -> [lid]
    | FStar_Syntax_Syntax.Sig_new_effect_for_free (n,_)
      |FStar_Syntax_Syntax.Sig_new_effect (n,_) ->
        [n.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_sub_effect _
      |FStar_Syntax_Syntax.Sig_pragma _|FStar_Syntax_Syntax.Sig_main _ -> []
let lid_of_sigelt:
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.option =
  fun se  ->
    match lids_of_sigelt se with | l::[] -> Some l | uu____1741 -> None
let quals_of_sigelt:
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.qualifier Prims.list =
  fun x  ->
    match x with
    | FStar_Syntax_Syntax.Sig_bundle (_,quals,_,_)
      |FStar_Syntax_Syntax.Sig_inductive_typ (_,_,_,_,_,_,quals,_)
       |FStar_Syntax_Syntax.Sig_effect_abbrev (_,_,_,_,quals,_,_)
        |FStar_Syntax_Syntax.Sig_datacon (_,_,_,_,_,quals,_,_)
         |FStar_Syntax_Syntax.Sig_declare_typ (_,_,_,quals,_)
          |FStar_Syntax_Syntax.Sig_assume (_,_,quals,_)
           |FStar_Syntax_Syntax.Sig_let (_,_,_,quals,_)
            |FStar_Syntax_Syntax.Sig_new_effect
             ({ FStar_Syntax_Syntax.qualifiers = quals;
                FStar_Syntax_Syntax.cattributes = _;
                FStar_Syntax_Syntax.mname = _; FStar_Syntax_Syntax.univs = _;
                FStar_Syntax_Syntax.binders = _;
                FStar_Syntax_Syntax.signature = _;
                FStar_Syntax_Syntax.ret_wp = _;
                FStar_Syntax_Syntax.bind_wp = _;
                FStar_Syntax_Syntax.if_then_else = _;
                FStar_Syntax_Syntax.ite_wp = _;
                FStar_Syntax_Syntax.stronger = _;
                FStar_Syntax_Syntax.close_wp = _;
                FStar_Syntax_Syntax.assert_p = _;
                FStar_Syntax_Syntax.assume_p = _;
                FStar_Syntax_Syntax.null_wp = _;
                FStar_Syntax_Syntax.trivial = _;
                FStar_Syntax_Syntax.repr = _;
                FStar_Syntax_Syntax.return_repr = _;
                FStar_Syntax_Syntax.bind_repr = _;
                FStar_Syntax_Syntax.actions = _;_},_)
             |FStar_Syntax_Syntax.Sig_new_effect_for_free
             ({ FStar_Syntax_Syntax.qualifiers = quals;
                FStar_Syntax_Syntax.cattributes = _;
                FStar_Syntax_Syntax.mname = _; FStar_Syntax_Syntax.univs = _;
                FStar_Syntax_Syntax.binders = _;
                FStar_Syntax_Syntax.signature = _;
                FStar_Syntax_Syntax.ret_wp = _;
                FStar_Syntax_Syntax.bind_wp = _;
                FStar_Syntax_Syntax.if_then_else = _;
                FStar_Syntax_Syntax.ite_wp = _;
                FStar_Syntax_Syntax.stronger = _;
                FStar_Syntax_Syntax.close_wp = _;
                FStar_Syntax_Syntax.assert_p = _;
                FStar_Syntax_Syntax.assume_p = _;
                FStar_Syntax_Syntax.null_wp = _;
                FStar_Syntax_Syntax.trivial = _;
                FStar_Syntax_Syntax.repr = _;
                FStar_Syntax_Syntax.return_repr = _;
                FStar_Syntax_Syntax.bind_repr = _;
                FStar_Syntax_Syntax.actions = _;_},_)
        -> quals
    | FStar_Syntax_Syntax.Sig_sub_effect (_,_)
      |FStar_Syntax_Syntax.Sig_pragma (_,_)|FStar_Syntax_Syntax.Sig_main
       (_,_) -> []
let range_of_sigelt: FStar_Syntax_Syntax.sigelt -> FStar_Range.range =
  fun x  ->
    match x with
    | FStar_Syntax_Syntax.Sig_bundle (_,_,_,r)
      |FStar_Syntax_Syntax.Sig_inductive_typ (_,_,_,_,_,_,_,r)
       |FStar_Syntax_Syntax.Sig_effect_abbrev (_,_,_,_,_,_,r)
        |FStar_Syntax_Syntax.Sig_datacon (_,_,_,_,_,_,_,r)
         |FStar_Syntax_Syntax.Sig_declare_typ (_,_,_,_,r)
          |FStar_Syntax_Syntax.Sig_assume (_,_,_,r)
           |FStar_Syntax_Syntax.Sig_let (_,r,_,_,_)
            |FStar_Syntax_Syntax.Sig_main (_,r)
             |FStar_Syntax_Syntax.Sig_pragma (_,r)
              |FStar_Syntax_Syntax.Sig_new_effect (_,r)
               |FStar_Syntax_Syntax.Sig_new_effect_for_free (_,r)
                |FStar_Syntax_Syntax.Sig_sub_effect (_,r)
        -> r
let range_of_lb uu___174_1924 =
  match uu___174_1924 with
  | (FStar_Util.Inl x,uu____1931,uu____1932) ->
      FStar_Syntax_Syntax.range_of_bv x
  | (FStar_Util.Inr l,uu____1936,uu____1937) -> FStar_Ident.range_of_lid l
let range_of_arg uu____1954 =
  match uu____1954 with | (hd,uu____1960) -> hd.FStar_Syntax_Syntax.pos
let range_of_args args r =
  FStar_All.pipe_right args
    (FStar_List.fold_left
       (fun r  -> fun a  -> FStar_Range.union_ranges r (range_of_arg a)) r)
let mk_app f args =
  let r = range_of_args args f.FStar_Syntax_Syntax.pos in
  FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (f, args)) None r
let mk_data l args =
  match args with
  | [] ->
      let uu____2074 =
        let uu____2077 =
          let uu____2078 =
            let uu____2083 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant
                (Some FStar_Syntax_Syntax.Data_ctor) in
            (uu____2083,
              (FStar_Syntax_Syntax.Meta_desugared
                 FStar_Syntax_Syntax.Data_app)) in
          FStar_Syntax_Syntax.Tm_meta uu____2078 in
        FStar_Syntax_Syntax.mk uu____2077 in
      uu____2074 None (FStar_Ident.range_of_lid l)
  | uu____2092 ->
      let e =
        let uu____2101 =
          FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant
            (Some FStar_Syntax_Syntax.Data_ctor) in
        mk_app uu____2101 args in
      FStar_Syntax_Syntax.mk
        (FStar_Syntax_Syntax.Tm_meta
           (e,
             (FStar_Syntax_Syntax.Meta_desugared FStar_Syntax_Syntax.Data_app)))
        None e.FStar_Syntax_Syntax.pos
let mangle_field_name: FStar_Ident.ident -> FStar_Ident.ident =
  fun x  ->
    FStar_Ident.mk_ident
      ((Prims.strcat "^fname^" x.FStar_Ident.idText),
        (x.FStar_Ident.idRange))
let unmangle_field_name: FStar_Ident.ident -> FStar_Ident.ident =
  fun x  ->
    if FStar_Util.starts_with x.FStar_Ident.idText "^fname^"
    then
      let uu____2116 =
        let uu____2119 =
          FStar_Util.substring_from x.FStar_Ident.idText
            (Prims.parse_int "7") in
        (uu____2119, (x.FStar_Ident.idRange)) in
      FStar_Ident.mk_ident uu____2116
    else x
let field_projector_prefix: Prims.string = "__proj__"
let field_projector_sep: Prims.string = "__item__"
let field_projector_contains_constructor: Prims.string -> Prims.bool =
  fun s  -> FStar_Util.starts_with s field_projector_prefix
let mk_field_projector_name_from_string:
  Prims.string -> Prims.string -> Prims.string =
  fun constr  ->
    fun field  ->
      Prims.strcat field_projector_prefix
        (Prims.strcat constr (Prims.strcat field_projector_sep field))
let mk_field_projector_name_from_ident:
  FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident =
  fun lid  ->
    fun i  ->
      let j = unmangle_field_name i in
      let jtext = j.FStar_Ident.idText in
      let newi =
        if field_projector_contains_constructor jtext
        then j
        else
          FStar_Ident.mk_ident
            ((mk_field_projector_name_from_string
                (lid.FStar_Ident.ident).FStar_Ident.idText jtext),
              (i.FStar_Ident.idRange)) in
      FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns [newi])
let mk_field_projector_name:
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.bv ->
      Prims.int -> (FStar_Ident.lident* FStar_Syntax_Syntax.bv)
  =
  fun lid  ->
    fun x  ->
      fun i  ->
        let nm =
          let uu____2152 = FStar_Syntax_Syntax.is_null_bv x in
          if uu____2152
          then
            let uu____2153 =
              let uu____2156 =
                let uu____2157 = FStar_Util.string_of_int i in
                Prims.strcat "_" uu____2157 in
              let uu____2158 = FStar_Syntax_Syntax.range_of_bv x in
              (uu____2156, uu____2158) in
            FStar_Ident.mk_ident uu____2153
          else x.FStar_Syntax_Syntax.ppname in
        let y =
          let uu___178_2161 = x in
          {
            FStar_Syntax_Syntax.ppname = nm;
            FStar_Syntax_Syntax.index =
              (uu___178_2161.FStar_Syntax_Syntax.index);
            FStar_Syntax_Syntax.sort =
              (uu___178_2161.FStar_Syntax_Syntax.sort)
          } in
        let uu____2162 = mk_field_projector_name_from_ident lid nm in
        (uu____2162, y)
let set_uvar uv t =
  let uu____2179 = FStar_Unionfind.find uv in
  match uu____2179 with
  | FStar_Syntax_Syntax.Fixed uu____2182 ->
      let uu____2183 =
        let uu____2184 =
          let uu____2185 = FStar_Unionfind.uvar_id uv in
          FStar_All.pipe_left FStar_Util.string_of_int uu____2185 in
        FStar_Util.format1 "Changing a fixed uvar! ?%s\n" uu____2184 in
      failwith uu____2183
  | uu____2187 -> FStar_Unionfind.change uv (FStar_Syntax_Syntax.Fixed t)
let qualifier_equal:
  FStar_Syntax_Syntax.qualifier ->
    FStar_Syntax_Syntax.qualifier -> Prims.bool
  =
  fun q1  ->
    fun q2  ->
      match (q1, q2) with
      | (FStar_Syntax_Syntax.Discriminator
         l1,FStar_Syntax_Syntax.Discriminator l2) ->
          FStar_Ident.lid_equals l1 l2
      | (FStar_Syntax_Syntax.Projector
         (l1a,l1b),FStar_Syntax_Syntax.Projector (l2a,l2b)) ->
          (FStar_Ident.lid_equals l1a l2a) &&
            (l1b.FStar_Ident.idText = l2b.FStar_Ident.idText)
      | (FStar_Syntax_Syntax.RecordType
         (ns1,f1),FStar_Syntax_Syntax.RecordType (ns2,f2))
        |(FStar_Syntax_Syntax.RecordConstructor
          (ns1,f1),FStar_Syntax_Syntax.RecordConstructor (ns2,f2)) ->
          ((((FStar_List.length ns1) = (FStar_List.length ns2)) &&
              (FStar_List.forall2
                 (fun x1  ->
                    fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
                 f1 f2))
             && ((FStar_List.length f1) = (FStar_List.length f2)))
            &&
            (FStar_List.forall2
               (fun x1  ->
                  fun x2  -> x1.FStar_Ident.idText = x2.FStar_Ident.idText)
               f1 f2)
      | uu____2234 -> q1 = q2
let abs:
  (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.lcomp,(FStar_Ident.lident*
                                   FStar_Syntax_Syntax.cflags Prims.list))
        FStar_Util.either Prims.option -> FStar_Syntax_Syntax.term
  =
  fun bs  ->
    fun t  ->
      fun lopt  ->
        if (FStar_List.length bs) = (Prims.parse_int "0")
        then t
        else
          (let close_lopt lopt =
             match lopt with
             | None |Some (FStar_Util.Inr _) -> lopt
             | Some (FStar_Util.Inl lc) ->
                 let uu____2320 =
                   let uu____2326 = FStar_Syntax_Subst.close_lcomp bs lc in
                   FStar_Util.Inl uu____2326 in
                 Some uu____2320 in
           match bs with
           | [] -> t
           | uu____2337 ->
               let body =
                 let uu____2342 = FStar_Syntax_Subst.close bs t in
                 FStar_Syntax_Subst.compress uu____2342 in
               (match ((body.FStar_Syntax_Syntax.n), lopt) with
                | (FStar_Syntax_Syntax.Tm_abs (bs',t,lopt'),None ) ->
                    let uu____2385 =
                      let uu____2388 =
                        let uu____2389 =
                          let uu____2404 =
                            let uu____2408 =
                              FStar_Syntax_Subst.close_binders bs in
                            FStar_List.append uu____2408 bs' in
                          let uu____2414 = close_lopt lopt' in
                          (uu____2404, t, uu____2414) in
                        FStar_Syntax_Syntax.Tm_abs uu____2389 in
                      FStar_Syntax_Syntax.mk uu____2388 in
                    uu____2385 None t.FStar_Syntax_Syntax.pos
                | uu____2440 ->
                    let uu____2449 =
                      let uu____2452 =
                        let uu____2453 =
                          let uu____2468 =
                            FStar_Syntax_Subst.close_binders bs in
                          let uu____2469 = close_lopt lopt in
                          (uu____2468, body, uu____2469) in
                        FStar_Syntax_Syntax.Tm_abs uu____2453 in
                      FStar_Syntax_Syntax.mk uu____2452 in
                    uu____2449 None t.FStar_Syntax_Syntax.pos))
let arrow:
  (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun bs  ->
    fun c  ->
      match bs with
      | [] -> comp_result c
      | uu____2512 ->
          let uu____2516 =
            let uu____2519 =
              let uu____2520 =
                let uu____2528 = FStar_Syntax_Subst.close_binders bs in
                let uu____2529 = FStar_Syntax_Subst.close_comp bs c in
                (uu____2528, uu____2529) in
              FStar_Syntax_Syntax.Tm_arrow uu____2520 in
            FStar_Syntax_Syntax.mk uu____2519 in
          uu____2516 None c.FStar_Syntax_Syntax.pos
let flat_arrow:
  (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list ->
    (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun bs  ->
    fun c  ->
      let t = arrow bs c in
      let uu____2559 =
        let uu____2560 = FStar_Syntax_Subst.compress t in
        uu____2560.FStar_Syntax_Syntax.n in
      match uu____2559 with
      | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
          (match c.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Total (tres,uu____2580) ->
               let uu____2587 =
                 let uu____2588 = FStar_Syntax_Subst.compress tres in
                 uu____2588.FStar_Syntax_Syntax.n in
               (match uu____2587 with
                | FStar_Syntax_Syntax.Tm_arrow (bs',c') ->
                    let uu____2605 = FStar_ST.read t.FStar_Syntax_Syntax.tk in
                    (FStar_Syntax_Syntax.mk
                       (FStar_Syntax_Syntax.Tm_arrow
                          ((FStar_List.append bs bs'), c'))) uu____2605
                      t.FStar_Syntax_Syntax.pos
                | uu____2625 -> t)
           | uu____2626 -> t)
      | uu____2627 -> t
let refine:
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun b  ->
    fun t  ->
      let uu____2636 =
        FStar_ST.read (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.tk in
      let uu____2641 =
        let uu____2642 = FStar_Syntax_Syntax.range_of_bv b in
        FStar_Range.union_ranges uu____2642 t.FStar_Syntax_Syntax.pos in
      let uu____2643 =
        let uu____2646 =
          let uu____2647 =
            let uu____2652 =
              let uu____2653 =
                let uu____2654 = FStar_Syntax_Syntax.mk_binder b in
                [uu____2654] in
              FStar_Syntax_Subst.close uu____2653 t in
            (b, uu____2652) in
          FStar_Syntax_Syntax.Tm_refine uu____2647 in
        FStar_Syntax_Syntax.mk uu____2646 in
      uu____2643 uu____2636 uu____2641
let branch: FStar_Syntax_Syntax.branch -> FStar_Syntax_Syntax.branch =
  fun b  -> FStar_Syntax_Subst.close_branch b
let rec arrow_formals_comp:
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list*
      FStar_Syntax_Syntax.comp)
  =
  fun k  ->
    let k = FStar_Syntax_Subst.compress k in
    match k.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____2692 = FStar_Syntax_Subst.open_comp bs c in
        (match uu____2692 with
         | (bs,c) ->
             let uu____2702 = is_tot_or_gtot_comp c in
             if uu____2702
             then
               let uu____2708 = arrow_formals_comp (comp_result c) in
               (match uu____2708 with
                | (bs',k) -> ((FStar_List.append bs bs'), k))
             else (bs, c))
    | uu____2733 ->
        let uu____2734 = FStar_Syntax_Syntax.mk_Total k in ([], uu____2734)
let rec arrow_formals:
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list*
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax)
  =
  fun k  ->
    let uu____2750 = arrow_formals_comp k in
    match uu____2750 with | (bs,c) -> (bs, (comp_result c))
let abs_formals:
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders* FStar_Syntax_Syntax.term*
      (FStar_Syntax_Syntax.lcomp,(FStar_Ident.lident*
                                   FStar_Syntax_Syntax.cflags Prims.list))
      FStar_Util.either Prims.option)
  =
  fun t  ->
    let subst_lcomp_opt s l =
      match l with
      | Some (FStar_Util.Inl l) ->
          let l =
            let uu___179_2831 = l in
            let uu____2832 =
              FStar_Syntax_Subst.subst s l.FStar_Syntax_Syntax.res_typ in
            {
              FStar_Syntax_Syntax.eff_name =
                (uu___179_2831.FStar_Syntax_Syntax.eff_name);
              FStar_Syntax_Syntax.res_typ = uu____2832;
              FStar_Syntax_Syntax.cflags =
                (uu___179_2831.FStar_Syntax_Syntax.cflags);
              FStar_Syntax_Syntax.comp =
                (fun uu____2835  ->
                   let uu____2836 = l.FStar_Syntax_Syntax.comp () in
                   FStar_Syntax_Subst.subst_comp s uu____2836)
            } in
          Some (FStar_Util.Inl l)
      | uu____2845 -> l in
    let rec aux t abs_body_lcomp =
      let uu____2883 =
        let uu____2884 =
          let uu____2887 = FStar_Syntax_Subst.compress t in
          FStar_All.pipe_left unascribe uu____2887 in
        uu____2884.FStar_Syntax_Syntax.n in
      match uu____2883 with
      | FStar_Syntax_Syntax.Tm_abs (bs,t,what) ->
          let uu____2925 = aux t what in
          (match uu____2925 with
           | (bs',t,what) -> ((FStar_List.append bs bs'), t, what))
      | uu____2982 -> ([], t, abs_body_lcomp) in
    let uu____2994 = aux t None in
    match uu____2994 with
    | (bs,t,abs_body_lcomp) ->
        let uu____3042 = FStar_Syntax_Subst.open_term' bs t in
        (match uu____3042 with
         | (bs,t,opening) ->
             let abs_body_lcomp = subst_lcomp_opt opening abs_body_lcomp in
             (bs, t, abs_body_lcomp))
let mk_letbinding:
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax ->
        FStar_Ident.lident ->
          (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
            FStar_Syntax_Syntax.syntax -> FStar_Syntax_Syntax.letbinding
  =
  fun lbname  ->
    fun univ_vars  ->
      fun typ  ->
        fun eff  ->
          fun def  ->
            {
              FStar_Syntax_Syntax.lbname = lbname;
              FStar_Syntax_Syntax.lbunivs = univ_vars;
              FStar_Syntax_Syntax.lbtyp = typ;
              FStar_Syntax_Syntax.lbeff = eff;
              FStar_Syntax_Syntax.lbdef = def
            }
let close_univs_and_mk_letbinding:
  FStar_Syntax_Syntax.fv Prims.list Prims.option ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
      FStar_Ident.ident Prims.list ->
        FStar_Syntax_Syntax.term ->
          FStar_Ident.lident ->
            FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.letbinding
  =
  fun recs  ->
    fun lbname  ->
      fun univ_vars  ->
        fun typ  ->
          fun eff  ->
            fun def  ->
              let def =
                match (recs, univ_vars) with
                | (None ,_)|(_,[]) -> def
                | (Some fvs,uu____3142) ->
                    let universes =
                      FStar_All.pipe_right univ_vars
                        (FStar_List.map
                           (fun _0_25  -> FStar_Syntax_Syntax.U_name _0_25)) in
                    let inst =
                      FStar_All.pipe_right fvs
                        (FStar_List.map
                           (fun fv  ->
                              (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v),
                                universes))) in
                    FStar_Syntax_InstFV.instantiate inst def in
              let typ = FStar_Syntax_Subst.close_univ_vars univ_vars typ in
              let def = FStar_Syntax_Subst.close_univ_vars univ_vars def in
              mk_letbinding lbname univ_vars typ eff def
let open_univ_vars_binders_and_comp:
  FStar_Syntax_Syntax.univ_names ->
    (FStar_Syntax_Syntax.bv* FStar_Syntax_Syntax.aqual) Prims.list ->
      FStar_Syntax_Syntax.comp ->
        (FStar_Syntax_Syntax.univ_names* (FStar_Syntax_Syntax.bv*
          FStar_Syntax_Syntax.aqual) Prims.list* FStar_Syntax_Syntax.comp)
  =
  fun uvs  ->
    fun binders  ->
      fun c  ->
        match binders with
        | [] ->
            let uu____3203 = FStar_Syntax_Subst.open_univ_vars_comp uvs c in
            (match uu____3203 with | (uvs,c) -> (uvs, [], c))
        | uu____3219 ->
            let t' = arrow binders c in
            let uu____3226 = FStar_Syntax_Subst.open_univ_vars uvs t' in
            (match uu____3226 with
             | (uvs,t') ->
                 let uu____3237 =
                   let uu____3238 = FStar_Syntax_Subst.compress t' in
                   uu____3238.FStar_Syntax_Syntax.n in
                 (match uu____3237 with
                  | FStar_Syntax_Syntax.Tm_arrow (binders,c) ->
                      (uvs, binders, c)
                  | uu____3264 -> failwith "Impossible"))
let is_tuple_constructor: FStar_Syntax_Syntax.typ -> Prims.bool =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Util.starts_with
          ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.str
          "Prims.tuple"
    | uu____3279 -> false
let mk_tuple_lid: Prims.int -> FStar_Range.range -> FStar_Ident.lident =
  fun n  ->
    fun r  ->
      let t =
        let uu____3287 = FStar_Util.string_of_int n in
        FStar_Util.format1 "tuple%s" uu____3287 in
      let uu____3288 = FStar_Syntax_Const.pconst t in
      FStar_Ident.set_lid_range uu____3288 r
let mk_tuple_data_lid: Prims.int -> FStar_Range.range -> FStar_Ident.lident =
  fun n  ->
    fun r  ->
      let t =
        let uu____3296 = FStar_Util.string_of_int n in
        FStar_Util.format1 "Mktuple%s" uu____3296 in
      let uu____3297 = FStar_Syntax_Const.pconst t in
      FStar_Ident.set_lid_range uu____3297 r
let is_tuple_data_lid: FStar_Ident.lident -> Prims.int -> Prims.bool =
  fun f  ->
    fun n  ->
      let uu____3304 = mk_tuple_data_lid n FStar_Range.dummyRange in
      FStar_Ident.lid_equals f uu____3304
let is_tuple_data_lid': FStar_Ident.lident -> Prims.bool =
  fun f  ->
    (f.FStar_Ident.nsstr = "Prims") &&
      (FStar_Util.starts_with (f.FStar_Ident.ident).FStar_Ident.idText
         "Mktuple")
let is_tuple_constructor_lid: FStar_Ident.lident -> Prims.bool =
  fun lid  ->
    FStar_Util.starts_with (FStar_Ident.text_of_lid lid) "Prims.tuple"
let is_dtuple_constructor_lid: FStar_Ident.lident -> Prims.bool =
  fun lid  ->
    (lid.FStar_Ident.nsstr = "Prims") &&
      (FStar_Util.starts_with (lid.FStar_Ident.ident).FStar_Ident.idText
         "Prims.dtuple")
let is_dtuple_constructor: FStar_Syntax_Syntax.typ -> Prims.bool =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        is_dtuple_constructor_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____3322 -> false
let mk_dtuple_lid: Prims.int -> FStar_Range.range -> FStar_Ident.lident =
  fun n  ->
    fun r  ->
      let t =
        let uu____3330 = FStar_Util.string_of_int n in
        FStar_Util.format1 "dtuple%s" uu____3330 in
      let uu____3331 = FStar_Syntax_Const.pconst t in
      FStar_Ident.set_lid_range uu____3331 r
let mk_dtuple_data_lid: Prims.int -> FStar_Range.range -> FStar_Ident.lident
  =
  fun n  ->
    fun r  ->
      let t =
        let uu____3339 = FStar_Util.string_of_int n in
        FStar_Util.format1 "Mkdtuple%s" uu____3339 in
      let uu____3340 = FStar_Syntax_Const.pconst t in
      FStar_Ident.set_lid_range uu____3340 r
let is_dtuple_data_lid': FStar_Ident.lident -> Prims.bool =
  fun f  -> FStar_Util.starts_with (FStar_Ident.text_of_lid f) "Mkdtuple"
let is_lid_equality: FStar_Ident.lident -> Prims.bool =
  fun x  -> FStar_Ident.lid_equals x FStar_Syntax_Const.eq2_lid
let is_forall: FStar_Ident.lident -> Prims.bool =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Syntax_Const.forall_lid
let is_exists: FStar_Ident.lident -> Prims.bool =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Syntax_Const.exists_lid
let is_qlid: FStar_Ident.lident -> Prims.bool =
  fun lid  -> (is_forall lid) || (is_exists lid)
let is_equality x = is_lid_equality x.FStar_Syntax_Syntax.v
let lid_is_connective: FStar_Ident.lident -> Prims.bool =
  let lst =
    [FStar_Syntax_Const.and_lid;
    FStar_Syntax_Const.or_lid;
    FStar_Syntax_Const.not_lid;
    FStar_Syntax_Const.iff_lid;
    FStar_Syntax_Const.imp_lid] in
  fun lid  -> FStar_Util.for_some (FStar_Ident.lid_equals lid) lst
let is_constructor:
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool =
  fun t  ->
    fun lid  ->
      let uu____3378 =
        let uu____3379 = pre_typ t in uu____3379.FStar_Syntax_Syntax.n in
      match uu____3378 with
      | FStar_Syntax_Syntax.Tm_fvar tc ->
          FStar_Ident.lid_equals
            (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v lid
      | uu____3387 -> false
let rec is_constructed_typ:
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool =
  fun t  ->
    fun lid  ->
      let uu____3394 =
        let uu____3395 = pre_typ t in uu____3395.FStar_Syntax_Syntax.n in
      match uu____3394 with
      | FStar_Syntax_Syntax.Tm_fvar uu____3398 -> is_constructor t lid
      | FStar_Syntax_Syntax.Tm_app (t,uu____3400) -> is_constructed_typ t lid
      | uu____3415 -> false
let rec get_tycon:
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term Prims.option =
  fun t  ->
    let t = pre_typ t in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar _
      |FStar_Syntax_Syntax.Tm_name _|FStar_Syntax_Syntax.Tm_fvar _ -> 
        Some t
    | FStar_Syntax_Syntax.Tm_app (t,uu____3426) -> get_tycon t
    | uu____3441 -> None
let is_interpreted: FStar_Ident.lident -> Prims.bool =
  fun l  ->
    let theory_syms =
      [FStar_Syntax_Const.op_Eq;
      FStar_Syntax_Const.op_notEq;
      FStar_Syntax_Const.op_LT;
      FStar_Syntax_Const.op_LTE;
      FStar_Syntax_Const.op_GT;
      FStar_Syntax_Const.op_GTE;
      FStar_Syntax_Const.op_Subtraction;
      FStar_Syntax_Const.op_Minus;
      FStar_Syntax_Const.op_Addition;
      FStar_Syntax_Const.op_Multiply;
      FStar_Syntax_Const.op_Division;
      FStar_Syntax_Const.op_Modulus;
      FStar_Syntax_Const.op_And;
      FStar_Syntax_Const.op_Or;
      FStar_Syntax_Const.op_Negation] in
    FStar_Util.for_some (FStar_Ident.lid_equals l) theory_syms
let ktype:
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax
  =
  (FStar_Syntax_Syntax.mk
     (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)) None
    FStar_Range.dummyRange
let ktype0:
  (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
    FStar_Syntax_Syntax.syntax
  =
  (FStar_Syntax_Syntax.mk
     (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_zero)) None
    FStar_Range.dummyRange
let type_u:
  Prims.unit ->
    ((FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
      FStar_Syntax_Syntax.syntax* FStar_Syntax_Syntax.universe)
  =
  fun uu____3471  ->
    let u =
      let uu____3475 = FStar_Unionfind.fresh None in
      FStar_All.pipe_left (fun _0_26  -> FStar_Syntax_Syntax.U_unif _0_26)
        uu____3475 in
    let uu____3481 =
      (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type u)) None
        FStar_Range.dummyRange in
    (uu____3481, u)
let kt_kt: FStar_Syntax_Syntax.term = FStar_Syntax_Const.kunary ktype0 ktype0
let kt_kt_kt: FStar_Syntax_Syntax.term =
  FStar_Syntax_Const.kbin ktype0 ktype0 ktype0
let fvar_const: FStar_Ident.lident -> FStar_Syntax_Syntax.term =
  fun l  ->
    FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant None
let tand: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.and_lid
let tor: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.or_lid
let timp: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.imp_lid
let tiff: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.iff_lid
let t_bool: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.bool_lid
let t_false: FStar_Syntax_Syntax.term =
  fvar_const FStar_Syntax_Const.false_lid
let t_true: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.true_lid
let b2t_v: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.b2t_lid
let t_not: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.not_lid
let mk_conj_opt:
  FStar_Syntax_Syntax.term Prims.option ->
    FStar_Syntax_Syntax.term ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax Prims.option
  =
  fun phi1  ->
    fun phi2  ->
      match phi1 with
      | None  -> Some phi2
      | Some phi1 ->
          let uu____3508 =
            let uu____3511 =
              FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
                phi2.FStar_Syntax_Syntax.pos in
            let uu____3512 =
              let uu____3515 =
                let uu____3516 =
                  let uu____3526 =
                    let uu____3528 = FStar_Syntax_Syntax.as_arg phi1 in
                    let uu____3529 =
                      let uu____3531 = FStar_Syntax_Syntax.as_arg phi2 in
                      [uu____3531] in
                    uu____3528 :: uu____3529 in
                  (tand, uu____3526) in
                FStar_Syntax_Syntax.Tm_app uu____3516 in
              FStar_Syntax_Syntax.mk uu____3515 in
            uu____3512 None uu____3511 in
          Some uu____3508
let mk_binop op_t phi1 phi2 =
  let uu____3566 =
    FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
      phi2.FStar_Syntax_Syntax.pos in
  let uu____3567 =
    let uu____3570 =
      let uu____3571 =
        let uu____3581 =
          let uu____3583 = FStar_Syntax_Syntax.as_arg phi1 in
          let uu____3584 =
            let uu____3586 = FStar_Syntax_Syntax.as_arg phi2 in [uu____3586] in
          uu____3583 :: uu____3584 in
        (op_t, uu____3581) in
      FStar_Syntax_Syntax.Tm_app uu____3571 in
    FStar_Syntax_Syntax.mk uu____3570 in
  uu____3567 None uu____3566
let mk_neg phi =
  let uu____3607 =
    let uu____3610 =
      let uu____3611 =
        let uu____3621 =
          let uu____3623 = FStar_Syntax_Syntax.as_arg phi in [uu____3623] in
        (t_not, uu____3621) in
      FStar_Syntax_Syntax.Tm_app uu____3611 in
    FStar_Syntax_Syntax.mk uu____3610 in
  uu____3607 None phi.FStar_Syntax_Syntax.pos
let mk_conj phi1 phi2 = mk_binop tand phi1 phi2
let mk_conj_l:
  FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term =
  fun phi  ->
    match phi with
    | [] ->
        FStar_Syntax_Syntax.fvar FStar_Syntax_Const.true_lid
          FStar_Syntax_Syntax.Delta_constant None
    | hd::tl -> FStar_List.fold_right mk_conj tl hd
let mk_disj phi1 phi2 = mk_binop tor phi1 phi2
let mk_disj_l:
  FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term =
  fun phi  ->
    match phi with
    | [] -> t_false
    | hd::tl -> FStar_List.fold_right mk_disj tl hd
let mk_imp:
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun phi1  ->
    fun phi2  ->
      let uu____3683 =
        let uu____3684 = FStar_Syntax_Subst.compress phi1 in
        uu____3684.FStar_Syntax_Syntax.n in
      match uu____3683 with
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.false_lid ->
          t_true
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.true_lid ->
          phi2
      | uu____3689 ->
          let uu____3690 =
            let uu____3691 = FStar_Syntax_Subst.compress phi2 in
            uu____3691.FStar_Syntax_Syntax.n in
          (match uu____3690 with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               (FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.true_lid)
                 ||
                 (FStar_Syntax_Syntax.fv_eq_lid tc
                    FStar_Syntax_Const.false_lid)
               -> phi2
           | uu____3695 -> mk_binop timp phi1 phi2)
let mk_iff phi1 phi2 = mk_binop tiff phi1 phi2
let b2t e =
  let uu____3719 =
    let uu____3722 =
      let uu____3723 =
        let uu____3733 =
          let uu____3735 = FStar_Syntax_Syntax.as_arg e in [uu____3735] in
        (b2t_v, uu____3733) in
      FStar_Syntax_Syntax.Tm_app uu____3723 in
    FStar_Syntax_Syntax.mk uu____3722 in
  uu____3719 None e.FStar_Syntax_Syntax.pos
let teq: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.eq2_lid
let mk_eq t1 t2 e1 e2 =
  let uu____3773 =
    FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
      e2.FStar_Syntax_Syntax.pos in
  let uu____3774 =
    let uu____3777 =
      let uu____3778 =
        let uu____3788 =
          let uu____3790 = FStar_Syntax_Syntax.as_arg e1 in
          let uu____3791 =
            let uu____3793 = FStar_Syntax_Syntax.as_arg e2 in [uu____3793] in
          uu____3790 :: uu____3791 in
        (teq, uu____3788) in
      FStar_Syntax_Syntax.Tm_app uu____3778 in
    FStar_Syntax_Syntax.mk uu____3777 in
  uu____3774 None uu____3773
let mk_has_type t x t' =
  let t_has_type = fvar_const FStar_Syntax_Const.has_type_lid in
  let t_has_type =
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_uinst
         (t_has_type,
           [FStar_Syntax_Syntax.U_zero; FStar_Syntax_Syntax.U_zero])) None
      FStar_Range.dummyRange in
  let uu____3831 =
    let uu____3834 =
      let uu____3835 =
        let uu____3845 =
          let uu____3847 = FStar_Syntax_Syntax.iarg t in
          let uu____3848 =
            let uu____3850 = FStar_Syntax_Syntax.as_arg x in
            let uu____3851 =
              let uu____3853 = FStar_Syntax_Syntax.as_arg t' in [uu____3853] in
            uu____3850 :: uu____3851 in
          uu____3847 :: uu____3848 in
        (t_has_type, uu____3845) in
      FStar_Syntax_Syntax.Tm_app uu____3835 in
    FStar_Syntax_Syntax.mk uu____3834 in
  uu____3831 None FStar_Range.dummyRange
let lex_t: FStar_Syntax_Syntax.term = fvar_const FStar_Syntax_Const.lex_t_lid
let lex_top: FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.lextop_lid
    FStar_Syntax_Syntax.Delta_constant (Some FStar_Syntax_Syntax.Data_ctor)
let lex_pair: FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.lexcons_lid
    FStar_Syntax_Syntax.Delta_constant (Some FStar_Syntax_Syntax.Data_ctor)
let tforall: FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.forall_lid
    (FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "1")) None
let t_haseq: FStar_Syntax_Syntax.term =
  FStar_Syntax_Syntax.fvar FStar_Syntax_Const.haseq_lid
    FStar_Syntax_Syntax.Delta_constant None
let lcomp_of_comp:
  (FStar_Syntax_Syntax.comp',Prims.unit) FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.lcomp
  =
  fun c0  ->
    let uu____3872 =
      match c0.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____3879 ->
          (FStar_Syntax_Const.effect_Tot_lid, [FStar_Syntax_Syntax.TOTAL])
      | FStar_Syntax_Syntax.GTotal uu____3886 ->
          (FStar_Syntax_Const.effect_GTot_lid,
            [FStar_Syntax_Syntax.SOMETRIVIAL])
      | FStar_Syntax_Syntax.Comp c ->
          ((c.FStar_Syntax_Syntax.effect_name),
            (c.FStar_Syntax_Syntax.flags)) in
    match uu____3872 with
    | (eff_name,flags) ->
        {
          FStar_Syntax_Syntax.eff_name = eff_name;
          FStar_Syntax_Syntax.res_typ = (comp_result c0);
          FStar_Syntax_Syntax.cflags = flags;
          FStar_Syntax_Syntax.comp = ((fun uu____3899  -> c0))
        }
let mk_forall:
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.typ ->
      (FStar_Syntax_Syntax.term',FStar_Syntax_Syntax.term')
        FStar_Syntax_Syntax.syntax
  =
  fun x  ->
    fun body  ->
      let uu____3906 =
        let uu____3909 =
          let uu____3910 =
            let uu____3920 =
              let uu____3922 =
                FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort in
              let uu____3923 =
                let uu____3925 =
                  let uu____3926 =
                    let uu____3927 =
                      let uu____3931 = FStar_Syntax_Syntax.mk_binder x in
                      [uu____3931] in
                    let uu____3932 =
                      let uu____3939 =
                        let uu____3945 =
                          let uu____3946 =
                            FStar_Syntax_Syntax.mk_Total ktype0 in
                          FStar_All.pipe_left lcomp_of_comp uu____3946 in
                        FStar_Util.Inl uu____3945 in
                      Some uu____3939 in
                    abs uu____3927 body uu____3932 in
                  FStar_Syntax_Syntax.as_arg uu____3926 in
                [uu____3925] in
              uu____3922 :: uu____3923 in
            (tforall, uu____3920) in
          FStar_Syntax_Syntax.Tm_app uu____3910 in
        FStar_Syntax_Syntax.mk uu____3909 in
      uu____3906 None FStar_Range.dummyRange
let rec close_forall:
  FStar_Syntax_Syntax.binder Prims.list ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ
  =
  fun bs  ->
    fun f  ->
      FStar_List.fold_right
        (fun b  ->
           fun f  ->
             let uu____3978 = FStar_Syntax_Syntax.is_null_binder b in
             if uu____3978 then f else mk_forall (Prims.fst b) f) bs f
let rec is_wild_pat p =
  match p.FStar_Syntax_Syntax.v with
  | FStar_Syntax_Syntax.Pat_wild uu____3991 -> true
  | uu____3992 -> false
let if_then_else b t1 t2 =
  let then_branch =
    let uu____4035 =
      FStar_Syntax_Syntax.withinfo
        (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool true))
        FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n
        t1.FStar_Syntax_Syntax.pos in
    (uu____4035, None, t1) in
  let else_branch =
    let uu____4058 =
      FStar_Syntax_Syntax.withinfo
        (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool false))
        FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n
        t2.FStar_Syntax_Syntax.pos in
    (uu____4058, None, t2) in
  let uu____4070 =
    let uu____4071 =
      FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos
        t2.FStar_Syntax_Syntax.pos in
    FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos uu____4071 in
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_match (b, [then_branch; else_branch])) None
    uu____4070
type qpats = FStar_Syntax_Syntax.args Prims.list
type connective =
  | QAll of (FStar_Syntax_Syntax.binders* qpats* FStar_Syntax_Syntax.typ)
  | QEx of (FStar_Syntax_Syntax.binders* qpats* FStar_Syntax_Syntax.typ)
  | BaseConn of (FStar_Ident.lident* FStar_Syntax_Syntax.args)
let uu___is_QAll: connective -> Prims.bool =
  fun projectee  ->
    match projectee with | QAll _0 -> true | uu____4144 -> false
let __proj__QAll__item___0:
  connective -> (FStar_Syntax_Syntax.binders* qpats* FStar_Syntax_Syntax.typ)
  = fun projectee  -> match projectee with | QAll _0 -> _0
let uu___is_QEx: connective -> Prims.bool =
  fun projectee  ->
    match projectee with | QEx _0 -> true | uu____4168 -> false
let __proj__QEx__item___0:
  connective -> (FStar_Syntax_Syntax.binders* qpats* FStar_Syntax_Syntax.typ)
  = fun projectee  -> match projectee with | QEx _0 -> _0
let uu___is_BaseConn: connective -> Prims.bool =
  fun projectee  ->
    match projectee with | BaseConn _0 -> true | uu____4191 -> false
let __proj__BaseConn__item___0:
  connective -> (FStar_Ident.lident* FStar_Syntax_Syntax.args) =
  fun projectee  -> match projectee with | BaseConn _0 -> _0
let destruct_typ_as_formula:
  FStar_Syntax_Syntax.term -> connective Prims.option =
  fun f  ->
    let rec unmeta_monadic f =
      let f = FStar_Syntax_Subst.compress f in
      match f.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta (t,FStar_Syntax_Syntax.Meta_monadic _)
        |FStar_Syntax_Syntax.Tm_meta
        (t,FStar_Syntax_Syntax.Meta_monadic_lift _) -> unmeta_monadic t
      | uu____4226 -> f in
    let destruct_base_conn f =
      let connectives =
        [(FStar_Syntax_Const.true_lid, (Prims.parse_int "0"));
        (FStar_Syntax_Const.false_lid, (Prims.parse_int "0"));
        (FStar_Syntax_Const.and_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.or_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.imp_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.iff_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.ite_lid, (Prims.parse_int "3"));
        (FStar_Syntax_Const.not_lid, (Prims.parse_int "1"));
        (FStar_Syntax_Const.eq2_lid, (Prims.parse_int "3"));
        (FStar_Syntax_Const.eq2_lid, (Prims.parse_int "2"));
        (FStar_Syntax_Const.eq3_lid, (Prims.parse_int "4"));
        (FStar_Syntax_Const.eq3_lid, (Prims.parse_int "2"))] in
      let rec aux f uu____4271 =
        match uu____4271 with
        | (lid,arity) ->
            let uu____4277 =
              let uu____4287 = unmeta_monadic f in head_and_args uu____4287 in
            (match uu____4277 with
             | (t,args) ->
                 let t = un_uinst t in
                 let uu____4306 =
                   (is_constructor t lid) &&
                     ((FStar_List.length args) = arity) in
                 if uu____4306 then Some (BaseConn (lid, args)) else None) in
      FStar_Util.find_map connectives (aux f) in
    let patterns t =
      let t = FStar_Syntax_Subst.compress t in
      match t.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta (t,FStar_Syntax_Syntax.Meta_pattern pats)
          ->
          let uu____4357 = FStar_Syntax_Subst.compress t in
          (pats, uu____4357)
      | uu____4364 ->
          let uu____4365 = FStar_Syntax_Subst.compress t in ([], uu____4365) in
    let destruct_q_conn t =
      let is_q fa fv =
        if fa
        then is_forall (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
        else is_exists (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
      let flat t =
        let uu____4407 = head_and_args t in
        match uu____4407 with
        | (t,args) ->
            let uu____4438 = un_uinst t in
            let uu____4439 =
              FStar_All.pipe_right args
                (FStar_List.map
                   (fun uu____4455  ->
                      match uu____4455 with
                      | (t,imp) ->
                          let uu____4462 = unascribe t in (uu____4462, imp))) in
            (uu____4438, uu____4439) in
      let rec aux qopt out t =
        let uu____4485 = let uu____4494 = flat t in (qopt, uu____4494) in
        match uu____4485 with
        | (Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _;
                 FStar_Syntax_Syntax.vars = _;_},({
                                                    FStar_Syntax_Syntax.n =
                                                      FStar_Syntax_Syntax.Tm_abs
                                                      (b::[],t2,_);
                                                    FStar_Syntax_Syntax.tk =
                                                      _;
                                                    FStar_Syntax_Syntax.pos =
                                                      _;
                                                    FStar_Syntax_Syntax.vars
                                                      = _;_},_)::[]))
          |(Some
            fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                  FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _;
                  FStar_Syntax_Syntax.vars = _;_},_::({
                                                        FStar_Syntax_Syntax.n
                                                          =
                                                          FStar_Syntax_Syntax.Tm_abs
                                                          (b::[],t2,_);
                                                        FStar_Syntax_Syntax.tk
                                                          = _;
                                                        FStar_Syntax_Syntax.pos
                                                          = _;
                                                        FStar_Syntax_Syntax.vars
                                                          = _;_},_)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _;
               FStar_Syntax_Syntax.vars = _;_},({
                                                  FStar_Syntax_Syntax.n =
                                                    FStar_Syntax_Syntax.Tm_abs
                                                    (b::[],t2,_);
                                                  FStar_Syntax_Syntax.tk = _;
                                                  FStar_Syntax_Syntax.pos = _;
                                                  FStar_Syntax_Syntax.vars =
                                                    _;_},_)::[]))
          |(None
            ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _;
                FStar_Syntax_Syntax.vars = _;_},_::({
                                                      FStar_Syntax_Syntax.n =
                                                        FStar_Syntax_Syntax.Tm_abs
                                                        (b::[],t2,_);
                                                      FStar_Syntax_Syntax.tk
                                                        = _;
                                                      FStar_Syntax_Syntax.pos
                                                        = _;
                                                      FStar_Syntax_Syntax.vars
                                                        = _;_},_)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            aux
              (Some
                 (is_forall
                    (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v))
              (b :: out) t2
        | (Some b,uu____4753) ->
            let bs = FStar_List.rev out in
            let uu____4771 = FStar_Syntax_Subst.open_term bs t in
            (match uu____4771 with
             | (bs,t) ->
                 let uu____4777 = patterns t in
                 (match uu____4777 with
                  | (pats,body) ->
                      if b
                      then Some (QAll (bs, pats, body))
                      else Some (QEx (bs, pats, body))))
        | uu____4815 -> None in
      aux None [] t in
    let phi = unmeta_monadic f in
    let uu____4827 = destruct_base_conn phi in
    match uu____4827 with | Some b -> Some b | None  -> destruct_q_conn phi
let action_as_lb:
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.action -> FStar_Syntax_Syntax.sigelt
  =
  fun eff_lid  ->
    fun a  ->
      let lb =
        let uu____4838 =
          let uu____4841 =
            FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name
              FStar_Syntax_Syntax.Delta_equational None in
          FStar_Util.Inr uu____4841 in
        close_univs_and_mk_letbinding None uu____4838
          a.FStar_Syntax_Syntax.action_univs a.FStar_Syntax_Syntax.action_typ
          FStar_Syntax_Const.effect_Tot_lid a.FStar_Syntax_Syntax.action_defn in
      FStar_Syntax_Syntax.Sig_let
        ((false, [lb]),
          ((a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos),
          [a.FStar_Syntax_Syntax.action_name],
          [FStar_Syntax_Syntax.Visible_default;
          FStar_Syntax_Syntax.Action eff_lid], [])
let mk_reify t =
  let reify_ =
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_reify) None
      t.FStar_Syntax_Syntax.pos in
  let uu____4870 =
    let uu____4873 =
      let uu____4874 =
        let uu____4884 =
          let uu____4886 = FStar_Syntax_Syntax.as_arg t in [uu____4886] in
        (reify_, uu____4884) in
      FStar_Syntax_Syntax.Tm_app uu____4874 in
    FStar_Syntax_Syntax.mk uu____4873 in
  uu____4870 None t.FStar_Syntax_Syntax.pos
let rec delta_qualifier:
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth =
  fun t  ->
    let t = FStar_Syntax_Subst.compress t in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____4902 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_fvar fv -> fv.FStar_Syntax_Syntax.fv_delta
    | FStar_Syntax_Syntax.Tm_bvar _
      |FStar_Syntax_Syntax.Tm_name _
       |FStar_Syntax_Syntax.Tm_match _
        |FStar_Syntax_Syntax.Tm_uvar _|FStar_Syntax_Syntax.Tm_unknown  ->
        FStar_Syntax_Syntax.Delta_equational
    | FStar_Syntax_Syntax.Tm_type _
      |FStar_Syntax_Syntax.Tm_constant _|FStar_Syntax_Syntax.Tm_arrow _ ->
        FStar_Syntax_Syntax.Delta_constant
    | FStar_Syntax_Syntax.Tm_uinst (t,_)
      |FStar_Syntax_Syntax.Tm_refine
       ({ FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _;
          FStar_Syntax_Syntax.sort = t;_},_)
       |FStar_Syntax_Syntax.Tm_meta (t,_)
        |FStar_Syntax_Syntax.Tm_ascribed (t,_,_)
         |FStar_Syntax_Syntax.Tm_app (t,_)
          |FStar_Syntax_Syntax.Tm_abs (_,t,_)|FStar_Syntax_Syntax.Tm_let
           (_,t)
        -> delta_qualifier t
let incr_delta_qualifier:
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth =
  fun t  ->
    let d = delta_qualifier t in
    let rec aux d =
      match d with
      | FStar_Syntax_Syntax.Delta_equational  -> d
      | FStar_Syntax_Syntax.Delta_constant  ->
          FStar_Syntax_Syntax.Delta_defined_at_level (Prims.parse_int "1")
      | FStar_Syntax_Syntax.Delta_defined_at_level i ->
          FStar_Syntax_Syntax.Delta_defined_at_level
            (i + (Prims.parse_int "1"))
      | FStar_Syntax_Syntax.Delta_abstract d -> aux d in
    aux d
let is_unknown: FStar_Syntax_Syntax.term -> Prims.bool =
  fun t  ->
    let uu____5008 =
      let uu____5009 = FStar_Syntax_Subst.compress t in
      uu____5009.FStar_Syntax_Syntax.n in
    match uu____5008 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____5012 -> false
let rec list_elements:
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term Prims.list Prims.option
  =
  fun e  ->
    let uu____5020 = let uu____5030 = unmeta e in head_and_args uu____5030 in
    match uu____5020 with
    | (head,args) ->
        let uu____5049 =
          let uu____5057 =
            let uu____5058 = un_uinst head in
            uu____5058.FStar_Syntax_Syntax.n in
          (uu____5057, args) in
        (match uu____5049 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,uu____5069) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.nil_lid ->
             Some []
         | (FStar_Syntax_Syntax.Tm_fvar
            fv,uu____5082::(hd,uu____5084)::(tl,uu____5086)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.cons_lid ->
             let uu____5120 =
               let uu____5124 =
                 let uu____5128 = list_elements tl in
                 FStar_Util.must uu____5128 in
               hd :: uu____5124 in
             Some uu____5120
         | uu____5137 -> None)