open Prims
let (tts_f :
  (FStar_Syntax_Syntax.term -> Prims.string) FStar_Pervasives_Native.option
    FStar_ST.ref)
  = FStar_Util.mk_ref FStar_Pervasives_Native.None 
let (tts : FStar_Syntax_Syntax.term -> Prims.string) =
  fun t  ->
    let uu____32 = FStar_ST.op_Bang tts_f  in
    match uu____32 with
    | FStar_Pervasives_Native.None  -> "<<hook unset>>"
    | FStar_Pervasives_Native.Some f -> f t
  
let (qual_id : FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident)
  =
  fun lid  ->
    fun id1  ->
      let uu____91 =
        FStar_Ident.lid_of_ids
          (FStar_List.append lid.FStar_Ident.ns [lid.FStar_Ident.ident; id1])
         in
      FStar_Ident.set_lid_range uu____91 id1.FStar_Ident.idRange
  
let (mk_discriminator : FStar_Ident.lident -> FStar_Ident.lident) =
  fun lid  ->
    let uu____97 =
      let uu____100 =
        let uu____103 =
          FStar_Ident.mk_ident
            ((Prims.strcat FStar_Ident.reserved_prefix
                (Prims.strcat "is_"
                   (lid.FStar_Ident.ident).FStar_Ident.idText)),
              ((lid.FStar_Ident.ident).FStar_Ident.idRange))
           in
        [uu____103]  in
      FStar_List.append lid.FStar_Ident.ns uu____100  in
    FStar_Ident.lid_of_ids uu____97
  
let (is_name : FStar_Ident.lident -> Prims.bool) =
  fun lid  ->
    let c =
      FStar_Util.char_at (lid.FStar_Ident.ident).FStar_Ident.idText
        (Prims.parse_int "0")
       in
    FStar_Util.is_upper c
  
let arg_of_non_null_binder :
  'Auu____114 .
    (FStar_Syntax_Syntax.bv,'Auu____114) FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.term,'Auu____114) FStar_Pervasives_Native.tuple2
  =
  fun uu____127  ->
    match uu____127 with
    | (b,imp) ->
        let uu____134 = FStar_Syntax_Syntax.bv_to_name b  in (uu____134, imp)
  
let (args_of_non_null_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.collect
         (fun b  ->
            let uu____173 = FStar_Syntax_Syntax.is_null_binder b  in
            if uu____173
            then []
            else (let uu____185 = arg_of_non_null_binder b  in [uu____185])))
  
let (args_of_binders :
  FStar_Syntax_Syntax.binders ->
    (FStar_Syntax_Syntax.binders,FStar_Syntax_Syntax.args)
      FStar_Pervasives_Native.tuple2)
  =
  fun binders  ->
    let uu____211 =
      FStar_All.pipe_right binders
        (FStar_List.map
           (fun b  ->
              let uu____275 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____275
              then
                let b1 =
                  let uu____293 =
                    FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                      (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                     in
                  (uu____293, (FStar_Pervasives_Native.snd b))  in
                let uu____294 = arg_of_non_null_binder b1  in (b1, uu____294)
              else
                (let uu____308 = arg_of_non_null_binder b  in (b, uu____308))))
       in
    FStar_All.pipe_right uu____211 FStar_List.unzip
  
let (name_binders :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_List.mapi
         (fun i  ->
            fun b  ->
              let uu____408 = FStar_Syntax_Syntax.is_null_binder b  in
              if uu____408
              then
                let uu____413 = b  in
                match uu____413 with
                | (a,imp) ->
                    let b1 =
                      let uu____425 =
                        let uu____426 = FStar_Util.string_of_int i  in
                        Prims.strcat "_" uu____426  in
                      FStar_Ident.id_of_text uu____425  in
                    let b2 =
                      {
                        FStar_Syntax_Syntax.ppname = b1;
                        FStar_Syntax_Syntax.index = (Prims.parse_int "0");
                        FStar_Syntax_Syntax.sort =
                          (a.FStar_Syntax_Syntax.sort)
                      }  in
                    (b2, imp)
              else b))
  
let (name_function_binders :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (binders,comp) ->
        let uu____460 =
          let uu____467 =
            let uu____468 =
              let uu____481 = name_binders binders  in (uu____481, comp)  in
            FStar_Syntax_Syntax.Tm_arrow uu____468  in
          FStar_Syntax_Syntax.mk uu____467  in
        uu____460 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
    | uu____499 -> t
  
let (null_binders_of_tks :
  (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list -> FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____535  ->
            match uu____535 with
            | (t,imp) ->
                let uu____546 =
                  let uu____547 = FStar_Syntax_Syntax.null_binder t  in
                  FStar_All.pipe_left FStar_Pervasives_Native.fst uu____547
                   in
                (uu____546, imp)))
  
let (binders_of_tks :
  (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list -> FStar_Syntax_Syntax.binders)
  =
  fun tks  ->
    FStar_All.pipe_right tks
      (FStar_List.map
         (fun uu____595  ->
            match uu____595 with
            | (t,imp) ->
                let uu____612 =
                  FStar_Syntax_Syntax.new_bv
                    (FStar_Pervasives_Native.Some (t.FStar_Syntax_Syntax.pos))
                    t
                   in
                (uu____612, imp)))
  
let (binders_of_freevars :
  FStar_Syntax_Syntax.bv FStar_Util.set ->
    FStar_Syntax_Syntax.binder Prims.list)
  =
  fun fvs  ->
    let uu____624 = FStar_Util.set_elements fvs  in
    FStar_All.pipe_right uu____624
      (FStar_List.map FStar_Syntax_Syntax.mk_binder)
  
let mk_subst : 'Auu____635 . 'Auu____635 -> 'Auu____635 Prims.list =
  fun s  -> [s] 
let (subst_of_list :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.subst_t)
  =
  fun formals  ->
    fun actuals  ->
      if (FStar_List.length formals) = (FStar_List.length actuals)
      then
        FStar_List.fold_right2
          (fun f  ->
             fun a  ->
               fun out  ->
                 (FStar_Syntax_Syntax.NT
                    ((FStar_Pervasives_Native.fst f),
                      (FStar_Pervasives_Native.fst a)))
                 :: out) formals actuals []
      else failwith "Ill-formed substitution"
  
let (rename_binders :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.subst_t)
  =
  fun replace_xs  ->
    fun with_ys  ->
      if (FStar_List.length replace_xs) = (FStar_List.length with_ys)
      then
        FStar_List.map2
          (fun uu____731  ->
             fun uu____732  ->
               match (uu____731, uu____732) with
               | ((x,uu____750),(y,uu____752)) ->
                   let uu____761 =
                     let uu____768 = FStar_Syntax_Syntax.bv_to_name y  in
                     (x, uu____768)  in
                   FStar_Syntax_Syntax.NT uu____761) replace_xs with_ys
      else failwith "Ill-formed substitution"
  
let rec (unmeta : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e2,uu____781) -> unmeta e2
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____787,uu____788) -> unmeta e2
    | uu____829 -> e1
  
let rec (unmeta_safe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_meta (e',m) ->
        (match m with
         | FStar_Syntax_Syntax.Meta_monadic uu____842 -> e1
         | FStar_Syntax_Syntax.Meta_monadic_lift uu____849 -> e1
         | uu____858 -> unmeta_safe e')
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____860,uu____861) ->
        unmeta_safe e2
    | uu____902 -> e1
  
let rec (univ_kernel :
  FStar_Syntax_Syntax.universe ->
    (FStar_Syntax_Syntax.universe,Prims.int) FStar_Pervasives_Native.tuple2)
  =
  fun u  ->
    match u with
    | FStar_Syntax_Syntax.U_unknown  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_name uu____916 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_unif uu____917 -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_zero  -> (u, (Prims.parse_int "0"))
    | FStar_Syntax_Syntax.U_succ u1 ->
        let uu____927 = univ_kernel u1  in
        (match uu____927 with | (k,n1) -> (k, (n1 + (Prims.parse_int "1"))))
    | FStar_Syntax_Syntax.U_max uu____938 ->
        failwith "Imposible: univ_kernel (U_max _)"
    | FStar_Syntax_Syntax.U_bvar uu____945 ->
        failwith "Imposible: univ_kernel (U_bvar _)"
  
let (constant_univ_as_nat : FStar_Syntax_Syntax.universe -> Prims.int) =
  fun u  ->
    let uu____955 = univ_kernel u  in FStar_Pervasives_Native.snd uu____955
  
let rec (compare_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.int)
  =
  fun u1  ->
    fun u2  ->
      match (u1, u2) with
      | (FStar_Syntax_Syntax.U_bvar uu____970,uu____971) ->
          failwith "Impossible: compare_univs"
      | (uu____972,FStar_Syntax_Syntax.U_bvar uu____973) ->
          failwith "Impossible: compare_univs"
      | (FStar_Syntax_Syntax.U_unknown ,FStar_Syntax_Syntax.U_unknown ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_unknown ,uu____974) ->
          ~- (Prims.parse_int "1")
      | (uu____975,FStar_Syntax_Syntax.U_unknown ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_zero ,FStar_Syntax_Syntax.U_zero ) ->
          (Prims.parse_int "0")
      | (FStar_Syntax_Syntax.U_zero ,uu____976) -> ~- (Prims.parse_int "1")
      | (uu____977,FStar_Syntax_Syntax.U_zero ) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_name u11,FStar_Syntax_Syntax.U_name u21) ->
          FStar_String.compare u11.FStar_Ident.idText u21.FStar_Ident.idText
      | (FStar_Syntax_Syntax.U_name uu____980,FStar_Syntax_Syntax.U_unif
         uu____981) -> ~- (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif uu____990,FStar_Syntax_Syntax.U_name
         uu____991) -> (Prims.parse_int "1")
      | (FStar_Syntax_Syntax.U_unif u11,FStar_Syntax_Syntax.U_unif u21) ->
          let uu____1018 = FStar_Syntax_Unionfind.univ_uvar_id u11  in
          let uu____1019 = FStar_Syntax_Unionfind.univ_uvar_id u21  in
          uu____1018 - uu____1019
      | (FStar_Syntax_Syntax.U_max us1,FStar_Syntax_Syntax.U_max us2) ->
          let n1 = FStar_List.length us1  in
          let n2 = FStar_List.length us2  in
          if n1 <> n2
          then n1 - n2
          else
            (let copt =
               let uu____1050 = FStar_List.zip us1 us2  in
               FStar_Util.find_map uu____1050
                 (fun uu____1065  ->
                    match uu____1065 with
                    | (u11,u21) ->
                        let c = compare_univs u11 u21  in
                        if c <> (Prims.parse_int "0")
                        then FStar_Pervasives_Native.Some c
                        else FStar_Pervasives_Native.None)
                in
             match copt with
             | FStar_Pervasives_Native.None  -> (Prims.parse_int "0")
             | FStar_Pervasives_Native.Some c -> c)
      | (FStar_Syntax_Syntax.U_max uu____1079,uu____1080) ->
          ~- (Prims.parse_int "1")
      | (uu____1083,FStar_Syntax_Syntax.U_max uu____1084) ->
          (Prims.parse_int "1")
      | uu____1087 ->
          let uu____1092 = univ_kernel u1  in
          (match uu____1092 with
           | (k1,n1) ->
               let uu____1099 = univ_kernel u2  in
               (match uu____1099 with
                | (k2,n2) ->
                    let r = compare_univs k1 k2  in
                    if r = (Prims.parse_int "0") then n1 - n2 else r))
  
let (eq_univs :
  FStar_Syntax_Syntax.universe -> FStar_Syntax_Syntax.universe -> Prims.bool)
  =
  fun u1  ->
    fun u2  ->
      let uu____1118 = compare_univs u1 u2  in
      uu____1118 = (Prims.parse_int "0")
  
let (ml_comp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Range.range -> FStar_Syntax_Syntax.comp)
  =
  fun t  ->
    fun r  ->
      let uu____1133 =
        let uu____1134 =
          FStar_Ident.set_lid_range FStar_Parser_Const.effect_ML_lid r  in
        {
          FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_zero];
          FStar_Syntax_Syntax.effect_name = uu____1134;
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = [FStar_Syntax_Syntax.MLEFFECT]
        }  in
      FStar_Syntax_Syntax.mk_Comp uu____1133
  
let (comp_effect_name :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> FStar_Ident.lident)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1.FStar_Syntax_Syntax.effect_name
    | FStar_Syntax_Syntax.Total uu____1151 ->
        FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.GTotal uu____1160 ->
        FStar_Parser_Const.effect_GTot_lid
  
let (comp_flags :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.cflags Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1182 -> [FStar_Syntax_Syntax.TOTAL]
    | FStar_Syntax_Syntax.GTotal uu____1191 ->
        [FStar_Syntax_Syntax.SOMETRIVIAL]
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.flags
  
let (comp_to_comp_typ_nouniv :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,u_opt) ->
        let uu____1217 =
          let uu____1218 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1218  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1217;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,u_opt) ->
        let uu____1245 =
          let uu____1246 = FStar_Util.map_opt u_opt (fun x  -> [x])  in
          FStar_Util.dflt [] uu____1246  in
        {
          FStar_Syntax_Syntax.comp_univs = uu____1245;
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
  
let (comp_set_flags :
  FStar_Syntax_Syntax.comp ->
    FStar_Syntax_Syntax.cflags Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    fun f  ->
      let uu___78_1279 = c  in
      let uu____1280 =
        let uu____1281 =
          let uu___79_1282 = comp_to_comp_typ_nouniv c  in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___79_1282.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___79_1282.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___79_1282.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args =
              (uu___79_1282.FStar_Syntax_Syntax.effect_args);
            FStar_Syntax_Syntax.flags = f
          }  in
        FStar_Syntax_Syntax.Comp uu____1281  in
      {
        FStar_Syntax_Syntax.n = uu____1280;
        FStar_Syntax_Syntax.pos = (uu___78_1279.FStar_Syntax_Syntax.pos);
        FStar_Syntax_Syntax.vars = (uu___78_1279.FStar_Syntax_Syntax.vars)
      }
  
let (lcomp_set_flags :
  FStar_Syntax_Syntax.lcomp ->
    FStar_Syntax_Syntax.cflags Prims.list -> FStar_Syntax_Syntax.lcomp)
  =
  fun lc  ->
    fun fs  ->
      let comp_typ_set_flags c =
        match c.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Total uu____1307 -> c
        | FStar_Syntax_Syntax.GTotal uu____1316 -> c
        | FStar_Syntax_Syntax.Comp ct ->
            let ct1 =
              let uu___80_1327 = ct  in
              {
                FStar_Syntax_Syntax.comp_univs =
                  (uu___80_1327.FStar_Syntax_Syntax.comp_univs);
                FStar_Syntax_Syntax.effect_name =
                  (uu___80_1327.FStar_Syntax_Syntax.effect_name);
                FStar_Syntax_Syntax.result_typ =
                  (uu___80_1327.FStar_Syntax_Syntax.result_typ);
                FStar_Syntax_Syntax.effect_args =
                  (uu___80_1327.FStar_Syntax_Syntax.effect_args);
                FStar_Syntax_Syntax.flags = fs
              }  in
            let uu___81_1328 = c  in
            {
              FStar_Syntax_Syntax.n = (FStar_Syntax_Syntax.Comp ct1);
              FStar_Syntax_Syntax.pos =
                (uu___81_1328.FStar_Syntax_Syntax.pos);
              FStar_Syntax_Syntax.vars =
                (uu___81_1328.FStar_Syntax_Syntax.vars)
            }
         in
      FStar_Syntax_Syntax.mk_lcomp lc.FStar_Syntax_Syntax.eff_name
        lc.FStar_Syntax_Syntax.res_typ fs
        (fun uu____1331  ->
           let uu____1332 = FStar_Syntax_Syntax.lcomp_comp lc  in
           comp_typ_set_flags uu____1332)
  
let (comp_to_comp_typ :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp_typ) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 -> c1
    | FStar_Syntax_Syntax.Total (t,FStar_Pervasives_Native.Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | FStar_Syntax_Syntax.GTotal (t,FStar_Pervasives_Native.Some u) ->
        {
          FStar_Syntax_Syntax.comp_univs = [u];
          FStar_Syntax_Syntax.effect_name = (comp_effect_name c);
          FStar_Syntax_Syntax.result_typ = t;
          FStar_Syntax_Syntax.effect_args = [];
          FStar_Syntax_Syntax.flags = (comp_flags c)
        }
    | uu____1367 ->
        failwith "Assertion failed: Computation type without universe"
  
let (is_named_tot :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Tot_lid
    | FStar_Syntax_Syntax.Total uu____1378 -> true
    | FStar_Syntax_Syntax.GTotal uu____1387 -> false
  
let (is_total_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals (comp_effect_name c)
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right (comp_flags c)
         (FStar_Util.for_some
            (fun uu___66_1408  ->
               match uu___66_1408 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1409 -> false)))
  
let (is_total_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
       FStar_Parser_Const.effect_Tot_lid)
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___67_1418  ->
               match uu___67_1418 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1419 -> false)))
  
let (is_tot_or_gtot_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    ((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
        FStar_Parser_Const.effect_Tot_lid)
       ||
       (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name
          FStar_Parser_Const.effect_GTot_lid))
      ||
      (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___68_1428  ->
               match uu___68_1428 with
               | FStar_Syntax_Syntax.TOTAL  -> true
               | FStar_Syntax_Syntax.RETURN  -> true
               | uu____1429 -> false)))
  
let (is_partial_return :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___69_1442  ->
            match uu___69_1442 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1443 -> false))
  
