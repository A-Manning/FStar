open Prims
exception Un_extractable 
let (uu___is_Un_extractable : Prims.exn -> Prims.bool) =
  fun projectee  ->
    match projectee with | Un_extractable  -> true | uu____9 -> false
  
let (type_leq :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Extraction_ML_Syntax.mlty ->
      FStar_Extraction_ML_Syntax.mlty -> Prims.bool)
  =
  fun g  ->
    fun t1  ->
      fun t2  ->
        FStar_Extraction_ML_Util.type_leq
          (FStar_Extraction_ML_Util.udelta_unfold g) t1 t2
  
let (type_leq_c :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Extraction_ML_Syntax.mlexpr FStar_Pervasives_Native.option ->
      FStar_Extraction_ML_Syntax.mlty ->
        FStar_Extraction_ML_Syntax.mlty ->
          (Prims.bool,FStar_Extraction_ML_Syntax.mlexpr
                        FStar_Pervasives_Native.option)
            FStar_Pervasives_Native.tuple2)
  =
  fun g  ->
    fun t1  ->
      fun t2  ->
        FStar_Extraction_ML_Util.type_leq_c
          (FStar_Extraction_ML_Util.udelta_unfold g) t1 t2
  
let (eraseTypeDeep :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlty)
  =
  fun g  ->
    fun t  ->
      FStar_Extraction_ML_Util.eraseTypeDeep
        (FStar_Extraction_ML_Util.udelta_unfold g) t
  
