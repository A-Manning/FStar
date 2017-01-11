
open Prims

let no_free_vars : FStar_Syntax_Syntax.free_vars = {FStar_Syntax_Syntax.free_names = FStar_Syntax_Syntax.no_names; FStar_Syntax_Syntax.free_uvars = FStar_Syntax_Syntax.no_uvs; FStar_Syntax_Syntax.free_univs = FStar_Syntax_Syntax.no_universe_uvars; FStar_Syntax_Syntax.free_univ_names = FStar_Syntax_Syntax.no_universe_names}


let singleton_bv : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.free_vars = (fun x -> (let _136_4 = (let _136_3 = (FStar_Syntax_Syntax.new_bv_set ())
in (FStar_Util.set_add x _136_3))
in {FStar_Syntax_Syntax.free_names = _136_4; FStar_Syntax_Syntax.free_uvars = FStar_Syntax_Syntax.no_uvs; FStar_Syntax_Syntax.free_univs = FStar_Syntax_Syntax.no_universe_uvars; FStar_Syntax_Syntax.free_univ_names = FStar_Syntax_Syntax.no_universe_names}))


let singleton_uv : ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax FStar_Syntax_Syntax.uvar_basis FStar_Unionfind.uvar * (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax)  ->  FStar_Syntax_Syntax.free_vars = (fun x -> (let _136_8 = (let _136_7 = (FStar_Syntax_Syntax.new_uv_set ())
in (FStar_Util.set_add x _136_7))
in {FStar_Syntax_Syntax.free_names = FStar_Syntax_Syntax.no_names; FStar_Syntax_Syntax.free_uvars = _136_8; FStar_Syntax_Syntax.free_univs = FStar_Syntax_Syntax.no_universe_uvars; FStar_Syntax_Syntax.free_univ_names = FStar_Syntax_Syntax.no_universe_names}))


let singleton_univ : FStar_Syntax_Syntax.universe_uvar  ->  FStar_Syntax_Syntax.free_vars = (fun x -> (let _136_12 = (let _136_11 = (FStar_Syntax_Syntax.new_universe_uvar_set ())
in (FStar_Util.set_add x _136_11))
in {FStar_Syntax_Syntax.free_names = FStar_Syntax_Syntax.no_names; FStar_Syntax_Syntax.free_uvars = FStar_Syntax_Syntax.no_uvs; FStar_Syntax_Syntax.free_univs = _136_12; FStar_Syntax_Syntax.free_univ_names = FStar_Syntax_Syntax.no_universe_names}))


let singleton_univ_name : FStar_Syntax_Syntax.univ_name  ->  FStar_Syntax_Syntax.free_vars = (fun x -> (let _136_16 = (let _136_15 = (FStar_Syntax_Syntax.new_universe_names_fifo_set ())
in (FStar_Util.fifo_set_add x _136_15))
in {FStar_Syntax_Syntax.free_names = FStar_Syntax_Syntax.no_names; FStar_Syntax_Syntax.free_uvars = FStar_Syntax_Syntax.no_uvs; FStar_Syntax_Syntax.free_univs = FStar_Syntax_Syntax.no_universe_uvars; FStar_Syntax_Syntax.free_univ_names = _136_16}))


let union : FStar_Syntax_Syntax.free_vars  ->  FStar_Syntax_Syntax.free_vars  ->  FStar_Syntax_Syntax.free_vars = (fun f1 f2 -> (let _136_24 = (FStar_Util.set_union f1.FStar_Syntax_Syntax.free_names f2.FStar_Syntax_Syntax.free_names)
in (let _136_23 = (FStar_Util.set_union f1.FStar_Syntax_Syntax.free_uvars f2.FStar_Syntax_Syntax.free_uvars)
in (let _136_22 = (FStar_Util.set_union f1.FStar_Syntax_Syntax.free_univs f2.FStar_Syntax_Syntax.free_univs)
in (let _136_21 = (FStar_Util.fifo_set_union f1.FStar_Syntax_Syntax.free_univ_names f2.FStar_Syntax_Syntax.free_univ_names)
in {FStar_Syntax_Syntax.free_names = _136_24; FStar_Syntax_Syntax.free_uvars = _136_23; FStar_Syntax_Syntax.free_univs = _136_22; FStar_Syntax_Syntax.free_univ_names = _136_21})))))


let rec free_univs : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.free_vars = (fun u -> (match ((FStar_Syntax_Subst.compress_univ u)) with
| (FStar_Syntax_Syntax.U_zero) | (FStar_Syntax_Syntax.U_bvar (_)) | (FStar_Syntax_Syntax.U_unknown) -> begin
no_free_vars
end
| FStar_Syntax_Syntax.U_name (uname) -> begin
(singleton_univ_name uname)
end
| FStar_Syntax_Syntax.U_succ (u) -> begin
(free_univs u)
end
| FStar_Syntax_Syntax.U_max (us) -> begin
(FStar_List.fold_left (fun out x -> (let _136_29 = (free_univs x)
in (union out _136_29))) no_free_vars us)
end
| FStar_Syntax_Syntax.U_unif (u) -> begin
(singleton_univ u)
end))