let (is_lcomp_partial_return : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags
      (FStar_Util.for_some
         (fun uu___70_1452  ->
            match uu___70_1452 with
            | FStar_Syntax_Syntax.RETURN  -> true
            | FStar_Syntax_Syntax.PARTIAL_RETURN  -> true
            | uu____1453 -> false))
  
let (is_tot_or_gtot_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    (is_total_comp c) ||
      (FStar_Ident.lid_equals FStar_Parser_Const.effect_GTot_lid
         (comp_effect_name c))
  
let (is_pure_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Parser_Const.effect_Tot_lid) ||
       (FStar_Ident.lid_equals l FStar_Parser_Const.effect_PURE_lid))
      || (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Pure_lid)
  
let (is_pure_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____1477 -> true
    | FStar_Syntax_Syntax.GTotal uu____1486 -> false
    | FStar_Syntax_Syntax.Comp ct ->
        ((is_total_comp c) ||
           (is_pure_effect ct.FStar_Syntax_Syntax.effect_name))
          ||
          (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___71_1499  ->
                   match uu___71_1499 with
                   | FStar_Syntax_Syntax.LEMMA  -> true
                   | uu____1500 -> false)))
  
let (is_ghost_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals FStar_Parser_Const.effect_GTot_lid l) ||
       (FStar_Ident.lid_equals FStar_Parser_Const.effect_GHOST_lid l))
      || (FStar_Ident.lid_equals FStar_Parser_Const.effect_Ghost_lid l)
  