let record_fields :
  'Auu____78 .
    FStar_Ident.ident Prims.list ->
      'Auu____78 Prims.list ->
        (Prims.string,'Auu____78) FStar_Pervasives_Native.tuple2 Prims.list
  =
  fun fs  ->
    fun vs  ->
      FStar_List.map2 (fun f  -> fun e  -> ((f.FStar_Ident.idText), e)) fs vs
  
let fail :
  'Auu____121 .
    FStar_Range.range ->
      (FStar_Errors.raw_error,Prims.string) FStar_Pervasives_Native.tuple2 ->
        'Auu____121
  = fun r  -> fun err  -> FStar_Errors.raise_error err r 
let err_uninst :
  'Auu____153 .
    FStar_Extraction_ML_UEnv.env ->
      FStar_Syntax_Syntax.term ->
        (Prims.string Prims.list,FStar_Extraction_ML_Syntax.mlty)
          FStar_Pervasives_Native.tuple2 ->
          FStar_Syntax_Syntax.term -> 'Auu____153
  =
  fun env  ->
    fun t  ->
      fun uu____179  ->
        fun app  ->
          match uu____179 with
          | (vars,ty) ->
              let uu____196 =
                let uu____202 =
                  let uu____204 = FStar_Syntax_Print.term_to_string t  in
                  let uu____206 =
                    FStar_All.pipe_right vars (FStar_String.concat ", ")  in
                  let uu____213 =
                    FStar_Extraction_ML_Code.string_of_mlty
                      env.FStar_Extraction_ML_UEnv.currentModule ty
                     in
                  let uu____215 = FStar_Syntax_Print.term_to_string app  in
                  FStar_Util.format4
                    "Variable %s has a polymorphic type (forall %s. %s); expected it to be fully instantiated, but got %s"
                    uu____204 uu____206 uu____213 uu____215
                   in
                (FStar_Errors.Fatal_Uninstantiated, uu____202)  in
              fail t.FStar_Syntax_Syntax.pos uu____196
  
let err_ill_typed_application :
  'Auu____234 'Auu____235 .
    FStar_Extraction_ML_UEnv.env ->
      FStar_Syntax_Syntax.term ->
        FStar_Extraction_ML_Syntax.mlexpr ->
          (FStar_Syntax_Syntax.term,'Auu____234)
            FStar_Pervasives_Native.tuple2 Prims.list ->
            FStar_Extraction_ML_Syntax.mlty -> 'Auu____235
  =
  fun env  ->
    fun t  ->
      fun mlhead  ->
        fun args  ->
          fun ty  ->
            let uu____273 =
              let uu____279 =
                let uu____281 = FStar_Syntax_Print.term_to_string t  in
                let uu____283 =
                  FStar_Extraction_ML_Code.string_of_mlexpr
                    env.FStar_Extraction_ML_UEnv.currentModule mlhead
                   in
                let uu____285 =
                  FStar_Extraction_ML_Code.string_of_mlty
                    env.FStar_Extraction_ML_UEnv.currentModule ty
                   in
                let uu____287 =
                  let uu____289 =
                    FStar_All.pipe_right args
                      (FStar_List.map
                         (fun uu____310  ->
                            match uu____310 with
                            | (x,uu____317) ->
                                FStar_Syntax_Print.term_to_string x))
                     in
                  FStar_All.pipe_right uu____289 (FStar_String.concat " ")
                   in
                FStar_Util.format4
                  "Ill-typed application: source application is %s \n translated prefix to %s at type %s\n remaining args are %s\n"
                  uu____281 uu____283 uu____285 uu____287
                 in
              (FStar_Errors.Fatal_IllTyped, uu____279)  in
            fail t.FStar_Syntax_Syntax.pos uu____273
  
let err_ill_typed_erasure :
  'Auu____334 .
    FStar_Extraction_ML_UEnv.env ->
      FStar_Range.range -> FStar_Extraction_ML_Syntax.mlty -> 'Auu____334
  =
  fun env  ->
    fun pos  ->
      fun ty  ->
        let uu____350 =
          let uu____356 =
            let uu____358 =
              FStar_Extraction_ML_Code.string_of_mlty
                env.FStar_Extraction_ML_UEnv.currentModule ty
               in
            FStar_Util.format1
              "Erased value found where a value of type %s was expected"
              uu____358
             in
          (FStar_Errors.Fatal_IllTyped, uu____356)  in
        fail pos uu____350
  
let err_value_restriction :
  'Auu____367 .
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax -> 'Auu____367
  =
  fun t  ->
    let uu____377 =
      let uu____383 =
        let uu____385 = FStar_Syntax_Print.tag_of_term t  in
        let uu____387 = FStar_Syntax_Print.term_to_string t  in
        FStar_Util.format2
          "Refusing to generalize because of the value restriction: (%s) %s"
          uu____385 uu____387
         in
      (FStar_Errors.Fatal_ValueRestriction, uu____383)  in
    fail t.FStar_Syntax_Syntax.pos uu____377
  
let (err_unexpected_eff :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Extraction_ML_Syntax.mlty ->
        FStar_Extraction_ML_Syntax.e_tag ->
          FStar_Extraction_ML_Syntax.e_tag -> unit)
  =
  fun env  ->
    fun t  ->
      fun ty  ->
        fun f0  ->
          fun f1  ->
            let uu____421 =
              let uu____427 =
                let uu____429 = FStar_Syntax_Print.term_to_string t  in
                let uu____431 =
                  FStar_Extraction_ML_Code.string_of_mlty
                    env.FStar_Extraction_ML_UEnv.currentModule ty
                   in
                let uu____433 = FStar_Extraction_ML_Util.eff_to_string f0  in
                let uu____435 = FStar_Extraction_ML_Util.eff_to_string f1  in
                FStar_Util.format4
                  "for expression %s of type %s, Expected effect %s; got effect %s"
                  uu____429 uu____431 uu____433 uu____435
                 in
              (FStar_Errors.Warning_ExtractionUnexpectedEffect, uu____427)
               in
            FStar_Errors.log_issue t.FStar_Syntax_Syntax.pos uu____421
  
let (effect_as_etag :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Ident.lident -> FStar_Extraction_ML_Syntax.e_tag)
  =
  let cache = FStar_Util.smap_create (Prims.parse_int "20")  in
  let rec delta_norm_eff g l =
    let uu____463 = FStar_Util.smap_try_find cache l.FStar_Ident.str  in
    match uu____463 with
    | FStar_Pervasives_Native.Some l1 -> l1
    | FStar_Pervasives_Native.None  ->
        let res =
          let uu____468 =
            FStar_TypeChecker_Env.lookup_effect_abbrev
              g.FStar_Extraction_ML_UEnv.tcenv [FStar_Syntax_Syntax.U_zero] l
             in
          match uu____468 with
          | FStar_Pervasives_Native.None  -> l
          | FStar_Pervasives_Native.Some (uu____479,c) ->
              delta_norm_eff g (FStar_Syntax_Util.comp_effect_name c)
           in
        (FStar_Util.smap_add cache l.FStar_Ident.str res; res)
     in
  fun g  ->
    fun l  ->
      let l1 = delta_norm_eff g l  in
      let uu____489 =
        FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_PURE_lid  in
      if uu____489
      then FStar_Extraction_ML_Syntax.E_PURE
      else
        (let uu____494 =
           FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_GHOST_lid  in
         if uu____494
         then FStar_Extraction_ML_Syntax.E_GHOST
         else
           (let ed_opt =
              FStar_TypeChecker_Env.effect_decl_opt
                g.FStar_Extraction_ML_UEnv.tcenv l1
               in
            match ed_opt with
            | FStar_Pervasives_Native.Some (ed,qualifiers) ->
                let uu____520 =
                  FStar_TypeChecker_Env.is_reifiable_effect
                    g.FStar_Extraction_ML_UEnv.tcenv
                    ed.FStar_Syntax_Syntax.mname
                   in
                if uu____520
                then FStar_Extraction_ML_Syntax.E_PURE
                else FStar_Extraction_ML_Syntax.E_IMPURE
            | FStar_Pervasives_Native.None  ->
                FStar_Extraction_ML_Syntax.E_IMPURE))
  
let rec (is_arity :
  FStar_Extraction_ML_UEnv.env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun env  ->
    fun t  ->
      let t1 = FStar_Syntax_Util.unmeta t  in
      let uu____544 =
        let uu____545 = FStar_Syntax_Subst.compress t1  in
        uu____545.FStar_Syntax_Syntax.n  in
      match uu____544 with
      | FStar_Syntax_Syntax.Tm_unknown  -> failwith "Impossible"
      | FStar_Syntax_Syntax.Tm_delayed uu____551 -> failwith "Impossible"
      | FStar_Syntax_Syntax.Tm_ascribed uu____576 -> failwith "Impossible"
      | FStar_Syntax_Syntax.Tm_meta uu____605 -> failwith "Impossible"
      | FStar_Syntax_Syntax.Tm_lazy i ->
          let uu____615 = FStar_Syntax_Util.unfold_lazy i  in
          is_arity env uu____615
      | FStar_Syntax_Syntax.Tm_uvar uu____616 -> false
      | FStar_Syntax_Syntax.Tm_constant uu____630 -> false
      | FStar_Syntax_Syntax.Tm_name uu____632 -> false
      | FStar_Syntax_Syntax.Tm_quoted uu____634 -> false
      | FStar_Syntax_Syntax.Tm_bvar uu____642 -> false
      | FStar_Syntax_Syntax.Tm_type uu____644 -> true
      | FStar_Syntax_Syntax.Tm_arrow (uu____646,c) ->
          is_arity env (FStar_Syntax_Util.comp_result c)
      | FStar_Syntax_Syntax.Tm_fvar uu____668 ->
          let t2 =
            FStar_TypeChecker_Normalize.normalize
              [FStar_TypeChecker_Env.AllowUnboundUniverses;
              FStar_TypeChecker_Env.EraseUniverses;
              FStar_TypeChecker_Env.UnfoldUntil
                FStar_Syntax_Syntax.delta_constant]
              env.FStar_Extraction_ML_UEnv.tcenv t1
             in
          let uu____670 =
            let uu____671 = FStar_Syntax_Subst.compress t2  in
            uu____671.FStar_Syntax_Syntax.n  in
          (match uu____670 with
           | FStar_Syntax_Syntax.Tm_fvar uu____675 -> false
           | uu____677 -> is_arity env t2)
      | FStar_Syntax_Syntax.Tm_app uu____678 ->
          let uu____695 = FStar_Syntax_Util.head_and_args t1  in
          (match uu____695 with | (head1,uu____714) -> is_arity env head1)
      | FStar_Syntax_Syntax.Tm_uinst (head1,uu____740) -> is_arity env head1
      | FStar_Syntax_Syntax.Tm_refine (x,uu____746) ->
          is_arity env x.FStar_Syntax_Syntax.sort
      | FStar_Syntax_Syntax.Tm_abs (uu____751,body,uu____753) ->
          is_arity env body
      | FStar_Syntax_Syntax.Tm_let (uu____778,body) -> is_arity env body
      | FStar_Syntax_Syntax.Tm_match (uu____798,branches) ->
          (match branches with
           | (uu____837,uu____838,e)::uu____840 -> is_arity env e
           | uu____887 -> false)
  
let rec (is_type_aux :
  FStar_Extraction_ML_UEnv.env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun env  ->
    fun t  ->
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_delayed uu____919 ->
          let uu____942 =
            let uu____944 = FStar_Syntax_Print.tag_of_term t1  in
            FStar_Util.format1 "Impossible: %s" uu____944  in
          failwith uu____942
      | FStar_Syntax_Syntax.Tm_unknown  ->
          let uu____948 =
            let uu____950 = FStar_Syntax_Print.tag_of_term t1  in
            FStar_Util.format1 "Impossible: %s" uu____950  in
          failwith uu____948
      | FStar_Syntax_Syntax.Tm_lazy i ->
          let uu____955 = FStar_Syntax_Util.unfold_lazy i  in
          is_type_aux env uu____955
      | FStar_Syntax_Syntax.Tm_constant uu____956 -> false
      | FStar_Syntax_Syntax.Tm_type uu____958 -> true
      | FStar_Syntax_Syntax.Tm_refine uu____960 -> true
      | FStar_Syntax_Syntax.Tm_arrow uu____968 -> true
      | FStar_Syntax_Syntax.Tm_fvar fv when
          FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.failwith_lid ->
          false
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          FStar_Extraction_ML_UEnv.is_type_name env fv
      | FStar_Syntax_Syntax.Tm_uvar
          ({ FStar_Syntax_Syntax.ctx_uvar_head = uu____987;
             FStar_Syntax_Syntax.ctx_uvar_gamma = uu____988;
             FStar_Syntax_Syntax.ctx_uvar_binders = uu____989;
             FStar_Syntax_Syntax.ctx_uvar_typ = t2;
             FStar_Syntax_Syntax.ctx_uvar_reason = uu____991;
             FStar_Syntax_Syntax.ctx_uvar_should_check = uu____992;
             FStar_Syntax_Syntax.ctx_uvar_range = uu____993;_},s)
          ->
          let uu____1034 = FStar_Syntax_Subst.subst' s t2  in
          is_arity env uu____1034
      | FStar_Syntax_Syntax.Tm_bvar
          { FStar_Syntax_Syntax.ppname = uu____1035;
            FStar_Syntax_Syntax.index = uu____1036;
            FStar_Syntax_Syntax.sort = t2;_}
          -> is_arity env t2
      | FStar_Syntax_Syntax.Tm_name
          { FStar_Syntax_Syntax.ppname = uu____1041;
            FStar_Syntax_Syntax.index = uu____1042;
            FStar_Syntax_Syntax.sort = t2;_}
          -> is_arity env t2
      | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____1048,uu____1049) ->
          is_type_aux env t2
      | FStar_Syntax_Syntax.Tm_uinst (t2,uu____1091) -> is_type_aux env t2
      | FStar_Syntax_Syntax.Tm_abs (bs,body,uu____1098) ->
          let uu____1123 = FStar_Syntax_Subst.open_term bs body  in
          (match uu____1123 with
           | (uu____1129,body1) -> is_type_aux env body1)
      | FStar_Syntax_Syntax.Tm_let ((false ,lb::[]),body) ->
          let x = FStar_Util.left lb.FStar_Syntax_Syntax.lbname  in
          let uu____1149 =
            let uu____1154 =
              let uu____1155 = FStar_Syntax_Syntax.mk_binder x  in
              [uu____1155]  in
            FStar_Syntax_Subst.open_term uu____1154 body  in
          (match uu____1149 with
           | (uu____1175,body1) -> is_type_aux env body1)
      | FStar_Syntax_Syntax.Tm_let ((uu____1177,lbs),body) ->
          let uu____1197 = FStar_Syntax_Subst.open_let_rec lbs body  in
          (match uu____1197 with
           | (uu____1205,body1) -> is_type_aux env body1)
      | FStar_Syntax_Syntax.Tm_match (uu____1211,branches) ->
          (match branches with
           | b::uu____1251 ->
               let uu____1296 = FStar_Syntax_Subst.open_branch b  in
               (match uu____1296 with
                | (uu____1298,uu____1299,e) -> is_type_aux env e)
           | uu____1317 -> false)
      | FStar_Syntax_Syntax.Tm_quoted uu____1335 -> false
      | FStar_Syntax_Syntax.Tm_meta (t2,uu____1344) -> is_type_aux env t2
      | FStar_Syntax_Syntax.Tm_app (head1,uu____1350) ->
          is_type_aux env head1
  
let (is_type :
  FStar_Extraction_ML_UEnv.env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun env  ->
    fun t  ->
      FStar_Extraction_ML_UEnv.debug env
        (fun uu____1391  ->
           let uu____1392 = FStar_Syntax_Print.tag_of_term t  in
           let uu____1394 = FStar_Syntax_Print.term_to_string t  in
           FStar_Util.print2 "checking is_type (%s) %s\n" uu____1392
             uu____1394);
      (let b = is_type_aux env t  in
       FStar_Extraction_ML_UEnv.debug env
         (fun uu____1403  ->
            if b
            then
              let uu____1405 = FStar_Syntax_Print.term_to_string t  in
              let uu____1407 = FStar_Syntax_Print.tag_of_term t  in
              FStar_Util.print2 "is_type %s (%s)\n" uu____1405 uu____1407
            else
              (let uu____1412 = FStar_Syntax_Print.term_to_string t  in
               let uu____1414 = FStar_Syntax_Print.tag_of_term t  in
               FStar_Util.print2 "not a type %s (%s)\n" uu____1412 uu____1414));
       b)
  
let is_type_binder :
  'Auu____1424 .
    FStar_Extraction_ML_UEnv.env ->
      (FStar_Syntax_Syntax.bv,'Auu____1424) FStar_Pervasives_Native.tuple2 ->
        Prims.bool
  =
  fun env  ->
    fun x  ->
      is_arity env (FStar_Pervasives_Native.fst x).FStar_Syntax_Syntax.sort
  
let (is_constructor : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1451 =
      let uu____1452 = FStar_Syntax_Subst.compress t  in
      uu____1452.FStar_Syntax_Syntax.n  in
    match uu____1451 with
    | FStar_Syntax_Syntax.Tm_fvar
        { FStar_Syntax_Syntax.fv_name = uu____1456;
          FStar_Syntax_Syntax.fv_delta = uu____1457;
          FStar_Syntax_Syntax.fv_qual = FStar_Pervasives_Native.Some
            (FStar_Syntax_Syntax.Data_ctor );_}
        -> true
    | FStar_Syntax_Syntax.Tm_fvar
        { FStar_Syntax_Syntax.fv_name = uu____1459;
          FStar_Syntax_Syntax.fv_delta = uu____1460;
          FStar_Syntax_Syntax.fv_qual = FStar_Pervasives_Native.Some
            (FStar_Syntax_Syntax.Record_ctor uu____1461);_}
        -> true
    | uu____1469 -> false
  
let rec (is_fstar_value : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t  ->
    let uu____1478 =
      let uu____1479 = FStar_Syntax_Subst.compress t  in
      uu____1479.FStar_Syntax_Syntax.n  in
    match uu____1478 with
    | FStar_Syntax_Syntax.Tm_constant uu____1483 -> true
    | FStar_Syntax_Syntax.Tm_bvar uu____1485 -> true
    | FStar_Syntax_Syntax.Tm_fvar uu____1487 -> true
    | FStar_Syntax_Syntax.Tm_abs uu____1489 -> true
    | FStar_Syntax_Syntax.Tm_app (head1,args) ->
        let uu____1535 = is_constructor head1  in
        if uu____1535
        then
          FStar_All.pipe_right args
            (FStar_List.for_all
               (fun uu____1557  ->
                  match uu____1557 with
                  | (te,uu____1566) -> is_fstar_value te))
        else false
    | FStar_Syntax_Syntax.Tm_meta (t1,uu____1575) -> is_fstar_value t1
    | FStar_Syntax_Syntax.Tm_ascribed (t1,uu____1581,uu____1582) ->
        is_fstar_value t1
    | uu____1623 -> false
  
let rec (is_ml_value : FStar_Extraction_ML_Syntax.mlexpr -> Prims.bool) =
  fun e  ->
    match e.FStar_Extraction_ML_Syntax.expr with
    | FStar_Extraction_ML_Syntax.MLE_Const uu____1633 -> true
    | FStar_Extraction_ML_Syntax.MLE_Var uu____1635 -> true
    | FStar_Extraction_ML_Syntax.MLE_Name uu____1638 -> true
    | FStar_Extraction_ML_Syntax.MLE_Fun uu____1640 -> true
    | FStar_Extraction_ML_Syntax.MLE_CTor (uu____1653,exps) ->
        FStar_Util.for_all is_ml_value exps
    | FStar_Extraction_ML_Syntax.MLE_Tuple exps ->
        FStar_Util.for_all is_ml_value exps
    | FStar_Extraction_ML_Syntax.MLE_Record (uu____1662,fields) ->
        FStar_Util.for_all
          (fun uu____1692  ->
             match uu____1692 with | (uu____1699,e1) -> is_ml_value e1)
          fields
    | FStar_Extraction_ML_Syntax.MLE_TApp (h,uu____1704) -> is_ml_value h
    | uu____1709 -> false
  
let (fresh : Prims.string -> Prims.string) =
  let c = FStar_Util.mk_ref (Prims.parse_int "0")  in
  fun x  ->
    FStar_Util.incr c;
    (let uu____1760 =
       let uu____1762 = FStar_ST.op_Bang c  in
       FStar_Util.string_of_int uu____1762  in
     Prims.strcat x uu____1760)
  
let (normalize_abs : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t0  ->
    let rec aux bs t copt =
      let t1 = FStar_Syntax_Subst.compress t  in
      match t1.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_abs (bs',body,copt1) ->
          aux (FStar_List.append bs bs') body copt1
      | uu____1887 ->
          let e' = FStar_Syntax_Util.unascribe t1  in
          let uu____1889 = FStar_Syntax_Util.is_fun e'  in
          if uu____1889
          then aux bs e' copt
          else FStar_Syntax_Util.abs bs e' copt
       in
    aux [] t0 FStar_Pervasives_Native.None
  
let (unit_binder : FStar_Syntax_Syntax.binder) =
  let uu____1903 =
    FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
      FStar_Syntax_Syntax.t_unit
     in
  FStar_All.pipe_left FStar_Syntax_Syntax.mk_binder uu____1903 
let (check_pats_for_ite :
  (FStar_Syntax_Syntax.pat,FStar_Syntax_Syntax.term
                             FStar_Pervasives_Native.option,FStar_Syntax_Syntax.term)
    FStar_Pervasives_Native.tuple3 Prims.list ->
    (Prims.bool,FStar_Syntax_Syntax.term FStar_Pervasives_Native.option,
      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
      FStar_Pervasives_Native.tuple3)
  =
  fun l  ->
    let def =
      (false, FStar_Pervasives_Native.None, FStar_Pervasives_Native.None)  in
    if (FStar_List.length l) <> (Prims.parse_int "2")
    then def
    else
      (let uu____1994 = FStar_List.hd l  in
       match uu____1994 with
       | (p1,w1,e1) ->
           let uu____2029 =
             let uu____2038 = FStar_List.tl l  in FStar_List.hd uu____2038
              in
           (match uu____2029 with
            | (p2,w2,e2) ->
                (match (w1, w2, (p1.FStar_Syntax_Syntax.v),
                         (p2.FStar_Syntax_Syntax.v))
                 with
                 | (FStar_Pervasives_Native.None
                    ,FStar_Pervasives_Native.None
                    ,FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool
                    (true )),FStar_Syntax_Syntax.Pat_constant
                    (FStar_Const.Const_bool (false ))) ->
                     (true, (FStar_Pervasives_Native.Some e1),
                       (FStar_Pervasives_Native.Some e2))
                 | (FStar_Pervasives_Native.None
                    ,FStar_Pervasives_Native.None
                    ,FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool
                    (false )),FStar_Syntax_Syntax.Pat_constant
                    (FStar_Const.Const_bool (true ))) ->
                     (true, (FStar_Pervasives_Native.Some e2),
                       (FStar_Pervasives_Native.Some e1))
                 | uu____2122 -> def)))
  
let (instantiate :
  FStar_Extraction_ML_Syntax.mltyscheme ->
    FStar_Extraction_ML_Syntax.mlty Prims.list ->
      FStar_Extraction_ML_Syntax.mlty)
  = fun s  -> fun args  -> FStar_Extraction_ML_Util.subst s args 
let (eta_expand :
  FStar_Extraction_ML_Syntax.mlty ->
    FStar_Extraction_ML_Syntax.mlexpr -> FStar_Extraction_ML_Syntax.mlexpr)
  =
  fun t  ->
    fun e  ->
      let uu____2161 = FStar_Extraction_ML_Util.doms_and_cod t  in
      match uu____2161 with
      | (ts,r) ->
          if ts = []
          then e
          else
            (let vs = FStar_List.map (fun uu____2185  -> fresh "a") ts  in
             let vs_ts = FStar_List.zip vs ts  in
             let vs_es =
               let uu____2199 = FStar_List.zip vs ts  in
               FStar_List.map
                 (fun uu____2216  ->
                    match uu____2216 with
                    | (v1,t1) ->
                        FStar_Extraction_ML_Syntax.with_ty t1
                          (FStar_Extraction_ML_Syntax.MLE_Var v1)) uu____2199
                in
             let body =
               FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty r)
                 (FStar_Extraction_ML_Syntax.MLE_App (e, vs_es))
                in
             FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t)
               (FStar_Extraction_ML_Syntax.MLE_Fun (vs_ts, body)))
  
let (default_value_for_ty :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlexpr)
  =
  fun g  ->
    fun t  ->
      let uu____2247 = FStar_Extraction_ML_Util.doms_and_cod t  in
      match uu____2247 with
      | (ts,r) ->
          let body r1 =
            let r2 =
              let uu____2267 = FStar_Extraction_ML_Util.udelta_unfold g r1
                 in
              match uu____2267 with
              | FStar_Pervasives_Native.None  -> r1
              | FStar_Pervasives_Native.Some r2 -> r2  in
            match r2 with
            | FStar_Extraction_ML_Syntax.MLTY_Erased  ->
                FStar_Extraction_ML_Syntax.ml_unit
            | FStar_Extraction_ML_Syntax.MLTY_Top  ->
                FStar_Extraction_ML_Syntax.apply_obj_repr
                  FStar_Extraction_ML_Syntax.ml_unit
                  FStar_Extraction_ML_Syntax.MLTY_Erased
            | uu____2271 ->
                FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty r2)
                  (FStar_Extraction_ML_Syntax.MLE_Coerce
                     (FStar_Extraction_ML_Syntax.ml_unit,
                       FStar_Extraction_ML_Syntax.MLTY_Erased, r2))
             in
          if ts = []
          then body r
          else
            (let vs = FStar_List.map (fun uu____2283  -> fresh "a") ts  in
             let vs_ts = FStar_List.zip vs ts  in
             let uu____2294 =
               let uu____2295 =
                 let uu____2307 = body r  in (vs_ts, uu____2307)  in
               FStar_Extraction_ML_Syntax.MLE_Fun uu____2295  in
             FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty t)
               uu____2294)
  
let (maybe_eta_expand :
  FStar_Extraction_ML_Syntax.mlty ->
    FStar_Extraction_ML_Syntax.mlexpr -> FStar_Extraction_ML_Syntax.mlexpr)
  =
  fun expect  ->
    fun e  ->
      let uu____2326 =
        (FStar_Options.ml_no_eta_expand_coertions ()) ||
          (let uu____2329 = FStar_Options.codegen ()  in
           uu____2329 = (FStar_Pervasives_Native.Some FStar_Options.Kremlin))
         in
      if uu____2326 then e else eta_expand expect e
  
let (apply_coercion :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Extraction_ML_Syntax.mlexpr ->
      FStar_Extraction_ML_Syntax.mlty ->
        FStar_Extraction_ML_Syntax.mlty -> FStar_Extraction_ML_Syntax.mlexpr)
  =
  fun g  ->
    fun e  ->
      fun ty  ->
        fun expect  ->
          let rec aux e1 ty1 expect1 =
            let coerce_branch uu____2395 =
              match uu____2395 with
              | (pat,w,b) ->
                  let uu____2419 = aux b ty1 expect1  in (pat, w, uu____2419)
               in
            match ((e1.FStar_Extraction_ML_Syntax.expr), ty1, expect1) with
            | (FStar_Extraction_ML_Syntax.MLE_Fun
               (arg::rest,body),FStar_Extraction_ML_Syntax.MLTY_Fun
               (t0,uu____2426,t1),FStar_Extraction_ML_Syntax.MLTY_Fun
               (s0,uu____2429,s1)) ->
                let body1 =
                  match rest with
                  | [] -> body
                  | uu____2461 ->
                      FStar_Extraction_ML_Syntax.with_ty t1
                        (FStar_Extraction_ML_Syntax.MLE_Fun (rest, body))
                   in
                let body2 = aux body1 t1 s1  in
                let uu____2477 = type_leq g s0 t0  in
                if uu____2477
                then
                  FStar_Extraction_ML_Syntax.with_ty expect1
                    (FStar_Extraction_ML_Syntax.MLE_Fun ([arg], body2))
                else
                  (let lb =
                     let uu____2500 =
                       let uu____2501 =
                         let uu____2502 =
                           let uu____2509 =
                             FStar_All.pipe_left
                               (FStar_Extraction_ML_Syntax.with_ty s0)
                               (FStar_Extraction_ML_Syntax.MLE_Var
                                  (FStar_Pervasives_Native.fst arg))
                              in
                           (uu____2509, s0, t0)  in
                         FStar_Extraction_ML_Syntax.MLE_Coerce uu____2502  in
                       FStar_Extraction_ML_Syntax.with_ty t0 uu____2501  in
                     {
                       FStar_Extraction_ML_Syntax.mllb_name =
                         (FStar_Pervasives_Native.fst arg);
                       FStar_Extraction_ML_Syntax.mllb_tysc =
                         (FStar_Pervasives_Native.Some ([], t0));
                       FStar_Extraction_ML_Syntax.mllb_add_unit = false;
                       FStar_Extraction_ML_Syntax.mllb_def = uu____2500;
                       FStar_Extraction_ML_Syntax.mllb_meta = [];
                       FStar_Extraction_ML_Syntax.print_typ = false
                     }  in
                   let body3 =
                     FStar_All.pipe_left
                       (FStar_Extraction_ML_Syntax.with_ty s1)
                       (FStar_Extraction_ML_Syntax.MLE_Let
                          ((FStar_Extraction_ML_Syntax.NonRec, [lb]), body2))
                      in
                   FStar_All.pipe_left
                     (FStar_Extraction_ML_Syntax.with_ty expect1)
                     (FStar_Extraction_ML_Syntax.MLE_Fun
                        ([((FStar_Pervasives_Native.fst arg), s0)], body3)))
            | (FStar_Extraction_ML_Syntax.MLE_Let
               (lbs,body),uu____2545,uu____2546) ->
                let uu____2559 =
                  let uu____2560 =
                    let uu____2571 = aux body ty1 expect1  in
                    (lbs, uu____2571)  in
                  FStar_Extraction_ML_Syntax.MLE_Let uu____2560  in
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty expect1) uu____2559
            | (FStar_Extraction_ML_Syntax.MLE_Match
               (s,branches),uu____2580,uu____2581) ->
                let uu____2602 =
                  let uu____2603 =
                    let uu____2618 = FStar_List.map coerce_branch branches
                       in
                    (s, uu____2618)  in
                  FStar_Extraction_ML_Syntax.MLE_Match uu____2603  in
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty expect1) uu____2602
            | (FStar_Extraction_ML_Syntax.MLE_If
               (s,b1,b2_opt),uu____2658,uu____2659) ->
                let uu____2664 =
                  let uu____2665 =
                    let uu____2674 = aux b1 ty1 expect1  in
                    let uu____2675 =
                      FStar_Util.map_opt b2_opt
                        (fun b2  -> aux b2 ty1 expect1)
                       in
                    (s, uu____2674, uu____2675)  in
                  FStar_Extraction_ML_Syntax.MLE_If uu____2665  in
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty expect1) uu____2664
            | (FStar_Extraction_ML_Syntax.MLE_Seq es,uu____2683,uu____2684)
                ->
                let uu____2687 = FStar_Util.prefix es  in
                (match uu____2687 with
                 | (prefix1,last1) ->
                     let uu____2700 =
                       let uu____2701 =
                         let uu____2704 =
                           let uu____2707 = aux last1 ty1 expect1  in
                           [uu____2707]  in
                         FStar_List.append prefix1 uu____2704  in
                       FStar_Extraction_ML_Syntax.MLE_Seq uu____2701  in
                     FStar_All.pipe_left
                       (FStar_Extraction_ML_Syntax.with_ty expect1)
                       uu____2700)
            | (FStar_Extraction_ML_Syntax.MLE_Try
               (s,branches),uu____2710,uu____2711) ->
                let uu____2732 =
                  let uu____2733 =
                    let uu____2748 = FStar_List.map coerce_branch branches
                       in
                    (s, uu____2748)  in
                  FStar_Extraction_ML_Syntax.MLE_Try uu____2733  in
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty expect1) uu____2732
            | uu____2785 ->
                FStar_Extraction_ML_Syntax.with_ty expect1
                  (FStar_Extraction_ML_Syntax.MLE_Coerce (e1, ty1, expect1))
             in
          aux e ty expect
  
let maybe_coerce :
  'Auu____2805 .
    'Auu____2805 ->
      FStar_Extraction_ML_UEnv.env ->
        FStar_Extraction_ML_Syntax.mlexpr ->
          FStar_Extraction_ML_Syntax.mlty ->
            FStar_Extraction_ML_Syntax.mlty ->
              FStar_Extraction_ML_Syntax.mlexpr
  =
  fun pos  ->
    fun g  ->
      fun e  ->
        fun ty  ->
          fun expect  ->
            let ty1 = eraseTypeDeep g ty  in
            let uu____2832 =
              type_leq_c g (FStar_Pervasives_Native.Some e) ty1 expect  in
            match uu____2832 with
            | (true ,FStar_Pervasives_Native.Some e') -> e'
            | uu____2845 ->
                (match ty1 with
                 | FStar_Extraction_ML_Syntax.MLTY_Erased  ->
                     default_value_for_ty g expect
                 | uu____2853 ->
                     let uu____2854 =
                       let uu____2856 =
                         FStar_Extraction_ML_Util.erase_effect_annotations
                           ty1
                          in
                       let uu____2857 =
                         FStar_Extraction_ML_Util.erase_effect_annotations
                           expect
                          in
                       type_leq g uu____2856 uu____2857  in
                     if uu____2854
                     then
                       (FStar_Extraction_ML_UEnv.debug g
                          (fun uu____2863  ->
                             let uu____2864 =
                               FStar_Extraction_ML_Code.string_of_mlexpr
                                 g.FStar_Extraction_ML_UEnv.currentModule e
                                in
                             let uu____2866 =
                               FStar_Extraction_ML_Code.string_of_mlty
                                 g.FStar_Extraction_ML_UEnv.currentModule ty1
                                in
                             FStar_Util.print2
                               "\n Effect mismatch on type of %s : %s\n"
                               uu____2864 uu____2866);
                        e)
                     else
                       (FStar_Extraction_ML_UEnv.debug g
                          (fun uu____2876  ->
                             let uu____2877 =
                               FStar_Extraction_ML_Code.string_of_mlexpr
                                 g.FStar_Extraction_ML_UEnv.currentModule e
                                in
                             let uu____2879 =
                               FStar_Extraction_ML_Code.string_of_mlty
                                 g.FStar_Extraction_ML_UEnv.currentModule ty1
                                in
                             let uu____2881 =
                               FStar_Extraction_ML_Code.string_of_mlty
                                 g.FStar_Extraction_ML_UEnv.currentModule
                                 expect
                                in
                             FStar_Util.print3
                               "\n (*needed to coerce expression \n %s \n of type \n %s \n to type \n %s *) \n"
                               uu____2877 uu____2879 uu____2881);
                        (let uu____2884 = apply_coercion g e ty1 expect  in
                         maybe_eta_expand expect uu____2884)))
  
let (bv_as_mlty :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.bv -> FStar_Extraction_ML_Syntax.mlty)
  =
  fun g  ->
    fun bv  ->
      let uu____2896 = FStar_Extraction_ML_UEnv.lookup_bv g bv  in
      match uu____2896 with
      | FStar_Util.Inl ty_b -> ty_b.FStar_Extraction_ML_UEnv.ty_b_ty
      | uu____2898 -> FStar_Extraction_ML_Syntax.MLTY_Top
  
let (basic_norm_steps : FStar_TypeChecker_Env.step Prims.list) =
  [FStar_TypeChecker_Env.Beta;
  FStar_TypeChecker_Env.Eager_unfolding;
  FStar_TypeChecker_Env.Iota;
  FStar_TypeChecker_Env.Zeta;
  FStar_TypeChecker_Env.Inlining;
  FStar_TypeChecker_Env.EraseUniverses;
  FStar_TypeChecker_Env.AllowUnboundUniverses] 
let (comp_no_args :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax)
  =
  fun c  ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total uu____2916 -> c
    | FStar_Syntax_Syntax.GTotal uu____2925 -> c
    | FStar_Syntax_Syntax.Comp ct ->
        let effect_args =
          FStar_List.map
            (fun uu____2961  ->
               match uu____2961 with
               | (uu____2976,aq) -> (FStar_Syntax_Syntax.t_unit, aq))
            ct.FStar_Syntax_Syntax.effect_args
           in
        let ct1 =
          let uu___368_2989 = ct  in
          {
            FStar_Syntax_Syntax.comp_univs =
              (uu___368_2989.FStar_Syntax_Syntax.comp_univs);
            FStar_Syntax_Syntax.effect_name =
              (uu___368_2989.FStar_Syntax_Syntax.effect_name);
            FStar_Syntax_Syntax.result_typ =
              (uu___368_2989.FStar_Syntax_Syntax.result_typ);
            FStar_Syntax_Syntax.effect_args = effect_args;
            FStar_Syntax_Syntax.flags =
              (uu___368_2989.FStar_Syntax_Syntax.flags)
          }  in
        let c1 =
          let uu___369_2993 = c  in
          {
            FStar_Syntax_Syntax.n = (FStar_Syntax_Syntax.Comp ct1);
            FStar_Syntax_Syntax.pos = (uu___369_2993.FStar_Syntax_Syntax.pos);
            FStar_Syntax_Syntax.vars =
              (uu___369_2993.FStar_Syntax_Syntax.vars)
          }  in
        c1
  
let rec (translate_term_to_mlty :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.term -> FStar_Extraction_ML_Syntax.mlty)
  =
  fun g  ->
    fun t0  ->
      let arg_as_mlty g1 uu____3042 =
        match uu____3042 with
        | (a,uu____3050) ->
            let uu____3055 = is_type g1 a  in
            if uu____3055
            then translate_term_to_mlty g1 a
            else FStar_Extraction_ML_UEnv.erasedContent
         in
      let fv_app_as_mlty g1 fv args =
        let uu____3076 =
          let uu____3078 = FStar_Extraction_ML_UEnv.is_fv_type g1 fv  in
          Prims.op_Negation uu____3078  in
        if uu____3076
        then FStar_Extraction_ML_Syntax.MLTY_Top
        else
          (let uu____3083 =
             let uu____3098 =
               FStar_TypeChecker_Env.lookup_lid
                 g1.FStar_Extraction_ML_UEnv.tcenv
                 (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                in
             match uu____3098 with
             | ((uu____3121,fvty),uu____3123) ->
                 let fvty1 =
                   FStar_TypeChecker_Normalize.normalize
                     [FStar_TypeChecker_Env.UnfoldUntil
                        FStar_Syntax_Syntax.delta_constant]
                     g1.FStar_Extraction_ML_UEnv.tcenv fvty
                    in
                 FStar_Syntax_Util.arrow_formals fvty1
              in
           match uu____3083 with
           | (formals,uu____3130) ->
               let mlargs = FStar_List.map (arg_as_mlty g1) args  in
               let mlargs1 =
                 let n_args = FStar_List.length args  in
                 if (FStar_List.length formals) > n_args
                 then
                   let uu____3187 = FStar_Util.first_N n_args formals  in
                   match uu____3187 with
                   | (uu____3220,rest) ->
                       let uu____3254 =
                         FStar_List.map
                           (fun uu____3264  ->
                              FStar_Extraction_ML_UEnv.erasedContent) rest
                          in
                       FStar_List.append mlargs uu____3254
                 else mlargs  in
               let nm =
                 let uu____3274 =
                   FStar_Extraction_ML_UEnv.maybe_mangle_type_projector g1 fv
                    in
                 match uu____3274 with
                 | FStar_Pervasives_Native.Some p -> p
                 | FStar_Pervasives_Native.None  ->
                     FStar_Extraction_ML_Syntax.mlpath_of_lident
                       (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                  in
               FStar_Extraction_ML_Syntax.MLTY_Named (mlargs1, nm))
         in
      let aux env t =
        let t1 = FStar_Syntax_Subst.compress t  in
        match t1.FStar_Syntax_Syntax.n with
        | FStar_Syntax_Syntax.Tm_type uu____3292 ->
            FStar_Extraction_ML_Syntax.MLTY_Erased
        | FStar_Syntax_Syntax.Tm_bvar uu____3293 ->
            let uu____3294 =
              let uu____3296 = FStar_Syntax_Print.term_to_string t1  in
              FStar_Util.format1 "Impossible: Unexpected term %s" uu____3296
               in
            failwith uu____3294
        | FStar_Syntax_Syntax.Tm_delayed uu____3299 ->
            let uu____3322 =
              let uu____3324 = FStar_Syntax_Print.term_to_string t1  in
              FStar_Util.format1 "Impossible: Unexpected term %s" uu____3324
               in
            failwith uu____3322
        | FStar_Syntax_Syntax.Tm_unknown  ->
            let uu____3327 =
              let uu____3329 = FStar_Syntax_Print.term_to_string t1  in
              FStar_Util.format1 "Impossible: Unexpected term %s" uu____3329
               in
            failwith uu____3327
        | FStar_Syntax_Syntax.Tm_lazy i ->
            let uu____3333 = FStar_Syntax_Util.unfold_lazy i  in
            translate_term_to_mlty env uu____3333
        | FStar_Syntax_Syntax.Tm_constant uu____3334 ->
            FStar_Extraction_ML_UEnv.unknownType
        | FStar_Syntax_Syntax.Tm_quoted uu____3335 ->
            FStar_Extraction_ML_UEnv.unknownType
        | FStar_Syntax_Syntax.Tm_uvar uu____3342 ->
            FStar_Extraction_ML_UEnv.unknownType
        | FStar_Syntax_Syntax.Tm_meta (t2,uu____3356) ->
            translate_term_to_mlty env t2
        | FStar_Syntax_Syntax.Tm_refine
            ({ FStar_Syntax_Syntax.ppname = uu____3361;
               FStar_Syntax_Syntax.index = uu____3362;
               FStar_Syntax_Syntax.sort = t2;_},uu____3364)
            -> translate_term_to_mlty env t2
        | FStar_Syntax_Syntax.Tm_uinst (t2,uu____3373) ->
            translate_term_to_mlty env t2
        | FStar_Syntax_Syntax.Tm_ascribed (t2,uu____3379,uu____3380) ->
            translate_term_to_mlty env t2
        | FStar_Syntax_Syntax.Tm_name bv -> bv_as_mlty env bv
        | FStar_Syntax_Syntax.Tm_fvar fv -> fv_app_as_mlty env fv []
        | FStar_Syntax_Syntax.Tm_arrow (bs,c) ->
            let uu____3453 = FStar_Syntax_Subst.open_comp bs c  in
            (match uu____3453 with
             | (bs1,c1) ->
                 let uu____3460 = binders_as_ml_binders env bs1  in
                 (match uu____3460 with
                  | (mlbs,env1) ->
                      let t_ret =
                        let eff =
                          FStar_TypeChecker_Env.norm_eff_name
                            env1.FStar_Extraction_ML_UEnv.tcenv
                            (FStar_Syntax_Util.comp_effect_name c1)
                           in
                        let c2 = comp_no_args c1  in
                        let uu____3493 =
                          let uu____3500 =
                            FStar_TypeChecker_Env.effect_decl_opt
                              env1.FStar_Extraction_ML_UEnv.tcenv eff
                             in
                          FStar_Util.must uu____3500  in
                        match uu____3493 with
                        | (ed,qualifiers) ->
                            let uu____3521 =
                              FStar_TypeChecker_Env.is_reifiable_effect
                                g.FStar_Extraction_ML_UEnv.tcenv
                                ed.FStar_Syntax_Syntax.mname
                               in
                            if uu____3521
                            then
                              let t2 =
                                FStar_TypeChecker_Env.reify_comp
                                  env1.FStar_Extraction_ML_UEnv.tcenv c2
                                  FStar_Syntax_Syntax.U_unknown
                                 in
                              (FStar_Extraction_ML_UEnv.debug env1
                                 (fun uu____3529  ->
                                    let uu____3530 =
                                      FStar_Syntax_Print.comp_to_string c2
                                       in
                                    let uu____3532 =
                                      FStar_Syntax_Print.term_to_string t2
                                       in
                                    FStar_Util.print2
                                      "Translating comp type %s as %s\n"
                                      uu____3530 uu____3532);
                               (let res = translate_term_to_mlty env1 t2  in
                                FStar_Extraction_ML_UEnv.debug env1
                                  (fun uu____3541  ->
                                     let uu____3542 =
                                       FStar_Syntax_Print.comp_to_string c2
                                        in
                                     let uu____3544 =
                                       FStar_Syntax_Print.term_to_string t2
                                        in
                                     let uu____3546 =
                                       FStar_Extraction_ML_Code.string_of_mlty
                                         env1.FStar_Extraction_ML_UEnv.currentModule
                                         res
                                        in
                                     FStar_Util.print3
                                       "Translated comp type %s as %s ... to %s\n"
                                       uu____3542 uu____3544 uu____3546);
                                res))
                            else
                              translate_term_to_mlty env1
                                (FStar_Syntax_Util.comp_result c2)
                         in
                      let erase =
                        effect_as_etag env1
                          (FStar_Syntax_Util.comp_effect_name c1)
                         in
                      let uu____3552 =
                        FStar_List.fold_right
                          (fun uu____3572  ->
                             fun uu____3573  ->
                               match (uu____3572, uu____3573) with
                               | ((uu____3596,t2),(tag,t')) ->
                                   (FStar_Extraction_ML_Syntax.E_PURE,
                                     (FStar_Extraction_ML_Syntax.MLTY_Fun
                                        (t2, tag, t')))) mlbs (erase, t_ret)
                         in
                      (match uu____3552 with | (uu____3611,t2) -> t2)))
        | FStar_Syntax_Syntax.Tm_app (head1,args) ->
            let res =
              let uu____3640 =
                let uu____3641 = FStar_Syntax_Util.un_uinst head1  in
                uu____3641.FStar_Syntax_Syntax.n  in
              match uu____3640 with
              | FStar_Syntax_Syntax.Tm_name bv -> bv_as_mlty env bv
              | FStar_Syntax_Syntax.Tm_fvar fv -> fv_app_as_mlty env fv args
              | FStar_Syntax_Syntax.Tm_app (head2,args') ->
                  let uu____3672 =
                    FStar_Syntax_Syntax.mk
                      (FStar_Syntax_Syntax.Tm_app
                         (head2, (FStar_List.append args' args)))
                      FStar_Pervasives_Native.None t1.FStar_Syntax_Syntax.pos
                     in
                  translate_term_to_mlty env uu____3672
              | uu____3693 -> FStar_Extraction_ML_UEnv.unknownType  in
            res
        | FStar_Syntax_Syntax.Tm_abs (bs,ty,uu____3696) ->
            let uu____3721 = FStar_Syntax_Subst.open_term bs ty  in
            (match uu____3721 with
             | (bs1,ty1) ->
                 let uu____3728 = binders_as_ml_binders env bs1  in
                 (match uu____3728 with
                  | (bts,env1) -> translate_term_to_mlty env1 ty1))
        | FStar_Syntax_Syntax.Tm_let uu____3756 ->
            FStar_Extraction_ML_UEnv.unknownType
        | FStar_Syntax_Syntax.Tm_match uu____3770 ->
            FStar_Extraction_ML_UEnv.unknownType
         in
      let rec is_top_ty t =
        match t with
        | FStar_Extraction_ML_Syntax.MLTY_Top  -> true
        | FStar_Extraction_ML_Syntax.MLTY_Named uu____3802 ->
            let uu____3809 = FStar_Extraction_ML_Util.udelta_unfold g t  in
            (match uu____3809 with
             | FStar_Pervasives_Native.None  -> false
             | FStar_Pervasives_Native.Some t1 -> is_top_ty t1)
        | uu____3815 -> false  in
      let uu____3817 =
        FStar_TypeChecker_Util.must_erase_for_extraction
          g.FStar_Extraction_ML_UEnv.tcenv t0
         in
      if uu____3817
      then FStar_Extraction_ML_Syntax.MLTY_Erased
      else
        (let mlt = aux g t0  in
         let uu____3823 = is_top_ty mlt  in
         if uu____3823
         then
           let t =
             FStar_TypeChecker_Normalize.normalize
               ((FStar_TypeChecker_Env.UnfoldUntil
                   FStar_Syntax_Syntax.delta_constant) :: basic_norm_steps)
               g.FStar_Extraction_ML_UEnv.tcenv t0
              in
           aux g t
         else mlt)

and (binders_as_ml_binders :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.binders ->
      ((FStar_Extraction_ML_Syntax.mlident,FStar_Extraction_ML_Syntax.mlty)
         FStar_Pervasives_Native.tuple2 Prims.list,FStar_Extraction_ML_UEnv.env)
        FStar_Pervasives_Native.tuple2)
  =
  fun g  ->
    fun bs  ->
      let uu____3842 =
        FStar_All.pipe_right bs
          (FStar_List.fold_left
             (fun uu____3898  ->
                fun b  ->
                  match uu____3898 with
                  | (ml_bs,env) ->
                      let uu____3944 = is_type_binder g b  in
                      if uu____3944
                      then
                        let b1 = FStar_Pervasives_Native.fst b  in
                        let env1 =
                          FStar_Extraction_ML_UEnv.extend_ty env b1
                            (FStar_Pervasives_Native.Some
                               FStar_Extraction_ML_Syntax.MLTY_Top)
                           in
                        let ml_b =
                          let uu____3970 =
                            FStar_Extraction_ML_UEnv.bv_as_ml_termvar b1  in
                          (uu____3970, FStar_Extraction_ML_Syntax.ml_unit_ty)
                           in
                        ((ml_b :: ml_bs), env1)
                      else
                        (let b1 = FStar_Pervasives_Native.fst b  in
                         let t =
                           translate_term_to_mlty env
                             b1.FStar_Syntax_Syntax.sort
                            in
                         let uu____3991 =
                           FStar_Extraction_ML_UEnv.extend_bv env b1 
                             ([], t) false false false
                            in
                         match uu____3991 with
                         | (env1,b2,uu____4016) ->
                             let ml_b =
                               let uu____4025 =
                                 FStar_Extraction_ML_UEnv.removeTick b2  in
                               (uu____4025, t)  in
                             ((ml_b :: ml_bs), env1))) ([], g))
         in
      match uu____3842 with | (ml_bs,env) -> ((FStar_List.rev ml_bs), env)

let (term_as_mlty :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.term -> FStar_Extraction_ML_Syntax.mlty)
  =
  fun g  ->
    fun t0  ->
      let t =
        FStar_TypeChecker_Normalize.normalize basic_norm_steps
          g.FStar_Extraction_ML_UEnv.tcenv t0
         in
      translate_term_to_mlty g t
  
let (mk_MLE_Seq :
  FStar_Extraction_ML_Syntax.mlexpr ->
    FStar_Extraction_ML_Syntax.mlexpr -> FStar_Extraction_ML_Syntax.mlexpr')
  =
  fun e1  ->
    fun e2  ->
      match ((e1.FStar_Extraction_ML_Syntax.expr),
              (e2.FStar_Extraction_ML_Syntax.expr))
      with
      | (FStar_Extraction_ML_Syntax.MLE_Seq
         es1,FStar_Extraction_ML_Syntax.MLE_Seq es2) ->
          FStar_Extraction_ML_Syntax.MLE_Seq (FStar_List.append es1 es2)
      | (FStar_Extraction_ML_Syntax.MLE_Seq es1,uu____4121) ->
          FStar_Extraction_ML_Syntax.MLE_Seq (FStar_List.append es1 [e2])
      | (uu____4124,FStar_Extraction_ML_Syntax.MLE_Seq es2) ->
          FStar_Extraction_ML_Syntax.MLE_Seq (e1 :: es2)
      | uu____4128 -> FStar_Extraction_ML_Syntax.MLE_Seq [e1; e2]
  
let (mk_MLE_Let :
  Prims.bool ->
    FStar_Extraction_ML_Syntax.mlletbinding ->
      FStar_Extraction_ML_Syntax.mlexpr -> FStar_Extraction_ML_Syntax.mlexpr')
  =
  fun top_level  ->
    fun lbs  ->
      fun body  ->
        match lbs with
        | (FStar_Extraction_ML_Syntax.NonRec ,lb::[]) when
            Prims.op_Negation top_level ->
            (match lb.FStar_Extraction_ML_Syntax.mllb_tysc with
             | FStar_Pervasives_Native.Some ([],t) when
                 t = FStar_Extraction_ML_Syntax.ml_unit_ty ->
                 if
                   body.FStar_Extraction_ML_Syntax.expr =
                     FStar_Extraction_ML_Syntax.ml_unit.FStar_Extraction_ML_Syntax.expr
                 then
                   (lb.FStar_Extraction_ML_Syntax.mllb_def).FStar_Extraction_ML_Syntax.expr
                 else
                   (match body.FStar_Extraction_ML_Syntax.expr with
                    | FStar_Extraction_ML_Syntax.MLE_Var x when
                        x = lb.FStar_Extraction_ML_Syntax.mllb_name ->
                        (lb.FStar_Extraction_ML_Syntax.mllb_def).FStar_Extraction_ML_Syntax.expr
                    | uu____4162 when
                        (lb.FStar_Extraction_ML_Syntax.mllb_def).FStar_Extraction_ML_Syntax.expr
                          =
                          FStar_Extraction_ML_Syntax.ml_unit.FStar_Extraction_ML_Syntax.expr
                        -> body.FStar_Extraction_ML_Syntax.expr
                    | uu____4163 ->
                        mk_MLE_Seq lb.FStar_Extraction_ML_Syntax.mllb_def
                          body)
             | uu____4164 -> FStar_Extraction_ML_Syntax.MLE_Let (lbs, body))
        | uu____4173 -> FStar_Extraction_ML_Syntax.MLE_Let (lbs, body)
  
let (resugar_pat :
  FStar_Syntax_Syntax.fv_qual FStar_Pervasives_Native.option ->
    FStar_Extraction_ML_Syntax.mlpattern ->
      FStar_Extraction_ML_Syntax.mlpattern)
  =
  fun q  ->
    fun p  ->
      match p with
      | FStar_Extraction_ML_Syntax.MLP_CTor (d,pats) ->
          let uu____4201 = FStar_Extraction_ML_Util.is_xtuple d  in
          (match uu____4201 with
           | FStar_Pervasives_Native.Some n1 ->
               FStar_Extraction_ML_Syntax.MLP_Tuple pats
           | uu____4208 ->
               (match q with
                | FStar_Pervasives_Native.Some
                    (FStar_Syntax_Syntax.Record_ctor (ty,fns)) ->
                    let path =
                      FStar_List.map FStar_Ident.text_of_id ty.FStar_Ident.ns
                       in
                    let fs = record_fields fns pats  in
                    FStar_Extraction_ML_Syntax.MLP_Record (path, fs)
                | uu____4241 -> p))
      | uu____4244 -> p
  
let rec (extract_one_pat :
  Prims.bool ->
    FStar_Extraction_ML_UEnv.env ->
      FStar_Syntax_Syntax.pat ->
        FStar_Extraction_ML_Syntax.mlty FStar_Pervasives_Native.option ->
          (FStar_Extraction_ML_UEnv.env ->
             FStar_Syntax_Syntax.term ->
               (FStar_Extraction_ML_Syntax.mlexpr,FStar_Extraction_ML_Syntax.e_tag,
                 FStar_Extraction_ML_Syntax.mlty)
                 FStar_Pervasives_Native.tuple3)
            ->
            (FStar_Extraction_ML_UEnv.env,(FStar_Extraction_ML_Syntax.mlpattern,
                                            FStar_Extraction_ML_Syntax.mlexpr
                                              Prims.list)
                                            FStar_Pervasives_Native.tuple2
                                            FStar_Pervasives_Native.option,
              Prims.bool) FStar_Pervasives_Native.tuple3)
  =
  fun imp  ->
    fun g  ->
      fun p  ->
        fun expected_topt  ->
          fun term_as_mlexpr  ->
            let ok t =
              match expected_topt with
              | FStar_Pervasives_Native.None  -> true
              | FStar_Pervasives_Native.Some t' ->
                  let ok = type_leq g t t'  in
                  (if Prims.op_Negation ok
                   then
                     FStar_Extraction_ML_UEnv.debug g
                       (fun uu____4346  ->
                          let uu____4347 =
                            FStar_Extraction_ML_Code.string_of_mlty
                              g.FStar_Extraction_ML_UEnv.currentModule t'
                             in
                          let uu____4349 =
                            FStar_Extraction_ML_Code.string_of_mlty
                              g.FStar_Extraction_ML_UEnv.currentModule t
                             in
                          FStar_Util.print2
                            "Expected pattern type %s; got pattern type %s\n"
                            uu____4347 uu____4349)
                   else ();
                   ok)
               in
            match p.FStar_Syntax_Syntax.v with
            | FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_int
                (c,swopt)) when
                let uu____4385 = FStar_Options.codegen ()  in
                uu____4385 <>
                  (FStar_Pervasives_Native.Some FStar_Options.Kremlin)
                ->
                let uu____4390 =
                  match swopt with
                  | FStar_Pervasives_Native.None  ->
                      let uu____4403 =
                        let uu____4404 =
                          let uu____4405 =
                            FStar_Extraction_ML_Util.mlconst_of_const
                              p.FStar_Syntax_Syntax.p
                              (FStar_Const.Const_int
                                 (c, FStar_Pervasives_Native.None))
                             in
                          FStar_Extraction_ML_Syntax.MLE_Const uu____4405  in
                        FStar_All.pipe_left
                          (FStar_Extraction_ML_Syntax.with_ty
                             FStar_Extraction_ML_Syntax.ml_int_ty) uu____4404
                         in
                      (uu____4403, FStar_Extraction_ML_Syntax.ml_int_ty)
                  | FStar_Pervasives_Native.Some sw ->
                      let source_term =
                        FStar_ToSyntax_ToSyntax.desugar_machine_integer
                          (g.FStar_Extraction_ML_UEnv.tcenv).FStar_TypeChecker_Env.dsenv
                          c sw FStar_Range.dummyRange
                         in
                      let uu____4427 = term_as_mlexpr g source_term  in
                      (match uu____4427 with
                       | (mlterm,uu____4439,mlty) -> (mlterm, mlty))
                   in
                (match uu____4390 with
                 | (mlc,ml_ty) ->
                     let x = FStar_Extraction_ML_Syntax.gensym ()  in
                     let when_clause =
                       let uu____4461 =
                         let uu____4462 =
                           let uu____4469 =
                             let uu____4472 =
                               FStar_All.pipe_left
                                 (FStar_Extraction_ML_Syntax.with_ty ml_ty)
                                 (FStar_Extraction_ML_Syntax.MLE_Var x)
                                in
                             [uu____4472; mlc]  in
                           (FStar_Extraction_ML_Util.prims_op_equality,
                             uu____4469)
                            in
                         FStar_Extraction_ML_Syntax.MLE_App uu____4462  in
                       FStar_All.pipe_left
                         (FStar_Extraction_ML_Syntax.with_ty
                            FStar_Extraction_ML_Syntax.ml_bool_ty) uu____4461
                        in
                     let uu____4475 = ok ml_ty  in
                     (g,
                       (FStar_Pervasives_Native.Some
                          ((FStar_Extraction_ML_Syntax.MLP_Var x),
                            [when_clause])), uu____4475))
            | FStar_Syntax_Syntax.Pat_constant s ->
                let t =
                  FStar_TypeChecker_TcTerm.tc_constant
                    g.FStar_Extraction_ML_UEnv.tcenv FStar_Range.dummyRange s
                   in
                let mlty = term_as_mlty g t  in
                let uu____4497 =
                  let uu____4506 =
                    let uu____4513 =
                      let uu____4514 =
                        FStar_Extraction_ML_Util.mlconst_of_const
                          p.FStar_Syntax_Syntax.p s
                         in
                      FStar_Extraction_ML_Syntax.MLP_Const uu____4514  in
                    (uu____4513, [])  in
                  FStar_Pervasives_Native.Some uu____4506  in
                let uu____4523 = ok mlty  in (g, uu____4497, uu____4523)
            | FStar_Syntax_Syntax.Pat_var x ->
                let mlty = term_as_mlty g x.FStar_Syntax_Syntax.sort  in
                let uu____4536 =
                  FStar_Extraction_ML_UEnv.extend_bv g x ([], mlty) false
                    false imp
                   in
                (match uu____4536 with
                 | (g1,x1,uu____4564) ->
                     let uu____4567 = ok mlty  in
                     (g1,
                       (if imp
                        then FStar_Pervasives_Native.None
                        else
                          FStar_Pervasives_Native.Some
                            ((FStar_Extraction_ML_Syntax.MLP_Var x1), [])),
                       uu____4567))
            | FStar_Syntax_Syntax.Pat_wild x ->
                let mlty = term_as_mlty g x.FStar_Syntax_Syntax.sort  in
                let uu____4605 =
                  FStar_Extraction_ML_UEnv.extend_bv g x ([], mlty) false
                    false imp
                   in
                (match uu____4605 with
                 | (g1,x1,uu____4633) ->
                     let uu____4636 = ok mlty  in
                     (g1,
                       (if imp
                        then FStar_Pervasives_Native.None
                        else
                          FStar_Pervasives_Native.Some
                            ((FStar_Extraction_ML_Syntax.MLP_Var x1), [])),
                       uu____4636))
            | FStar_Syntax_Syntax.Pat_dot_term uu____4672 ->
                (g, FStar_Pervasives_Native.None, true)
            | FStar_Syntax_Syntax.Pat_cons (f,pats) ->
                let uu____4715 =
                  let uu____4724 = FStar_Extraction_ML_UEnv.lookup_fv g f  in
                  match uu____4724 with
                  | { FStar_Extraction_ML_UEnv.exp_b_name = uu____4733;
                      FStar_Extraction_ML_UEnv.exp_b_expr =
                        {
                          FStar_Extraction_ML_Syntax.expr =
                            FStar_Extraction_ML_Syntax.MLE_Name n1;
                          FStar_Extraction_ML_Syntax.mlty = uu____4735;
                          FStar_Extraction_ML_Syntax.loc = uu____4736;_};
                      FStar_Extraction_ML_UEnv.exp_b_tscheme = ttys;
                      FStar_Extraction_ML_UEnv.exp_b_inst_ok = uu____4738;_}
                      -> (n1, ttys)
                  | uu____4745 -> failwith "Expected a constructor"  in
                (match uu____4715 with
                 | (d,tys) ->
                     let nTyVars =
                       FStar_List.length (FStar_Pervasives_Native.fst tys)
                        in
                     let uu____4782 = FStar_Util.first_N nTyVars pats  in
                     (match uu____4782 with
                      | (tysVarPats,restPats) ->
                          let f_ty_opt =
                            try
                              (fun uu___371_4890  ->
                                 match () with
                                 | () ->
                                     let mlty_args =
                                       FStar_All.pipe_right tysVarPats
                                         (FStar_List.map
                                            (fun uu____4921  ->
                                               match uu____4921 with
                                               | (p1,uu____4928) ->
                                                   (match p1.FStar_Syntax_Syntax.v
                                                    with
                                                    | FStar_Syntax_Syntax.Pat_dot_term
                                                        (uu____4931,t) ->
                                                        term_as_mlty g t
                                                    | uu____4937 ->
                                                        (FStar_Extraction_ML_UEnv.debug
                                                           g
                                                           (fun uu____4941 
                                                              ->
                                                              let uu____4942
                                                                =
                                                                FStar_Syntax_Print.pat_to_string
                                                                  p1
                                                                 in
                                                              FStar_Util.print1
                                                                "Pattern %s is not extractable"
                                                                uu____4942);
                                                         FStar_Exn.raise
                                                           Un_extractable))))
                                        in
                                     let f_ty =
                                       FStar_Extraction_ML_Util.subst tys
                                         mlty_args
                                        in
                                     let uu____4946 =
                                       FStar_Extraction_ML_Util.uncurry_mlty_fun
                                         f_ty
                                        in
                                     FStar_Pervasives_Native.Some uu____4946)
                                ()
                            with
                            | Un_extractable  -> FStar_Pervasives_Native.None
                             in
                          let uu____4975 =
                            FStar_Util.fold_map
                              (fun g1  ->
                                 fun uu____5012  ->
                                   match uu____5012 with
                                   | (p1,imp1) ->
                                       let uu____5034 =
                                         extract_one_pat true g1 p1
                                           FStar_Pervasives_Native.None
                                           term_as_mlexpr
                                          in
                                       (match uu____5034 with
                                        | (g2,p2,uu____5065) -> (g2, p2))) g
                              tysVarPats
                             in
                          (match uu____4975 with
                           | (g1,tyMLPats) ->
                               let uu____5129 =
                                 FStar_Util.fold_map
                                   (fun uu____5194  ->
                                      fun uu____5195  ->
                                        match (uu____5194, uu____5195) with
                                        | ((g2,f_ty_opt1),(p1,imp1)) ->
                                            let uu____5293 =
                                              match f_ty_opt1 with
                                              | FStar_Pervasives_Native.Some
                                                  (hd1::rest,res) ->
                                                  ((FStar_Pervasives_Native.Some
                                                      (rest, res)),
                                                    (FStar_Pervasives_Native.Some
                                                       hd1))
                                              | uu____5353 ->
                                                  (FStar_Pervasives_Native.None,
                                                    FStar_Pervasives_Native.None)
                                               in
                                            (match uu____5293 with
                                             | (f_ty_opt2,expected_ty) ->
                                                 let uu____5424 =
                                                   extract_one_pat false g2
                                                     p1 expected_ty
                                                     term_as_mlexpr
                                                    in
                                                 (match uu____5424 with
                                                  | (g3,p2,uu____5467) ->
                                                      ((g3, f_ty_opt2), p2))))
                                   (g1, f_ty_opt) restPats
                                  in
                               (match uu____5129 with
                                | ((g2,f_ty_opt1),restMLPats) ->
                                    let uu____5588 =
                                      let uu____5599 =
                                        FStar_All.pipe_right
                                          (FStar_List.append tyMLPats
                                             restMLPats)
                                          (FStar_List.collect
                                             (fun uu___365_5650  ->
                                                match uu___365_5650 with
                                                | FStar_Pervasives_Native.Some
                                                    x -> [x]
                                                | uu____5692 -> []))
                                         in
                                      FStar_All.pipe_right uu____5599
                                        FStar_List.split
                                       in
                                    (match uu____5588 with
                                     | (mlPats,when_clauses) ->
                                         let pat_ty_compat =
                                           match f_ty_opt1 with
                                           | FStar_Pervasives_Native.Some
                                               ([],t) -> ok t
                                           | uu____5768 -> false  in
                                         let uu____5778 =
                                           let uu____5787 =
                                             let uu____5794 =
                                               resugar_pat
                                                 f.FStar_Syntax_Syntax.fv_qual
                                                 (FStar_Extraction_ML_Syntax.MLP_CTor
                                                    (d, mlPats))
                                                in
                                             let uu____5797 =
                                               FStar_All.pipe_right
                                                 when_clauses
                                                 FStar_List.flatten
                                                in
                                             (uu____5794, uu____5797)  in
                                           FStar_Pervasives_Native.Some
                                             uu____5787
                                            in
                                         (g2, uu____5778, pat_ty_compat))))))
  
let (extract_pat :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.pat ->
      FStar_Extraction_ML_Syntax.mlty ->
        (FStar_Extraction_ML_UEnv.env ->
           FStar_Syntax_Syntax.term ->
             (FStar_Extraction_ML_Syntax.mlexpr,FStar_Extraction_ML_Syntax.e_tag,
               FStar_Extraction_ML_Syntax.mlty)
               FStar_Pervasives_Native.tuple3)
          ->
          (FStar_Extraction_ML_UEnv.env,(FStar_Extraction_ML_Syntax.mlpattern,
                                          FStar_Extraction_ML_Syntax.mlexpr
                                            FStar_Pervasives_Native.option)
                                          FStar_Pervasives_Native.tuple2
                                          Prims.list,Prims.bool)
            FStar_Pervasives_Native.tuple3)
  =
  fun g  ->
    fun p  ->
      fun expected_t  ->
        fun term_as_mlexpr  ->
          let extract_one_pat1 g1 p1 expected_t1 =
            let uu____5929 =
              extract_one_pat false g1 p1 expected_t1 term_as_mlexpr  in
            match uu____5929 with
            | (g2,FStar_Pervasives_Native.Some (x,v1),b) -> (g2, (x, v1), b)
            | uu____5992 ->
                failwith "Impossible: Unable to translate pattern"
             in
          let mk_when_clause whens =
            match whens with
            | [] -> FStar_Pervasives_Native.None
            | hd1::tl1 ->
                let uu____6040 =
                  FStar_List.fold_left FStar_Extraction_ML_Util.conjoin hd1
                    tl1
                   in
                FStar_Pervasives_Native.Some uu____6040
             in
          let uu____6041 =
            extract_one_pat1 g p (FStar_Pervasives_Native.Some expected_t)
             in
          match uu____6041 with
          | (g1,(p1,whens),b) ->
              let when_clause = mk_when_clause whens  in
              (g1, [(p1, when_clause)], b)
  
let (maybe_eta_data_and_project_record :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.fv_qual FStar_Pervasives_Native.option ->
      FStar_Extraction_ML_Syntax.mlty ->
        FStar_Extraction_ML_Syntax.mlexpr ->
          FStar_Extraction_ML_Syntax.mlexpr)
  =
  fun g  ->
    fun qual  ->
      fun residualType  ->
        fun mlAppExpr  ->
          let rec eta_args more_args t =
            match t with
            | FStar_Extraction_ML_Syntax.MLTY_Fun (t0,uu____6201,t1) ->
                let x = FStar_Extraction_ML_Syntax.gensym ()  in
                let uu____6205 =
                  let uu____6217 =
                    let uu____6227 =
                      FStar_All.pipe_left
                        (FStar_Extraction_ML_Syntax.with_ty t0)
                        (FStar_Extraction_ML_Syntax.MLE_Var x)
                       in
                    ((x, t0), uu____6227)  in
                  uu____6217 :: more_args  in
                eta_args uu____6205 t1
            | FStar_Extraction_ML_Syntax.MLTY_Named (uu____6243,uu____6244)
                -> ((FStar_List.rev more_args), t)
            | uu____6269 ->
                let uu____6270 =
                  let uu____6272 =
                    FStar_Extraction_ML_Code.string_of_mlexpr
                      g.FStar_Extraction_ML_UEnv.currentModule mlAppExpr
                     in
                  let uu____6274 =
                    FStar_Extraction_ML_Code.string_of_mlty
                      g.FStar_Extraction_ML_UEnv.currentModule t
                     in
                  FStar_Util.format2
                    "Impossible: Head type is not an arrow: (%s : %s)"
                    uu____6272 uu____6274
                   in
                failwith uu____6270
             in
          let as_record qual1 e =
            match ((e.FStar_Extraction_ML_Syntax.expr), qual1) with
            | (FStar_Extraction_ML_Syntax.MLE_CTor
               (uu____6309,args),FStar_Pervasives_Native.Some
               (FStar_Syntax_Syntax.Record_ctor (tyname,fields))) ->
                let path =
                  FStar_List.map FStar_Ident.text_of_id tyname.FStar_Ident.ns
                   in
                let fields1 = record_fields fields args  in
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     e.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_Record (path, fields1))
            | uu____6346 -> e  in
          let resugar_and_maybe_eta qual1 e =
            let uu____6368 = eta_args [] residualType  in
            match uu____6368 with
            | (eargs,tres) ->
                (match eargs with
                 | [] ->
                     let uu____6426 = as_record qual1 e  in
                     FStar_Extraction_ML_Util.resugar_exp uu____6426
                 | uu____6427 ->
                     let uu____6439 = FStar_List.unzip eargs  in
                     (match uu____6439 with
                      | (binders,eargs1) ->
                          (match e.FStar_Extraction_ML_Syntax.expr with
                           | FStar_Extraction_ML_Syntax.MLE_CTor (head1,args)
                               ->
                               let body =
                                 let uu____6485 =
                                   let uu____6486 =
                                     FStar_All.pipe_left
                                       (FStar_Extraction_ML_Syntax.with_ty
                                          tres)
                                       (FStar_Extraction_ML_Syntax.MLE_CTor
                                          (head1,
                                            (FStar_List.append args eargs1)))
                                      in
                                   FStar_All.pipe_left (as_record qual1)
                                     uu____6486
                                    in
                                 FStar_All.pipe_left
                                   FStar_Extraction_ML_Util.resugar_exp
                                   uu____6485
                                  in
                               FStar_All.pipe_left
                                 (FStar_Extraction_ML_Syntax.with_ty
                                    e.FStar_Extraction_ML_Syntax.mlty)
                                 (FStar_Extraction_ML_Syntax.MLE_Fun
                                    (binders, body))
                           | uu____6496 ->
                               failwith "Impossible: Not a constructor")))
             in
          match ((mlAppExpr.FStar_Extraction_ML_Syntax.expr), qual) with
          | (uu____6500,FStar_Pervasives_Native.None ) -> mlAppExpr
          | (FStar_Extraction_ML_Syntax.MLE_App
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Name mlp;
                FStar_Extraction_ML_Syntax.mlty = uu____6504;
                FStar_Extraction_ML_Syntax.loc = uu____6505;_},mle::args),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Record_projector (constrname,f))) ->
              let f1 =
                FStar_Ident.lid_of_ids
                  (FStar_List.append constrname.FStar_Ident.ns [f])
                 in
              let fn = FStar_Extraction_ML_Util.mlpath_of_lid f1  in
              let proj = FStar_Extraction_ML_Syntax.MLE_Proj (mle, fn)  in
              let e =
                match args with
                | [] -> proj
                | uu____6528 ->
                    let uu____6531 =
                      let uu____6538 =
                        FStar_All.pipe_left
                          (FStar_Extraction_ML_Syntax.with_ty
                             FStar_Extraction_ML_Syntax.MLTY_Top) proj
                         in
                      (uu____6538, args)  in
                    FStar_Extraction_ML_Syntax.MLE_App uu____6531
                 in
              FStar_Extraction_ML_Syntax.with_ty
                mlAppExpr.FStar_Extraction_ML_Syntax.mlty e
          | (FStar_Extraction_ML_Syntax.MLE_App
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_TApp
                  ({
                     FStar_Extraction_ML_Syntax.expr =
                       FStar_Extraction_ML_Syntax.MLE_Name mlp;
                     FStar_Extraction_ML_Syntax.mlty = uu____6542;
                     FStar_Extraction_ML_Syntax.loc = uu____6543;_},uu____6544);
                FStar_Extraction_ML_Syntax.mlty = uu____6545;
                FStar_Extraction_ML_Syntax.loc = uu____6546;_},mle::args),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Record_projector (constrname,f))) ->
              let f1 =
                FStar_Ident.lid_of_ids
                  (FStar_List.append constrname.FStar_Ident.ns [f])
                 in
              let fn = FStar_Extraction_ML_Util.mlpath_of_lid f1  in
              let proj = FStar_Extraction_ML_Syntax.MLE_Proj (mle, fn)  in
              let e =
                match args with
                | [] -> proj
                | uu____6573 ->
                    let uu____6576 =
                      let uu____6583 =
                        FStar_All.pipe_left
                          (FStar_Extraction_ML_Syntax.with_ty
                             FStar_Extraction_ML_Syntax.MLTY_Top) proj
                         in
                      (uu____6583, args)  in
                    FStar_Extraction_ML_Syntax.MLE_App uu____6576
                 in
              FStar_Extraction_ML_Syntax.with_ty
                mlAppExpr.FStar_Extraction_ML_Syntax.mlty e
          | (FStar_Extraction_ML_Syntax.MLE_App
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Name mlp;
                FStar_Extraction_ML_Syntax.mlty = uu____6587;
                FStar_Extraction_ML_Syntax.loc = uu____6588;_},mlargs),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Data_ctor )) ->
              let uu____6596 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, mlargs))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6596
          | (FStar_Extraction_ML_Syntax.MLE_App
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Name mlp;
                FStar_Extraction_ML_Syntax.mlty = uu____6600;
                FStar_Extraction_ML_Syntax.loc = uu____6601;_},mlargs),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Record_ctor uu____6603)) ->
              let uu____6616 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, mlargs))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6616
          | (FStar_Extraction_ML_Syntax.MLE_App
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_TApp
                  ({
                     FStar_Extraction_ML_Syntax.expr =
                       FStar_Extraction_ML_Syntax.MLE_Name mlp;
                     FStar_Extraction_ML_Syntax.mlty = uu____6620;
                     FStar_Extraction_ML_Syntax.loc = uu____6621;_},uu____6622);
                FStar_Extraction_ML_Syntax.mlty = uu____6623;
                FStar_Extraction_ML_Syntax.loc = uu____6624;_},mlargs),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Data_ctor )) ->
              let uu____6636 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, mlargs))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6636
          | (FStar_Extraction_ML_Syntax.MLE_App
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_TApp
                  ({
                     FStar_Extraction_ML_Syntax.expr =
                       FStar_Extraction_ML_Syntax.MLE_Name mlp;
                     FStar_Extraction_ML_Syntax.mlty = uu____6640;
                     FStar_Extraction_ML_Syntax.loc = uu____6641;_},uu____6642);
                FStar_Extraction_ML_Syntax.mlty = uu____6643;
                FStar_Extraction_ML_Syntax.loc = uu____6644;_},mlargs),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Record_ctor uu____6646)) ->
              let uu____6663 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, mlargs))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6663
          | (FStar_Extraction_ML_Syntax.MLE_Name
             mlp,FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Data_ctor
             )) ->
              let uu____6669 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, []))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6669
          | (FStar_Extraction_ML_Syntax.MLE_Name
             mlp,FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Record_ctor uu____6673)) ->
              let uu____6682 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, []))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6682
          | (FStar_Extraction_ML_Syntax.MLE_TApp
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Name mlp;
                FStar_Extraction_ML_Syntax.mlty = uu____6686;
                FStar_Extraction_ML_Syntax.loc = uu____6687;_},uu____6688),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Data_ctor )) ->
              let uu____6695 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, []))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6695
          | (FStar_Extraction_ML_Syntax.MLE_TApp
             ({
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Name mlp;
                FStar_Extraction_ML_Syntax.mlty = uu____6699;
                FStar_Extraction_ML_Syntax.loc = uu____6700;_},uu____6701),FStar_Pervasives_Native.Some
             (FStar_Syntax_Syntax.Record_ctor uu____6702)) ->
              let uu____6715 =
                FStar_All.pipe_left
                  (FStar_Extraction_ML_Syntax.with_ty
                     mlAppExpr.FStar_Extraction_ML_Syntax.mlty)
                  (FStar_Extraction_ML_Syntax.MLE_CTor (mlp, []))
                 in
              FStar_All.pipe_left (resugar_and_maybe_eta qual) uu____6715
          | uu____6718 -> mlAppExpr
  