let rec free_names_and_uvs' : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.free_vars = (fun tm -> (

let aux_binders = (fun bs from_body -> (

let from_binders = (FStar_All.pipe_right bs (FStar_List.fold_left (fun n _37_31 -> (match (_37_31) with
| (x, _37_30) -> begin
(let _136_45 = (free_names_and_uvars x.FStar_Syntax_Syntax.sort)
in (union n _136_45))
end)) no_free_vars))
in (union from_binders from_body)))
in (

let t = (FStar_Syntax_Subst.compress tm)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (_37_35) -> begin
(failwith "Impossible")
end
| FStar_Syntax_Syntax.Tm_name (x) -> begin
(singleton_bv x)
end
| FStar_Syntax_Syntax.Tm_uvar (x, t) -> begin
(singleton_uv ((x), (t)))
end
| FStar_Syntax_Syntax.Tm_type (u) -> begin
(free_univs u)
end
| (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
no_free_vars
end
| FStar_Syntax_Syntax.Tm_uinst (t, us) -> begin
(

let f = (free_names_and_uvars t)
in (FStar_List.fold_left (fun out u -> (let _136_51 = (free_univs u)
in (union out _136_51))) f us))
end
| FStar_Syntax_Syntax.Tm_abs (bs, t, _37_65) -> begin
(let _136_52 = (free_names_and_uvars t)
in (aux_binders bs _136_52))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(let _136_53 = (free_names_and_uvars_comp c)
in (aux_binders bs _136_53))
end
| FStar_Syntax_Syntax.Tm_refine (bv, t) -> begin
(let _136_54 = (free_names_and_uvars t)
in (aux_binders ((((bv), (None)))::[]) _136_54))
end
| FStar_Syntax_Syntax.Tm_app (t, args) -> begin
(let _136_55 = (free_names_and_uvars t)
in (free_names_and_uvars_args args _136_55))
end
| FStar_Syntax_Syntax.Tm_match (t, pats) -> begin
(let _136_64 = (let _136_63 = (free_names_and_uvars t)
in (FStar_List.fold_left (fun n _37_88 -> (match (_37_88) with
| (p, wopt, t) -> begin
(

let n1 = (match (wopt) with
| None -> begin
no_free_vars
end
| Some (w) -> begin
(free_names_and_uvars w)
end)
in (

let n2 = (free_names_and_uvars t)
in (

let n = (let _136_61 = (FStar_Syntax_Syntax.pat_bvs p)
in (FStar_All.pipe_right _136_61 (FStar_List.fold_left (fun n x -> (let _136_60 = (free_names_and_uvars x.FStar_Syntax_Syntax.sort)
in (union n _136_60))) n)))
in (let _136_62 = (union n1 n2)
in (union n _136_62)))))
end)) _136_63))
in (FStar_All.pipe_right pats _136_64))
end
| FStar_Syntax_Syntax.Tm_ascribed (t1, FStar_Util.Inl (t2), _37_101) -> begin
(let _136_66 = (free_names_and_uvars t1)
in (let _136_65 = (free_names_and_uvars t2)
in (union _136_66 _136_65)))
end
| FStar_Syntax_Syntax.Tm_ascribed (t1, FStar_Util.Inr (c), _37_108) -> begin
(let _136_68 = (free_names_and_uvars t1)
in (let _136_67 = (free_names_and_uvars_comp c)
in (union _136_68 _136_67)))
end
| FStar_Syntax_Syntax.Tm_let (lbs, t) -> begin
(let _136_75 = (let _136_74 = (free_names_and_uvars t)
in (FStar_List.fold_left (fun n lb -> (let _136_73 = (let _136_72 = (free_names_and_uvars lb.FStar_Syntax_Syntax.lbtyp)
in (let _136_71 = (free_names_and_uvars lb.FStar_Syntax_Syntax.lbdef)
in (union _136_72 _136_71)))
in (union n _136_73))) _136_74))
in (FStar_All.pipe_right (Prims.snd lbs) _136_75))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_pattern (args)) -> begin
(let _136_76 = (free_names_and_uvars t)
in (FStar_List.fold_right free_names_and_uvars_args args _136_76))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_monadic (_37_124, t')) -> begin
(let _136_78 = (free_names_and_uvars t)
in (let _136_77 = (free_names_and_uvars t')
in (union _136_78 _136_77)))
end
| FStar_Syntax_Syntax.Tm_meta (t, _37_132) -> begin
(free_names_and_uvars t)
end))))
and free_names_and_uvars : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.free_vars = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match ((FStar_ST.read t.FStar_Syntax_Syntax.vars)) with
| Some (n) -> begin
if (should_invalidate_cache n) then begin
(

let _37_139 = (FStar_ST.op_Colon_Equals t.FStar_Syntax_Syntax.vars None)
in (free_names_and_uvars t))
end else begin
n
end
end
| _37_142 -> begin
(

let n = (free_names_and_uvs' t)
in (

let _37_144 = (FStar_ST.op_Colon_Equals t.FStar_Syntax_Syntax.vars (Some (n)))
in n))
end)))
and free_names_and_uvars_args : FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.free_vars  ->  FStar_Syntax_Syntax.free_vars = (fun args acc -> (FStar_All.pipe_right args (FStar_List.fold_left (fun n _37_152 -> (match (_37_152) with
| (x, _37_151) -> begin
(let _136_84 = (free_names_and_uvars x)
in (union n _136_84))
end)) acc)))
and free_names_and_uvars_binders = (fun bs acc -> (FStar_All.pipe_right bs (FStar_List.fold_left (fun n _37_159 -> (match (_37_159) with
| (x, _37_158) -> begin
(let _136_87 = (free_names_and_uvars x.FStar_Syntax_Syntax.sort)
in (union n _136_87))
end)) acc)))
and free_names_and_uvars_comp : FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.free_vars = (fun c -> (match ((FStar_ST.read c.FStar_Syntax_Syntax.vars)) with
| Some (n) -> begin
if (should_invalidate_cache n) then begin
(

let _37_163 = (FStar_ST.op_Colon_Equals c.FStar_Syntax_Syntax.vars None)
in (free_names_and_uvars_comp c))
end else begin
n
end
end
| _37_166 -> begin
(

let n = (match (c.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.GTotal (t, None)) | (FStar_Syntax_Syntax.Total (t, None)) -> begin
(free_names_and_uvars t)
end
| (FStar_Syntax_Syntax.GTotal (t, Some (u))) | (FStar_Syntax_Syntax.Total (t, Some (u))) -> begin
(let _136_90 = (free_univs u)
in (let _136_89 = (free_names_and_uvars t)
in (union _136_90 _136_89)))
end
| FStar_Syntax_Syntax.Comp (ct) -> begin
(

let us = (let _136_91 = (free_names_and_uvars ct.FStar_Syntax_Syntax.result_typ)
in (free_names_and_uvars_args ct.FStar_Syntax_Syntax.effect_args _136_91))
in (FStar_List.fold_left (fun us u -> (let _136_94 = (free_univs u)
in (union us _136_94))) us ct.FStar_Syntax_Syntax.comp_univs))
end)
in (

let _37_188 = (FStar_ST.op_Colon_Equals c.FStar_Syntax_Syntax.vars (Some (n)))
in n))
end))
and should_invalidate_cache : FStar_Syntax_Syntax.free_vars  ->  Prims.bool = (fun n -> ((let _136_97 = (FStar_All.pipe_right n.FStar_Syntax_Syntax.free_uvars FStar_Util.set_elements)
in (FStar_All.pipe_right _136_97 (FStar_Util.for_some (fun _37_194 -> (match (_37_194) with
| (u, _37_193) -> begin
(match ((FStar_Unionfind.find u)) with
| FStar_Syntax_Syntax.Fixed (_37_196) -> begin
true
end
| _37_199 -> begin
false
end)
end))))) || (let _136_99 = (FStar_All.pipe_right n.FStar_Syntax_Syntax.free_univs FStar_Util.set_elements)
in (FStar_All.pipe_right _136_99 (FStar_Util.for_some (fun u -> (match ((FStar_Unionfind.find u)) with
| Some (_37_202) -> begin
true
end
| None -> begin
false
end)))))))


let names : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.bv FStar_Util.set = (fun t -> (let _136_102 = (free_names_and_uvars t)
in _136_102.FStar_Syntax_Syntax.free_names))


let uvars : FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ) FStar_Util.set = (fun t -> (let _136_105 = (free_names_and_uvars t)
in _136_105.FStar_Syntax_Syntax.free_uvars))


let univs : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe_uvar FStar_Util.set = (fun t -> (let _136_108 = (free_names_and_uvars t)
in _136_108.FStar_Syntax_Syntax.free_univs))


let univnames : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.univ_name FStar_Util.set = (fun t -> (let _136_111 = (free_names_and_uvars t)
in _136_111.FStar_Syntax_Syntax.free_univ_names))


let names_of_binders : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.bv FStar_Util.set = (fun bs -> (let _136_114 = (free_names_and_uvars_binders bs no_free_vars)
in _136_114.FStar_Syntax_Syntax.free_names))