let (is_div_effect : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    ((FStar_Ident.lid_equals l FStar_Parser_Const.effect_DIV_lid) ||
       (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Div_lid))
      || (FStar_Ident.lid_equals l FStar_Parser_Const.effect_Dv_lid)
  
let (is_pure_or_ghost_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  -> (is_pure_comp c) || (is_ghost_effect (comp_effect_name c)) 
let (is_pure_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun lc  ->
    ((is_total_lcomp lc) || (is_pure_effect lc.FStar_Syntax_Syntax.eff_name))
      ||
      (FStar_All.pipe_right lc.FStar_Syntax_Syntax.cflags
         (FStar_Util.for_some
            (fun uu___72_1528  ->
               match uu___72_1528 with
               | FStar_Syntax_Syntax.LEMMA  -> true
               | uu____1529 -> false)))
  
let (is_pure_or_ghost_lcomp : FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun lc  ->
    (is_pure_lcomp lc) || (is_ghost_effect lc.FStar_Syntax_Syntax.eff_name)
  
let (is_pure_or_ghost_function : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1540 =
      let uu____1541 = FStar_Syntax_Subst.compress t  in
      uu____1541.FStar_Syntax_Syntax.n  in
    match uu____1540 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1544,c) -> is_pure_or_ghost_comp c
    | uu____1562 -> true
  
let (is_lemma_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp ct ->
        FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
          FStar_Parser_Const.effect_Lemma_lid
    | uu____1573 -> false
  
let (is_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1579 =
      let uu____1580 = FStar_Syntax_Subst.compress t  in
      uu____1580.FStar_Syntax_Syntax.n  in
    match uu____1579 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1583,c) -> is_lemma_comp c
    | uu____1601 -> false
  
let (head_and_args :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,(FStar_Syntax_Syntax.term'
                                                             FStar_Syntax_Syntax.syntax,
                                                            FStar_Syntax_Syntax.aqual)
                                                            FStar_Pervasives_Native.tuple2
                                                            Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) -> (head1, args)
    | uu____1668 -> (t1, [])
  
let rec (head_and_args' :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.term,(FStar_Syntax_Syntax.term'
                                 FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
                                FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_app (head1,args) ->
        let uu____1735 = head_and_args' head1  in
        (match uu____1735 with
         | (head2,args') -> (head2, (FStar_List.append args' args)))
    | uu____1792 -> (t1, [])
  
let (un_uinst : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____1814) ->
        FStar_Syntax_Subst.compress t2
    | uu____1819 -> t1
  
let (is_smt_lemma : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1825 =
      let uu____1826 = FStar_Syntax_Subst.compress t  in
      uu____1826.FStar_Syntax_Syntax.n  in
    match uu____1825 with
    | FStar_Syntax_Syntax.Tm_arrow (uu____1829,c) ->
        (match c.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.Comp ct when
             FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
               FStar_Parser_Const.effect_Lemma_lid
             ->
             (match ct.FStar_Syntax_Syntax.effect_args with
              | _req::_ens::(pats,uu____1851)::uu____1852 ->
                  let pats' = unmeta pats  in
                  let uu____1896 = head_and_args pats'  in
                  (match uu____1896 with
                   | (head1,uu____1912) ->
                       let uu____1933 =
                         let uu____1934 = un_uinst head1  in
                         uu____1934.FStar_Syntax_Syntax.n  in
                       (match uu____1933 with
                        | FStar_Syntax_Syntax.Tm_fvar fv ->
                            FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.cons_lid
                        | uu____1938 -> false))
              | uu____1939 -> false)
         | uu____1948 -> false)
    | uu____1949 -> false
  
let (is_ml_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Comp c1 ->
        (FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name
           FStar_Parser_Const.effect_ML_lid)
          ||
          (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags
             (FStar_Util.for_some
                (fun uu___73_1963  ->
                   match uu___73_1963 with
                   | FStar_Syntax_Syntax.MLEFFECT  -> true
                   | uu____1964 -> false)))
    | uu____1965 -> false
  
let (comp_result :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total (t,uu____1980) -> t
    | FStar_Syntax_Syntax.GTotal (t,uu____1990) -> t
    | FStar_Syntax_Syntax.Comp ct -> ct.FStar_Syntax_Syntax.result_typ
  
let (set_result_typ :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp)
  =
  fun c  ->
    fun t  ->
      match c.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____2018 ->
          FStar_Syntax_Syntax.mk_Total t
      | FStar_Syntax_Syntax.GTotal uu____2027 ->
          FStar_Syntax_Syntax.mk_GTotal t
      | FStar_Syntax_Syntax.Comp ct ->
          FStar_Syntax_Syntax.mk_Comp
            (let uu___82_2039 = ct  in
             {
               FStar_Syntax_Syntax.comp_univs =
                 (uu___82_2039.FStar_Syntax_Syntax.comp_univs);
               FStar_Syntax_Syntax.effect_name =
                 (uu___82_2039.FStar_Syntax_Syntax.effect_name);
               FStar_Syntax_Syntax.result_typ = t;
               FStar_Syntax_Syntax.effect_args =
                 (uu___82_2039.FStar_Syntax_Syntax.effect_args);
               FStar_Syntax_Syntax.flags =
                 (uu___82_2039.FStar_Syntax_Syntax.flags)
             })
  
let (is_trivial_wp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun c  ->
    FStar_All.pipe_right (comp_flags c)
      (FStar_Util.for_some
         (fun uu___74_2052  ->
            match uu___74_2052 with
            | FStar_Syntax_Syntax.TOTAL  -> true
            | FStar_Syntax_Syntax.RETURN  -> true
            | uu____2053 -> false))
  
let (primops : FStar_Ident.lident Prims.list) =
  [FStar_Parser_Const.op_Eq;
  FStar_Parser_Const.op_notEq;
  FStar_Parser_Const.op_LT;
  FStar_Parser_Const.op_LTE;
  FStar_Parser_Const.op_GT;
  FStar_Parser_Const.op_GTE;
  FStar_Parser_Const.op_Subtraction;
  FStar_Parser_Const.op_Minus;
  FStar_Parser_Const.op_Addition;
  FStar_Parser_Const.op_Multiply;
  FStar_Parser_Const.op_Division;
  FStar_Parser_Const.op_Modulus;
  FStar_Parser_Const.op_And;
  FStar_Parser_Const.op_Or;
  FStar_Parser_Const.op_Negation] 
let (is_primop_lid : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    FStar_All.pipe_right primops
      (FStar_Util.for_some (FStar_Ident.lid_equals l))
  
let (is_primop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> Prims.bool) =
  fun f  ->
    match f.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        is_primop_lid (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____2073 -> false
  
let rec (unascribe : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun e  ->
    let e1 = FStar_Syntax_Subst.compress e  in
    match e1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_ascribed (e2,uu____2081,uu____2082) ->
        unascribe e2
    | uu____2123 -> e1
  
let rec (ascribe :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    ((FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.comp'
                                                             FStar_Syntax_Syntax.syntax)
       FStar_Util.either,FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
                           FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple2 ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    fun k  ->
      match t.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_ascribed (t',uu____2175,uu____2176) ->
          ascribe t' k
      | uu____2217 ->
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_ascribed
               (t, k, FStar_Pervasives_Native.None))
            FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let (unfold_lazy : FStar_Syntax_Syntax.lazyinfo -> FStar_Syntax_Syntax.term)
  =
  fun i  ->
    let uu____2243 =
      let uu____2252 = FStar_ST.op_Bang FStar_Syntax_Syntax.lazy_chooser  in
      FStar_Util.must uu____2252  in
    uu____2243 i.FStar_Syntax_Syntax.lkind i
  
let rec (unlazy : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let uu____2311 =
      let uu____2312 = FStar_Syntax_Subst.compress t  in
      uu____2312.FStar_Syntax_Syntax.n  in
    match uu____2311 with
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____2316 = unfold_lazy i  in
        FStar_All.pipe_left unlazy uu____2316
    | uu____2317 -> t
  
let mk_lazy :
  'a .
    'a ->
      FStar_Syntax_Syntax.typ ->
        FStar_Syntax_Syntax.lazy_kind ->
          FStar_Range.range FStar_Pervasives_Native.option ->
            FStar_Syntax_Syntax.term
  =
  fun t  ->
    fun typ  ->
      fun k  ->
        fun r  ->
          let rng =
            match r with
            | FStar_Pervasives_Native.Some r1 -> r1
            | FStar_Pervasives_Native.None  -> FStar_Range.dummyRange  in
          let i =
            let uu____2356 = FStar_Dyn.mkdyn t  in
            {
              FStar_Syntax_Syntax.blob = uu____2356;
              FStar_Syntax_Syntax.lkind = k;
              FStar_Syntax_Syntax.typ = typ;
              FStar_Syntax_Syntax.rng = rng
            }  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_lazy i)
            FStar_Pervasives_Native.None rng
  
let (canon_app :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____2368 =
      let uu____2381 = unascribe t  in head_and_args' uu____2381  in
    match uu____2368 with
    | (hd1,args) ->
        FStar_Syntax_Syntax.mk_Tm_app hd1 args FStar_Pervasives_Native.None
          t.FStar_Syntax_Syntax.pos
  
type eq_result =
  | Equal 
  | NotEqual 
  | Unknown [@@deriving show]
let (uu___is_Equal : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Equal  -> true | uu____2407 -> false
  
let (uu___is_NotEqual : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | NotEqual  -> true | uu____2413 -> false
  
let (uu___is_Unknown : eq_result -> Prims.bool) =
  fun projectee  ->
    match projectee with | Unknown  -> true | uu____2419 -> false
  
let (injectives : Prims.string Prims.list) =
  ["FStar.Int8.int_to_t";
  "FStar.Int16.int_to_t";
  "FStar.Int32.int_to_t";
  "FStar.Int64.int_to_t";
  "FStar.UInt8.uint_to_t";
  "FStar.UInt16.uint_to_t";
  "FStar.UInt32.uint_to_t";
  "FStar.UInt64.uint_to_t";
  "FStar.Int8.__int_to_t";
  "FStar.Int16.__int_to_t";
  "FStar.Int32.__int_to_t";
  "FStar.Int64.__int_to_t";
  "FStar.UInt8.__uint_to_t";
  "FStar.UInt16.__uint_to_t";
  "FStar.UInt32.__uint_to_t";
  "FStar.UInt64.__uint_to_t"] 
let rec (eq_tm :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> eq_result) =
  fun t1  ->
    fun t2  ->
      let t11 = canon_app t1  in
      let t21 = canon_app t2  in
      let equal_if uu___75_2495 = if uu___75_2495 then Equal else Unknown  in
      let equal_iff uu___76_2502 = if uu___76_2502 then Equal else NotEqual
         in
      let eq_and f g = match f with | Equal  -> g () | uu____2520 -> Unknown
         in
      let eq_inj f g =
        match (f, g) with
        | (Equal ,Equal ) -> Equal
        | (NotEqual ,uu____2532) -> NotEqual
        | (uu____2533,NotEqual ) -> NotEqual
        | (Unknown ,uu____2534) -> Unknown
        | (uu____2535,Unknown ) -> Unknown  in
      let equal_data f1 args1 f2 args2 =
        let uu____2581 = FStar_Syntax_Syntax.fv_eq f1 f2  in
        if uu____2581
        then
          let uu____2583 = FStar_List.zip args1 args2  in
          FStar_All.pipe_left
            (FStar_List.fold_left
               (fun acc  ->
                  fun uu____2641  ->
                    match uu____2641 with
                    | ((a1,q1),(a2,q2)) ->
                        let uu____2667 = eq_tm a1 a2  in
                        eq_inj acc uu____2667) Equal) uu____2583
        else NotEqual  in
      let uu____2669 =
        let uu____2674 =
          let uu____2675 = unmeta t11  in uu____2675.FStar_Syntax_Syntax.n
           in
        let uu____2678 =
          let uu____2679 = unmeta t21  in uu____2679.FStar_Syntax_Syntax.n
           in
        (uu____2674, uu____2678)  in
      match uu____2669 with
      | (FStar_Syntax_Syntax.Tm_bvar bv1,FStar_Syntax_Syntax.Tm_bvar bv2) ->
          equal_if
            (bv1.FStar_Syntax_Syntax.index = bv2.FStar_Syntax_Syntax.index)
      | (FStar_Syntax_Syntax.Tm_lazy uu____2684,uu____2685) ->
          let uu____2686 = unlazy t11  in eq_tm uu____2686 t21
      | (uu____2687,FStar_Syntax_Syntax.Tm_lazy uu____2688) ->
          let uu____2689 = unlazy t21  in eq_tm t11 uu____2689
      | (FStar_Syntax_Syntax.Tm_name a,FStar_Syntax_Syntax.Tm_name b) ->
          equal_if (FStar_Syntax_Syntax.bv_eq a b)
      | (FStar_Syntax_Syntax.Tm_fvar f,FStar_Syntax_Syntax.Tm_fvar g) ->
          if
            (f.FStar_Syntax_Syntax.fv_qual =
               (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor))
              &&
              (g.FStar_Syntax_Syntax.fv_qual =
                 (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor))
          then equal_data f [] g []
          else
            (let uu____2707 = FStar_Syntax_Syntax.fv_eq f g  in
             equal_if uu____2707)
      | (FStar_Syntax_Syntax.Tm_uinst (f,us),FStar_Syntax_Syntax.Tm_uinst
         (g,vs)) ->
          let uu____2720 = eq_tm f g  in
          eq_and uu____2720
            (fun uu____2723  ->
               let uu____2724 = eq_univs_list us vs  in equal_if uu____2724)
      | (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____2725),uu____2726) -> Unknown
      | (uu____2727,FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range
         uu____2728)) -> Unknown
      | (FStar_Syntax_Syntax.Tm_constant c,FStar_Syntax_Syntax.Tm_constant d)
          ->
          let uu____2731 = FStar_Const.eq_const c d  in equal_iff uu____2731
      | (FStar_Syntax_Syntax.Tm_uvar (u1,[]),FStar_Syntax_Syntax.Tm_uvar
         (u2,[])) ->
          let uu____2738 =
            FStar_Syntax_Unionfind.equiv u1.FStar_Syntax_Syntax.ctx_uvar_head
              u2.FStar_Syntax_Syntax.ctx_uvar_head
             in
          equal_if uu____2738
      | (FStar_Syntax_Syntax.Tm_app (h1,args1),FStar_Syntax_Syntax.Tm_app
         (h2,args2)) ->
          let uu____2783 =
            let uu____2788 =
              let uu____2789 = un_uinst h1  in
              uu____2789.FStar_Syntax_Syntax.n  in
            let uu____2792 =
              let uu____2793 = un_uinst h2  in
              uu____2793.FStar_Syntax_Syntax.n  in
            (uu____2788, uu____2792)  in
          (match uu____2783 with
           | (FStar_Syntax_Syntax.Tm_fvar f1,FStar_Syntax_Syntax.Tm_fvar f2)
               when
               (f1.FStar_Syntax_Syntax.fv_qual =
                  (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor))
                 &&
                 (f2.FStar_Syntax_Syntax.fv_qual =
                    (FStar_Pervasives_Native.Some
                       FStar_Syntax_Syntax.Data_ctor))
               -> equal_data f1 args1 f2 args2
           | (FStar_Syntax_Syntax.Tm_fvar f1,FStar_Syntax_Syntax.Tm_fvar f2)
               when
               (FStar_Syntax_Syntax.fv_eq f1 f2) &&
                 (let uu____2805 =
                    let uu____2806 = FStar_Syntax_Syntax.lid_of_fv f1  in
                    FStar_Ident.string_of_lid uu____2806  in
                  FStar_List.mem uu____2805 injectives)
               -> equal_data f1 args1 f2 args2
           | uu____2807 ->
               let uu____2812 = eq_tm h1 h2  in
               eq_and uu____2812 (fun uu____2814  -> eq_args args1 args2))
      | (FStar_Syntax_Syntax.Tm_match (t12,bs1),FStar_Syntax_Syntax.Tm_match
         (t22,bs2)) ->
          if (FStar_List.length bs1) = (FStar_List.length bs2)
          then
            let uu____2919 = FStar_List.zip bs1 bs2  in
            let uu____2982 = eq_tm t12 t22  in
            FStar_List.fold_right
              (fun uu____3019  ->
                 fun a  ->
                   match uu____3019 with
                   | (b1,b2) ->
                       eq_and a (fun uu____3112  -> branch_matches b1 b2))
              uu____2919 uu____2982
          else Unknown
      | (FStar_Syntax_Syntax.Tm_type u,FStar_Syntax_Syntax.Tm_type v1) ->
          let uu____3116 = eq_univs u v1  in equal_if uu____3116
      | (FStar_Syntax_Syntax.Tm_quoted (t12,q1),FStar_Syntax_Syntax.Tm_quoted
         (t22,q2)) -> if q1 = q2 then eq_tm t12 t22 else Unknown
      | uu____3130 -> Unknown

and (branch_matches :
  (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                             FStar_Syntax_Syntax.syntax
                                                             FStar_Pervasives_Native.option,
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
    FStar_Pervasives_Native.tuple3 ->
    (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                               FStar_Syntax_Syntax.syntax
                                                               FStar_Pervasives_Native.option,
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple3 -> eq_result)
  =
  fun b1  ->
    fun b2  ->
      let related_by f o1 o2 =
        match (o1, o2) with
        | (FStar_Pervasives_Native.None ,FStar_Pervasives_Native.None ) ->
            true
        | (FStar_Pervasives_Native.Some x,FStar_Pervasives_Native.Some y) ->
            f x y
        | (uu____3213,uu____3214) -> false  in
      let uu____3223 = b1  in
      match uu____3223 with
      | (p1,w1,t1) ->
          let uu____3257 = b2  in
          (match uu____3257 with
           | (p2,w2,t2) ->
               let uu____3291 = FStar_Syntax_Syntax.eq_pat p1 p2  in
               if uu____3291
               then
                 let uu____3292 =
                   (let uu____3295 = eq_tm t1 t2  in uu____3295 = Equal) &&
                     (related_by
                        (fun t11  ->
                           fun t21  ->
                             let uu____3304 = eq_tm t11 t21  in
                             uu____3304 = Equal) w1 w2)
                    in
                 (if uu____3292 then Equal else Unknown)
               else Unknown)

and (eq_args :
  FStar_Syntax_Syntax.args -> FStar_Syntax_Syntax.args -> eq_result) =
  fun a1  ->
    fun a2  ->
      match (a1, a2) with
      | ([],[]) -> Equal
      | ((a,uu____3354)::a11,(b,uu____3357)::b1) ->
          let uu____3411 = eq_tm a b  in
          (match uu____3411 with
           | Equal  -> eq_args a11 b1
           | uu____3412 -> Unknown)
      | uu____3413 -> Unknown

and (eq_univs_list :
  FStar_Syntax_Syntax.universes ->
    FStar_Syntax_Syntax.universes -> Prims.bool)
  =
  fun us  ->
    fun vs  ->
      ((FStar_List.length us) = (FStar_List.length vs)) &&
        (FStar_List.forall2 eq_univs us vs)

let rec (unrefine : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____3443) ->
        unrefine x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____3449,uu____3450) ->
        unrefine t2
    | uu____3491 -> t1
  
let rec (is_unit : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3497 =
      let uu____3498 = unrefine t  in uu____3498.FStar_Syntax_Syntax.n  in
    match uu____3497 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          ||
          (FStar_Syntax_Syntax.fv_eq_lid fv
             FStar_Parser_Const.auto_squash_lid)
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____3503) -> is_unit t1
    | uu____3508 -> false
  
let rec (non_informative : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3514 =
      let uu____3515 = unrefine t  in uu____3515.FStar_Syntax_Syntax.n  in
    match uu____3514 with
    | FStar_Syntax_Syntax.Tm_type uu____3518 -> true
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        ((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.unit_lid) ||
           (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid))
          || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.erased_lid)
    | FStar_Syntax_Syntax.Tm_app (head1,uu____3521) -> non_informative head1
    | FStar_Syntax_Syntax.Tm_uinst (t1,uu____3543) -> non_informative t1
    | FStar_Syntax_Syntax.Tm_arrow (uu____3548,c) ->
        (is_tot_or_gtot_comp c) && (non_informative (comp_result c))
    | uu____3566 -> false
  
let (is_fun : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun e  ->
    let uu____3572 =
      let uu____3573 = FStar_Syntax_Subst.compress e  in
      uu____3573.FStar_Syntax_Syntax.n  in
    match uu____3572 with
    | FStar_Syntax_Syntax.Tm_abs uu____3576 -> true
    | uu____3593 -> false
  
let (is_function_typ : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____3599 =
      let uu____3600 = FStar_Syntax_Subst.compress t  in
      uu____3600.FStar_Syntax_Syntax.n  in
    match uu____3599 with
    | FStar_Syntax_Syntax.Tm_arrow uu____3603 -> true
    | uu____3616 -> false
  
let rec (pre_typ : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_refine (x,uu____3624) ->
        pre_typ x.FStar_Syntax_Syntax.sort
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____3630,uu____3631) ->
        pre_typ t2
    | uu____3672 -> t1
  
let (destruct :
  FStar_Syntax_Syntax.term ->
    FStar_Ident.lident ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 Prims.list
        FStar_Pervasives_Native.option)
  =
  fun typ  ->
    fun lid  ->
      let typ1 = FStar_Syntax_Subst.compress typ  in
      let uu____3694 =
        let uu____3695 = un_uinst typ1  in uu____3695.FStar_Syntax_Syntax.n
         in
      match uu____3694 with
      | FStar_Syntax_Syntax.Tm_app (head1,args) ->
          let head2 = un_uinst head1  in
          (match head2.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_fvar tc when
               FStar_Syntax_Syntax.fv_eq_lid tc lid ->
               FStar_Pervasives_Native.Some args
           | uu____3750 -> FStar_Pervasives_Native.None)
      | FStar_Syntax_Syntax.Tm_fvar tc when
          FStar_Syntax_Syntax.fv_eq_lid tc lid ->
          FStar_Pervasives_Native.Some []
      | uu____3774 -> FStar_Pervasives_Native.None
  
let (lids_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Ident.lident Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_let (uu____3792,lids) -> lids
    | FStar_Syntax_Syntax.Sig_splice (lids,uu____3799) -> lids
    | FStar_Syntax_Syntax.Sig_bundle (uu____3804,lids) -> lids
    | FStar_Syntax_Syntax.Sig_inductive_typ
        (lid,uu____3815,uu____3816,uu____3817,uu____3818,uu____3819) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_effect_abbrev
        (lid,uu____3829,uu____3830,uu____3831,uu____3832) -> [lid]
    | FStar_Syntax_Syntax.Sig_datacon
        (lid,uu____3838,uu____3839,uu____3840,uu____3841,uu____3842) -> 
        [lid]
    | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____3848,uu____3849) ->
        [lid]
    | FStar_Syntax_Syntax.Sig_assume (lid,uu____3851,uu____3852) -> [lid]
    | FStar_Syntax_Syntax.Sig_new_effect_for_free n1 ->
        [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_new_effect n1 -> [n1.FStar_Syntax_Syntax.mname]
    | FStar_Syntax_Syntax.Sig_sub_effect uu____3855 -> []
    | FStar_Syntax_Syntax.Sig_pragma uu____3856 -> []
    | FStar_Syntax_Syntax.Sig_main uu____3857 -> []
  
let (lid_of_sigelt :
  FStar_Syntax_Syntax.sigelt ->
    FStar_Ident.lident FStar_Pervasives_Native.option)
  =
  fun se  ->
    match lids_of_sigelt se with
    | l::[] -> FStar_Pervasives_Native.Some l
    | uu____3870 -> FStar_Pervasives_Native.None
  
let (quals_of_sigelt :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.qualifier Prims.list) =
  fun x  -> x.FStar_Syntax_Syntax.sigquals 
let (range_of_sigelt : FStar_Syntax_Syntax.sigelt -> FStar_Range.range) =
  fun x  -> x.FStar_Syntax_Syntax.sigrng 
let (range_of_lbname :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Range.range)
  =
  fun uu___77_3893  ->
    match uu___77_3893 with
    | FStar_Util.Inl x -> FStar_Syntax_Syntax.range_of_bv x
    | FStar_Util.Inr fv ->
        FStar_Ident.range_of_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
  
let range_of_arg :
  'Auu____3906 'Auu____3907 .
    ('Auu____3906 FStar_Syntax_Syntax.syntax,'Auu____3907)
      FStar_Pervasives_Native.tuple2 -> FStar_Range.range
  =
  fun uu____3918  ->
    match uu____3918 with | (hd1,uu____3926) -> hd1.FStar_Syntax_Syntax.pos
  
let range_of_args :
  'Auu____3939 'Auu____3940 .
    ('Auu____3939 FStar_Syntax_Syntax.syntax,'Auu____3940)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Range.range -> FStar_Range.range
  =
  fun args  ->
    fun r  ->
      FStar_All.pipe_right args
        (FStar_List.fold_left
           (fun r1  -> fun a  -> FStar_Range.union_ranges r1 (range_of_arg a))
           r)
  
let (mk_app :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun f  ->
    fun args  ->
      match args with
      | [] -> f
      | uu____4031 ->
          let r = range_of_args args f.FStar_Syntax_Syntax.pos  in
          FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (f, args))
            FStar_Pervasives_Native.None r
  
let (mk_data :
  FStar_Ident.lident ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Syntax_Syntax.syntax)
  =
  fun l  ->
    fun args  ->
      match args with
      | [] ->
          let uu____4091 = FStar_Ident.range_of_lid l  in
          let uu____4092 =
            let uu____4101 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
                (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
               in
            FStar_Syntax_Syntax.mk uu____4101  in
          uu____4092 FStar_Pervasives_Native.None uu____4091
      | uu____4109 ->
          let e =
            let uu____4121 =
              FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
                (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
               in
            mk_app uu____4121 args  in
          FStar_Syntax_Syntax.mk e FStar_Pervasives_Native.None
            e.FStar_Syntax_Syntax.pos
  
let (mangle_field_name : FStar_Ident.ident -> FStar_Ident.ident) =
  fun x  ->
    FStar_Ident.mk_ident
      ((Prims.strcat "__fname__" x.FStar_Ident.idText),
        (x.FStar_Ident.idRange))
  
let (unmangle_field_name : FStar_Ident.ident -> FStar_Ident.ident) =
  fun x  ->
    if FStar_Util.starts_with x.FStar_Ident.idText "__fname__"
    then
      let uu____4136 =
        let uu____4141 =
          FStar_Util.substring_from x.FStar_Ident.idText
            (Prims.parse_int "9")
           in
        (uu____4141, (x.FStar_Ident.idRange))  in
      FStar_Ident.mk_ident uu____4136
    else x
  
let (field_projector_prefix : Prims.string) = "__proj__" 
let (field_projector_sep : Prims.string) = "__item__" 
let (field_projector_contains_constructor : Prims.string -> Prims.bool) =
  fun s  -> FStar_Util.starts_with s field_projector_prefix 
let (mk_field_projector_name_from_string :
  Prims.string -> Prims.string -> Prims.string) =
  fun constr  ->
    fun field  ->
      Prims.strcat field_projector_prefix
        (Prims.strcat constr (Prims.strcat field_projector_sep field))
  
let (mk_field_projector_name_from_ident :
  FStar_Ident.lident -> FStar_Ident.ident -> FStar_Ident.lident) =
  fun lid  ->
    fun i  ->
      let j = unmangle_field_name i  in
      let jtext = j.FStar_Ident.idText  in
      let newi =
        if field_projector_contains_constructor jtext
        then j
        else
          FStar_Ident.mk_ident
            ((mk_field_projector_name_from_string
                (lid.FStar_Ident.ident).FStar_Ident.idText jtext),
              (i.FStar_Ident.idRange))
         in
      FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns [newi])
  
let (mk_field_projector_name :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.bv ->
      Prims.int ->
        (FStar_Ident.lident,FStar_Syntax_Syntax.bv)
          FStar_Pervasives_Native.tuple2)
  =
  fun lid  ->
    fun x  ->
      fun i  ->
        let nm =
          let uu____4192 = FStar_Syntax_Syntax.is_null_bv x  in
          if uu____4192
          then
            let uu____4193 =
              let uu____4198 =
                let uu____4199 = FStar_Util.string_of_int i  in
                Prims.strcat "_" uu____4199  in
              let uu____4200 = FStar_Syntax_Syntax.range_of_bv x  in
              (uu____4198, uu____4200)  in
            FStar_Ident.mk_ident uu____4193
          else x.FStar_Syntax_Syntax.ppname  in
        let y =
          let uu___83_4203 = x  in
          {
            FStar_Syntax_Syntax.ppname = nm;
            FStar_Syntax_Syntax.index =
              (uu___83_4203.FStar_Syntax_Syntax.index);
            FStar_Syntax_Syntax.sort =
              (uu___83_4203.FStar_Syntax_Syntax.sort)
          }  in
        let uu____4204 = mk_field_projector_name_from_ident lid nm  in
        (uu____4204, y)
  
let (ses_of_sigbundle :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.sigelt Prims.list) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_bundle (ses,uu____4215) -> ses
    | uu____4224 -> failwith "ses_of_sigbundle: not a Sig_bundle"
  
let (eff_decl_of_new_effect :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.eff_decl) =
  fun se  ->
    match se.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_new_effect ne -> ne
    | uu____4233 -> failwith "eff_decl_of_new_effect: not a Sig_new_effect"
  
let (set_uvar : FStar_Syntax_Syntax.uvar -> FStar_Syntax_Syntax.term -> unit)
  =
  fun uv  ->
    fun t  ->
      let uu____4244 = FStar_Syntax_Unionfind.find uv  in
      match uu____4244 with
      | FStar_Pervasives_Native.Some uu____4247 ->
          let uu____4248 =
            let uu____4249 =
              let uu____4250 = FStar_Syntax_Unionfind.uvar_id uv  in
              FStar_All.pipe_left FStar_Util.string_of_int uu____4250  in
            FStar_Util.format1 "Changing a fixed uvar! ?%s\n" uu____4249  in
          failwith uu____4248
      | uu____4251 -> FStar_Syntax_Unionfind.change uv t
  
let (qualifier_equal :
  FStar_Syntax_Syntax.qualifier ->
    FStar_Syntax_Syntax.qualifier -> Prims.bool)
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
         (ns1,f1),FStar_Syntax_Syntax.RecordType (ns2,f2)) ->
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
      | (FStar_Syntax_Syntax.RecordConstructor
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
      | uu____4326 -> q1 = q2
  
let (abs :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.residual_comp FStar_Pervasives_Native.option ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun t  ->
      fun lopt  ->
        let close_lopt lopt1 =
          match lopt1 with
          | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.None
          | FStar_Pervasives_Native.Some rc ->
              let uu____4371 =
                let uu___84_4372 = rc  in
                let uu____4373 =
                  FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                    (FStar_Syntax_Subst.close bs)
                   in
                {
                  FStar_Syntax_Syntax.residual_effect =
                    (uu___84_4372.FStar_Syntax_Syntax.residual_effect);
                  FStar_Syntax_Syntax.residual_typ = uu____4373;
                  FStar_Syntax_Syntax.residual_flags =
                    (uu___84_4372.FStar_Syntax_Syntax.residual_flags)
                }  in
              FStar_Pervasives_Native.Some uu____4371
           in
        match bs with
        | [] -> t
        | uu____4388 ->
            let body =
              let uu____4390 = FStar_Syntax_Subst.close bs t  in
              FStar_Syntax_Subst.compress uu____4390  in
            (match ((body.FStar_Syntax_Syntax.n), lopt) with
             | (FStar_Syntax_Syntax.Tm_abs
                (bs',t1,lopt'),FStar_Pervasives_Native.None ) ->
                 let uu____4420 =
                   let uu____4427 =
                     let uu____4428 =
                       let uu____4445 =
                         let uu____4452 = FStar_Syntax_Subst.close_binders bs
                            in
                         FStar_List.append uu____4452 bs'  in
                       let uu____4463 = close_lopt lopt'  in
                       (uu____4445, t1, uu____4463)  in
                     FStar_Syntax_Syntax.Tm_abs uu____4428  in
                   FStar_Syntax_Syntax.mk uu____4427  in
                 uu____4420 FStar_Pervasives_Native.None
                   t1.FStar_Syntax_Syntax.pos
             | uu____4479 ->
                 let uu____4486 =
                   let uu____4493 =
                     let uu____4494 =
                       let uu____4511 = FStar_Syntax_Subst.close_binders bs
                          in
                       let uu____4518 = close_lopt lopt  in
                       (uu____4511, body, uu____4518)  in
                     FStar_Syntax_Syntax.Tm_abs uu____4494  in
                   FStar_Syntax_Syntax.mk uu____4493  in
                 uu____4486 FStar_Pervasives_Native.None
                   t.FStar_Syntax_Syntax.pos)
  
let (arrow :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      match bs with
      | [] -> comp_result c
      | uu____4568 ->
          let uu____4575 =
            let uu____4582 =
              let uu____4583 =
                let uu____4596 = FStar_Syntax_Subst.close_binders bs  in
                let uu____4603 = FStar_Syntax_Subst.close_comp bs c  in
                (uu____4596, uu____4603)  in
              FStar_Syntax_Syntax.Tm_arrow uu____4583  in
            FStar_Syntax_Syntax.mk uu____4582  in
          uu____4575 FStar_Pervasives_Native.None c.FStar_Syntax_Syntax.pos
  
let (flat_arrow :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun bs  ->
    fun c  ->
      let t = arrow bs c  in
      let uu____4648 =
        let uu____4649 = FStar_Syntax_Subst.compress t  in
        uu____4649.FStar_Syntax_Syntax.n  in
      match uu____4648 with
      | FStar_Syntax_Syntax.Tm_arrow (bs1,c1) ->
          (match c1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Total (tres,uu____4675) ->
               let uu____4684 =
                 let uu____4685 = FStar_Syntax_Subst.compress tres  in
                 uu____4685.FStar_Syntax_Syntax.n  in
               (match uu____4684 with
                | FStar_Syntax_Syntax.Tm_arrow (bs',c') ->
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_arrow
                         ((FStar_List.append bs1 bs'), c'))
                      FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
                | uu____4720 -> t)
           | uu____4721 -> t)
      | uu____4722 -> t
  
let (refine :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t  ->
      let uu____4739 =
        let uu____4740 = FStar_Syntax_Syntax.range_of_bv b  in
        FStar_Range.union_ranges uu____4740 t.FStar_Syntax_Syntax.pos  in
      let uu____4741 =
        let uu____4748 =
          let uu____4749 =
            let uu____4756 =
              let uu____4759 =
                let uu____4760 = FStar_Syntax_Syntax.mk_binder b  in
                [uu____4760]  in
              FStar_Syntax_Subst.close uu____4759 t  in
            (b, uu____4756)  in
          FStar_Syntax_Syntax.Tm_refine uu____4749  in
        FStar_Syntax_Syntax.mk uu____4748  in
      uu____4741 FStar_Pervasives_Native.None uu____4739
  
let (branch : FStar_Syntax_Syntax.branch -> FStar_Syntax_Syntax.branch) =
  fun b  -> FStar_Syntax_Subst.close_branch b 
let rec (arrow_formals_comp :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
       FStar_Pervasives_Native.tuple2 Prims.list,FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.tuple2)
  =
  fun k  ->
    let k1 = FStar_Syntax_Subst.compress k  in
    match k1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____4827 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____4827 with
         | (bs1,c1) ->
             let uu____4844 = is_total_comp c1  in
             if uu____4844
             then
               let uu____4855 = arrow_formals_comp (comp_result c1)  in
               (match uu____4855 with
                | (bs',k2) -> ((FStar_List.append bs1 bs'), k2))
             else (bs1, c1))
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____4907;
           FStar_Syntax_Syntax.index = uu____4908;
           FStar_Syntax_Syntax.sort = k2;_},uu____4910)
        -> arrow_formals_comp k2
    | uu____4917 ->
        let uu____4918 = FStar_Syntax_Syntax.mk_Total k1  in ([], uu____4918)
  
let rec (arrow_formals :
  FStar_Syntax_Syntax.term ->
    ((FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
       FStar_Pervasives_Native.tuple2 Prims.list,FStar_Syntax_Syntax.term'
                                                   FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2)
  =
  fun k  ->
    let uu____4946 = arrow_formals_comp k  in
    match uu____4946 with | (bs,c) -> (bs, (comp_result c))
  
let (abs_formals :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.binders,FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.residual_comp
                                                            FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple3)
  =
  fun t  ->
    let subst_lcomp_opt s l =
      match l with
      | FStar_Pervasives_Native.Some rc ->
          let uu____5028 =
            let uu___85_5029 = rc  in
            let uu____5030 =
              FStar_Util.map_opt rc.FStar_Syntax_Syntax.residual_typ
                (FStar_Syntax_Subst.subst s)
               in
            {
              FStar_Syntax_Syntax.residual_effect =
                (uu___85_5029.FStar_Syntax_Syntax.residual_effect);
              FStar_Syntax_Syntax.residual_typ = uu____5030;
              FStar_Syntax_Syntax.residual_flags =
                (uu___85_5029.FStar_Syntax_Syntax.residual_flags)
            }  in
          FStar_Pervasives_Native.Some uu____5028
      | uu____5039 -> l  in
    let rec aux t1 abs_body_lcomp =
      let uu____5071 =
        let uu____5072 =
          let uu____5075 = FStar_Syntax_Subst.compress t1  in
          FStar_All.pipe_left unascribe uu____5075  in
        uu____5072.FStar_Syntax_Syntax.n  in
      match uu____5071 with
      | FStar_Syntax_Syntax.Tm_abs (bs,t2,what) ->
          let uu____5115 = aux t2 what  in
          (match uu____5115 with
           | (bs',t3,what1) -> ((FStar_List.append bs bs'), t3, what1))
      | uu____5175 -> ([], t1, abs_body_lcomp)  in
    let uu____5188 = aux t FStar_Pervasives_Native.None  in
    match uu____5188 with
    | (bs,t1,abs_body_lcomp) ->
        let uu____5230 = FStar_Syntax_Subst.open_term' bs t1  in
        (match uu____5230 with
         | (bs1,t2,opening) ->
             let abs_body_lcomp1 = subst_lcomp_opt opening abs_body_lcomp  in
             (bs1, t2, abs_body_lcomp1))
  
let (mk_letbinding :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
            FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list
              -> FStar_Range.range -> FStar_Syntax_Syntax.letbinding)
  =
  fun lbname  ->
    fun univ_vars  ->
      fun typ  ->
        fun eff  ->
          fun def  ->
            fun lbattrs  ->
              fun pos  ->
                {
                  FStar_Syntax_Syntax.lbname = lbname;
                  FStar_Syntax_Syntax.lbunivs = univ_vars;
                  FStar_Syntax_Syntax.lbtyp = typ;
                  FStar_Syntax_Syntax.lbeff = eff;
                  FStar_Syntax_Syntax.lbdef = def;
                  FStar_Syntax_Syntax.lbattrs = lbattrs;
                  FStar_Syntax_Syntax.lbpos = pos
                }
  
let (close_univs_and_mk_letbinding :
  FStar_Syntax_Syntax.fv Prims.list FStar_Pervasives_Native.option ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.fv) FStar_Util.either ->
      FStar_Syntax_Syntax.univ_name Prims.list ->
        FStar_Syntax_Syntax.term ->
          FStar_Ident.lident ->
            FStar_Syntax_Syntax.term ->
              FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list
                -> FStar_Range.range -> FStar_Syntax_Syntax.letbinding)
  =
  fun recs  ->
    fun lbname  ->
      fun univ_vars  ->
        fun typ  ->
          fun eff  ->
            fun def  ->
              fun attrs  ->
                fun pos  ->
                  let def1 =
                    match (recs, univ_vars) with
                    | (FStar_Pervasives_Native.None ,uu____5391) -> def
                    | (uu____5402,[]) -> def
                    | (FStar_Pervasives_Native.Some fvs,uu____5414) ->
                        let universes =
                          FStar_All.pipe_right univ_vars
                            (FStar_List.map
                               (fun _0_4  -> FStar_Syntax_Syntax.U_name _0_4))
                           in
                        let inst1 =
                          FStar_All.pipe_right fvs
                            (FStar_List.map
                               (fun fv  ->
                                  (((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v),
                                    universes)))
                           in
                        FStar_Syntax_InstFV.instantiate inst1 def
                     in
                  let typ1 = FStar_Syntax_Subst.close_univ_vars univ_vars typ
                     in
                  let def2 =
                    FStar_Syntax_Subst.close_univ_vars univ_vars def1  in
                  mk_letbinding lbname univ_vars typ1 eff def2 attrs pos
  
let (open_univ_vars_binders_and_comp :
  FStar_Syntax_Syntax.univ_names ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
        (FStar_Syntax_Syntax.univ_names,(FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
                                          FStar_Pervasives_Native.tuple2
                                          Prims.list,FStar_Syntax_Syntax.comp)
          FStar_Pervasives_Native.tuple3)
  =
  fun uvs  ->
    fun binders  ->
      fun c  ->
        match binders with
        | [] ->
            let uu____5500 = FStar_Syntax_Subst.open_univ_vars_comp uvs c  in
            (match uu____5500 with | (uvs1,c1) -> (uvs1, [], c1))
        | uu____5529 ->
            let t' = arrow binders c  in
            let uu____5539 = FStar_Syntax_Subst.open_univ_vars uvs t'  in
            (match uu____5539 with
             | (uvs1,t'1) ->
                 let uu____5558 =
                   let uu____5559 = FStar_Syntax_Subst.compress t'1  in
                   uu____5559.FStar_Syntax_Syntax.n  in
                 (match uu____5558 with
                  | FStar_Syntax_Syntax.Tm_arrow (binders1,c1) ->
                      (uvs1, binders1, c1)
                  | uu____5600 -> failwith "Impossible"))
  
let (is_tuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_tuple_constructor_string
          ((fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v).FStar_Ident.str
    | uu____5619 -> false
  
let (is_dtuple_constructor : FStar_Syntax_Syntax.typ -> Prims.bool) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Parser_Const.is_dtuple_constructor_lid
          (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
    | uu____5626 -> false
  
let (is_lid_equality : FStar_Ident.lident -> Prims.bool) =
  fun x  -> FStar_Ident.lid_equals x FStar_Parser_Const.eq2_lid 
let (is_forall : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Parser_Const.forall_lid 
let (is_exists : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> FStar_Ident.lid_equals lid FStar_Parser_Const.exists_lid 
let (is_qlid : FStar_Ident.lident -> Prims.bool) =
  fun lid  -> (is_forall lid) || (is_exists lid) 
let (is_equality :
  FStar_Ident.lident FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun x  -> is_lid_equality x.FStar_Syntax_Syntax.v 
let (lid_is_connective : FStar_Ident.lident -> Prims.bool) =
  let lst =
    [FStar_Parser_Const.and_lid;
    FStar_Parser_Const.or_lid;
    FStar_Parser_Const.not_lid;
    FStar_Parser_Const.iff_lid;
    FStar_Parser_Const.imp_lid]  in
  fun lid  -> FStar_Util.for_some (FStar_Ident.lid_equals lid) lst 
let (is_constructor :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____5674 =
        let uu____5675 = pre_typ t  in uu____5675.FStar_Syntax_Syntax.n  in
      match uu____5674 with
      | FStar_Syntax_Syntax.Tm_fvar tc ->
          FStar_Ident.lid_equals
            (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v lid
      | uu____5679 -> false
  
let rec (is_constructed_typ :
  FStar_Syntax_Syntax.term -> FStar_Ident.lident -> Prims.bool) =
  fun t  ->
    fun lid  ->
      let uu____5690 =
        let uu____5691 = pre_typ t  in uu____5691.FStar_Syntax_Syntax.n  in
      match uu____5690 with
      | FStar_Syntax_Syntax.Tm_fvar uu____5694 -> is_constructor t lid
      | FStar_Syntax_Syntax.Tm_app (t1,uu____5696) ->
          is_constructed_typ t1 lid
      | FStar_Syntax_Syntax.Tm_uinst (t1,uu____5718) ->
          is_constructed_typ t1 lid
      | uu____5723 -> false
  
let rec (get_tycon :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun t  ->
    let t1 = pre_typ t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_bvar uu____5734 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_name uu____5735 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_fvar uu____5736 ->
        FStar_Pervasives_Native.Some t1
    | FStar_Syntax_Syntax.Tm_app (t2,uu____5738) -> get_tycon t2
    | uu____5759 -> FStar_Pervasives_Native.None
  
let (is_interpreted : FStar_Ident.lident -> Prims.bool) =
  fun l  ->
    let theory_syms =
      [FStar_Parser_Const.op_Eq;
      FStar_Parser_Const.op_notEq;
      FStar_Parser_Const.op_LT;
      FStar_Parser_Const.op_LTE;
      FStar_Parser_Const.op_GT;
      FStar_Parser_Const.op_GTE;
      FStar_Parser_Const.op_Subtraction;
      FStar_Parser_Const.op_Minus;
      FStar_Parser_Const.op_Addition;
      FStar_Parser_Const.op_Multiply;
      FStar_Parser_Const.op_Division;
      FStar_Parser_Const.op_Modulus;
      FStar_Parser_Const.op_And;
      FStar_Parser_Const.op_Or;
      FStar_Parser_Const.op_Negation]  in
    FStar_Util.for_some (FStar_Ident.lid_equals l) theory_syms
  
let (is_fstar_tactics_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____5773 =
      let uu____5774 = un_uinst t  in uu____5774.FStar_Syntax_Syntax.n  in
    match uu____5773 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.by_tactic_lid
    | uu____5778 -> false
  
let (is_builtin_tactic : FStar_Ident.lident -> Prims.bool) =
  fun md  ->
    let path = FStar_Ident.path_of_lid md  in
    if (FStar_List.length path) > (Prims.parse_int "2")
    then
      let uu____5785 =
        let uu____5788 = FStar_List.splitAt (Prims.parse_int "2") path  in
        FStar_Pervasives_Native.fst uu____5788  in
      match uu____5785 with
      | "FStar"::"Tactics"::[] -> true
      | "FStar"::"Reflection"::[] -> true
      | uu____5801 -> false
    else false
  
let (ktype : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (ktype0 : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_zero)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (type_u :
  unit ->
    (FStar_Syntax_Syntax.typ,FStar_Syntax_Syntax.universe)
      FStar_Pervasives_Native.tuple2)
  =
  fun uu____5817  ->
    let u =
      let uu____5823 = FStar_Syntax_Unionfind.univ_fresh ()  in
      FStar_All.pipe_left (fun _0_5  -> FStar_Syntax_Syntax.U_unif _0_5)
        uu____5823
       in
    let uu____5840 =
      FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type u)
        FStar_Pervasives_Native.None FStar_Range.dummyRange
       in
    (uu____5840, u)
  
let (attr_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun a  ->
    fun a'  ->
      let uu____5851 = eq_tm a a'  in
      match uu____5851 with | Equal  -> true | uu____5852 -> false
  
let (attr_substitute : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  let uu____5855 =
    let uu____5862 =
      let uu____5863 =
        let uu____5864 =
          FStar_Ident.lid_of_path ["FStar"; "Pervasives"; "Substitute"]
            FStar_Range.dummyRange
           in
        FStar_Syntax_Syntax.lid_as_fv uu____5864
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
         in
      FStar_Syntax_Syntax.Tm_fvar uu____5863  in
    FStar_Syntax_Syntax.mk uu____5862  in
  uu____5855 FStar_Pervasives_Native.None FStar_Range.dummyRange 
let (exp_true_bool : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool true))
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_false_bool : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool false))
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_unit : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) =
  FStar_Syntax_Syntax.mk
    (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_unit)
    FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_int : Prims.string -> FStar_Syntax_Syntax.term) =
  fun s  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant
         (FStar_Const.Const_int (s, FStar_Pervasives_Native.None)))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_char : FStar_BaseTypes.char -> FStar_Syntax_Syntax.term) =
  fun c  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_char c))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (exp_string : Prims.string -> FStar_Syntax_Syntax.term) =
  fun s  ->
    FStar_Syntax_Syntax.mk
      (FStar_Syntax_Syntax.Tm_constant
         (FStar_Const.Const_string (s, FStar_Range.dummyRange)))
      FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (fvar_const : FStar_Ident.lident -> FStar_Syntax_Syntax.term) =
  fun l  ->
    FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.delta_constant
      FStar_Pervasives_Native.None
  
let (tand : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.and_lid 
let (tor : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.or_lid 
let (timp : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.imp_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "1"))
    FStar_Pervasives_Native.None
  
let (tiff : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.iff_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "2"))
    FStar_Pervasives_Native.None
  
let (t_bool : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.bool_lid 
let (b2t_v : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.b2t_lid 
let (t_not : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.not_lid 
let (t_false : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.false_lid 
let (t_true : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.true_lid 
let (tac_opaque_attr : FStar_Syntax_Syntax.term) = exp_string "tac_opaque" 
let (dm4f_bind_range_attr : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.dm4f_bind_range_attr 
let (mk_conj_opt :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
    FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
        FStar_Pervasives_Native.option)
  =
  fun phi1  ->
    fun phi2  ->
      match phi1 with
      | FStar_Pervasives_Native.None  -> FStar_Pervasives_Native.Some phi2
      | FStar_Pervasives_Native.Some phi11 ->
          let uu____5943 =
            let uu____5946 =
              FStar_Range.union_ranges phi11.FStar_Syntax_Syntax.pos
                phi2.FStar_Syntax_Syntax.pos
               in
            let uu____5947 =
              let uu____5954 =
                let uu____5955 =
                  let uu____5970 =
                    let uu____5979 = FStar_Syntax_Syntax.as_arg phi11  in
                    let uu____5986 =
                      let uu____5995 = FStar_Syntax_Syntax.as_arg phi2  in
                      [uu____5995]  in
                    uu____5979 :: uu____5986  in
                  (tand, uu____5970)  in
                FStar_Syntax_Syntax.Tm_app uu____5955  in
              FStar_Syntax_Syntax.mk uu____5954  in
            uu____5947 FStar_Pervasives_Native.None uu____5946  in
          FStar_Pervasives_Native.Some uu____5943
  
let (mk_binop :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun op_t  ->
    fun phi1  ->
      fun phi2  ->
        let uu____6064 =
          FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos
            phi2.FStar_Syntax_Syntax.pos
           in
        let uu____6065 =
          let uu____6072 =
            let uu____6073 =
              let uu____6088 =
                let uu____6097 = FStar_Syntax_Syntax.as_arg phi1  in
                let uu____6104 =
                  let uu____6113 = FStar_Syntax_Syntax.as_arg phi2  in
                  [uu____6113]  in
                uu____6097 :: uu____6104  in
              (op_t, uu____6088)  in
            FStar_Syntax_Syntax.Tm_app uu____6073  in
          FStar_Syntax_Syntax.mk uu____6072  in
        uu____6065 FStar_Pervasives_Native.None uu____6064
  
let (mk_neg :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    let uu____6162 =
      let uu____6169 =
        let uu____6170 =
          let uu____6185 =
            let uu____6194 = FStar_Syntax_Syntax.as_arg phi  in [uu____6194]
             in
          (t_not, uu____6185)  in
        FStar_Syntax_Syntax.Tm_app uu____6170  in
      FStar_Syntax_Syntax.mk uu____6169  in
    uu____6162 FStar_Pervasives_Native.None phi.FStar_Syntax_Syntax.pos
  
let (mk_conj :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  = fun phi1  -> fun phi2  -> mk_binop tand phi1 phi2 
let (mk_conj_l :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    match phi with
    | [] ->
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.true_lid
          FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
    | hd1::tl1 -> FStar_List.fold_right mk_conj tl1 hd1
  
let (mk_disj :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  = fun phi1  -> fun phi2  -> mk_binop tor phi1 phi2 
let (mk_disj_l :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun phi  ->
    match phi with
    | [] -> t_false
    | hd1::tl1 -> FStar_List.fold_right mk_disj tl1 hd1
  
let (mk_imp :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term)
  = fun phi1  -> fun phi2  -> mk_binop timp phi1 phi2 
let (mk_iff :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term)
  = fun phi1  -> fun phi2  -> mk_binop tiff phi1 phi2 
let (b2t :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e  ->
    let uu____6379 =
      let uu____6386 =
        let uu____6387 =
          let uu____6402 =
            let uu____6411 = FStar_Syntax_Syntax.as_arg e  in [uu____6411]
             in
          (b2t_v, uu____6402)  in
        FStar_Syntax_Syntax.Tm_app uu____6387  in
      FStar_Syntax_Syntax.mk uu____6386  in
    uu____6379 FStar_Pervasives_Native.None e.FStar_Syntax_Syntax.pos
  
let (teq : FStar_Syntax_Syntax.term) = fvar_const FStar_Parser_Const.eq2_lid 
let (mk_untyped_eq2 :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun e1  ->
    fun e2  ->
      let uu____6463 =
        FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
          e2.FStar_Syntax_Syntax.pos
         in
      let uu____6464 =
        let uu____6471 =
          let uu____6472 =
            let uu____6487 =
              let uu____6496 = FStar_Syntax_Syntax.as_arg e1  in
              let uu____6503 =
                let uu____6512 = FStar_Syntax_Syntax.as_arg e2  in
                [uu____6512]  in
              uu____6496 :: uu____6503  in
            (teq, uu____6487)  in
          FStar_Syntax_Syntax.Tm_app uu____6472  in
        FStar_Syntax_Syntax.mk uu____6471  in
      uu____6464 FStar_Pervasives_Native.None uu____6463
  
let (mk_eq2 :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun u  ->
    fun t  ->
      fun e1  ->
        fun e2  ->
          let eq_inst = FStar_Syntax_Syntax.mk_Tm_uinst teq [u]  in
          let uu____6571 =
            FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos
              e2.FStar_Syntax_Syntax.pos
             in
          let uu____6572 =
            let uu____6579 =
              let uu____6580 =
                let uu____6595 =
                  let uu____6604 = FStar_Syntax_Syntax.iarg t  in
                  let uu____6611 =
                    let uu____6620 = FStar_Syntax_Syntax.as_arg e1  in
                    let uu____6627 =
                      let uu____6636 = FStar_Syntax_Syntax.as_arg e2  in
                      [uu____6636]  in
                    uu____6620 :: uu____6627  in
                  uu____6604 :: uu____6611  in
                (eq_inst, uu____6595)  in
              FStar_Syntax_Syntax.Tm_app uu____6580  in
            FStar_Syntax_Syntax.mk uu____6579  in
          uu____6572 FStar_Pervasives_Native.None uu____6571
  
let (mk_has_type :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    fun x  ->
      fun t'  ->
        let t_has_type = fvar_const FStar_Parser_Const.has_type_lid  in
        let t_has_type1 =
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_uinst
               (t_has_type,
                 [FStar_Syntax_Syntax.U_zero; FStar_Syntax_Syntax.U_zero]))
            FStar_Pervasives_Native.None FStar_Range.dummyRange
           in
        let uu____6703 =
          let uu____6710 =
            let uu____6711 =
              let uu____6726 =
                let uu____6735 = FStar_Syntax_Syntax.iarg t  in
                let uu____6742 =
                  let uu____6751 = FStar_Syntax_Syntax.as_arg x  in
                  let uu____6758 =
                    let uu____6767 = FStar_Syntax_Syntax.as_arg t'  in
                    [uu____6767]  in
                  uu____6751 :: uu____6758  in
                uu____6735 :: uu____6742  in
              (t_has_type1, uu____6726)  in
            FStar_Syntax_Syntax.Tm_app uu____6711  in
          FStar_Syntax_Syntax.mk uu____6710  in
        uu____6703 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (mk_with_type :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun t  ->
      fun e  ->
        let t_with_type =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.with_type_lid
            FStar_Syntax_Syntax.delta_equational FStar_Pervasives_Native.None
           in
        let t_with_type1 =
          FStar_Syntax_Syntax.mk
            (FStar_Syntax_Syntax.Tm_uinst (t_with_type, [u]))
            FStar_Pervasives_Native.None FStar_Range.dummyRange
           in
        let uu____6834 =
          let uu____6841 =
            let uu____6842 =
              let uu____6857 =
                let uu____6866 = FStar_Syntax_Syntax.iarg t  in
                let uu____6873 =
                  let uu____6882 = FStar_Syntax_Syntax.as_arg e  in
                  [uu____6882]  in
                uu____6866 :: uu____6873  in
              (t_with_type1, uu____6857)  in
            FStar_Syntax_Syntax.Tm_app uu____6842  in
          FStar_Syntax_Syntax.mk uu____6841  in
        uu____6834 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (lex_t : FStar_Syntax_Syntax.term) =
  fvar_const FStar_Parser_Const.lex_t_lid 
let (lex_top : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax) =
  let uu____6922 =
    let uu____6929 =
      let uu____6930 =
        let uu____6937 =
          FStar_Syntax_Syntax.fvar FStar_Parser_Const.lextop_lid
            FStar_Syntax_Syntax.delta_constant
            (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
           in
        (uu____6937, [FStar_Syntax_Syntax.U_zero])  in
      FStar_Syntax_Syntax.Tm_uinst uu____6930  in
    FStar_Syntax_Syntax.mk uu____6929  in
  uu____6922 FStar_Pervasives_Native.None FStar_Range.dummyRange 
let (lex_pair : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.lexcons_lid
    FStar_Syntax_Syntax.delta_constant
    (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
  
let (tforall : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.forall_lid
    (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "1"))
    FStar_Pervasives_Native.None
  
let (t_haseq : FStar_Syntax_Syntax.term) =
  FStar_Syntax_Syntax.fvar FStar_Parser_Const.haseq_lid
    FStar_Syntax_Syntax.delta_constant FStar_Pervasives_Native.None
  
let (lcomp_of_comp : FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.lcomp) =
  fun c0  ->
    let uu____6950 =
      match c0.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Total uu____6963 ->
          (FStar_Parser_Const.effect_Tot_lid, [FStar_Syntax_Syntax.TOTAL])
      | FStar_Syntax_Syntax.GTotal uu____6974 ->
          (FStar_Parser_Const.effect_GTot_lid,
            [FStar_Syntax_Syntax.SOMETRIVIAL])
      | FStar_Syntax_Syntax.Comp c ->
          ((c.FStar_Syntax_Syntax.effect_name),
            (c.FStar_Syntax_Syntax.flags))
       in
    match uu____6950 with
    | (eff_name,flags1) ->
        FStar_Syntax_Syntax.mk_lcomp eff_name (comp_result c0) flags1
          (fun uu____6995  -> c0)
  
let (mk_residual_comp :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option ->
      FStar_Syntax_Syntax.cflags Prims.list ->
        FStar_Syntax_Syntax.residual_comp)
  =
  fun l  ->
    fun t  ->
      fun f  ->
        {
          FStar_Syntax_Syntax.residual_effect = l;
          FStar_Syntax_Syntax.residual_typ = t;
          FStar_Syntax_Syntax.residual_flags = f
        }
  
let (residual_tot :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.residual_comp)
  =
  fun t  ->
    {
      FStar_Syntax_Syntax.residual_effect = FStar_Parser_Const.effect_Tot_lid;
      FStar_Syntax_Syntax.residual_typ = (FStar_Pervasives_Native.Some t);
      FStar_Syntax_Syntax.residual_flags = [FStar_Syntax_Syntax.TOTAL]
    }
  
let (residual_comp_of_comp :
  FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.residual_comp) =
  fun c  ->
    {
      FStar_Syntax_Syntax.residual_effect = (comp_effect_name c);
      FStar_Syntax_Syntax.residual_typ =
        (FStar_Pervasives_Native.Some (comp_result c));
      FStar_Syntax_Syntax.residual_flags = (comp_flags c)
    }
  
let (residual_comp_of_lcomp :
  FStar_Syntax_Syntax.lcomp -> FStar_Syntax_Syntax.residual_comp) =
  fun lc  ->
    {
      FStar_Syntax_Syntax.residual_effect = (lc.FStar_Syntax_Syntax.eff_name);
      FStar_Syntax_Syntax.residual_typ =
        (FStar_Pervasives_Native.Some (lc.FStar_Syntax_Syntax.res_typ));
      FStar_Syntax_Syntax.residual_flags = (lc.FStar_Syntax_Syntax.cflags)
    }
  
let (mk_forall_aux :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun fa  ->
    fun x  ->
      fun body  ->
        let uu____7073 =
          let uu____7080 =
            let uu____7081 =
              let uu____7096 =
                let uu____7105 =
                  FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort  in
                let uu____7112 =
                  let uu____7121 =
                    let uu____7128 =
                      let uu____7129 =
                        let uu____7130 = FStar_Syntax_Syntax.mk_binder x  in
                        [uu____7130]  in
                      abs uu____7129 body
                        (FStar_Pervasives_Native.Some (residual_tot ktype0))
                       in
                    FStar_Syntax_Syntax.as_arg uu____7128  in
                  [uu____7121]  in
                uu____7105 :: uu____7112  in
              (fa, uu____7096)  in
            FStar_Syntax_Syntax.Tm_app uu____7081  in
          FStar_Syntax_Syntax.mk uu____7080  in
        uu____7073 FStar_Pervasives_Native.None FStar_Range.dummyRange
  
let (mk_forall_no_univ :
  FStar_Syntax_Syntax.bv ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  = fun x  -> fun body  -> mk_forall_aux tforall x body 
let (mk_forall :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.bv ->
      FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun u  ->
    fun x  ->
      fun body  ->
        let tforall1 = FStar_Syntax_Syntax.mk_Tm_uinst tforall [u]  in
        mk_forall_aux tforall1 x body
  
let (close_forall_no_univs :
  (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
    FStar_Pervasives_Native.tuple2 Prims.list ->
    FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun bs  ->
    fun f  ->
      FStar_List.fold_right
        (fun b  ->
           fun f1  ->
             let uu____7235 = FStar_Syntax_Syntax.is_null_binder b  in
             if uu____7235
             then f1
             else mk_forall_no_univ (FStar_Pervasives_Native.fst b) f1) bs f
  
let rec (is_wild_pat :
  FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t -> Prims.bool) =
  fun p  ->
    match p.FStar_Syntax_Syntax.v with
    | FStar_Syntax_Syntax.Pat_wild uu____7246 -> true
    | uu____7247 -> false
  
let (if_then_else :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun b  ->
    fun t1  ->
      fun t2  ->
        let then_branch =
          let uu____7292 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool true))
              t1.FStar_Syntax_Syntax.pos
             in
          (uu____7292, FStar_Pervasives_Native.None, t1)  in
        let else_branch =
          let uu____7320 =
            FStar_Syntax_Syntax.withinfo
              (FStar_Syntax_Syntax.Pat_constant
                 (FStar_Const.Const_bool false)) t2.FStar_Syntax_Syntax.pos
             in
          (uu____7320, FStar_Pervasives_Native.None, t2)  in
        let uu____7333 =
          let uu____7334 =
            FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos
              t2.FStar_Syntax_Syntax.pos
             in
          FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos uu____7334  in
        FStar_Syntax_Syntax.mk
          (FStar_Syntax_Syntax.Tm_match (b, [then_branch; else_branch]))
          FStar_Pervasives_Native.None uu____7333
  
let (mk_squash :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun p  ->
      let sq =
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.squash_lid
          (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "1"))
          FStar_Pervasives_Native.None
         in
      let uu____7408 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____7411 =
        let uu____7420 = FStar_Syntax_Syntax.as_arg p  in [uu____7420]  in
      mk_app uu____7408 uu____7411
  
let (mk_auto_squash :
  FStar_Syntax_Syntax.universe ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun u  ->
    fun p  ->
      let sq =
        FStar_Syntax_Syntax.fvar FStar_Parser_Const.auto_squash_lid
          (FStar_Syntax_Syntax.Delta_constant_at_level (Prims.parse_int "2"))
          FStar_Pervasives_Native.None
         in
      let uu____7452 = FStar_Syntax_Syntax.mk_Tm_uinst sq [u]  in
      let uu____7455 =
        let uu____7464 = FStar_Syntax_Syntax.as_arg p  in [uu____7464]  in
      mk_app uu____7452 uu____7455
  
let (un_squash :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____7492 = head_and_args t  in
    match uu____7492 with
    | (head1,args) ->
        let uu____7533 =
          let uu____7546 =
            let uu____7547 = un_uinst head1  in
            uu____7547.FStar_Syntax_Syntax.n  in
          (uu____7546, args)  in
        (match uu____7533 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,(p,uu____7564)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some p
         | (FStar_Syntax_Syntax.Tm_refine (b,p),[]) ->
             (match (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_fvar fv when
                  FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.unit_lid
                  ->
                  let uu____7616 =
                    let uu____7621 =
                      let uu____7622 = FStar_Syntax_Syntax.mk_binder b  in
                      [uu____7622]  in
                    FStar_Syntax_Subst.open_term uu____7621 p  in
                  (match uu____7616 with
                   | (bs,p1) ->
                       let b1 =
                         match bs with
                         | b1::[] -> b1
                         | uu____7663 -> failwith "impossible"  in
                       let uu____7668 =
                         let uu____7669 = FStar_Syntax_Free.names p1  in
                         FStar_Util.set_mem (FStar_Pervasives_Native.fst b1)
                           uu____7669
                          in
                       if uu____7668
                       then FStar_Pervasives_Native.None
                       else FStar_Pervasives_Native.Some p1)
              | uu____7679 -> FStar_Pervasives_Native.None)
         | uu____7682 -> FStar_Pervasives_Native.None)
  
let (is_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe,FStar_Syntax_Syntax.term'
                                    FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____7710 = head_and_args t  in
    match uu____7710 with
    | (head1,args) ->
        let uu____7755 =
          let uu____7768 =
            let uu____7769 = FStar_Syntax_Subst.compress head1  in
            uu____7769.FStar_Syntax_Syntax.n  in
          (uu____7768, args)  in
        (match uu____7755 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____7789;
               FStar_Syntax_Syntax.vars = uu____7790;_},u::[]),(t1,uu____7793)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____7830 -> FStar_Pervasives_Native.None)
  
let (is_auto_squash :
  FStar_Syntax_Syntax.term ->
    (FStar_Syntax_Syntax.universe,FStar_Syntax_Syntax.term'
                                    FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____7862 = head_and_args t  in
    match uu____7862 with
    | (head1,args) ->
        let uu____7907 =
          let uu____7920 =
            let uu____7921 = FStar_Syntax_Subst.compress head1  in
            uu____7921.FStar_Syntax_Syntax.n  in
          (uu____7920, args)  in
        (match uu____7907 with
         | (FStar_Syntax_Syntax.Tm_uinst
            ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
               FStar_Syntax_Syntax.pos = uu____7941;
               FStar_Syntax_Syntax.vars = uu____7942;_},u::[]),(t1,uu____7945)::[])
             when
             FStar_Syntax_Syntax.fv_eq_lid fv
               FStar_Parser_Const.auto_squash_lid
             -> FStar_Pervasives_Native.Some (u, t1)
         | uu____7982 -> FStar_Pervasives_Native.None)
  
let (is_sub_singleton : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____8006 = let uu____8021 = unmeta t  in head_and_args uu____8021
       in
    match uu____8006 with
    | (head1,uu____8023) ->
        let uu____8044 =
          let uu____8045 = un_uinst head1  in
          uu____8045.FStar_Syntax_Syntax.n  in
        (match uu____8044 with
         | FStar_Syntax_Syntax.Tm_fvar fv ->
             (((((((((((((((((FStar_Syntax_Syntax.fv_eq_lid fv
                                FStar_Parser_Const.squash_lid)
                               ||
                               (FStar_Syntax_Syntax.fv_eq_lid fv
                                  FStar_Parser_Const.auto_squash_lid))
                              ||
                              (FStar_Syntax_Syntax.fv_eq_lid fv
                                 FStar_Parser_Const.and_lid))
                             ||
                             (FStar_Syntax_Syntax.fv_eq_lid fv
                                FStar_Parser_Const.or_lid))
                            ||
                            (FStar_Syntax_Syntax.fv_eq_lid fv
                               FStar_Parser_Const.not_lid))
                           ||
                           (FStar_Syntax_Syntax.fv_eq_lid fv
                              FStar_Parser_Const.imp_lid))
                          ||
                          (FStar_Syntax_Syntax.fv_eq_lid fv
                             FStar_Parser_Const.iff_lid))
                         ||
                         (FStar_Syntax_Syntax.fv_eq_lid fv
                            FStar_Parser_Const.ite_lid))
                        ||
                        (FStar_Syntax_Syntax.fv_eq_lid fv
                           FStar_Parser_Const.exists_lid))
                       ||
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.forall_lid))
                      ||
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.true_lid))
                     ||
                     (FStar_Syntax_Syntax.fv_eq_lid fv
                        FStar_Parser_Const.false_lid))
                    ||
                    (FStar_Syntax_Syntax.fv_eq_lid fv
                       FStar_Parser_Const.eq2_lid))
                   ||
                   (FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.eq3_lid))
                  ||
                  (FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.b2t_lid))
                 ||
                 (FStar_Syntax_Syntax.fv_eq_lid fv
                    FStar_Parser_Const.haseq_lid))
                ||
                (FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.has_type_lid))
               ||
               (FStar_Syntax_Syntax.fv_eq_lid fv
                  FStar_Parser_Const.precedes_lid)
         | uu____8049 -> false)
  
let (arrow_one :
  FStar_Syntax_Syntax.typ ->
    (FStar_Syntax_Syntax.binder,FStar_Syntax_Syntax.comp)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
  =
  fun t  ->
    let uu____8067 =
      let uu____8078 =
        let uu____8079 = FStar_Syntax_Subst.compress t  in
        uu____8079.FStar_Syntax_Syntax.n  in
      match uu____8078 with
      | FStar_Syntax_Syntax.Tm_arrow ([],c) ->
          failwith "fatal: empty binders on arrow?"
      | FStar_Syntax_Syntax.Tm_arrow (b::[],c) ->
          FStar_Pervasives_Native.Some (b, c)
      | FStar_Syntax_Syntax.Tm_arrow (b::bs,c) ->
          let uu____8182 =
            let uu____8191 =
              let uu____8192 = arrow bs c  in
              FStar_Syntax_Syntax.mk_Total uu____8192  in
            (b, uu____8191)  in
          FStar_Pervasives_Native.Some uu____8182
      | uu____8205 -> FStar_Pervasives_Native.None  in
    FStar_Util.bind_opt uu____8067
      (fun uu____8237  ->
         match uu____8237 with
         | (b,c) ->
             let uu____8266 = FStar_Syntax_Subst.open_comp [b] c  in
             (match uu____8266 with
              | (bs,c1) ->
                  let b1 =
                    match bs with
                    | b1::[] -> b1
                    | uu____8313 ->
                        failwith
                          "impossible: open_comp returned different amount of binders"
                     in
                  FStar_Pervasives_Native.Some (b1, c1)))
  
let (is_free_in :
  FStar_Syntax_Syntax.bv -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun bv  ->
    fun t  ->
      let uu____8340 = FStar_Syntax_Free.names t  in
      FStar_Util.set_mem bv uu____8340
  
type qpats = FStar_Syntax_Syntax.args Prims.list[@@deriving show]
type connective =
  | QAll of (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
  FStar_Pervasives_Native.tuple3 
  | QEx of (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
  FStar_Pervasives_Native.tuple3 
  | BaseConn of (FStar_Ident.lident,FStar_Syntax_Syntax.args)
  FStar_Pervasives_Native.tuple2 [@@deriving show]
let (uu___is_QAll : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QAll _0 -> true | uu____8388 -> false
  
let (__proj__QAll__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | QAll _0 -> _0 
let (uu___is_QEx : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | QEx _0 -> true | uu____8426 -> false
  
let (__proj__QEx__item___0 :
  connective ->
    (FStar_Syntax_Syntax.binders,qpats,FStar_Syntax_Syntax.typ)
      FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | QEx _0 -> _0 
let (uu___is_BaseConn : connective -> Prims.bool) =
  fun projectee  ->
    match projectee with | BaseConn _0 -> true | uu____8462 -> false
  
let (__proj__BaseConn__item___0 :
  connective ->
    (FStar_Ident.lident,FStar_Syntax_Syntax.args)
      FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | BaseConn _0 -> _0 
let (destruct_typ_as_formula :
  FStar_Syntax_Syntax.term -> connective FStar_Pervasives_Native.option) =
  fun f  ->
    let rec unmeta_monadic f1 =
      let f2 = FStar_Syntax_Subst.compress f1  in
      match f2.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic uu____8499) -> unmeta_monadic t
      | FStar_Syntax_Syntax.Tm_meta
          (t,FStar_Syntax_Syntax.Meta_monadic_lift uu____8511) ->
          unmeta_monadic t
      | uu____8524 -> f2  in
    let destruct_base_conn f1 =
      let connectives =
        [(FStar_Parser_Const.true_lid, (Prims.parse_int "0"));
        (FStar_Parser_Const.false_lid, (Prims.parse_int "0"));
        (FStar_Parser_Const.and_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.or_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.imp_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.iff_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.ite_lid, (Prims.parse_int "3"));
        (FStar_Parser_Const.not_lid, (Prims.parse_int "1"));
        (FStar_Parser_Const.eq2_lid, (Prims.parse_int "3"));
        (FStar_Parser_Const.eq2_lid, (Prims.parse_int "2"));
        (FStar_Parser_Const.eq3_lid, (Prims.parse_int "4"));
        (FStar_Parser_Const.eq3_lid, (Prims.parse_int "2"))]  in
      let aux f2 uu____8608 =
        match uu____8608 with
        | (lid,arity) ->
            let uu____8617 =
              let uu____8632 = unmeta_monadic f2  in head_and_args uu____8632
               in
            (match uu____8617 with
             | (t,args) ->
                 let t1 = un_uinst t  in
                 let uu____8658 =
                   (is_constructor t1 lid) &&
                     ((FStar_List.length args) = arity)
                    in
                 if uu____8658
                 then FStar_Pervasives_Native.Some (BaseConn (lid, args))
                 else FStar_Pervasives_Native.None)
         in
      FStar_Util.find_map connectives (aux f1)  in
    let patterns t =
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_meta
          (t2,FStar_Syntax_Syntax.Meta_pattern pats) ->
          let uu____8727 = FStar_Syntax_Subst.compress t2  in
          (pats, uu____8727)
      | uu____8738 -> ([], t1)  in
    let destruct_q_conn t =
      let is_q fa fv =
        if fa
        then is_forall (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
        else is_exists (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
         in
      let flat t1 =
        let uu____8793 = head_and_args t1  in
        match uu____8793 with
        | (t2,args) ->
            let uu____8840 = un_uinst t2  in
            let uu____8841 =
              FStar_All.pipe_right args
                (FStar_List.map
                   (fun uu____8872  ->
                      match uu____8872 with
                      | (t3,imp) ->
                          let uu____8883 = unascribe t3  in (uu____8883, imp)))
               in
            (uu____8840, uu____8841)
         in
      let rec aux qopt out t1 =
        let uu____8924 = let uu____8945 = flat t1  in (qopt, uu____8945)  in
        match uu____8924 with
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____8980;
                 FStar_Syntax_Syntax.vars = uu____8981;_},({
                                                             FStar_Syntax_Syntax.n
                                                               =
                                                               FStar_Syntax_Syntax.Tm_abs
                                                               (b::[],t2,uu____8984);
                                                             FStar_Syntax_Syntax.pos
                                                               = uu____8985;
                                                             FStar_Syntax_Syntax.vars
                                                               = uu____8986;_},uu____8987)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.Some
           fa,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
                 FStar_Syntax_Syntax.pos = uu____9064;
                 FStar_Syntax_Syntax.vars = uu____9065;_},uu____9066::
               ({
                  FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs
                    (b::[],t2,uu____9069);
                  FStar_Syntax_Syntax.pos = uu____9070;
                  FStar_Syntax_Syntax.vars = uu____9071;_},uu____9072)::[]))
            when is_q fa tc -> aux qopt (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____9160;
               FStar_Syntax_Syntax.vars = uu____9161;_},({
                                                           FStar_Syntax_Syntax.n
                                                             =
                                                             FStar_Syntax_Syntax.Tm_abs
                                                             (b::[],t2,uu____9164);
                                                           FStar_Syntax_Syntax.pos
                                                             = uu____9165;
                                                           FStar_Syntax_Syntax.vars
                                                             = uu____9166;_},uu____9167)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____9238 =
              let uu____9241 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____9241  in
            aux uu____9238 (b :: out) t2
        | (FStar_Pervasives_Native.None
           ,({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar tc;
               FStar_Syntax_Syntax.pos = uu____9247;
               FStar_Syntax_Syntax.vars = uu____9248;_},uu____9249::({
                                                                    FStar_Syntax_Syntax.n
                                                                    =
                                                                    FStar_Syntax_Syntax.Tm_abs
                                                                    (b::[],t2,uu____9252);
                                                                    FStar_Syntax_Syntax.pos
                                                                    =
                                                                    uu____9253;
                                                                    FStar_Syntax_Syntax.vars
                                                                    =
                                                                    uu____9254;_},uu____9255)::[]))
            when
            is_qlid (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v ->
            let uu____9338 =
              let uu____9341 =
                is_forall
                  (tc.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                 in
              FStar_Pervasives_Native.Some uu____9341  in
            aux uu____9338 (b :: out) t2
        | (FStar_Pervasives_Native.Some b,uu____9347) ->
            let bs = FStar_List.rev out  in
            let uu____9389 = FStar_Syntax_Subst.open_term bs t1  in
            (match uu____9389 with
             | (bs1,t2) ->
                 let uu____9398 = patterns t2  in
                 (match uu____9398 with
                  | (pats,body) ->
                      if b
                      then
                        FStar_Pervasives_Native.Some (QAll (bs1, pats, body))
                      else
                        FStar_Pervasives_Native.Some (QEx (bs1, pats, body))))
        | uu____9440 -> FStar_Pervasives_Native.None  in
      aux FStar_Pervasives_Native.None [] t  in
    let u_connectives =
      [(FStar_Parser_Const.true_lid, FStar_Parser_Const.c_true_lid,
         (Prims.parse_int "0"));
      (FStar_Parser_Const.false_lid, FStar_Parser_Const.c_false_lid,
        (Prims.parse_int "0"));
      (FStar_Parser_Const.and_lid, FStar_Parser_Const.c_and_lid,
        (Prims.parse_int "2"));
      (FStar_Parser_Const.or_lid, FStar_Parser_Const.c_or_lid,
        (Prims.parse_int "2"))]
       in
    let destruct_sq_base_conn t =
      let uu____9512 = un_squash t  in
      FStar_Util.bind_opt uu____9512
        (fun t1  ->
           let uu____9528 = head_and_args' t1  in
           match uu____9528 with
           | (hd1,args) ->
               let uu____9561 =
                 let uu____9566 =
                   let uu____9567 = un_uinst hd1  in
                   uu____9567.FStar_Syntax_Syntax.n  in
                 (uu____9566, (FStar_List.length args))  in
               (match uu____9561 with
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_6) when
                    (_0_6 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_and_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.and_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_7) when
                    (_0_7 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_or_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.or_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_8) when
                    (_0_8 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq2_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq2_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_9) when
                    (_0_9 = (Prims.parse_int "3")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq2_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq2_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_10) when
                    (_0_10 = (Prims.parse_int "2")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq3_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq3_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_11) when
                    (_0_11 = (Prims.parse_int "4")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_eq3_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.eq3_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_12) when
                    (_0_12 = (Prims.parse_int "0")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_true_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.true_lid, args))
                | (FStar_Syntax_Syntax.Tm_fvar fv,_0_13) when
                    (_0_13 = (Prims.parse_int "0")) &&
                      (FStar_Syntax_Syntax.fv_eq_lid fv
                         FStar_Parser_Const.c_false_lid)
                    ->
                    FStar_Pervasives_Native.Some
                      (BaseConn (FStar_Parser_Const.false_lid, args))
                | uu____9586 -> FStar_Pervasives_Native.None))
       in
    let rec destruct_sq_forall t =
      let uu____9615 = un_squash t  in
      FStar_Util.bind_opt uu____9615
        (fun t1  ->
           let uu____9630 = arrow_one t1  in
           match uu____9630 with
           | FStar_Pervasives_Native.Some (b,c) ->
               let uu____9645 =
                 let uu____9646 = is_tot_or_gtot_comp c  in
                 Prims.op_Negation uu____9646  in
               if uu____9645
               then FStar_Pervasives_Native.None
               else
                 (let q =
                    let uu____9653 = comp_to_comp_typ_nouniv c  in
                    uu____9653.FStar_Syntax_Syntax.result_typ  in
                  let uu____9654 =
                    is_free_in (FStar_Pervasives_Native.fst b) q  in
                  if uu____9654
                  then
                    let uu____9657 = patterns q  in
                    match uu____9657 with
                    | (pats,q1) ->
                        FStar_All.pipe_left maybe_collect
                          (FStar_Pervasives_Native.Some
                             (QAll ([b], pats, q1)))
                  else
                    (let uu____9709 =
                       let uu____9710 =
                         let uu____9715 =
                           let uu____9716 =
                             FStar_Syntax_Syntax.as_arg
                               (FStar_Pervasives_Native.fst b).FStar_Syntax_Syntax.sort
                              in
                           let uu____9723 =
                             let uu____9732 = FStar_Syntax_Syntax.as_arg q
                                in
                             [uu____9732]  in
                           uu____9716 :: uu____9723  in
                         (FStar_Parser_Const.imp_lid, uu____9715)  in
                       BaseConn uu____9710  in
                     FStar_Pervasives_Native.Some uu____9709))
           | uu____9757 -> FStar_Pervasives_Native.None)
    
    and destruct_sq_exists t =
      let uu____9765 = un_squash t  in
      FStar_Util.bind_opt uu____9765
        (fun t1  ->
           let uu____9796 = head_and_args' t1  in
           match uu____9796 with
           | (hd1,args) ->
               let uu____9829 =
                 let uu____9842 =
                   let uu____9843 = un_uinst hd1  in
                   uu____9843.FStar_Syntax_Syntax.n  in
                 (uu____9842, args)  in
               (match uu____9829 with
                | (FStar_Syntax_Syntax.Tm_fvar
                   fv,(a1,uu____9858)::(a2,uu____9860)::[]) when
                    FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.dtuple2_lid
                    ->
                    let uu____9895 =
                      let uu____9896 = FStar_Syntax_Subst.compress a2  in
                      uu____9896.FStar_Syntax_Syntax.n  in
                    (match uu____9895 with
                     | FStar_Syntax_Syntax.Tm_abs (b::[],q,uu____9903) ->
                         let uu____9930 = FStar_Syntax_Subst.open_term [b] q
                            in
                         (match uu____9930 with
                          | (bs,q1) ->
                              let b1 =
                                match bs with
                                | b1::[] -> b1
                                | uu____9969 -> failwith "impossible"  in
                              let uu____9974 = patterns q1  in
                              (match uu____9974 with
                               | (pats,q2) ->
                                   FStar_All.pipe_left maybe_collect
                                     (FStar_Pervasives_Native.Some
                                        (QEx ([b1], pats, q2)))))
                     | uu____10025 -> FStar_Pervasives_Native.None)
                | uu____10026 -> FStar_Pervasives_Native.None))
    
    and maybe_collect f1 =
      match f1 with
      | FStar_Pervasives_Native.Some (QAll (bs,pats,phi)) ->
          let uu____10047 = destruct_sq_forall phi  in
          (match uu____10047 with
           | FStar_Pervasives_Native.Some (QAll (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun _0_14  -> FStar_Pervasives_Native.Some _0_14)
                 (QAll
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____10061 -> f1)
      | FStar_Pervasives_Native.Some (QEx (bs,pats,phi)) ->
          let uu____10067 = destruct_sq_exists phi  in
          (match uu____10067 with
           | FStar_Pervasives_Native.Some (QEx (bs',pats',psi)) ->
               FStar_All.pipe_left
                 (fun _0_15  -> FStar_Pervasives_Native.Some _0_15)
                 (QEx
                    ((FStar_List.append bs bs'),
                      (FStar_List.append pats pats'), psi))
           | uu____10081 -> f1)
      | uu____10084 -> f1
     in
    let phi = unmeta_monadic f  in
    let uu____10088 = destruct_base_conn phi  in
    FStar_Util.catch_opt uu____10088
      (fun uu____10093  ->
         let uu____10094 = destruct_q_conn phi  in
         FStar_Util.catch_opt uu____10094
           (fun uu____10099  ->
              let uu____10100 = destruct_sq_base_conn phi  in
              FStar_Util.catch_opt uu____10100
                (fun uu____10105  ->
                   let uu____10106 = destruct_sq_forall phi  in
                   FStar_Util.catch_opt uu____10106
                     (fun uu____10111  ->
                        let uu____10112 = destruct_sq_exists phi  in
                        FStar_Util.catch_opt uu____10112
                          (fun uu____10116  -> FStar_Pervasives_Native.None)))))
  
let (unthunk_lemma_post :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let uu____10128 =
      let uu____10129 = FStar_Syntax_Subst.compress t  in
      uu____10129.FStar_Syntax_Syntax.n  in
    match uu____10128 with
    | FStar_Syntax_Syntax.Tm_abs (b::[],e,uu____10136) ->
        let uu____10163 = FStar_Syntax_Subst.open_term [b] e  in
        (match uu____10163 with
         | (bs,e1) ->
             let b1 = FStar_List.hd bs  in
             let uu____10189 = is_free_in (FStar_Pervasives_Native.fst b1) e1
                in
             if uu____10189
             then
               let uu____10192 =
                 let uu____10201 = FStar_Syntax_Syntax.as_arg exp_unit  in
                 [uu____10201]  in
               mk_app t uu____10192
             else e1)
    | uu____10221 ->
        let uu____10222 =
          let uu____10231 = FStar_Syntax_Syntax.as_arg exp_unit  in
          [uu____10231]  in
        mk_app t uu____10222
  
let (action_as_lb :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.action ->
      FStar_Range.range -> FStar_Syntax_Syntax.sigelt)
  =
  fun eff_lid  ->
    fun a  ->
      fun pos  ->
        let lb =
          let uu____10266 =
            let uu____10271 =
              FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name
                FStar_Syntax_Syntax.delta_equational
                FStar_Pervasives_Native.None
               in
            FStar_Util.Inr uu____10271  in
          let uu____10272 =
            let uu____10273 =
              FStar_Syntax_Syntax.mk_Total a.FStar_Syntax_Syntax.action_typ
               in
            arrow a.FStar_Syntax_Syntax.action_params uu____10273  in
          let uu____10276 =
            abs a.FStar_Syntax_Syntax.action_params
              a.FStar_Syntax_Syntax.action_defn FStar_Pervasives_Native.None
             in
          close_univs_and_mk_letbinding FStar_Pervasives_Native.None
            uu____10266 a.FStar_Syntax_Syntax.action_univs uu____10272
            FStar_Parser_Const.effect_Tot_lid uu____10276 [] pos
           in
        {
          FStar_Syntax_Syntax.sigel =
            (FStar_Syntax_Syntax.Sig_let
               ((false, [lb]), [a.FStar_Syntax_Syntax.action_name]));
          FStar_Syntax_Syntax.sigrng =
            ((a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos);
          FStar_Syntax_Syntax.sigquals =
            [FStar_Syntax_Syntax.Visible_default;
            FStar_Syntax_Syntax.Action eff_lid];
          FStar_Syntax_Syntax.sigmeta = FStar_Syntax_Syntax.default_sigmeta;
          FStar_Syntax_Syntax.sigattrs = []
        }
  
let (mk_reify :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t  ->
    let reify_ =
      FStar_Syntax_Syntax.mk
        (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_reify)
        FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
       in
    let uu____10299 =
      let uu____10306 =
        let uu____10307 =
          let uu____10322 =
            let uu____10331 = FStar_Syntax_Syntax.as_arg t  in [uu____10331]
             in
          (reify_, uu____10322)  in
        FStar_Syntax_Syntax.Tm_app uu____10307  in
      FStar_Syntax_Syntax.mk uu____10306  in
    uu____10299 FStar_Pervasives_Native.None t.FStar_Syntax_Syntax.pos
  
let rec (delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let t1 = FStar_Syntax_Subst.compress t  in
    match t1.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____10369 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_lazy i ->
        let uu____10395 = unfold_lazy i  in delta_qualifier uu____10395
    | FStar_Syntax_Syntax.Tm_fvar fv -> fv.FStar_Syntax_Syntax.fv_delta
    | FStar_Syntax_Syntax.Tm_bvar uu____10397 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_name uu____10398 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_match uu____10399 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_uvar uu____10422 ->
        FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_unknown  -> FStar_Syntax_Syntax.delta_equational
    | FStar_Syntax_Syntax.Tm_type uu____10429 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_quoted uu____10430 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_constant uu____10437 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_arrow uu____10438 ->
        FStar_Syntax_Syntax.delta_constant
    | FStar_Syntax_Syntax.Tm_uinst (t2,uu____10452) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_refine
        ({ FStar_Syntax_Syntax.ppname = uu____10457;
           FStar_Syntax_Syntax.index = uu____10458;
           FStar_Syntax_Syntax.sort = t2;_},uu____10460)
        -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_meta (t2,uu____10468) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____10474,uu____10475) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_app (t2,uu____10517) -> delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_abs (uu____10538,t2,uu____10540) ->
        delta_qualifier t2
    | FStar_Syntax_Syntax.Tm_let (uu____10561,t2) -> delta_qualifier t2
  
let rec (incr_delta_depth :
  FStar_Syntax_Syntax.delta_depth -> FStar_Syntax_Syntax.delta_depth) =
  fun d  ->
    match d with
    | FStar_Syntax_Syntax.Delta_constant_at_level i ->
        FStar_Syntax_Syntax.Delta_constant_at_level
          (i + (Prims.parse_int "1"))
    | FStar_Syntax_Syntax.Delta_equational_at_level i ->
        FStar_Syntax_Syntax.Delta_equational_at_level
          (i + (Prims.parse_int "1"))
    | FStar_Syntax_Syntax.Delta_abstract d1 -> incr_delta_depth d1
  
let (incr_delta_qualifier :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.delta_depth) =
  fun t  ->
    let uu____10592 = delta_qualifier t  in incr_delta_depth uu____10592
  
let (is_unknown : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____10598 =
      let uu____10599 = FStar_Syntax_Subst.compress t  in
      uu____10599.FStar_Syntax_Syntax.n  in
    match uu____10598 with
    | FStar_Syntax_Syntax.Tm_unknown  -> true
    | uu____10602 -> false
  
let rec (list_elements :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.term Prims.list FStar_Pervasives_Native.option)
  =
  fun e  ->
    let uu____10616 =
      let uu____10631 = unmeta e  in head_and_args uu____10631  in
    match uu____10616 with
    | (head1,args) ->
        let uu____10658 =
          let uu____10671 =
            let uu____10672 = un_uinst head1  in
            uu____10672.FStar_Syntax_Syntax.n  in
          (uu____10671, args)  in
        (match uu____10658 with
         | (FStar_Syntax_Syntax.Tm_fvar fv,uu____10688) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.nil_lid ->
             FStar_Pervasives_Native.Some []
         | (FStar_Syntax_Syntax.Tm_fvar
            fv,uu____10708::(hd1,uu____10710)::(tl1,uu____10712)::[]) when
             FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.cons_lid ->
             let uu____10759 =
               let uu____10762 =
                 let uu____10765 = list_elements tl1  in
                 FStar_Util.must uu____10765  in
               hd1 :: uu____10762  in
             FStar_Pervasives_Native.Some uu____10759
         | uu____10774 -> FStar_Pervasives_Native.None)
  
let rec apply_last :
  'Auu____10796 .
    ('Auu____10796 -> 'Auu____10796) ->
      'Auu____10796 Prims.list -> 'Auu____10796 Prims.list
  =
  fun f  ->
    fun l  ->
      match l with
      | [] -> failwith "apply_last: got empty list"
      | a::[] -> let uu____10821 = f a  in [uu____10821]
      | x::xs -> let uu____10826 = apply_last f xs  in x :: uu____10826
  
let (dm4f_lid :
  FStar_Syntax_Syntax.eff_decl -> Prims.string -> FStar_Ident.lident) =
  fun ed  ->
    fun name  ->
      let p = FStar_Ident.path_of_lid ed.FStar_Syntax_Syntax.mname  in
      let p' =
        apply_last
          (fun s  ->
             Prims.strcat "_dm4f_" (Prims.strcat s (Prims.strcat "_" name)))
          p
         in
      FStar_Ident.lid_of_path p' FStar_Range.dummyRange
  
let rec (mk_list :
  FStar_Syntax_Syntax.term ->
    FStar_Range.range ->
      FStar_Syntax_Syntax.term Prims.list -> FStar_Syntax_Syntax.term)
  =
  fun typ  ->
    fun rng  ->
      fun l  ->
        let ctor l1 =
          let uu____10872 =
            let uu____10879 =
              let uu____10880 =
                FStar_Syntax_Syntax.lid_as_fv l1
                  FStar_Syntax_Syntax.delta_constant
                  (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Data_ctor)
                 in
              FStar_Syntax_Syntax.Tm_fvar uu____10880  in
            FStar_Syntax_Syntax.mk uu____10879  in
          uu____10872 FStar_Pervasives_Native.None rng  in
        let cons1 args pos =
          let uu____10897 =
            let uu____10902 =
              let uu____10903 = ctor FStar_Parser_Const.cons_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____10903
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____10902 args  in
          uu____10897 FStar_Pervasives_Native.None pos  in
        let nil args pos =
          let uu____10919 =
            let uu____10924 =
              let uu____10925 = ctor FStar_Parser_Const.nil_lid  in
              FStar_Syntax_Syntax.mk_Tm_uinst uu____10925
                [FStar_Syntax_Syntax.U_zero]
               in
            FStar_Syntax_Syntax.mk_Tm_app uu____10924 args  in
          uu____10919 FStar_Pervasives_Native.None pos  in
        let uu____10928 =
          let uu____10929 =
            let uu____10930 = FStar_Syntax_Syntax.iarg typ  in [uu____10930]
             in
          nil uu____10929 rng  in
        FStar_List.fold_right
          (fun t  ->
             fun a  ->
               let uu____10958 =
                 let uu____10959 = FStar_Syntax_Syntax.iarg typ  in
                 let uu____10966 =
                   let uu____10975 = FStar_Syntax_Syntax.as_arg t  in
                   let uu____10982 =
                     let uu____10991 = FStar_Syntax_Syntax.as_arg a  in
                     [uu____10991]  in
                   uu____10975 :: uu____10982  in
                 uu____10959 :: uu____10966  in
               cons1 uu____10958 t.FStar_Syntax_Syntax.pos) l uu____10928
  
let (uvar_from_id :
  Prims.int ->
    (FStar_Syntax_Syntax.binding Prims.list,(FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
                                              FStar_Pervasives_Native.tuple2
                                              Prims.list,FStar_Syntax_Syntax.term'
                                                           FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple3 ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun id1  ->
    fun uu____11049  ->
      match uu____11049 with
      | (gamma,bs,t) ->
          let ctx_u =
            let uu____11092 = FStar_Syntax_Unionfind.from_id id1  in
            {
              FStar_Syntax_Syntax.ctx_uvar_head = uu____11092;
              FStar_Syntax_Syntax.ctx_uvar_gamma = gamma;
              FStar_Syntax_Syntax.ctx_uvar_binders = bs;
              FStar_Syntax_Syntax.ctx_uvar_typ = t;
              FStar_Syntax_Syntax.ctx_uvar_reason = "";
              FStar_Syntax_Syntax.ctx_uvar_should_check = true;
              FStar_Syntax_Syntax.ctx_uvar_range = FStar_Range.dummyRange
            }  in
          (failwith
             "uvar_from_id: not fully supported yet .. delayed substitutions";
           FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uvar (ctx_u, []))
             FStar_Pervasives_Native.None FStar_Range.dummyRange)
  
let rec eqlist :
  'a .
    ('a -> 'a -> Prims.bool) -> 'a Prims.list -> 'a Prims.list -> Prims.bool
  =
  fun eq1  ->
    fun xs  ->
      fun ys  ->
        match (xs, ys) with
        | ([],[]) -> true
        | (x::xs1,y::ys1) -> (eq1 x y) && (eqlist eq1 xs1 ys1)
        | uu____11169 -> false
  
let eqsum :
  'a 'b .
    ('a -> 'a -> Prims.bool) ->
      ('b -> 'b -> Prims.bool) ->
        ('a,'b) FStar_Util.either -> ('a,'b) FStar_Util.either -> Prims.bool
  =
  fun e1  ->
    fun e2  ->
      fun x  ->
        fun y  ->
          match (x, y) with
          | (FStar_Util.Inl x1,FStar_Util.Inl y1) -> e1 x1 y1
          | (FStar_Util.Inr x1,FStar_Util.Inr y1) -> e2 x1 y1
          | uu____11276 -> false
  
let eqprod :
  'a 'b .
    ('a -> 'a -> Prims.bool) ->
      ('b -> 'b -> Prims.bool) ->
        ('a,'b) FStar_Pervasives_Native.tuple2 ->
          ('a,'b) FStar_Pervasives_Native.tuple2 -> Prims.bool
  =
  fun e1  ->
    fun e2  ->
      fun x  ->
        fun y  ->
          match (x, y) with | ((x1,x2),(y1,y2)) -> (e1 x1 y1) && (e2 x2 y2)
  
let eqopt :
  'a .
    ('a -> 'a -> Prims.bool) ->
      'a FStar_Pervasives_Native.option ->
        'a FStar_Pervasives_Native.option -> Prims.bool
  =
  fun e  ->
    fun x  ->
      fun y  ->
        match (x, y) with
        | (FStar_Pervasives_Native.Some x1,FStar_Pervasives_Native.Some y1)
            -> e x1 y1
        | uu____11431 -> false
  
let (debug_term_eq : Prims.bool FStar_ST.ref) = FStar_Util.mk_ref false 
let (check : Prims.string -> Prims.bool -> Prims.bool) =
  fun msg  ->
    fun cond  ->
      if cond
      then true
      else
        ((let uu____11465 = FStar_ST.op_Bang debug_term_eq  in
          if uu____11465
          then FStar_Util.print1 ">>> term_eq failing: %s\n" msg
          else ());
         false)
  
let (fail : Prims.string -> Prims.bool) = fun msg  -> check msg false 
let rec (term_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun dbg  ->
    fun t1  ->
      fun t2  ->
        let t11 = let uu____11653 = unmeta_safe t1  in canon_app uu____11653
           in
        let t21 = let uu____11659 = unmeta_safe t2  in canon_app uu____11659
           in
        let uu____11662 =
          let uu____11667 =
            let uu____11668 =
              let uu____11671 = un_uinst t11  in
              FStar_Syntax_Subst.compress uu____11671  in
            uu____11668.FStar_Syntax_Syntax.n  in
          let uu____11672 =
            let uu____11673 =
              let uu____11676 = un_uinst t21  in
              FStar_Syntax_Subst.compress uu____11676  in
            uu____11673.FStar_Syntax_Syntax.n  in
          (uu____11667, uu____11672)  in
        match uu____11662 with
        | (FStar_Syntax_Syntax.Tm_uinst uu____11677,uu____11678) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____11685,FStar_Syntax_Syntax.Tm_uinst uu____11686) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_delayed uu____11693,uu____11694) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____11719,FStar_Syntax_Syntax.Tm_delayed uu____11720) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_ascribed uu____11745,uu____11746) ->
            failwith "term_eq: impossible, should have been removed"
        | (uu____11773,FStar_Syntax_Syntax.Tm_ascribed uu____11774) ->
            failwith "term_eq: impossible, should have been removed"
        | (FStar_Syntax_Syntax.Tm_bvar x,FStar_Syntax_Syntax.Tm_bvar y) ->
            check "bvar"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_name x,FStar_Syntax_Syntax.Tm_name y) ->
            check "name"
              (x.FStar_Syntax_Syntax.index = y.FStar_Syntax_Syntax.index)
        | (FStar_Syntax_Syntax.Tm_fvar x,FStar_Syntax_Syntax.Tm_fvar y) ->
            let uu____11807 = FStar_Syntax_Syntax.fv_eq x y  in
            check "fvar" uu____11807
        | (FStar_Syntax_Syntax.Tm_constant c1,FStar_Syntax_Syntax.Tm_constant
           c2) ->
            let uu____11810 = FStar_Const.eq_const c1 c2  in
            check "const" uu____11810
        | (FStar_Syntax_Syntax.Tm_type
           uu____11811,FStar_Syntax_Syntax.Tm_type uu____11812) -> true
        | (FStar_Syntax_Syntax.Tm_abs (b1,t12,k1),FStar_Syntax_Syntax.Tm_abs
           (b2,t22,k2)) ->
            (let uu____11861 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "abs binders" uu____11861) &&
              (let uu____11867 = term_eq_dbg dbg t12 t22  in
               check "abs bodies" uu____11867)
        | (FStar_Syntax_Syntax.Tm_arrow (b1,c1),FStar_Syntax_Syntax.Tm_arrow
           (b2,c2)) ->
            (let uu____11906 = eqlist (binder_eq_dbg dbg) b1 b2  in
             check "arrow binders" uu____11906) &&
              (let uu____11912 = comp_eq_dbg dbg c1 c2  in
               check "arrow comp" uu____11912)
        | (FStar_Syntax_Syntax.Tm_refine
           (b1,t12),FStar_Syntax_Syntax.Tm_refine (b2,t22)) ->
            (check "refine bv"
               (b1.FStar_Syntax_Syntax.index = b2.FStar_Syntax_Syntax.index))
              &&
              (let uu____11926 = term_eq_dbg dbg t12 t22  in
               check "refine formula" uu____11926)
        | (FStar_Syntax_Syntax.Tm_app (f1,a1),FStar_Syntax_Syntax.Tm_app
           (f2,a2)) ->
            (let uu____11973 = term_eq_dbg dbg f1 f2  in
             check "app head" uu____11973) &&
              (let uu____11975 = eqlist (arg_eq_dbg dbg) a1 a2  in
               check "app args" uu____11975)
        | (FStar_Syntax_Syntax.Tm_match
           (t12,bs1),FStar_Syntax_Syntax.Tm_match (t22,bs2)) ->
            (let uu____12060 = term_eq_dbg dbg t12 t22  in
             check "match head" uu____12060) &&
              (let uu____12062 = eqlist (branch_eq_dbg dbg) bs1 bs2  in
               check "match branches" uu____12062)
        | (FStar_Syntax_Syntax.Tm_lazy uu____12077,uu____12078) ->
            let uu____12079 =
              let uu____12080 = unlazy t11  in
              term_eq_dbg dbg uu____12080 t21  in
            check "lazy_l" uu____12079
        | (uu____12081,FStar_Syntax_Syntax.Tm_lazy uu____12082) ->
            let uu____12083 =
              let uu____12084 = unlazy t21  in
              term_eq_dbg dbg t11 uu____12084  in
            check "lazy_r" uu____12083
        | (FStar_Syntax_Syntax.Tm_let
           ((b1,lbs1),t12),FStar_Syntax_Syntax.Tm_let ((b2,lbs2),t22)) ->
            ((check "let flag" (b1 = b2)) &&
               (let uu____12120 = eqlist (letbinding_eq_dbg dbg) lbs1 lbs2
                   in
                check "let lbs" uu____12120))
              &&
              (let uu____12122 = term_eq_dbg dbg t12 t22  in
               check "let body" uu____12122)
        | (FStar_Syntax_Syntax.Tm_uvar
           (u1,uu____12124),FStar_Syntax_Syntax.Tm_uvar (u2,uu____12126)) ->
            check "uvar"
              (u1.FStar_Syntax_Syntax.ctx_uvar_head =
                 u2.FStar_Syntax_Syntax.ctx_uvar_head)
        | (FStar_Syntax_Syntax.Tm_quoted
           (qt1,qi1),FStar_Syntax_Syntax.Tm_quoted (qt2,qi2)) ->
            (check "tm_quoted qi" (qi1 = qi2)) &&
              (let uu____12158 = term_eq_dbg dbg qt1 qt2  in
               check "tm_quoted payload" uu____12158)
        | (FStar_Syntax_Syntax.Tm_meta (t12,m1),FStar_Syntax_Syntax.Tm_meta
           (t22,m2)) ->
            (match (m1, m2) with
             | (FStar_Syntax_Syntax.Meta_monadic
                (n1,ty1),FStar_Syntax_Syntax.Meta_monadic (n2,ty2)) ->
                 (let uu____12185 = FStar_Ident.lid_equals n1 n2  in
                  check "meta_monadic lid" uu____12185) &&
                   (let uu____12187 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic type" uu____12187)
             | (FStar_Syntax_Syntax.Meta_monadic_lift
                (s1,t13,ty1),FStar_Syntax_Syntax.Meta_monadic_lift
                (s2,t23,ty2)) ->
                 ((let uu____12204 = FStar_Ident.lid_equals s1 s2  in
                   check "meta_monadic_lift src" uu____12204) &&
                    (let uu____12206 = FStar_Ident.lid_equals t13 t23  in
                     check "meta_monadic_lift tgt" uu____12206))
                   &&
                   (let uu____12208 = term_eq_dbg dbg ty1 ty2  in
                    check "meta_monadic_lift type" uu____12208)
             | uu____12209 -> fail "metas")
        | (FStar_Syntax_Syntax.Tm_unknown ,uu____12214) -> fail "unk"
        | (uu____12215,FStar_Syntax_Syntax.Tm_unknown ) -> fail "unk"
        | (FStar_Syntax_Syntax.Tm_bvar uu____12216,uu____12217) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_name uu____12218,uu____12219) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_fvar uu____12220,uu____12221) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_constant uu____12222,uu____12223) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_type uu____12224,uu____12225) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_abs uu____12226,uu____12227) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_arrow uu____12244,uu____12245) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_refine uu____12258,uu____12259) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_app uu____12266,uu____12267) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_match uu____12282,uu____12283) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_let uu____12306,uu____12307) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_uvar uu____12320,uu____12321) ->
            fail "bottom"
        | (FStar_Syntax_Syntax.Tm_meta uu____12328,uu____12329) ->
            fail "bottom"
        | (uu____12336,FStar_Syntax_Syntax.Tm_bvar uu____12337) ->
            fail "bottom"
        | (uu____12338,FStar_Syntax_Syntax.Tm_name uu____12339) ->
            fail "bottom"
        | (uu____12340,FStar_Syntax_Syntax.Tm_fvar uu____12341) ->
            fail "bottom"
        | (uu____12342,FStar_Syntax_Syntax.Tm_constant uu____12343) ->
            fail "bottom"
        | (uu____12344,FStar_Syntax_Syntax.Tm_type uu____12345) ->
            fail "bottom"
        | (uu____12346,FStar_Syntax_Syntax.Tm_abs uu____12347) ->
            fail "bottom"
        | (uu____12364,FStar_Syntax_Syntax.Tm_arrow uu____12365) ->
            fail "bottom"
        | (uu____12378,FStar_Syntax_Syntax.Tm_refine uu____12379) ->
            fail "bottom"
        | (uu____12386,FStar_Syntax_Syntax.Tm_app uu____12387) ->
            fail "bottom"
        | (uu____12402,FStar_Syntax_Syntax.Tm_match uu____12403) ->
            fail "bottom"
        | (uu____12426,FStar_Syntax_Syntax.Tm_let uu____12427) ->
            fail "bottom"
        | (uu____12440,FStar_Syntax_Syntax.Tm_uvar uu____12441) ->
            fail "bottom"
        | (uu____12448,FStar_Syntax_Syntax.Tm_meta uu____12449) ->
            fail "bottom"

and (arg_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 -> Prims.bool)
  =
  fun dbg  ->
    fun a1  ->
      fun a2  ->
        eqprod
          (fun t1  ->
             fun t2  ->
               let uu____12476 = term_eq_dbg dbg t1 t2  in
               check "arg tm" uu____12476)
          (fun q1  -> fun q2  -> check "arg qual" (q1 = q2)) a1 a2

and (binder_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2 ->
      (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 -> Prims.bool)
  =
  fun dbg  ->
    fun b1  ->
      fun b2  ->
        eqprod
          (fun b11  ->
             fun b21  ->
               let uu____12497 =
                 term_eq_dbg dbg b11.FStar_Syntax_Syntax.sort
                   b21.FStar_Syntax_Syntax.sort
                  in
               check "binder sort" uu____12497)
          (fun q1  -> fun q2  -> check "binder qual" (q1 = q2)) b1 b2

and (lcomp_eq_dbg :
  FStar_Syntax_Syntax.lcomp -> FStar_Syntax_Syntax.lcomp -> Prims.bool) =
  fun c1  -> fun c2  -> fail "lcomp"

and (residual_eq_dbg :
  FStar_Syntax_Syntax.residual_comp ->
    FStar_Syntax_Syntax.residual_comp -> Prims.bool)
  = fun r1  -> fun r2  -> fail "residual"

and (comp_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
      FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax -> Prims.bool)
  =
  fun dbg  ->
    fun c1  ->
      fun c2  ->
        let c11 = comp_to_comp_typ_nouniv c1  in
        let c21 = comp_to_comp_typ_nouniv c2  in
        ((let uu____12517 =
            FStar_Ident.lid_equals c11.FStar_Syntax_Syntax.effect_name
              c21.FStar_Syntax_Syntax.effect_name
             in
          check "comp eff" uu____12517) &&
           (let uu____12519 =
              term_eq_dbg dbg c11.FStar_Syntax_Syntax.result_typ
                c21.FStar_Syntax_Syntax.result_typ
               in
            check "comp result typ" uu____12519))
          && true

and (eq_flags_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.cflags -> FStar_Syntax_Syntax.cflags -> Prims.bool)
  = fun dbg  -> fun f1  -> fun f2  -> true

and (branch_eq_dbg :
  Prims.bool ->
    (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                               FStar_Syntax_Syntax.syntax
                                                               FStar_Pervasives_Native.option,
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
      FStar_Pervasives_Native.tuple3 ->
      (FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t,FStar_Syntax_Syntax.term'
                                                                 FStar_Syntax_Syntax.syntax
                                                                 FStar_Pervasives_Native.option,
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
        FStar_Pervasives_Native.tuple3 -> Prims.bool)
  =
  fun dbg  ->
    fun uu____12524  ->
      fun uu____12525  ->
        match (uu____12524, uu____12525) with
        | ((p1,w1,t1),(p2,w2,t2)) ->
            ((let uu____12650 = FStar_Syntax_Syntax.eq_pat p1 p2  in
              check "branch pat" uu____12650) &&
               (let uu____12652 = term_eq_dbg dbg t1 t2  in
                check "branch body" uu____12652))
              &&
              (let uu____12654 =
                 match (w1, w2) with
                 | (FStar_Pervasives_Native.Some
                    x,FStar_Pervasives_Native.Some y) -> term_eq_dbg dbg x y
                 | (FStar_Pervasives_Native.None
                    ,FStar_Pervasives_Native.None ) -> true
                 | uu____12669 -> false  in
               check "branch when" uu____12654)

and (letbinding_eq_dbg :
  Prims.bool ->
    FStar_Syntax_Syntax.letbinding ->
      FStar_Syntax_Syntax.letbinding -> Prims.bool)
  =
  fun dbg  ->
    fun lb1  ->
      fun lb2  ->
        ((let uu____12683 =
            eqsum (fun bv1  -> fun bv2  -> true) FStar_Syntax_Syntax.fv_eq
              lb1.FStar_Syntax_Syntax.lbname lb2.FStar_Syntax_Syntax.lbname
             in
          check "lb bv" uu____12683) &&
           (let uu____12689 =
              term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbtyp
                lb2.FStar_Syntax_Syntax.lbtyp
               in
            check "lb typ" uu____12689))
          &&
          (let uu____12691 =
             term_eq_dbg dbg lb1.FStar_Syntax_Syntax.lbdef
               lb2.FStar_Syntax_Syntax.lbdef
              in
           check "lb def" uu____12691)

let (term_eq :
  FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t1  ->
    fun t2  ->
      let r =
        let uu____12703 = FStar_ST.op_Bang debug_term_eq  in
        term_eq_dbg uu____12703 t1 t2  in
      FStar_ST.op_Colon_Equals debug_term_eq false; r
  
let rec (sizeof : FStar_Syntax_Syntax.term -> Prims.int) =
  fun t  ->
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____12756 ->
        let uu____12781 =
          let uu____12782 = FStar_Syntax_Subst.compress t  in
          sizeof uu____12782  in
        (Prims.parse_int "1") + uu____12781
    | FStar_Syntax_Syntax.Tm_bvar bv ->
        let uu____12784 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____12784
    | FStar_Syntax_Syntax.Tm_name bv ->
        let uu____12786 = sizeof bv.FStar_Syntax_Syntax.sort  in
        (Prims.parse_int "1") + uu____12786
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
        let uu____12793 = sizeof t1  in (FStar_List.length us) + uu____12793
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____12796) ->
        let uu____12817 = sizeof t1  in
        let uu____12818 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____12829  ->
                 match uu____12829 with
                 | (bv,uu____12835) ->
                     let uu____12836 = sizeof bv.FStar_Syntax_Syntax.sort  in
                     acc + uu____12836) (Prims.parse_int "0") bs
           in
        uu____12817 + uu____12818
    | FStar_Syntax_Syntax.Tm_app (hd1,args) ->
        let uu____12859 = sizeof hd1  in
        let uu____12860 =
          FStar_List.fold_left
            (fun acc  ->
               fun uu____12871  ->
                 match uu____12871 with
                 | (arg,uu____12877) ->
                     let uu____12878 = sizeof arg  in acc + uu____12878)
            (Prims.parse_int "0") args
           in
        uu____12859 + uu____12860
    | uu____12879 -> (Prims.parse_int "1")
  
let (is_fvar : FStar_Ident.lident -> FStar_Syntax_Syntax.term -> Prims.bool)
  =
  fun lid  ->
    fun t  ->
      let uu____12890 =
        let uu____12891 = un_uinst t  in uu____12891.FStar_Syntax_Syntax.n
         in
      match uu____12890 with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          FStar_Syntax_Syntax.fv_eq_lid fv lid
      | uu____12895 -> false
  
let (is_synth_by_tactic : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  -> is_fvar FStar_Parser_Const.synth_lid t 
let (has_attribute :
  FStar_Syntax_Syntax.attribute Prims.list ->
    FStar_Ident.lident -> Prims.bool)
  = fun attrs  -> fun attr  -> FStar_Util.for_some (is_fvar attr) attrs 
let (process_pragma :
  FStar_Syntax_Syntax.pragma -> FStar_Range.range -> unit) =
  fun p  ->
    fun r  ->
      let set_options1 t s =
        let uu____12936 = FStar_Options.set_options t s  in
        match uu____12936 with
        | FStar_Getopt.Success  -> ()
        | FStar_Getopt.Help  ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_FailToProcessPragma,
                "Failed to process pragma: use 'fstar --help' to see which options are available")
              r
        | FStar_Getopt.Error s1 ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_FailToProcessPragma,
                (Prims.strcat "Failed to process pragma: " s1)) r
         in
      match p with
      | FStar_Syntax_Syntax.LightOff  ->
          if p = FStar_Syntax_Syntax.LightOff
          then FStar_Options.set_ml_ish ()
          else ()
      | FStar_Syntax_Syntax.SetOptions o -> set_options1 FStar_Options.Set o
      | FStar_Syntax_Syntax.ResetOptions sopt ->
          ((let uu____12944 = FStar_Options.restore_cmd_line_options false
               in
            FStar_All.pipe_right uu____12944 (fun a237  -> ()));
           (match sopt with
            | FStar_Pervasives_Native.None  -> ()
            | FStar_Pervasives_Native.Some s ->
                set_options1 FStar_Options.Reset s))
  
let rec (unbound_variables :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun tm  ->
    let t = FStar_Syntax_Subst.compress tm  in
    match t.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Tm_delayed uu____12970 -> failwith "Impossible"
    | FStar_Syntax_Syntax.Tm_name x -> []
    | FStar_Syntax_Syntax.Tm_uvar uu____12998 -> []
    | FStar_Syntax_Syntax.Tm_type u -> []
    | FStar_Syntax_Syntax.Tm_bvar x -> [x]
    | FStar_Syntax_Syntax.Tm_fvar uu____13007 -> []
    | FStar_Syntax_Syntax.Tm_constant uu____13008 -> []
    | FStar_Syntax_Syntax.Tm_lazy uu____13009 -> []
    | FStar_Syntax_Syntax.Tm_unknown  -> []
    | FStar_Syntax_Syntax.Tm_uinst (t1,us) -> unbound_variables t1
    | FStar_Syntax_Syntax.Tm_abs (bs,t1,uu____13018) ->
        let uu____13039 = FStar_Syntax_Subst.open_term bs t1  in
        (match uu____13039 with
         | (bs1,t2) ->
             let uu____13048 =
               FStar_List.collect
                 (fun uu____13058  ->
                    match uu____13058 with
                    | (b,uu____13066) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____13067 = unbound_variables t2  in
             FStar_List.append uu____13048 uu____13067)
    | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
        let uu____13088 = FStar_Syntax_Subst.open_comp bs c  in
        (match uu____13088 with
         | (bs1,c1) ->
             let uu____13097 =
               FStar_List.collect
                 (fun uu____13107  ->
                    match uu____13107 with
                    | (b,uu____13115) ->
                        unbound_variables b.FStar_Syntax_Syntax.sort) bs1
                in
             let uu____13116 = unbound_variables_comp c1  in
             FStar_List.append uu____13097 uu____13116)
    | FStar_Syntax_Syntax.Tm_refine (b,t1) ->
        let uu____13125 =
          FStar_Syntax_Subst.open_term [(b, FStar_Pervasives_Native.None)] t1
           in
        (match uu____13125 with
         | (bs,t2) ->
             let uu____13142 =
               FStar_List.collect
                 (fun uu____13152  ->
                    match uu____13152 with
                    | (b1,uu____13160) ->
                        unbound_variables b1.FStar_Syntax_Syntax.sort) bs
                in
             let uu____13161 = unbound_variables t2  in
             FStar_List.append uu____13142 uu____13161)
    | FStar_Syntax_Syntax.Tm_app (t1,args) ->
        let uu____13186 =
          FStar_List.collect
            (fun uu____13198  ->
               match uu____13198 with
               | (x,uu____13208) -> unbound_variables x) args
           in
        let uu____13213 = unbound_variables t1  in
        FStar_List.append uu____13186 uu____13213
    | FStar_Syntax_Syntax.Tm_match (t1,pats) ->
        let uu____13254 = unbound_variables t1  in
        let uu____13257 =
          FStar_All.pipe_right pats
            (FStar_List.collect
               (fun br  ->
                  let uu____13272 = FStar_Syntax_Subst.open_branch br  in
                  match uu____13272 with
                  | (p,wopt,t2) ->
                      let uu____13294 = unbound_variables t2  in
                      let uu____13297 =
                        match wopt with
                        | FStar_Pervasives_Native.None  -> []
                        | FStar_Pervasives_Native.Some t3 ->
                            unbound_variables t3
                         in
                      FStar_List.append uu____13294 uu____13297))
           in
        FStar_List.append uu____13254 uu____13257
    | FStar_Syntax_Syntax.Tm_ascribed (t1,asc,uu____13311) ->
        let uu____13352 = unbound_variables t1  in
        let uu____13355 =
          let uu____13358 =
            match FStar_Pervasives_Native.fst asc with
            | FStar_Util.Inl t2 -> unbound_variables t2
            | FStar_Util.Inr c2 -> unbound_variables_comp c2  in
          let uu____13389 =
            match FStar_Pervasives_Native.snd asc with
            | FStar_Pervasives_Native.None  -> []
            | FStar_Pervasives_Native.Some tac -> unbound_variables tac  in
          FStar_List.append uu____13358 uu____13389  in
        FStar_List.append uu____13352 uu____13355
    | FStar_Syntax_Syntax.Tm_let ((false ,lb::[]),t1) ->
        let uu____13427 = unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
        let uu____13430 =
          let uu____13433 = unbound_variables lb.FStar_Syntax_Syntax.lbdef
             in
          let uu____13436 =
            match lb.FStar_Syntax_Syntax.lbname with
            | FStar_Util.Inr uu____13441 -> unbound_variables t1
            | FStar_Util.Inl bv ->
                let uu____13443 =
                  FStar_Syntax_Subst.open_term
                    [(bv, FStar_Pervasives_Native.None)] t1
                   in
                (match uu____13443 with
                 | (uu____13458,t2) -> unbound_variables t2)
             in
          FStar_List.append uu____13433 uu____13436  in
        FStar_List.append uu____13427 uu____13430
    | FStar_Syntax_Syntax.Tm_let ((uu____13460,lbs),t1) ->
        let uu____13477 = FStar_Syntax_Subst.open_let_rec lbs t1  in
        (match uu____13477 with
         | (lbs1,t2) ->
             let uu____13492 = unbound_variables t2  in
             let uu____13495 =
               FStar_List.collect
                 (fun lb  ->
                    let uu____13502 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbtyp  in
                    let uu____13505 =
                      unbound_variables lb.FStar_Syntax_Syntax.lbdef  in
                    FStar_List.append uu____13502 uu____13505) lbs1
                in
             FStar_List.append uu____13492 uu____13495)
    | FStar_Syntax_Syntax.Tm_quoted (tm1,qi) ->
        (match qi.FStar_Syntax_Syntax.qkind with
         | FStar_Syntax_Syntax.Quote_static  -> []
         | FStar_Syntax_Syntax.Quote_dynamic  -> unbound_variables tm1)
    | FStar_Syntax_Syntax.Tm_meta (t1,m) ->
        let uu____13522 = unbound_variables t1  in
        let uu____13525 =
          match m with
          | FStar_Syntax_Syntax.Meta_pattern args ->
              FStar_List.collect
                (FStar_List.collect
                   (fun uu____13558  ->
                      match uu____13558 with
                      | (a,uu____13568) -> unbound_variables a)) args
          | FStar_Syntax_Syntax.Meta_monadic_lift
              (uu____13573,uu____13574,t') -> unbound_variables t'
          | FStar_Syntax_Syntax.Meta_monadic (uu____13580,t') ->
              unbound_variables t'
          | FStar_Syntax_Syntax.Meta_labeled uu____13586 -> []
          | FStar_Syntax_Syntax.Meta_desugared uu____13593 -> []
          | FStar_Syntax_Syntax.Meta_named uu____13594 -> []  in
        FStar_List.append uu____13522 uu____13525

and (unbound_variables_comp :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.bv Prims.list)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.GTotal (t,uu____13601) -> unbound_variables t
    | FStar_Syntax_Syntax.Total (t,uu____13611) -> unbound_variables t
    | FStar_Syntax_Syntax.Comp ct ->
        let uu____13621 = unbound_variables ct.FStar_Syntax_Syntax.result_typ
           in
        let uu____13624 =
          FStar_List.collect
            (fun uu____13636  ->
               match uu____13636 with
               | (a,uu____13646) -> unbound_variables a)
            ct.FStar_Syntax_Syntax.effect_args
           in
        FStar_List.append uu____13621 uu____13624