let (maybe_promote_effect :
  FStar_Extraction_ML_Syntax.mlexpr ->
    FStar_Extraction_ML_Syntax.e_tag ->
      FStar_Extraction_ML_Syntax.mlty ->
        (FStar_Extraction_ML_Syntax.mlexpr,FStar_Extraction_ML_Syntax.e_tag)
          FStar_Pervasives_Native.tuple2)
  =
  fun ml_e  ->
    fun tag  ->
      fun t  ->
        match (tag, t) with
        | (FStar_Extraction_ML_Syntax.E_GHOST
           ,FStar_Extraction_ML_Syntax.MLTY_Erased ) ->
            (FStar_Extraction_ML_Syntax.ml_unit,
              FStar_Extraction_ML_Syntax.E_PURE)
        | (FStar_Extraction_ML_Syntax.E_PURE
           ,FStar_Extraction_ML_Syntax.MLTY_Erased ) ->
            (FStar_Extraction_ML_Syntax.ml_unit,
              FStar_Extraction_ML_Syntax.E_PURE)
        | uu____6749 -> (ml_e, tag)
  
let (extract_lb_sig :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.letbindings ->
      (FStar_Syntax_Syntax.lbname,FStar_Extraction_ML_Syntax.e_tag,(FStar_Syntax_Syntax.typ,
                                                                    (FStar_Syntax_Syntax.binders,
                                                                    FStar_Extraction_ML_Syntax.mltyscheme)
                                                                    FStar_Pervasives_Native.tuple2)
                                                                    FStar_Pervasives_Native.tuple2,
        Prims.bool,FStar_Syntax_Syntax.term) FStar_Pervasives_Native.tuple5
        Prims.list)
  =
  fun g  ->
    fun lbs  ->
      let maybe_generalize uu____6810 =
        match uu____6810 with
        | { FStar_Syntax_Syntax.lbname = lbname_;
            FStar_Syntax_Syntax.lbunivs = uu____6831;
            FStar_Syntax_Syntax.lbtyp = lbtyp;
            FStar_Syntax_Syntax.lbeff = lbeff;
            FStar_Syntax_Syntax.lbdef = lbdef;
            FStar_Syntax_Syntax.lbattrs = uu____6835;
            FStar_Syntax_Syntax.lbpos = uu____6836;_} ->
            let f_e = effect_as_etag g lbeff  in
            let lbtyp1 = FStar_Syntax_Subst.compress lbtyp  in
            let no_gen uu____6917 =
              let expected_t = term_as_mlty g lbtyp1  in
              (lbname_, f_e, (lbtyp1, ([], ([], expected_t))), false, lbdef)
               in
            let uu____6994 =
              FStar_TypeChecker_Util.must_erase_for_extraction
                g.FStar_Extraction_ML_UEnv.tcenv lbtyp1
               in
            if uu____6994
            then
              (lbname_, f_e,
                (lbtyp1, ([], ([], FStar_Extraction_ML_Syntax.MLTY_Erased))),
                false, lbdef)
            else
              (match lbtyp1.FStar_Syntax_Syntax.n with
               | FStar_Syntax_Syntax.Tm_arrow (bs,c) when
                   let uu____7080 = FStar_List.hd bs  in
                   FStar_All.pipe_right uu____7080 (is_type_binder g) ->
                   let uu____7102 = FStar_Syntax_Subst.open_comp bs c  in
                   (match uu____7102 with
                    | (bs1,c1) ->
                        let uu____7128 =
                          let uu____7141 =
                            FStar_Util.prefix_until
                              (fun x  ->
                                 let uu____7187 = is_type_binder g x  in
                                 Prims.op_Negation uu____7187) bs1
                             in
                          match uu____7141 with
                          | FStar_Pervasives_Native.None  ->
                              (bs1, (FStar_Syntax_Util.comp_result c1))
                          | FStar_Pervasives_Native.Some (bs2,b,rest) ->
                              let uu____7314 =
                                FStar_Syntax_Util.arrow (b :: rest) c1  in
                              (bs2, uu____7314)
                           in
                        (match uu____7128 with
                         | (tbinders,tbody) ->
                             let n_tbinders = FStar_List.length tbinders  in
                             let lbdef1 =
                               let uu____7376 = normalize_abs lbdef  in
                               FStar_All.pipe_right uu____7376
                                 FStar_Syntax_Util.unmeta
                                in
                             (match lbdef1.FStar_Syntax_Syntax.n with
                              | FStar_Syntax_Syntax.Tm_abs (bs2,body,copt) ->
                                  let uu____7425 =
                                    FStar_Syntax_Subst.open_term bs2 body  in
                                  (match uu____7425 with
                                   | (bs3,body1) ->
                                       if
                                         n_tbinders <=
                                           (FStar_List.length bs3)
                                       then
                                         let uu____7483 =
                                           FStar_Util.first_N n_tbinders bs3
                                            in
                                         (match uu____7483 with
                                          | (targs,rest_args) ->
                                              let expected_source_ty =
                                                let s =
                                                  FStar_List.map2
                                                    (fun uu____7590  ->
                                                       fun uu____7591  ->
                                                         match (uu____7590,
                                                                 uu____7591)
                                                         with
                                                         | ((x,uu____7617),
                                                            (y,uu____7619))
                                                             ->
                                                             let uu____7640 =
                                                               let uu____7647
                                                                 =
                                                                 FStar_Syntax_Syntax.bv_to_name
                                                                   y
                                                                  in
                                                               (x,
                                                                 uu____7647)
                                                                in
                                                             FStar_Syntax_Syntax.NT
                                                               uu____7640)
                                                    tbinders targs
                                                   in
                                                FStar_Syntax_Subst.subst s
                                                  tbody
                                                 in
                                              let env =
                                                FStar_List.fold_left
                                                  (fun env  ->
                                                     fun uu____7664  ->
                                                       match uu____7664 with
                                                       | (a,uu____7672) ->
                                                           FStar_Extraction_ML_UEnv.extend_ty
                                                             env a
                                                             FStar_Pervasives_Native.None)
                                                  g targs
                                                 in
                                              let expected_t =
                                                term_as_mlty env
                                                  expected_source_ty
                                                 in
                                              let polytype =
                                                let uu____7683 =
                                                  FStar_All.pipe_right targs
                                                    (FStar_List.map
                                                       (fun uu____7702  ->
                                                          match uu____7702
                                                          with
                                                          | (x,uu____7711) ->
                                                              FStar_Extraction_ML_UEnv.bv_as_ml_tyvar
                                                                x))
                                                   in
                                                (uu____7683, expected_t)  in
                                              let add_unit =
                                                match rest_args with
                                                | [] ->
                                                    (let uu____7727 =
                                                       is_fstar_value body1
                                                        in
                                                     Prims.op_Negation
                                                       uu____7727)
                                                      ||
                                                      (let uu____7730 =
                                                         FStar_Syntax_Util.is_pure_comp
                                                           c1
                                                          in
                                                       Prims.op_Negation
                                                         uu____7730)
                                                | uu____7732 -> false  in
                                              let rest_args1 =
                                                if add_unit
                                                then unit_binder :: rest_args
                                                else rest_args  in
                                              let polytype1 =
                                                if add_unit
                                                then
                                                  FStar_Extraction_ML_Syntax.push_unit
                                                    polytype
                                                else polytype  in
                                              let body2 =
                                                FStar_Syntax_Util.abs
                                                  rest_args1 body1 copt
                                                 in
                                              (lbname_, f_e,
                                                (lbtyp1, (targs, polytype1)),
                                                add_unit, body2))
                                       else
                                         failwith "Not enough type binders")
                              | FStar_Syntax_Syntax.Tm_uinst uu____7794 ->
                                  let env =
                                    FStar_List.fold_left
                                      (fun env  ->
                                         fun uu____7813  ->
                                           match uu____7813 with
                                           | (a,uu____7821) ->
                                               FStar_Extraction_ML_UEnv.extend_ty
                                                 env a
                                                 FStar_Pervasives_Native.None)
                                      g tbinders
                                     in
                                  let expected_t = term_as_mlty env tbody  in
                                  let polytype =
                                    let uu____7832 =
                                      FStar_All.pipe_right tbinders
                                        (FStar_List.map
                                           (fun uu____7851  ->
                                              match uu____7851 with
                                              | (x,uu____7860) ->
                                                  FStar_Extraction_ML_UEnv.bv_as_ml_tyvar
                                                    x))
                                       in
                                    (uu____7832, expected_t)  in
                                  let args =
                                    FStar_All.pipe_right tbinders
                                      (FStar_List.map
                                         (fun uu____7904  ->
                                            match uu____7904 with
                                            | (bv,uu____7912) ->
                                                let uu____7917 =
                                                  FStar_Syntax_Syntax.bv_to_name
                                                    bv
                                                   in
                                                FStar_All.pipe_right
                                                  uu____7917
                                                  FStar_Syntax_Syntax.as_arg))
                                     in
                                  let e =
                                    FStar_Syntax_Syntax.mk
                                      (FStar_Syntax_Syntax.Tm_app
                                         (lbdef1, args))
                                      FStar_Pervasives_Native.None
                                      lbdef1.FStar_Syntax_Syntax.pos
                                     in
                                  (lbname_, f_e,
                                    (lbtyp1, (tbinders, polytype)), false, e)
                              | FStar_Syntax_Syntax.Tm_fvar uu____7947 ->
                                  let env =
                                    FStar_List.fold_left
                                      (fun env  ->
                                         fun uu____7960  ->
                                           match uu____7960 with
                                           | (a,uu____7968) ->
                                               FStar_Extraction_ML_UEnv.extend_ty
                                                 env a
                                                 FStar_Pervasives_Native.None)
                                      g tbinders
                                     in
                                  let expected_t = term_as_mlty env tbody  in
                                  let polytype =
                                    let uu____7979 =
                                      FStar_All.pipe_right tbinders
                                        (FStar_List.map
                                           (fun uu____7998  ->
                                              match uu____7998 with
                                              | (x,uu____8007) ->
                                                  FStar_Extraction_ML_UEnv.bv_as_ml_tyvar
                                                    x))
                                       in
                                    (uu____7979, expected_t)  in
                                  let args =
                                    FStar_All.pipe_right tbinders
                                      (FStar_List.map
                                         (fun uu____8051  ->
                                            match uu____8051 with
                                            | (bv,uu____8059) ->
                                                let uu____8064 =
                                                  FStar_Syntax_Syntax.bv_to_name
                                                    bv
                                                   in
                                                FStar_All.pipe_right
                                                  uu____8064
                                                  FStar_Syntax_Syntax.as_arg))
                                     in
                                  let e =
                                    FStar_Syntax_Syntax.mk
                                      (FStar_Syntax_Syntax.Tm_app
                                         (lbdef1, args))
                                      FStar_Pervasives_Native.None
                                      lbdef1.FStar_Syntax_Syntax.pos
                                     in
                                  (lbname_, f_e,
                                    (lbtyp1, (tbinders, polytype)), false, e)
                              | FStar_Syntax_Syntax.Tm_name uu____8094 ->
                                  let env =
                                    FStar_List.fold_left
                                      (fun env  ->
                                         fun uu____8107  ->
                                           match uu____8107 with
                                           | (a,uu____8115) ->
                                               FStar_Extraction_ML_UEnv.extend_ty
                                                 env a
                                                 FStar_Pervasives_Native.None)
                                      g tbinders
                                     in
                                  let expected_t = term_as_mlty env tbody  in
                                  let polytype =
                                    let uu____8126 =
                                      FStar_All.pipe_right tbinders
                                        (FStar_List.map
                                           (fun uu____8145  ->
                                              match uu____8145 with
                                              | (x,uu____8154) ->
                                                  FStar_Extraction_ML_UEnv.bv_as_ml_tyvar
                                                    x))
                                       in
                                    (uu____8126, expected_t)  in
                                  let args =
                                    FStar_All.pipe_right tbinders
                                      (FStar_List.map
                                         (fun uu____8198  ->
                                            match uu____8198 with
                                            | (bv,uu____8206) ->
                                                let uu____8211 =
                                                  FStar_Syntax_Syntax.bv_to_name
                                                    bv
                                                   in
                                                FStar_All.pipe_right
                                                  uu____8211
                                                  FStar_Syntax_Syntax.as_arg))
                                     in
                                  let e =
                                    FStar_Syntax_Syntax.mk
                                      (FStar_Syntax_Syntax.Tm_app
                                         (lbdef1, args))
                                      FStar_Pervasives_Native.None
                                      lbdef1.FStar_Syntax_Syntax.pos
                                     in
                                  (lbname_, f_e,
                                    (lbtyp1, (tbinders, polytype)), false, e)
                              | uu____8241 -> err_value_restriction lbdef1)))
               | uu____8261 -> no_gen ())
         in
      FStar_All.pipe_right (FStar_Pervasives_Native.snd lbs)
        (FStar_List.map maybe_generalize)
  
let (extract_lb_iface :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.letbindings ->
      (FStar_Extraction_ML_UEnv.env,(FStar_Syntax_Syntax.fv,FStar_Extraction_ML_UEnv.exp_binding)
                                      FStar_Pervasives_Native.tuple2
                                      Prims.list)
        FStar_Pervasives_Native.tuple2)
  =
  fun g  ->
    fun lbs  ->
      let is_top =
        FStar_Syntax_Syntax.is_top_level (FStar_Pervasives_Native.snd lbs)
         in
      let is_rec =
        (Prims.op_Negation is_top) && (FStar_Pervasives_Native.fst lbs)  in
      let lbs1 = extract_lb_sig g lbs  in
      FStar_Util.fold_map
        (fun env  ->
           fun uu____8412  ->
             match uu____8412 with
             | (lbname,e_tag,(typ,(binders,mltyscheme)),add_unit,_body) ->
                 let uu____8473 =
                   FStar_Extraction_ML_UEnv.extend_lb env lbname typ
                     mltyscheme add_unit is_rec
                    in
                 (match uu____8473 with
                  | (env1,uu____8490,exp_binding) ->
                      let uu____8494 =
                        let uu____8499 = FStar_Util.right lbname  in
                        (uu____8499, exp_binding)  in
                      (env1, uu____8494))) g lbs1
  
let rec (check_term_as_mlexpr :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Extraction_ML_Syntax.e_tag ->
        FStar_Extraction_ML_Syntax.mlty ->
          (FStar_Extraction_ML_Syntax.mlexpr,FStar_Extraction_ML_Syntax.mlty)
            FStar_Pervasives_Native.tuple2)
  =
  fun g  ->
    fun e  ->
      fun f  ->
        fun ty  ->
          FStar_Extraction_ML_UEnv.debug g
            (fun uu____8565  ->
               let uu____8566 = FStar_Syntax_Print.term_to_string e  in
               let uu____8568 =
                 FStar_Extraction_ML_Code.string_of_mlty
                   g.FStar_Extraction_ML_UEnv.currentModule ty
                  in
               FStar_Util.print2 "Checking %s at type %s\n" uu____8566
                 uu____8568);
          (match (f, ty) with
           | (FStar_Extraction_ML_Syntax.E_GHOST ,uu____8575) ->
               (FStar_Extraction_ML_Syntax.ml_unit,
                 FStar_Extraction_ML_Syntax.MLTY_Erased)
           | (FStar_Extraction_ML_Syntax.E_PURE
              ,FStar_Extraction_ML_Syntax.MLTY_Erased ) ->
               (FStar_Extraction_ML_Syntax.ml_unit,
                 FStar_Extraction_ML_Syntax.MLTY_Erased)
           | uu____8576 ->
               let uu____8581 = term_as_mlexpr g e  in
               (match uu____8581 with
                | (ml_e,tag,t) ->
                    let uu____8595 = maybe_promote_effect ml_e tag t  in
                    (match uu____8595 with
                     | (ml_e1,tag1) ->
                         let uu____8606 =
                           FStar_Extraction_ML_Util.eff_leq tag1 f  in
                         if uu____8606
                         then
                           let uu____8613 =
                             maybe_coerce e.FStar_Syntax_Syntax.pos g ml_e1 t
                               ty
                              in
                           (uu____8613, ty)
                         else
                           (match (tag1, f, ty) with
                            | (FStar_Extraction_ML_Syntax.E_GHOST
                               ,FStar_Extraction_ML_Syntax.E_PURE
                               ,FStar_Extraction_ML_Syntax.MLTY_Erased ) ->
                                let uu____8620 =
                                  maybe_coerce e.FStar_Syntax_Syntax.pos g
                                    ml_e1 t ty
                                   in
                                (uu____8620, ty)
                            | uu____8621 ->
                                (err_unexpected_eff g e ty f tag1;
                                 (let uu____8629 =
                                    maybe_coerce e.FStar_Syntax_Syntax.pos g
                                      ml_e1 t ty
                                     in
                                  (uu____8629, ty)))))))

and (term_as_mlexpr :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.term ->
      (FStar_Extraction_ML_Syntax.mlexpr,FStar_Extraction_ML_Syntax.e_tag,
        FStar_Extraction_ML_Syntax.mlty) FStar_Pervasives_Native.tuple3)
  =
  fun g  ->
    fun e  ->
      let uu____8632 = term_as_mlexpr' g e  in
      match uu____8632 with
      | (e1,f,t) ->
          let uu____8648 = maybe_promote_effect e1 f t  in
          (match uu____8648 with | (e2,f1) -> (e2, f1, t))

and (term_as_mlexpr' :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.term ->
      (FStar_Extraction_ML_Syntax.mlexpr,FStar_Extraction_ML_Syntax.e_tag,
        FStar_Extraction_ML_Syntax.mlty) FStar_Pervasives_Native.tuple3)
  =
  fun g  ->
    fun top  ->
      FStar_Extraction_ML_UEnv.debug g
        (fun u  ->
           let uu____8673 =
             let uu____8675 =
               FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos  in
             let uu____8677 = FStar_Syntax_Print.tag_of_term top  in
             let uu____8679 = FStar_Syntax_Print.term_to_string top  in
             FStar_Util.format3 "%s: term_as_mlexpr' (%s) :  %s \n"
               uu____8675 uu____8677 uu____8679
              in
           FStar_Util.print_string uu____8673);
      (let t = FStar_Syntax_Subst.compress top  in
       match t.FStar_Syntax_Syntax.n with
       | FStar_Syntax_Syntax.Tm_unknown  ->
           let uu____8689 =
             let uu____8691 = FStar_Syntax_Print.tag_of_term t  in
             FStar_Util.format1 "Impossible: Unexpected term: %s" uu____8691
              in
           failwith uu____8689
       | FStar_Syntax_Syntax.Tm_delayed uu____8700 ->
           let uu____8723 =
             let uu____8725 = FStar_Syntax_Print.tag_of_term t  in
             FStar_Util.format1 "Impossible: Unexpected term: %s" uu____8725
              in
           failwith uu____8723
       | FStar_Syntax_Syntax.Tm_uvar uu____8734 ->
           let uu____8747 =
             let uu____8749 = FStar_Syntax_Print.tag_of_term t  in
             FStar_Util.format1 "Impossible: Unexpected term: %s" uu____8749
              in
           failwith uu____8747
       | FStar_Syntax_Syntax.Tm_bvar uu____8758 ->
           let uu____8759 =
             let uu____8761 = FStar_Syntax_Print.tag_of_term t  in
             FStar_Util.format1 "Impossible: Unexpected term: %s" uu____8761
              in
           failwith uu____8759
       | FStar_Syntax_Syntax.Tm_lazy i ->
           let uu____8771 = FStar_Syntax_Util.unfold_lazy i  in
           term_as_mlexpr g uu____8771
       | FStar_Syntax_Syntax.Tm_type uu____8772 ->
           (FStar_Extraction_ML_Syntax.ml_unit,
             FStar_Extraction_ML_Syntax.E_PURE,
             FStar_Extraction_ML_Syntax.ml_unit_ty)
       | FStar_Syntax_Syntax.Tm_refine uu____8773 ->
           (FStar_Extraction_ML_Syntax.ml_unit,
             FStar_Extraction_ML_Syntax.E_PURE,
             FStar_Extraction_ML_Syntax.ml_unit_ty)
       | FStar_Syntax_Syntax.Tm_arrow uu____8780 ->
           (FStar_Extraction_ML_Syntax.ml_unit,
             FStar_Extraction_ML_Syntax.E_PURE,
             FStar_Extraction_ML_Syntax.ml_unit_ty)
       | FStar_Syntax_Syntax.Tm_quoted
           (qt,{
                 FStar_Syntax_Syntax.qkind =
                   FStar_Syntax_Syntax.Quote_dynamic ;
                 FStar_Syntax_Syntax.antiquotes = uu____8796;_})
           ->
           let uu____8809 =
             let uu____8810 =
               FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.failwith_lid
                 FStar_Syntax_Syntax.delta_constant
                 FStar_Pervasives_Native.None
                in
             FStar_Extraction_ML_UEnv.lookup_fv g uu____8810  in
           (match uu____8809 with
            | { FStar_Extraction_ML_UEnv.exp_b_name = uu____8817;
                FStar_Extraction_ML_UEnv.exp_b_expr = fw;
                FStar_Extraction_ML_UEnv.exp_b_tscheme = uu____8819;
                FStar_Extraction_ML_UEnv.exp_b_inst_ok = uu____8820;_} ->
                let uu____8823 =
                  let uu____8824 =
                    let uu____8825 =
                      let uu____8832 =
                        let uu____8835 =
                          FStar_All.pipe_left
                            (FStar_Extraction_ML_Syntax.with_ty
                               FStar_Extraction_ML_Syntax.ml_string_ty)
                            (FStar_Extraction_ML_Syntax.MLE_Const
                               (FStar_Extraction_ML_Syntax.MLC_String
                                  "Cannot evaluate open quotation at runtime"))
                           in
                        [uu____8835]  in
                      (fw, uu____8832)  in
                    FStar_Extraction_ML_Syntax.MLE_App uu____8825  in
                  FStar_All.pipe_left
                    (FStar_Extraction_ML_Syntax.with_ty
                       FStar_Extraction_ML_Syntax.ml_int_ty) uu____8824
                   in
                (uu____8823, FStar_Extraction_ML_Syntax.E_PURE,
                  FStar_Extraction_ML_Syntax.ml_int_ty))
       | FStar_Syntax_Syntax.Tm_quoted
           (qt,{
                 FStar_Syntax_Syntax.qkind = FStar_Syntax_Syntax.Quote_static ;
                 FStar_Syntax_Syntax.antiquotes = aqs;_})
           ->
           let uu____8853 = FStar_Reflection_Basic.inspect_ln qt  in
           (match uu____8853 with
            | FStar_Reflection_Data.Tv_Var bv ->
                let uu____8861 = FStar_Syntax_Syntax.lookup_aq bv aqs  in
                (match uu____8861 with
                 | FStar_Pervasives_Native.Some tm -> term_as_mlexpr g tm
                 | FStar_Pervasives_Native.None  ->
                     let tv =
                       let uu____8872 =
                         let uu____8879 =
                           FStar_Reflection_Embeddings.e_term_view_aq aqs  in
                         FStar_Syntax_Embeddings.embed uu____8879
                           (FStar_Reflection_Data.Tv_Var bv)
                          in
                       uu____8872 t.FStar_Syntax_Syntax.pos
                         FStar_Pervasives_Native.None
                         FStar_Syntax_Embeddings.id_norm_cb
                        in
                     let t1 =
                       let uu____8910 =
                         let uu____8921 = FStar_Syntax_Syntax.as_arg tv  in
                         [uu____8921]  in
                       FStar_Syntax_Util.mk_app
                         (FStar_Reflection_Data.refl_constant_term
                            FStar_Reflection_Data.fstar_refl_pack_ln)
                         uu____8910
                        in
                     term_as_mlexpr g t1)
            | tv ->
                let tv1 =
                  let uu____8948 =
                    let uu____8955 =
                      FStar_Reflection_Embeddings.e_term_view_aq aqs  in
                    FStar_Syntax_Embeddings.embed uu____8955 tv  in
                  uu____8948 t.FStar_Syntax_Syntax.pos
                    FStar_Pervasives_Native.None
                    FStar_Syntax_Embeddings.id_norm_cb
                   in
                let t1 =
                  let uu____8986 =
                    let uu____8997 = FStar_Syntax_Syntax.as_arg tv1  in
                    [uu____8997]  in
                  FStar_Syntax_Util.mk_app
                    (FStar_Reflection_Data.refl_constant_term
                       FStar_Reflection_Data.fstar_refl_pack_ln) uu____8986
                   in
                term_as_mlexpr g t1)
       | FStar_Syntax_Syntax.Tm_meta
           (t1,FStar_Syntax_Syntax.Meta_monadic (m,uu____9024)) ->
           let t2 = FStar_Syntax_Subst.compress t1  in
           (match t2.FStar_Syntax_Syntax.n with
            | FStar_Syntax_Syntax.Tm_let ((false ,lb::[]),body) when
                FStar_Util.is_left lb.FStar_Syntax_Syntax.lbname ->
                let uu____9057 =
                  let uu____9064 =
                    FStar_TypeChecker_Env.effect_decl_opt
                      g.FStar_Extraction_ML_UEnv.tcenv m
                     in
                  FStar_Util.must uu____9064  in
                (match uu____9057 with
                 | (ed,qualifiers) ->
                     let uu____9091 =
                       let uu____9093 =
                         FStar_TypeChecker_Env.is_reifiable_effect
                           g.FStar_Extraction_ML_UEnv.tcenv
                           ed.FStar_Syntax_Syntax.mname
                          in
                       Prims.op_Negation uu____9093  in
                     if uu____9091
                     then term_as_mlexpr g t2
                     else
                       failwith
                         "This should not happen (should have been handled at Tm_abs level)")
            | uu____9111 -> term_as_mlexpr g t2)
       | FStar_Syntax_Syntax.Tm_meta (t1,uu____9113) -> term_as_mlexpr g t1
       | FStar_Syntax_Syntax.Tm_uinst (t1,uu____9119) -> term_as_mlexpr g t1
       | FStar_Syntax_Syntax.Tm_constant c ->
           let uu____9125 =
             FStar_TypeChecker_TcTerm.type_of_tot_term
               g.FStar_Extraction_ML_UEnv.tcenv t
              in
           (match uu____9125 with
            | (uu____9138,ty,uu____9140) ->
                let ml_ty = term_as_mlty g ty  in
                let uu____9142 =
                  let uu____9143 =
                    FStar_Extraction_ML_Util.mlexpr_of_const
                      t.FStar_Syntax_Syntax.pos c
                     in
                  FStar_Extraction_ML_Syntax.with_ty ml_ty uu____9143  in
                (uu____9142, FStar_Extraction_ML_Syntax.E_PURE, ml_ty))
       | FStar_Syntax_Syntax.Tm_name uu____9144 ->
           let uu____9145 = is_type g t  in
           if uu____9145
           then
             (FStar_Extraction_ML_Syntax.ml_unit,
               FStar_Extraction_ML_Syntax.E_PURE,
               FStar_Extraction_ML_Syntax.ml_unit_ty)
           else
             (let uu____9156 = FStar_Extraction_ML_UEnv.lookup_term g t  in
              match uu____9156 with
              | (FStar_Util.Inl uu____9169,uu____9170) ->
                  (FStar_Extraction_ML_Syntax.ml_unit,
                    FStar_Extraction_ML_Syntax.E_PURE,
                    FStar_Extraction_ML_Syntax.ml_unit_ty)
              | (FStar_Util.Inr
                 { FStar_Extraction_ML_UEnv.exp_b_name = uu____9175;
                   FStar_Extraction_ML_UEnv.exp_b_expr = x;
                   FStar_Extraction_ML_UEnv.exp_b_tscheme = mltys;
                   FStar_Extraction_ML_UEnv.exp_b_inst_ok = uu____9178;_},qual)
                  ->
                  (match mltys with
                   | ([],t1) when t1 = FStar_Extraction_ML_Syntax.ml_unit_ty
                       ->
                       (FStar_Extraction_ML_Syntax.ml_unit,
                         FStar_Extraction_ML_Syntax.E_PURE, t1)
                   | ([],t1) ->
                       let uu____9196 =
                         maybe_eta_data_and_project_record g qual t1 x  in
                       (uu____9196, FStar_Extraction_ML_Syntax.E_PURE, t1)
                   | uu____9197 -> err_uninst g t mltys t))
       | FStar_Syntax_Syntax.Tm_fvar fv ->
           let uu____9205 = is_type g t  in
           if uu____9205
           then
             (FStar_Extraction_ML_Syntax.ml_unit,
               FStar_Extraction_ML_Syntax.E_PURE,
               FStar_Extraction_ML_Syntax.ml_unit_ty)
           else
             (let uu____9216 = FStar_Extraction_ML_UEnv.try_lookup_fv g fv
                 in
              match uu____9216 with
              | FStar_Pervasives_Native.None  ->
                  (FStar_Extraction_ML_Syntax.ml_unit,
                    FStar_Extraction_ML_Syntax.E_PURE,
                    FStar_Extraction_ML_Syntax.MLTY_Erased)
              | FStar_Pervasives_Native.Some
                  { FStar_Extraction_ML_UEnv.exp_b_name = uu____9225;
                    FStar_Extraction_ML_UEnv.exp_b_expr = x;
                    FStar_Extraction_ML_UEnv.exp_b_tscheme = mltys;
                    FStar_Extraction_ML_UEnv.exp_b_inst_ok = uu____9228;_}
                  ->
                  (match mltys with
                   | ([],t1) when t1 = FStar_Extraction_ML_Syntax.ml_unit_ty
                       ->
                       (FStar_Extraction_ML_Syntax.ml_unit,
                         FStar_Extraction_ML_Syntax.E_PURE, t1)
                   | ([],t1) ->
                       let uu____9241 =
                         maybe_eta_data_and_project_record g
                           fv.FStar_Syntax_Syntax.fv_qual t1 x
                          in
                       (uu____9241, FStar_Extraction_ML_Syntax.E_PURE, t1)
                   | uu____9242 -> err_uninst g t mltys t))
       | FStar_Syntax_Syntax.Tm_abs (bs,body,rcopt) ->
           let uu____9276 = FStar_Syntax_Subst.open_term bs body  in
           (match uu____9276 with
            | (bs1,body1) ->
                let uu____9289 = binders_as_ml_binders g bs1  in
                (match uu____9289 with
                 | (ml_bs,env) ->
                     let body2 =
                       match rcopt with
                       | FStar_Pervasives_Native.Some rc ->
                           let uu____9325 =
                             FStar_TypeChecker_Env.is_reifiable_rc
                               env.FStar_Extraction_ML_UEnv.tcenv rc
                              in
                           if uu____9325
                           then
                             FStar_TypeChecker_Util.reify_body
                               env.FStar_Extraction_ML_UEnv.tcenv body1
                           else body1
                       | FStar_Pervasives_Native.None  ->
                           (FStar_Extraction_ML_UEnv.debug g
                              (fun uu____9333  ->
                                 let uu____9334 =
                                   FStar_Syntax_Print.term_to_string body1
                                    in
                                 FStar_Util.print1
                                   "No computation type for: %s\n" uu____9334);
                            body1)
                        in
                     let uu____9337 = term_as_mlexpr env body2  in
                     (match uu____9337 with
                      | (ml_body,f,t1) ->
                          let uu____9353 =
                            FStar_List.fold_right
                              (fun uu____9373  ->
                                 fun uu____9374  ->
                                   match (uu____9373, uu____9374) with
                                   | ((uu____9397,targ),(f1,t2)) ->
                                       (FStar_Extraction_ML_Syntax.E_PURE,
                                         (FStar_Extraction_ML_Syntax.MLTY_Fun
                                            (targ, f1, t2)))) ml_bs (f, t1)
                             in
                          (match uu____9353 with
                           | (f1,tfun) ->
                               let uu____9420 =
                                 FStar_All.pipe_left
                                   (FStar_Extraction_ML_Syntax.with_ty tfun)
                                   (FStar_Extraction_ML_Syntax.MLE_Fun
                                      (ml_bs, ml_body))
                                  in
                               (uu____9420, f1, tfun)))))
       | FStar_Syntax_Syntax.Tm_app
           ({
              FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
                (FStar_Const.Const_range_of );
              FStar_Syntax_Syntax.pos = uu____9428;
              FStar_Syntax_Syntax.vars = uu____9429;_},(a1,uu____9431)::[])
           ->
           let ty =
             let uu____9471 =
               FStar_Syntax_Syntax.tabbrev FStar_Parser_Const.range_lid  in
             term_as_mlty g uu____9471  in
           let uu____9472 =
             let uu____9473 =
               FStar_Extraction_ML_Util.mlexpr_of_range
                 a1.FStar_Syntax_Syntax.pos
                in
             FStar_All.pipe_left (FStar_Extraction_ML_Syntax.with_ty ty)
               uu____9473
              in
           (uu____9472, FStar_Extraction_ML_Syntax.E_PURE, ty)
       | FStar_Syntax_Syntax.Tm_app
           ({
              FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
                (FStar_Const.Const_set_range_of );
              FStar_Syntax_Syntax.pos = uu____9474;
              FStar_Syntax_Syntax.vars = uu____9475;_},(t1,uu____9477)::
            (r,uu____9479)::[])
           -> term_as_mlexpr g t1
       | FStar_Syntax_Syntax.Tm_app
           ({
              FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant
                (FStar_Const.Const_reflect uu____9534);
              FStar_Syntax_Syntax.pos = uu____9535;
              FStar_Syntax_Syntax.vars = uu____9536;_},uu____9537)
           -> failwith "Unreachable? Tm_app Const_reflect"
       | FStar_Syntax_Syntax.Tm_app (head1,args) ->
           let is_total rc =
             (FStar_Ident.lid_equals rc.FStar_Syntax_Syntax.residual_effect
                FStar_Parser_Const.effect_Tot_lid)
               ||
               (FStar_All.pipe_right rc.FStar_Syntax_Syntax.residual_flags
                  (FStar_List.existsb
                     (fun uu___366_9606  ->
                        match uu___366_9606 with
                        | FStar_Syntax_Syntax.TOTAL  -> true
                        | uu____9609 -> false)))
              in
           let uu____9611 =
             let uu____9616 =
               let uu____9617 = FStar_Syntax_Subst.compress head1  in
               uu____9617.FStar_Syntax_Syntax.n  in
             ((head1.FStar_Syntax_Syntax.n), uu____9616)  in
           (match uu____9611 with
            | (FStar_Syntax_Syntax.Tm_uvar uu____9626,uu____9627) ->
                let t1 =
                  FStar_TypeChecker_Normalize.normalize
                    [FStar_TypeChecker_Env.Beta;
                    FStar_TypeChecker_Env.Iota;
                    FStar_TypeChecker_Env.Zeta;
                    FStar_TypeChecker_Env.EraseUniverses;
                    FStar_TypeChecker_Env.AllowUnboundUniverses]
                    g.FStar_Extraction_ML_UEnv.tcenv t
                   in
                term_as_mlexpr g t1
            | (uu____9641,FStar_Syntax_Syntax.Tm_abs
               (bs,uu____9643,FStar_Pervasives_Native.Some rc)) when
                is_total rc ->
                let t1 =
                  FStar_TypeChecker_Normalize.normalize
                    [FStar_TypeChecker_Env.Beta;
                    FStar_TypeChecker_Env.Iota;
                    FStar_TypeChecker_Env.Zeta;
                    FStar_TypeChecker_Env.EraseUniverses;
                    FStar_TypeChecker_Env.AllowUnboundUniverses]
                    g.FStar_Extraction_ML_UEnv.tcenv t
                   in
                term_as_mlexpr g t1
            | (uu____9668,FStar_Syntax_Syntax.Tm_constant
               (FStar_Const.Const_reify )) ->
                let e =
                  let uu____9670 = FStar_List.hd args  in
                  FStar_TypeChecker_Util.reify_body_with_arg
                    g.FStar_Extraction_ML_UEnv.tcenv head1 uu____9670
                   in
                let tm =
                  let uu____9682 =
                    let uu____9687 = FStar_TypeChecker_Util.remove_reify e
                       in
                    let uu____9688 = FStar_List.tl args  in
                    FStar_Syntax_Syntax.mk_Tm_app uu____9687 uu____9688  in
                  uu____9682 FStar_Pervasives_Native.None
                    t.FStar_Syntax_Syntax.pos
                   in
                term_as_mlexpr g tm
            | uu____9699 ->
                let rec extract_app is_data uu____9752 uu____9753 restArgs =
                  match (uu____9752, uu____9753) with
                  | ((mlhead,mlargs_f),(f,t1)) ->
                      let mk_head uu____9834 =
                        let mlargs =
                          FStar_All.pipe_right (FStar_List.rev mlargs_f)
                            (FStar_List.map FStar_Pervasives_Native.fst)
                           in
                        FStar_All.pipe_left
                          (FStar_Extraction_ML_Syntax.with_ty t1)
                          (FStar_Extraction_ML_Syntax.MLE_App
                             (mlhead, mlargs))
                         in
                      (FStar_Extraction_ML_UEnv.debug g
                         (fun uu____9861  ->
                            let uu____9862 =
                              let uu____9864 = mk_head ()  in
                              FStar_Extraction_ML_Code.string_of_mlexpr
                                g.FStar_Extraction_ML_UEnv.currentModule
                                uu____9864
                               in
                            let uu____9865 =
                              FStar_Extraction_ML_Code.string_of_mlty
                                g.FStar_Extraction_ML_UEnv.currentModule t1
                               in
                            let uu____9867 =
                              match restArgs with
                              | [] -> "none"
                              | (hd1,uu____9878)::uu____9879 ->
                                  FStar_Syntax_Print.term_to_string hd1
                               in
                            FStar_Util.print3
                              "extract_app ml_head=%s type of head = %s, next arg = %s\n"
                              uu____9862 uu____9865 uu____9867);
                       (match (restArgs, t1) with
                        | ([],uu____9913) ->
                            let app =
                              let uu____9929 = mk_head ()  in
                              maybe_eta_data_and_project_record g is_data t1
                                uu____9929
                               in
                            (app, f, t1)
                        | ((arg,uu____9931)::rest,FStar_Extraction_ML_Syntax.MLTY_Fun
                           (formal_t,f',t2)) when
                            (is_type g arg) &&
                              (type_leq g formal_t
                                 FStar_Extraction_ML_Syntax.ml_unit_ty)
                            ->
                            let uu____9962 =
                              let uu____9967 =
                                FStar_Extraction_ML_Util.join
                                  arg.FStar_Syntax_Syntax.pos f f'
                                 in
                              (uu____9967, t2)  in
                            extract_app is_data
                              (mlhead,
                                ((FStar_Extraction_ML_Syntax.ml_unit,
                                   FStar_Extraction_ML_Syntax.E_PURE) ::
                                mlargs_f)) uu____9962 rest
                        | ((e0,uu____9979)::rest,FStar_Extraction_ML_Syntax.MLTY_Fun
                           (tExpected,f',t2)) ->
                            let r = e0.FStar_Syntax_Syntax.pos  in
                            let expected_effect =
                              let uu____10012 =
                                (FStar_Options.lax ()) &&
                                  (FStar_TypeChecker_Util.short_circuit_head
                                     head1)
                                 in
                              if uu____10012
                              then FStar_Extraction_ML_Syntax.E_IMPURE
                              else FStar_Extraction_ML_Syntax.E_PURE  in
                            let uu____10017 =
                              check_term_as_mlexpr g e0 expected_effect
                                tExpected
                               in
                            (match uu____10017 with
                             | (e01,tInferred) ->
                                 let uu____10030 =
                                   let uu____10035 =
                                     FStar_Extraction_ML_Util.join_l r
                                       [f; f']
                                      in
                                   (uu____10035, t2)  in
                                 extract_app is_data
                                   (mlhead, ((e01, expected_effect) ::
                                     mlargs_f)) uu____10030 rest)
                        | uu____10046 ->
                            let uu____10059 =
                              FStar_Extraction_ML_Util.udelta_unfold g t1  in
                            (match uu____10059 with
                             | FStar_Pervasives_Native.Some t2 ->
                                 extract_app is_data (mlhead, mlargs_f)
                                   (f, t2) restArgs
                             | FStar_Pervasives_Native.None  ->
                                 (match t1 with
                                  | FStar_Extraction_ML_Syntax.MLTY_Erased 
                                      ->
                                      (FStar_Extraction_ML_Syntax.ml_unit,
                                        FStar_Extraction_ML_Syntax.E_PURE,
                                        t1)
                                  | FStar_Extraction_ML_Syntax.MLTY_Top  ->
                                      let t2 =
                                        FStar_List.fold_right
                                          (fun t2  ->
                                             fun out  ->
                                               FStar_Extraction_ML_Syntax.MLTY_Fun
                                                 (FStar_Extraction_ML_Syntax.MLTY_Top,
                                                   FStar_Extraction_ML_Syntax.E_PURE,
                                                   out)) restArgs
                                          FStar_Extraction_ML_Syntax.MLTY_Top
                                         in
                                      let mlhead1 =
                                        let mlargs =
                                          FStar_All.pipe_right
                                            (FStar_List.rev mlargs_f)
                                            (FStar_List.map
                                               FStar_Pervasives_Native.fst)
                                           in
                                        let head2 =
                                          FStar_All.pipe_left
                                            (FStar_Extraction_ML_Syntax.with_ty
                                               FStar_Extraction_ML_Syntax.MLTY_Top)
                                            (FStar_Extraction_ML_Syntax.MLE_App
                                               (mlhead, mlargs))
                                           in
                                        maybe_coerce
                                          top.FStar_Syntax_Syntax.pos g head2
                                          FStar_Extraction_ML_Syntax.MLTY_Top
                                          t2
                                         in
                                      extract_app is_data (mlhead1, [])
                                        (f, t2) restArgs
                                  | uu____10131 ->
                                      let mlhead1 =
                                        let mlargs =
                                          FStar_All.pipe_right
                                            (FStar_List.rev mlargs_f)
                                            (FStar_List.map
                                               FStar_Pervasives_Native.fst)
                                           in
                                        let head2 =
                                          FStar_All.pipe_left
                                            (FStar_Extraction_ML_Syntax.with_ty
                                               FStar_Extraction_ML_Syntax.MLTY_Top)
                                            (FStar_Extraction_ML_Syntax.MLE_App
                                               (mlhead, mlargs))
                                           in
                                        maybe_coerce
                                          top.FStar_Syntax_Syntax.pos g head2
                                          FStar_Extraction_ML_Syntax.MLTY_Top
                                          t1
                                         in
                                      err_ill_typed_application g top mlhead1
                                        restArgs t1))))
                   in
                let extract_app_maybe_projector is_data mlhead uu____10202
                  args1 =
                  match uu____10202 with
                  | (f,t1) ->
                      (match is_data with
                       | FStar_Pervasives_Native.Some
                           (FStar_Syntax_Syntax.Record_projector uu____10232)
                           ->
                           let rec remove_implicits args2 f1 t2 =
                             match (args2, t2) with
                             | ((a0,FStar_Pervasives_Native.Some
                                 (FStar_Syntax_Syntax.Implicit uu____10316))::args3,FStar_Extraction_ML_Syntax.MLTY_Fun
                                (uu____10318,f',t3)) ->
                                 let uu____10356 =
                                   FStar_Extraction_ML_Util.join
                                     a0.FStar_Syntax_Syntax.pos f1 f'
                                    in
                                 remove_implicits args3 uu____10356 t3
                             | uu____10357 -> (args2, f1, t2)  in
                           let uu____10382 = remove_implicits args1 f t1  in
                           (match uu____10382 with
                            | (args2,f1,t2) ->
                                extract_app is_data (mlhead, []) (f1, t2)
                                  args2)
                       | uu____10438 ->
                           extract_app is_data (mlhead, []) (f, t1) args1)
                   in
                let extract_app_with_instantiations uu____10462 =
                  let head2 = FStar_Syntax_Util.un_uinst head1  in
                  match head2.FStar_Syntax_Syntax.n with
                  | FStar_Syntax_Syntax.Tm_name uu____10470 ->
                      let uu____10471 =
                        let uu____10492 =
                          FStar_Extraction_ML_UEnv.lookup_term g head2  in
                        match uu____10492 with
                        | (FStar_Util.Inr exp_b,q) ->
                            (((exp_b.FStar_Extraction_ML_UEnv.exp_b_expr),
                               (exp_b.FStar_Extraction_ML_UEnv.exp_b_tscheme),
                               (exp_b.FStar_Extraction_ML_UEnv.exp_b_inst_ok)),
                              q)
                        | uu____10549 -> failwith "FIXME Ty"  in
                      (match uu____10471 with
                       | ((head_ml,(vars,t1),inst_ok),qual) ->
                           let has_typ_apps =
                             match args with
                             | (a,uu____10625)::uu____10626 -> is_type g a
                             | uu____10653 -> false  in
                           let uu____10665 =
                             match vars with
                             | uu____10694::uu____10695 when
                                 (Prims.op_Negation has_typ_apps) && inst_ok
                                 -> (head_ml, t1, args)
                             | uu____10709 ->
                                 let n1 = FStar_List.length vars  in
                                 if n1 <= (FStar_List.length args)
                                 then
                                   let uu____10744 =
                                     FStar_Util.first_N n1 args  in
                                   (match uu____10744 with
                                    | (prefix1,rest) ->
                                        let prefixAsMLTypes =
                                          FStar_List.map
                                            (fun uu____10849  ->
                                               match uu____10849 with
                                               | (x,uu____10857) ->
                                                   term_as_mlty g x) prefix1
                                           in
                                        let t2 =
                                          instantiate (vars, t1)
                                            prefixAsMLTypes
                                           in
                                        let mk_tapp e ty_args =
                                          match ty_args with
                                          | [] -> e
                                          | uu____10878 ->
                                              let uu___372_10881 = e  in
                                              {
                                                FStar_Extraction_ML_Syntax.expr
                                                  =
                                                  (FStar_Extraction_ML_Syntax.MLE_TApp
                                                     (e, ty_args));
                                                FStar_Extraction_ML_Syntax.mlty
                                                  =
                                                  (uu___372_10881.FStar_Extraction_ML_Syntax.mlty);
                                                FStar_Extraction_ML_Syntax.loc
                                                  =
                                                  (uu___372_10881.FStar_Extraction_ML_Syntax.loc)
                                              }
                                           in
                                        let head3 =
                                          match head_ml.FStar_Extraction_ML_Syntax.expr
                                          with
                                          | FStar_Extraction_ML_Syntax.MLE_Name
                                              uu____10885 ->
                                              let uu___373_10886 =
                                                mk_tapp head_ml
                                                  prefixAsMLTypes
                                                 in
                                              {
                                                FStar_Extraction_ML_Syntax.expr
                                                  =
                                                  (uu___373_10886.FStar_Extraction_ML_Syntax.expr);
                                                FStar_Extraction_ML_Syntax.mlty
                                                  = t2;
                                                FStar_Extraction_ML_Syntax.loc
                                                  =
                                                  (uu___373_10886.FStar_Extraction_ML_Syntax.loc)
                                              }
                                          | FStar_Extraction_ML_Syntax.MLE_Var
                                              uu____10887 ->
                                              let uu___373_10889 =
                                                mk_tapp head_ml
                                                  prefixAsMLTypes
                                                 in
                                              {
                                                FStar_Extraction_ML_Syntax.expr
                                                  =
                                                  (uu___373_10889.FStar_Extraction_ML_Syntax.expr);
                                                FStar_Extraction_ML_Syntax.mlty
                                                  = t2;
                                                FStar_Extraction_ML_Syntax.loc
                                                  =
                                                  (uu___373_10889.FStar_Extraction_ML_Syntax.loc)
                                              }
                                          | FStar_Extraction_ML_Syntax.MLE_App
                                              (head3,{
                                                       FStar_Extraction_ML_Syntax.expr
                                                         =
                                                         FStar_Extraction_ML_Syntax.MLE_Const
                                                         (FStar_Extraction_ML_Syntax.MLC_Unit
                                                         );
                                                       FStar_Extraction_ML_Syntax.mlty
                                                         = uu____10891;
                                                       FStar_Extraction_ML_Syntax.loc
                                                         = uu____10892;_}::[])
                                              ->
                                              FStar_All.pipe_right
                                                (FStar_Extraction_ML_Syntax.MLE_App
                                                   ((let uu___374_10898 =
                                                       mk_tapp head3
                                                         prefixAsMLTypes
                                                        in
                                                     {
                                                       FStar_Extraction_ML_Syntax.expr
                                                         =
                                                         (uu___374_10898.FStar_Extraction_ML_Syntax.expr);
                                                       FStar_Extraction_ML_Syntax.mlty
                                                         =
                                                         (FStar_Extraction_ML_Syntax.MLTY_Fun
                                                            (FStar_Extraction_ML_Syntax.ml_unit_ty,
                                                              FStar_Extraction_ML_Syntax.E_PURE,
                                                              t2));
                                                       FStar_Extraction_ML_Syntax.loc
                                                         =
                                                         (uu___374_10898.FStar_Extraction_ML_Syntax.loc)
                                                     }),
                                                     [FStar_Extraction_ML_Syntax.ml_unit]))
                                                (FStar_Extraction_ML_Syntax.with_ty
                                                   t2)
                                          | uu____10899 ->
                                              failwith
                                                "Impossible: Unexpected head term"
                                           in
                                        (head3, t2, rest))
                                 else err_uninst g head2 (vars, t1) top
                              in
                           (match uu____10665 with
                            | (head_ml1,head_t,args1) ->
                                (match args1 with
                                 | [] ->
                                     let uu____10965 =
                                       maybe_eta_data_and_project_record g
                                         qual head_t head_ml1
                                        in
                                     (uu____10965,
                                       FStar_Extraction_ML_Syntax.E_PURE,
                                       head_t)
                                 | uu____10966 ->
                                     extract_app_maybe_projector qual
                                       head_ml1
                                       (FStar_Extraction_ML_Syntax.E_PURE,
                                         head_t) args1)))
                  | FStar_Syntax_Syntax.Tm_fvar uu____10975 ->
                      let uu____10976 =
                        let uu____10997 =
                          FStar_Extraction_ML_UEnv.lookup_term g head2  in
                        match uu____10997 with
                        | (FStar_Util.Inr exp_b,q) ->
                            (((exp_b.FStar_Extraction_ML_UEnv.exp_b_expr),
                               (exp_b.FStar_Extraction_ML_UEnv.exp_b_tscheme),
                               (exp_b.FStar_Extraction_ML_UEnv.exp_b_inst_ok)),
                              q)
                        | uu____11054 -> failwith "FIXME Ty"  in
                      (match uu____10976 with
                       | ((head_ml,(vars,t1),inst_ok),qual) ->
                           let has_typ_apps =
                             match args with
                             | (a,uu____11130)::uu____11131 -> is_type g a
                             | uu____11158 -> false  in
                           let uu____11170 =
                             match vars with
                             | uu____11199::uu____11200 when
                                 (Prims.op_Negation has_typ_apps) && inst_ok
                                 -> (head_ml, t1, args)
                             | uu____11214 ->
                                 let n1 = FStar_List.length vars  in
                                 if n1 <= (FStar_List.length args)
                                 then
                                   let uu____11249 =
                                     FStar_Util.first_N n1 args  in
                                   (match uu____11249 with
                                    | (prefix1,rest) ->
                                        let prefixAsMLTypes =
                                          FStar_List.map
                                            (fun uu____11354  ->
                                               match uu____11354 with
                                               | (x,uu____11362) ->
                                                   term_as_mlty g x) prefix1
                                           in
                                        let t2 =
                                          instantiate (vars, t1)
                                            prefixAsMLTypes
                                           in
                                        let mk_tapp e ty_args =
                                          match ty_args with
                                          | [] -> e
                                          | uu____11383 ->
                                              let uu___372_11386 = e  in
                                              {
                                                FStar_Extraction_ML_Syntax.expr
                                                  =
                                                  (FStar_Extraction_ML_Syntax.MLE_TApp
                                                     (e, ty_args));
                                                FStar_Extraction_ML_Syntax.mlty
                                                  =
                                                  (uu___372_11386.FStar_Extraction_ML_Syntax.mlty);
                                                FStar_Extraction_ML_Syntax.loc
                                                  =
                                                  (uu___372_11386.FStar_Extraction_ML_Syntax.loc)
                                              }
                                           in
                                        let head3 =
                                          match head_ml.FStar_Extraction_ML_Syntax.expr
                                          with
                                          | FStar_Extraction_ML_Syntax.MLE_Name
                                              uu____11390 ->
                                              let uu___373_11391 =
                                                mk_tapp head_ml
                                                  prefixAsMLTypes
                                                 in
                                              {
                                                FStar_Extraction_ML_Syntax.expr
                                                  =
                                                  (uu___373_11391.FStar_Extraction_ML_Syntax.expr);
                                                FStar_Extraction_ML_Syntax.mlty
                                                  = t2;
                                                FStar_Extraction_ML_Syntax.loc
                                                  =
                                                  (uu___373_11391.FStar_Extraction_ML_Syntax.loc)
                                              }
                                          | FStar_Extraction_ML_Syntax.MLE_Var
                                              uu____11392 ->
                                              let uu___373_11394 =
                                                mk_tapp head_ml
                                                  prefixAsMLTypes
                                                 in
                                              {
                                                FStar_Extraction_ML_Syntax.expr
                                                  =
                                                  (uu___373_11394.FStar_Extraction_ML_Syntax.expr);
                                                FStar_Extraction_ML_Syntax.mlty
                                                  = t2;
                                                FStar_Extraction_ML_Syntax.loc
                                                  =
                                                  (uu___373_11394.FStar_Extraction_ML_Syntax.loc)
                                              }
                                          | FStar_Extraction_ML_Syntax.MLE_App
                                              (head3,{
                                                       FStar_Extraction_ML_Syntax.expr
                                                         =
                                                         FStar_Extraction_ML_Syntax.MLE_Const
                                                         (FStar_Extraction_ML_Syntax.MLC_Unit
                                                         );
                                                       FStar_Extraction_ML_Syntax.mlty
                                                         = uu____11396;
                                                       FStar_Extraction_ML_Syntax.loc
                                                         = uu____11397;_}::[])
                                              ->
                                              FStar_All.pipe_right
                                                (FStar_Extraction_ML_Syntax.MLE_App
                                                   ((let uu___374_11403 =
                                                       mk_tapp head3
                                                         prefixAsMLTypes
                                                        in
                                                     {
                                                       FStar_Extraction_ML_Syntax.expr
                                                         =
                                                         (uu___374_11403.FStar_Extraction_ML_Syntax.expr);
                                                       FStar_Extraction_ML_Syntax.mlty
                                                         =
                                                         (FStar_Extraction_ML_Syntax.MLTY_Fun
                                                            (FStar_Extraction_ML_Syntax.ml_unit_ty,
                                                              FStar_Extraction_ML_Syntax.E_PURE,
                                                              t2));
                                                       FStar_Extraction_ML_Syntax.loc
                                                         =
                                                         (uu___374_11403.FStar_Extraction_ML_Syntax.loc)
                                                     }),
                                                     [FStar_Extraction_ML_Syntax.ml_unit]))
                                                (FStar_Extraction_ML_Syntax.with_ty
                                                   t2)
                                          | uu____11404 ->
                                              failwith
                                                "Impossible: Unexpected head term"
                                           in
                                        (head3, t2, rest))
                                 else err_uninst g head2 (vars, t1) top
                              in
                           (match uu____11170 with
                            | (head_ml1,head_t,args1) ->
                                (match args1 with
                                 | [] ->
                                     let uu____11470 =
                                       maybe_eta_data_and_project_record g
                                         qual head_t head_ml1
                                        in
                                     (uu____11470,
                                       FStar_Extraction_ML_Syntax.E_PURE,
                                       head_t)
                                 | uu____11471 ->
                                     extract_app_maybe_projector qual
                                       head_ml1
                                       (FStar_Extraction_ML_Syntax.E_PURE,
                                         head_t) args1)))
                  | uu____11480 ->
                      let uu____11481 = term_as_mlexpr g head2  in
                      (match uu____11481 with
                       | (head3,f,t1) ->
                           extract_app_maybe_projector
                             FStar_Pervasives_Native.None head3 (f, t1) args)
                   in
                let uu____11497 = is_type g t  in
                if uu____11497
                then
                  (FStar_Extraction_ML_Syntax.ml_unit,
                    FStar_Extraction_ML_Syntax.E_PURE,
                    FStar_Extraction_ML_Syntax.ml_unit_ty)
                else
                  (let uu____11508 =
                     let uu____11509 = FStar_Syntax_Util.un_uinst head1  in
                     uu____11509.FStar_Syntax_Syntax.n  in
                   match uu____11508 with
                   | FStar_Syntax_Syntax.Tm_fvar fv ->
                       let uu____11519 =
                         FStar_Extraction_ML_UEnv.try_lookup_fv g fv  in
                       (match uu____11519 with
                        | FStar_Pervasives_Native.None  ->
                            (FStar_Extraction_ML_Syntax.ml_unit,
                              FStar_Extraction_ML_Syntax.E_PURE,
                              FStar_Extraction_ML_Syntax.MLTY_Erased)
                        | uu____11528 -> extract_app_with_instantiations ())
                   | uu____11531 -> extract_app_with_instantiations ()))
       | FStar_Syntax_Syntax.Tm_ascribed (e0,(tc,uu____11534),f) ->
           let t1 =
             match tc with
             | FStar_Util.Inl t1 -> term_as_mlty g t1
             | FStar_Util.Inr c ->
                 term_as_mlty g (FStar_Syntax_Util.comp_result c)
              in
           let f1 =
             match f with
             | FStar_Pervasives_Native.None  ->
                 failwith "Ascription node with an empty effect label"
             | FStar_Pervasives_Native.Some l -> effect_as_etag g l  in
           let uu____11602 = check_term_as_mlexpr g e0 f1 t1  in
           (match uu____11602 with | (e,t2) -> (e, f1, t2))
       | FStar_Syntax_Syntax.Tm_let ((is_rec,lbs),e') ->
           let top_level = FStar_Syntax_Syntax.is_top_level lbs  in
           let uu____11637 =
             if is_rec
             then FStar_Syntax_Subst.open_let_rec lbs e'
             else
               (let uu____11653 = FStar_Syntax_Syntax.is_top_level lbs  in
                if uu____11653
                then (lbs, e')
                else
                  (let lb = FStar_List.hd lbs  in
                   let x =
                     let uu____11668 =
                       FStar_Util.left lb.FStar_Syntax_Syntax.lbname  in
                     FStar_Syntax_Syntax.freshen_bv uu____11668  in
                   let lb1 =
                     let uu___375_11670 = lb  in
                     {
                       FStar_Syntax_Syntax.lbname = (FStar_Util.Inl x);
                       FStar_Syntax_Syntax.lbunivs =
                         (uu___375_11670.FStar_Syntax_Syntax.lbunivs);
                       FStar_Syntax_Syntax.lbtyp =
                         (uu___375_11670.FStar_Syntax_Syntax.lbtyp);
                       FStar_Syntax_Syntax.lbeff =
                         (uu___375_11670.FStar_Syntax_Syntax.lbeff);
                       FStar_Syntax_Syntax.lbdef =
                         (uu___375_11670.FStar_Syntax_Syntax.lbdef);
                       FStar_Syntax_Syntax.lbattrs =
                         (uu___375_11670.FStar_Syntax_Syntax.lbattrs);
                       FStar_Syntax_Syntax.lbpos =
                         (uu___375_11670.FStar_Syntax_Syntax.lbpos)
                     }  in
                   let e'1 =
                     FStar_Syntax_Subst.subst
                       [FStar_Syntax_Syntax.DB ((Prims.parse_int "0"), x)] e'
                      in
                   ([lb1], e'1)))
              in
           (match uu____11637 with
            | (lbs1,e'1) ->
                let lbs2 =
                  if top_level
                  then
                    FStar_All.pipe_right lbs1
                      (FStar_List.map
                         (fun lb  ->
                            let tcenv =
                              let uu____11704 =
                                FStar_Ident.lid_of_path
                                  (FStar_List.append
                                     (FStar_Pervasives_Native.fst
                                        g.FStar_Extraction_ML_UEnv.currentModule)
                                     [FStar_Pervasives_Native.snd
                                        g.FStar_Extraction_ML_UEnv.currentModule])
                                  FStar_Range.dummyRange
                                 in
                              FStar_TypeChecker_Env.set_current_module
                                g.FStar_Extraction_ML_UEnv.tcenv uu____11704
                               in
                            let lbdef =
                              let uu____11719 = FStar_Options.ml_ish ()  in
                              if uu____11719
                              then lb.FStar_Syntax_Syntax.lbdef
                              else
                                (let norm_call uu____11731 =
                                   FStar_TypeChecker_Normalize.normalize
                                     [FStar_TypeChecker_Env.AllowUnboundUniverses;
                                     FStar_TypeChecker_Env.EraseUniverses;
                                     FStar_TypeChecker_Env.Inlining;
                                     FStar_TypeChecker_Env.Eager_unfolding;
                                     FStar_TypeChecker_Env.Exclude
                                       FStar_TypeChecker_Env.Zeta;
                                     FStar_TypeChecker_Env.PureSubtermsWithinComputations;
                                     FStar_TypeChecker_Env.Primops;
                                     FStar_TypeChecker_Env.Unascribe;
                                     FStar_TypeChecker_Env.ForExtraction]
                                     tcenv lb.FStar_Syntax_Syntax.lbdef
                                    in
                                 let uu____11732 =
                                   (FStar_All.pipe_left
                                      (FStar_TypeChecker_Env.debug tcenv)
                                      (FStar_Options.Other "Extraction"))
                                     ||
                                     (FStar_All.pipe_left
                                        (FStar_TypeChecker_Env.debug tcenv)
                                        (FStar_Options.Other "ExtractNorm"))
                                    in
                                 if uu____11732
                                 then
                                   let a =
                                     let uu____11744 =
                                       let uu____11746 =
                                         FStar_Syntax_Print.lbname_to_string
                                           lb.FStar_Syntax_Syntax.lbname
                                          in
                                       FStar_Util.format1
                                         "(Time to normalize top-level let %s)"
                                         uu____11746
                                        in
                                     FStar_Util.measure_execution_time
                                       uu____11744 norm_call
                                      in
                                   ((let uu____11752 =
                                       FStar_Syntax_Print.term_to_string a
                                        in
                                     FStar_Util.print1 "Normalized to %s\n"
                                       uu____11752);
                                    a)
                                 else norm_call ())
                               in
                            let uu___376_11757 = lb  in
                            {
                              FStar_Syntax_Syntax.lbname =
                                (uu___376_11757.FStar_Syntax_Syntax.lbname);
                              FStar_Syntax_Syntax.lbunivs =
                                (uu___376_11757.FStar_Syntax_Syntax.lbunivs);
                              FStar_Syntax_Syntax.lbtyp =
                                (uu___376_11757.FStar_Syntax_Syntax.lbtyp);
                              FStar_Syntax_Syntax.lbeff =
                                (uu___376_11757.FStar_Syntax_Syntax.lbeff);
                              FStar_Syntax_Syntax.lbdef = lbdef;
                              FStar_Syntax_Syntax.lbattrs =
                                (uu___376_11757.FStar_Syntax_Syntax.lbattrs);
                              FStar_Syntax_Syntax.lbpos =
                                (uu___376_11757.FStar_Syntax_Syntax.lbpos)
                            }))
                  else lbs1  in
                let check_lb env uu____11810 =
                  match uu____11810 with
                  | (nm,(_lbname,f,(_t,(targs,polytype)),add_unit,e)) ->
                      let env1 =
                        FStar_List.fold_left
                          (fun env1  ->
                             fun uu____11966  ->
                               match uu____11966 with
                               | (a,uu____11974) ->
                                   FStar_Extraction_ML_UEnv.extend_ty env1 a
                                     FStar_Pervasives_Native.None) env targs
                         in
                      let expected_t = FStar_Pervasives_Native.snd polytype
                         in
                      let uu____11980 =
                        check_term_as_mlexpr env1 e f expected_t  in
                      (match uu____11980 with
                       | (e1,ty) ->
                           let uu____11991 =
                             maybe_promote_effect e1 f expected_t  in
                           (match uu____11991 with
                            | (e2,f1) ->
                                let meta =
                                  match (f1, ty) with
                                  | (FStar_Extraction_ML_Syntax.E_PURE
                                     ,FStar_Extraction_ML_Syntax.MLTY_Erased
                                     ) -> [FStar_Extraction_ML_Syntax.Erased]
                                  | (FStar_Extraction_ML_Syntax.E_GHOST
                                     ,FStar_Extraction_ML_Syntax.MLTY_Erased
                                     ) -> [FStar_Extraction_ML_Syntax.Erased]
                                  | uu____12003 -> []  in
                                (f1,
                                  {
                                    FStar_Extraction_ML_Syntax.mllb_name = nm;
                                    FStar_Extraction_ML_Syntax.mllb_tysc =
                                      (FStar_Pervasives_Native.Some polytype);
                                    FStar_Extraction_ML_Syntax.mllb_add_unit
                                      = add_unit;
                                    FStar_Extraction_ML_Syntax.mllb_def = e2;
                                    FStar_Extraction_ML_Syntax.mllb_meta =
                                      meta;
                                    FStar_Extraction_ML_Syntax.print_typ =
                                      true
                                  })))
                   in
                let lbs3 = extract_lb_sig g (is_rec, lbs2)  in
                let uu____12034 =
                  FStar_List.fold_right
                    (fun lb  ->
                       fun uu____12131  ->
                         match uu____12131 with
                         | (env,lbs4) ->
                             let uu____12265 = lb  in
                             (match uu____12265 with
                              | (lbname,uu____12316,(t1,(uu____12318,polytype)),add_unit,uu____12321)
                                  ->
                                  let uu____12336 =
                                    FStar_Extraction_ML_UEnv.extend_lb env
                                      lbname t1 polytype add_unit true
                                     in
                                  (match uu____12336 with
                                   | (env1,nm,uu____12377) ->
                                       (env1, ((nm, lb) :: lbs4))))) lbs3
                    (g, [])
                   in
                (match uu____12034 with
                 | (env_body,lbs4) ->
                     let env_def = if is_rec then env_body else g  in
                     let lbs5 =
                       FStar_All.pipe_right lbs4
                         (FStar_List.map (check_lb env_def))
                        in
                     let e'_rng = e'1.FStar_Syntax_Syntax.pos  in
                     let uu____12656 = term_as_mlexpr env_body e'1  in
                     (match uu____12656 with
                      | (e'2,f',t') ->
                          let f =
                            let uu____12673 =
                              let uu____12676 =
                                FStar_List.map FStar_Pervasives_Native.fst
                                  lbs5
                                 in
                              f' :: uu____12676  in
                            FStar_Extraction_ML_Util.join_l e'_rng
                              uu____12673
                             in
                          let is_rec1 =
                            if is_rec = true
                            then FStar_Extraction_ML_Syntax.Rec
                            else FStar_Extraction_ML_Syntax.NonRec  in
                          let uu____12689 =
                            let uu____12690 =
                              let uu____12691 =
                                let uu____12692 =
                                  FStar_List.map FStar_Pervasives_Native.snd
                                    lbs5
                                   in
                                (is_rec1, uu____12692)  in
                              mk_MLE_Let top_level uu____12691 e'2  in
                            let uu____12701 =
                              FStar_Extraction_ML_Util.mlloc_of_range
                                t.FStar_Syntax_Syntax.pos
                               in
                            FStar_Extraction_ML_Syntax.with_ty_loc t'
                              uu____12690 uu____12701
                             in
                          (uu____12689, f, t'))))
       | FStar_Syntax_Syntax.Tm_match (scrutinee,pats) ->
           let uu____12740 = term_as_mlexpr g scrutinee  in
           (match uu____12740 with
            | (e,f_e,t_e) ->
                let uu____12756 = check_pats_for_ite pats  in
                (match uu____12756 with
                 | (b,then_e,else_e) ->
                     let no_lift x t1 = x  in
                     if b
                     then
                       (match (then_e, else_e) with
                        | (FStar_Pervasives_Native.Some
                           then_e1,FStar_Pervasives_Native.Some else_e1) ->
                            let uu____12821 = term_as_mlexpr g then_e1  in
                            (match uu____12821 with
                             | (then_mle,f_then,t_then) ->
                                 let uu____12837 = term_as_mlexpr g else_e1
                                    in
                                 (match uu____12837 with
                                  | (else_mle,f_else,t_else) ->
                                      let uu____12853 =
                                        let uu____12864 =
                                          type_leq g t_then t_else  in
                                        if uu____12864
                                        then (t_else, no_lift)
                                        else
                                          (let uu____12885 =
                                             type_leq g t_else t_then  in
                                           if uu____12885
                                           then (t_then, no_lift)
                                           else
                                             (FStar_Extraction_ML_Syntax.MLTY_Top,
                                               FStar_Extraction_ML_Syntax.apply_obj_repr))
                                         in
                                      (match uu____12853 with
                                       | (t_branch,maybe_lift1) ->
                                           let uu____12932 =
                                             let uu____12933 =
                                               let uu____12934 =
                                                 let uu____12943 =
                                                   maybe_lift1 then_mle
                                                     t_then
                                                    in
                                                 let uu____12944 =
                                                   let uu____12947 =
                                                     maybe_lift1 else_mle
                                                       t_else
                                                      in
                                                   FStar_Pervasives_Native.Some
                                                     uu____12947
                                                    in
                                                 (e, uu____12943,
                                                   uu____12944)
                                                  in
                                               FStar_Extraction_ML_Syntax.MLE_If
                                                 uu____12934
                                                in
                                             FStar_All.pipe_left
                                               (FStar_Extraction_ML_Syntax.with_ty
                                                  t_branch) uu____12933
                                              in
                                           let uu____12950 =
                                             FStar_Extraction_ML_Util.join
                                               then_e1.FStar_Syntax_Syntax.pos
                                               f_then f_else
                                              in
                                           (uu____12932, uu____12950,
                                             t_branch))))
                        | uu____12951 ->
                            failwith
                              "ITE pats matched but then and else expressions not found?")
                     else
                       (let uu____12969 =
                          FStar_All.pipe_right pats
                            (FStar_Util.fold_map
                               (fun compat  ->
                                  fun br  ->
                                    let uu____13068 =
                                      FStar_Syntax_Subst.open_branch br  in
                                    match uu____13068 with
                                    | (pat,when_opt,branch1) ->
                                        let uu____13113 =
                                          extract_pat g pat t_e
                                            term_as_mlexpr
                                           in
                                        (match uu____13113 with
                                         | (env,p,pat_t_compat) ->
                                             let uu____13175 =
                                               match when_opt with
                                               | FStar_Pervasives_Native.None
                                                    ->
                                                   (FStar_Pervasives_Native.None,
                                                     FStar_Extraction_ML_Syntax.E_PURE)
                                               | FStar_Pervasives_Native.Some
                                                   w ->
                                                   let w_pos =
                                                     w.FStar_Syntax_Syntax.pos
                                                      in
                                                   let uu____13198 =
                                                     term_as_mlexpr env w  in
                                                   (match uu____13198 with
                                                    | (w1,f_w,t_w) ->
                                                        let w2 =
                                                          maybe_coerce w_pos
                                                            env w1 t_w
                                                            FStar_Extraction_ML_Syntax.ml_bool_ty
                                                           in
                                                        ((FStar_Pervasives_Native.Some
                                                            w2), f_w))
                                                in
                                             (match uu____13175 with
                                              | (when_opt1,f_when) ->
                                                  let uu____13248 =
                                                    term_as_mlexpr env
                                                      branch1
                                                     in
                                                  (match uu____13248 with
                                                   | (mlbranch,f_branch,t_branch)
                                                       ->
                                                       let uu____13283 =
                                                         FStar_All.pipe_right
                                                           p
                                                           (FStar_List.map
                                                              (fun
                                                                 uu____13360 
                                                                 ->
                                                                 match uu____13360
                                                                 with
                                                                 | (p1,wopt)
                                                                    ->
                                                                    let when_clause
                                                                    =
                                                                    FStar_Extraction_ML_Util.conjoin_opt
                                                                    wopt
                                                                    when_opt1
                                                                     in
                                                                    (p1,
                                                                    (when_clause,
                                                                    f_when),
                                                                    (mlbranch,
                                                                    f_branch,
                                                                    t_branch))))
                                                          in
                                                       ((compat &&
                                                           pat_t_compat),
                                                         uu____13283)))))
                               true)
                           in
                        match uu____12969 with
                        | (pat_t_compat,mlbranches) ->
                            let mlbranches1 = FStar_List.flatten mlbranches
                               in
                            let e1 =
                              if pat_t_compat
                              then e
                              else
                                (FStar_Extraction_ML_UEnv.debug g
                                   (fun uu____13531  ->
                                      let uu____13532 =
                                        FStar_Extraction_ML_Code.string_of_mlexpr
                                          g.FStar_Extraction_ML_UEnv.currentModule
                                          e
                                         in
                                      let uu____13534 =
                                        FStar_Extraction_ML_Code.string_of_mlty
                                          g.FStar_Extraction_ML_UEnv.currentModule
                                          t_e
                                         in
                                      FStar_Util.print2
                                        "Coercing scrutinee %s from type %s because pattern type is incompatible\n"
                                        uu____13532 uu____13534);
                                 FStar_All.pipe_left
                                   (FStar_Extraction_ML_Syntax.with_ty t_e)
                                   (FStar_Extraction_ML_Syntax.MLE_Coerce
                                      (e, t_e,
                                        FStar_Extraction_ML_Syntax.MLTY_Top)))
                               in
                            (match mlbranches1 with
                             | [] ->
                                 let uu____13561 =
                                   let uu____13562 =
                                     FStar_Syntax_Syntax.lid_as_fv
                                       FStar_Parser_Const.failwith_lid
                                       FStar_Syntax_Syntax.delta_constant
                                       FStar_Pervasives_Native.None
                                      in
                                   FStar_Extraction_ML_UEnv.lookup_fv g
                                     uu____13562
                                    in
                                 (match uu____13561 with
                                  | {
                                      FStar_Extraction_ML_UEnv.exp_b_name =
                                        uu____13569;
                                      FStar_Extraction_ML_UEnv.exp_b_expr =
                                        fw;
                                      FStar_Extraction_ML_UEnv.exp_b_tscheme
                                        = uu____13571;
                                      FStar_Extraction_ML_UEnv.exp_b_inst_ok
                                        = uu____13572;_}
                                      ->
                                      let uu____13575 =
                                        let uu____13576 =
                                          let uu____13577 =
                                            let uu____13584 =
                                              let uu____13587 =
                                                FStar_All.pipe_left
                                                  (FStar_Extraction_ML_Syntax.with_ty
                                                     FStar_Extraction_ML_Syntax.ml_string_ty)
                                                  (FStar_Extraction_ML_Syntax.MLE_Const
                                                     (FStar_Extraction_ML_Syntax.MLC_String
                                                        "unreachable"))
                                                 in
                                              [uu____13587]  in
                                            (fw, uu____13584)  in
                                          FStar_Extraction_ML_Syntax.MLE_App
                                            uu____13577
                                           in
                                        FStar_All.pipe_left
                                          (FStar_Extraction_ML_Syntax.with_ty
                                             FStar_Extraction_ML_Syntax.ml_int_ty)
                                          uu____13576
                                         in
                                      (uu____13575,
                                        FStar_Extraction_ML_Syntax.E_PURE,
                                        FStar_Extraction_ML_Syntax.ml_int_ty))
                             | (uu____13591,uu____13592,(uu____13593,f_first,t_first))::rest
                                 ->
                                 let uu____13653 =
                                   FStar_List.fold_left
                                     (fun uu____13695  ->
                                        fun uu____13696  ->
                                          match (uu____13695, uu____13696)
                                          with
                                          | ((topt,f),(uu____13753,uu____13754,
                                                       (uu____13755,f_branch,t_branch)))
                                              ->
                                              let f1 =
                                                FStar_Extraction_ML_Util.join
                                                  top.FStar_Syntax_Syntax.pos
                                                  f f_branch
                                                 in
                                              let topt1 =
                                                match topt with
                                                | FStar_Pervasives_Native.None
                                                     ->
                                                    FStar_Pervasives_Native.None
                                                | FStar_Pervasives_Native.Some
                                                    t1 ->
                                                    let uu____13811 =
                                                      type_leq g t1 t_branch
                                                       in
                                                    if uu____13811
                                                    then
                                                      FStar_Pervasives_Native.Some
                                                        t_branch
                                                    else
                                                      (let uu____13818 =
                                                         type_leq g t_branch
                                                           t1
                                                          in
                                                       if uu____13818
                                                       then
                                                         FStar_Pervasives_Native.Some
                                                           t1
                                                       else
                                                         FStar_Pervasives_Native.None)
                                                 in
                                              (topt1, f1))
                                     ((FStar_Pervasives_Native.Some t_first),
                                       f_first) rest
                                    in
                                 (match uu____13653 with
                                  | (topt,f_match) ->
                                      let mlbranches2 =
                                        FStar_All.pipe_right mlbranches1
                                          (FStar_List.map
                                             (fun uu____13916  ->
                                                match uu____13916 with
                                                | (p,(wopt,uu____13945),
                                                   (b1,uu____13947,t1)) ->
                                                    let b2 =
                                                      match topt with
                                                      | FStar_Pervasives_Native.None
                                                           ->
                                                          FStar_Extraction_ML_Syntax.apply_obj_repr
                                                            b1 t1
                                                      | FStar_Pervasives_Native.Some
                                                          uu____13966 -> b1
                                                       in
                                                    (p, wopt, b2)))
                                         in
                                      let t_match =
                                        match topt with
                                        | FStar_Pervasives_Native.None  ->
                                            FStar_Extraction_ML_Syntax.MLTY_Top
                                        | FStar_Pervasives_Native.Some t1 ->
                                            t1
                                         in
                                      let uu____13971 =
                                        FStar_All.pipe_left
                                          (FStar_Extraction_ML_Syntax.with_ty
                                             t_match)
                                          (FStar_Extraction_ML_Syntax.MLE_Match
                                             (e1, mlbranches2))
                                         in
                                      (uu____13971, f_match, t_match)))))))

let (ind_discriminator_body :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Ident.lident ->
      FStar_Ident.lident -> FStar_Extraction_ML_Syntax.mlmodule1)
  =
  fun env  ->
    fun discName  ->
      fun constrName  ->
        let uu____13998 =
          let uu____14003 =
            FStar_TypeChecker_Env.lookup_lid
              env.FStar_Extraction_ML_UEnv.tcenv discName
             in
          FStar_All.pipe_left FStar_Pervasives_Native.fst uu____14003  in
        match uu____13998 with
        | (uu____14028,fstar_disc_type) ->
            let wildcards =
              let uu____14038 =
                let uu____14039 = FStar_Syntax_Subst.compress fstar_disc_type
                   in
                uu____14039.FStar_Syntax_Syntax.n  in
              match uu____14038 with
              | FStar_Syntax_Syntax.Tm_arrow (binders,uu____14050) ->
                  let uu____14071 =
                    FStar_All.pipe_right binders
                      (FStar_List.filter
                         (fun uu___367_14105  ->
                            match uu___367_14105 with
                            | (uu____14113,FStar_Pervasives_Native.Some
                               (FStar_Syntax_Syntax.Implicit uu____14114)) ->
                                true
                            | uu____14119 -> false))
                     in
                  FStar_All.pipe_right uu____14071
                    (FStar_List.map
                       (fun uu____14155  ->
                          let uu____14162 = fresh "_"  in
                          (uu____14162, FStar_Extraction_ML_Syntax.MLTY_Top)))
              | uu____14166 -> failwith "Discriminator must be a function"
               in
            let mlid = fresh "_discr_"  in
            let targ = FStar_Extraction_ML_Syntax.MLTY_Top  in
            let disc_ty = FStar_Extraction_ML_Syntax.MLTY_Top  in
            let discrBody =
              let uu____14181 =
                let uu____14182 =
                  let uu____14194 =
                    let uu____14195 =
                      let uu____14196 =
                        let uu____14211 =
                          FStar_All.pipe_left
                            (FStar_Extraction_ML_Syntax.with_ty targ)
                            (FStar_Extraction_ML_Syntax.MLE_Name ([], mlid))
                           in
                        let uu____14217 =
                          let uu____14228 =
                            let uu____14237 =
                              let uu____14238 =
                                let uu____14245 =
                                  FStar_Extraction_ML_Syntax.mlpath_of_lident
                                    constrName
                                   in
                                (uu____14245,
                                  [FStar_Extraction_ML_Syntax.MLP_Wild])
                                 in
                              FStar_Extraction_ML_Syntax.MLP_CTor uu____14238
                               in
                            let uu____14248 =
                              FStar_All.pipe_left
                                (FStar_Extraction_ML_Syntax.with_ty
                                   FStar_Extraction_ML_Syntax.ml_bool_ty)
                                (FStar_Extraction_ML_Syntax.MLE_Const
                                   (FStar_Extraction_ML_Syntax.MLC_Bool true))
                               in
                            (uu____14237, FStar_Pervasives_Native.None,
                              uu____14248)
                             in
                          let uu____14252 =
                            let uu____14263 =
                              let uu____14272 =
                                FStar_All.pipe_left
                                  (FStar_Extraction_ML_Syntax.with_ty
                                     FStar_Extraction_ML_Syntax.ml_bool_ty)
                                  (FStar_Extraction_ML_Syntax.MLE_Const
                                     (FStar_Extraction_ML_Syntax.MLC_Bool
                                        false))
                                 in
                              (FStar_Extraction_ML_Syntax.MLP_Wild,
                                FStar_Pervasives_Native.None, uu____14272)
                               in
                            [uu____14263]  in
                          uu____14228 :: uu____14252  in
                        (uu____14211, uu____14217)  in
                      FStar_Extraction_ML_Syntax.MLE_Match uu____14196  in
                    FStar_All.pipe_left
                      (FStar_Extraction_ML_Syntax.with_ty
                         FStar_Extraction_ML_Syntax.ml_bool_ty) uu____14195
                     in
                  ((FStar_List.append wildcards [(mlid, targ)]), uu____14194)
                   in
                FStar_Extraction_ML_Syntax.MLE_Fun uu____14182  in
              FStar_All.pipe_left
                (FStar_Extraction_ML_Syntax.with_ty disc_ty) uu____14181
               in
            let uu____14333 =
              let uu____14334 =
                let uu____14337 =
                  let uu____14338 =
                    FStar_Extraction_ML_UEnv.convIdent
                      discName.FStar_Ident.ident
                     in
                  {
                    FStar_Extraction_ML_Syntax.mllb_name = uu____14338;
                    FStar_Extraction_ML_Syntax.mllb_tysc =
                      FStar_Pervasives_Native.None;
                    FStar_Extraction_ML_Syntax.mllb_add_unit = false;
                    FStar_Extraction_ML_Syntax.mllb_def = discrBody;
                    FStar_Extraction_ML_Syntax.mllb_meta = [];
                    FStar_Extraction_ML_Syntax.print_typ = false
                  }  in
                [uu____14337]  in
              (FStar_Extraction_ML_Syntax.NonRec, uu____14334)  in
            FStar_Extraction_ML_Syntax.MLM_Let uu____14333
  