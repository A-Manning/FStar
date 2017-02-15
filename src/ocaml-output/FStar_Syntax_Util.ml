
open Prims

let qual_id : FStar_Ident.lident  ->  FStar_Ident.ident  ->  FStar_Ident.lident = (fun lid id -> (let _0_193 = (FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns ((lid.FStar_Ident.ident)::(id)::[])))
in (FStar_Ident.set_lid_range _0_193 id.FStar_Ident.idRange)))


let mk_discriminator : FStar_Ident.lident  ->  FStar_Ident.lident = (fun lid -> (FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns (((FStar_Ident.mk_ident (((Prims.strcat FStar_Ident.reserved_prefix (Prims.strcat "is_" lid.FStar_Ident.ident.FStar_Ident.idText))), (lid.FStar_Ident.ident.FStar_Ident.idRange))))::[]))))


let is_name : FStar_Ident.lident  ->  Prims.bool = (fun lid -> (

let c = (FStar_Util.char_at lid.FStar_Ident.ident.FStar_Ident.idText (Prims.parse_int "0"))
in (FStar_Util.is_upper c)))


let arg_of_non_null_binder = (fun uu____24 -> (match (uu____24) with
| (b, imp) -> begin
(let _0_194 = (FStar_Syntax_Syntax.bv_to_name b)
in ((_0_194), (imp)))
end))


let args_of_non_null_binders : FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.aqual) Prims.list = (fun binders -> (FStar_All.pipe_right binders (FStar_List.collect (fun b -> (

let uu____41 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____41) with
| true -> begin
[]
end
| uu____47 -> begin
(let _0_195 = (arg_of_non_null_binder b)
in (_0_195)::[])
end))))))


let args_of_binders : FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.args) = (fun binders -> (let _0_199 = (FStar_All.pipe_right binders (FStar_List.map (fun b -> (

let uu____88 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____88) with
| true -> begin
(

let b = (let _0_196 = (FStar_Syntax_Syntax.new_bv None (Prims.fst b).FStar_Syntax_Syntax.sort)
in ((_0_196), ((Prims.snd b))))
in (let _0_197 = (arg_of_non_null_binder b)
in ((b), (_0_197))))
end
| uu____102 -> begin
(let _0_198 = (arg_of_non_null_binder b)
in ((b), (_0_198)))
end)))))
in (FStar_All.pipe_right _0_199 FStar_List.unzip)))


let name_binders : FStar_Syntax_Syntax.binder Prims.list  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list = (fun binders -> (FStar_All.pipe_right binders (FStar_List.mapi (fun i b -> (

let uu____125 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____125) with
| true -> begin
(

let uu____128 = b
in (match (uu____128) with
| (a, imp) -> begin
(

let b = (FStar_Ident.id_of_text (let _0_200 = (FStar_Util.string_of_int i)
in (Prims.strcat "_" _0_200)))
in (

let b = {FStar_Syntax_Syntax.ppname = b; FStar_Syntax_Syntax.index = (Prims.parse_int "0"); FStar_Syntax_Syntax.sort = a.FStar_Syntax_Syntax.sort}
in ((b), (imp))))
end))
end
| uu____135 -> begin
b
end))))))


let name_function_binders = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (binders, comp) -> begin
((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((let _0_201 = (name_binders binders)
in ((_0_201), (comp)))))) None t.FStar_Syntax_Syntax.pos)
end
| uu____174 -> begin
t
end))


let null_binders_of_tks : (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.aqual) Prims.list  ->  FStar_Syntax_Syntax.binders = (fun tks -> (FStar_All.pipe_right tks (FStar_List.map (fun uu____194 -> (match (uu____194) with
| (t, imp) -> begin
(let _0_203 = (let _0_202 = (FStar_Syntax_Syntax.null_binder t)
in (FStar_All.pipe_left Prims.fst _0_202))
in ((_0_203), (imp)))
end)))))


let binders_of_tks : (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.aqual) Prims.list  ->  FStar_Syntax_Syntax.binders = (fun tks -> (FStar_All.pipe_right tks (FStar_List.map (fun uu____224 -> (match (uu____224) with
| (t, imp) -> begin
(let _0_204 = (FStar_Syntax_Syntax.new_bv (Some (t.FStar_Syntax_Syntax.pos)) t)
in ((_0_204), (imp)))
end)))))


let binders_of_freevars : FStar_Syntax_Syntax.bv FStar_Util.set  ->  FStar_Syntax_Syntax.binder Prims.list = (fun fvs -> (let _0_205 = (FStar_Util.set_elements fvs)
in (FStar_All.pipe_right _0_205 (FStar_List.map FStar_Syntax_Syntax.mk_binder))))


let mk_subst = (fun s -> (s)::[])


let subst_of_list : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.subst_t = (fun formals actuals -> (match (((FStar_List.length formals) = (FStar_List.length actuals))) with
| true -> begin
(FStar_List.fold_right2 (fun f a out -> (FStar_Syntax_Syntax.NT ((((Prims.fst f)), ((Prims.fst a)))))::out) formals actuals [])
end
| uu____290 -> begin
(failwith "Ill-formed substitution")
end))


let rename_binders : FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.subst_t = (fun replace_xs with_ys -> (match (((FStar_List.length replace_xs) = (FStar_List.length with_ys))) with
| true -> begin
(FStar_List.map2 (fun uu____309 uu____310 -> (match (((uu____309), (uu____310))) with
| ((x, uu____320), (y, uu____322)) -> begin
FStar_Syntax_Syntax.NT ((let _0_206 = (FStar_Syntax_Syntax.bv_to_name y)
in ((x), (_0_206))))
end)) replace_xs with_ys)
end
| uu____327 -> begin
(failwith "Ill-formed substitution")
end))


let rec unmeta : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun e -> (

let e = (FStar_Syntax_Subst.compress e)
in (match (e.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_meta (e, _)) | (FStar_Syntax_Syntax.Tm_ascribed (e, _, _)) -> begin
(unmeta e)
end
| uu____351 -> begin
e
end)))


let rec univ_kernel : FStar_Syntax_Syntax.universe  ->  (FStar_Syntax_Syntax.universe * Prims.int) = (fun u -> (match (u) with
| (FStar_Syntax_Syntax.U_unknown) | (FStar_Syntax_Syntax.U_name (_)) | (FStar_Syntax_Syntax.U_unif (_)) | (FStar_Syntax_Syntax.U_zero) -> begin
((u), ((Prims.parse_int "0")))
end
| FStar_Syntax_Syntax.U_succ (u) -> begin
(

let uu____362 = (univ_kernel u)
in (match (uu____362) with
| (k, n) -> begin
((k), ((n + (Prims.parse_int "1"))))
end))
end
| FStar_Syntax_Syntax.U_max (uu____369) -> begin
(failwith "Imposible: univ_kernel (U_max _)")
end
| FStar_Syntax_Syntax.U_bvar (uu____373) -> begin
(failwith "Imposible: univ_kernel (U_bvar _)")
end))


let constant_univ_as_nat : FStar_Syntax_Syntax.universe  ->  Prims.int = (fun u -> (Prims.snd (univ_kernel u)))


let rec compare_univs : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  Prims.int = (fun u1 u2 -> (match (((u1), (u2))) with
| ((FStar_Syntax_Syntax.U_bvar (_), _)) | ((_, FStar_Syntax_Syntax.U_bvar (_))) -> begin
(failwith "Impossible: compare_univs")
end
| (FStar_Syntax_Syntax.U_unknown, FStar_Syntax_Syntax.U_unknown) -> begin
(Prims.parse_int "0")
end
| (FStar_Syntax_Syntax.U_unknown, uu____389) -> begin
(~- ((Prims.parse_int "1")))
end
| (uu____390, FStar_Syntax_Syntax.U_unknown) -> begin
(Prims.parse_int "1")
end
| (FStar_Syntax_Syntax.U_zero, FStar_Syntax_Syntax.U_zero) -> begin
(Prims.parse_int "0")
end
| (FStar_Syntax_Syntax.U_zero, uu____391) -> begin
(~- ((Prims.parse_int "1")))
end
| (uu____392, FStar_Syntax_Syntax.U_zero) -> begin
(Prims.parse_int "1")
end
| (FStar_Syntax_Syntax.U_name (u1), FStar_Syntax_Syntax.U_name (u2)) -> begin
(FStar_String.compare u1.FStar_Ident.idText u2.FStar_Ident.idText)
end
| (FStar_Syntax_Syntax.U_name (uu____395), FStar_Syntax_Syntax.U_unif (uu____396)) -> begin
(~- ((Prims.parse_int "1")))
end
| (FStar_Syntax_Syntax.U_unif (uu____399), FStar_Syntax_Syntax.U_name (uu____400)) -> begin
(Prims.parse_int "1")
end
| (FStar_Syntax_Syntax.U_unif (u1), FStar_Syntax_Syntax.U_unif (u2)) -> begin
(let _0_208 = (FStar_Unionfind.uvar_id u1)
in (let _0_207 = (FStar_Unionfind.uvar_id u2)
in (_0_208 - _0_207)))
end
| (FStar_Syntax_Syntax.U_max (us1), FStar_Syntax_Syntax.U_max (us2)) -> begin
(

let n1 = (FStar_List.length us1)
in (

let n2 = (FStar_List.length us2)
in (match ((n1 <> n2)) with
| true -> begin
(n1 - n2)
end
| uu____428 -> begin
(

let copt = (let _0_209 = (FStar_List.zip us1 us2)
in (FStar_Util.find_map _0_209 (fun uu____433 -> (match (uu____433) with
| (u1, u2) -> begin
(

let c = (compare_univs u1 u2)
in (match ((c <> (Prims.parse_int "0"))) with
| true -> begin
Some (c)
end
| uu____441 -> begin
None
end))
end))))
in (match (copt) with
| None -> begin
(Prims.parse_int "0")
end
| Some (c) -> begin
c
end))
end)))
end
| (FStar_Syntax_Syntax.U_max (uu____443), uu____444) -> begin
(~- ((Prims.parse_int "1")))
end
| (uu____446, FStar_Syntax_Syntax.U_max (uu____447)) -> begin
(Prims.parse_int "1")
end
| uu____449 -> begin
(

let uu____452 = (univ_kernel u1)
in (match (uu____452) with
| (k1, n1) -> begin
(

let uu____457 = (univ_kernel u2)
in (match (uu____457) with
| (k2, n2) -> begin
(

let r = (compare_univs k1 k2)
in (match ((r = (Prims.parse_int "0"))) with
| true -> begin
(n1 - n2)
end
| uu____463 -> begin
r
end))
end))
end))
end))


let eq_univs : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  Prims.bool = (fun u1 u2 -> (let _0_210 = (compare_univs u1 u2)
in (_0_210 = (Prims.parse_int "0"))))


let ml_comp : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.comp = (fun t r -> (FStar_Syntax_Syntax.mk_Comp {FStar_Syntax_Syntax.comp_univs = (FStar_Syntax_Syntax.U_unknown)::[]; FStar_Syntax_Syntax.effect_name = (FStar_Ident.set_lid_range FStar_Syntax_Const.effect_ML_lid r); FStar_Syntax_Syntax.result_typ = t; FStar_Syntax_Syntax.effect_args = []; FStar_Syntax_Syntax.flags = (FStar_Syntax_Syntax.MLEFFECT)::[]}))


let comp_effect_name = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (c) -> begin
c.FStar_Syntax_Syntax.effect_name
end
| FStar_Syntax_Syntax.Total (uu____496) -> begin
FStar_Syntax_Const.effect_Tot_lid
end
| FStar_Syntax_Syntax.GTotal (uu____502) -> begin
FStar_Syntax_Const.effect_GTot_lid
end))


let comp_flags = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (uu____520) -> begin
(FStar_Syntax_Syntax.TOTAL)::[]
end
| FStar_Syntax_Syntax.GTotal (uu____526) -> begin
(FStar_Syntax_Syntax.SOMETRIVIAL)::[]
end
| FStar_Syntax_Syntax.Comp (ct) -> begin
ct.FStar_Syntax_Syntax.flags
end))


let comp_set_flags : FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.cflags Prims.list  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax = (fun c f -> (

let comp_to_comp_typ = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (c) -> begin
c
end
| (FStar_Syntax_Syntax.Total (t, u_opt)) | (FStar_Syntax_Syntax.GTotal (t, u_opt)) -> begin
(let _0_212 = (let _0_211 = (FStar_Util.map_opt u_opt (fun x -> (x)::[]))
in (FStar_Util.dflt [] _0_211))
in {FStar_Syntax_Syntax.comp_univs = _0_212; FStar_Syntax_Syntax.effect_name = (comp_effect_name c); FStar_Syntax_Syntax.result_typ = t; FStar_Syntax_Syntax.effect_args = []; FStar_Syntax_Syntax.flags = (comp_flags c)})
end))
in (

let uu___175_569 = c
in (let _0_213 = FStar_Syntax_Syntax.Comp ((

let uu___176_570 = (comp_to_comp_typ c)
in {FStar_Syntax_Syntax.comp_univs = uu___176_570.FStar_Syntax_Syntax.comp_univs; FStar_Syntax_Syntax.effect_name = uu___176_570.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = uu___176_570.FStar_Syntax_Syntax.result_typ; FStar_Syntax_Syntax.effect_args = uu___176_570.FStar_Syntax_Syntax.effect_args; FStar_Syntax_Syntax.flags = f}))
in {FStar_Syntax_Syntax.n = _0_213; FStar_Syntax_Syntax.tk = uu___175_569.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = uu___175_569.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = uu___175_569.FStar_Syntax_Syntax.vars}))))


let comp_to_comp_typ : FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp_typ = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (c) -> begin
c
end
| (FStar_Syntax_Syntax.Total (t, Some (u))) | (FStar_Syntax_Syntax.GTotal (t, Some (u))) -> begin
{FStar_Syntax_Syntax.comp_univs = (u)::[]; FStar_Syntax_Syntax.effect_name = (comp_effect_name c); FStar_Syntax_Syntax.result_typ = t; FStar_Syntax_Syntax.effect_args = []; FStar_Syntax_Syntax.flags = (comp_flags c)}
end
| uu____595 -> begin
(failwith "Assertion failed: Computation type without universe")
end))


let is_named_tot = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (c) -> begin
(FStar_Ident.lid_equals c.FStar_Syntax_Syntax.effect_name FStar_Syntax_Const.effect_Tot_lid)
end
| FStar_Syntax_Syntax.Total (uu____608) -> begin
true
end
| FStar_Syntax_Syntax.GTotal (uu____614) -> begin
false
end))


let is_total_comp = (fun c -> (FStar_All.pipe_right (comp_flags c) (FStar_Util.for_some (fun uu___163_632 -> (match (uu___163_632) with
| (FStar_Syntax_Syntax.TOTAL) | (FStar_Syntax_Syntax.RETURN) -> begin
true
end
| uu____633 -> begin
false
end)))))


let is_total_lcomp : FStar_Syntax_Syntax.lcomp  ->  Prims.bool = (fun c -> ((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name FStar_Syntax_Const.effect_Tot_lid) || (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags (FStar_Util.for_some (fun uu___164_638 -> (match (uu___164_638) with
| (FStar_Syntax_Syntax.TOTAL) | (FStar_Syntax_Syntax.RETURN) -> begin
true
end
| uu____639 -> begin
false
end))))))


let is_tot_or_gtot_lcomp : FStar_Syntax_Syntax.lcomp  ->  Prims.bool = (fun c -> (((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name FStar_Syntax_Const.effect_Tot_lid) || (FStar_Ident.lid_equals c.FStar_Syntax_Syntax.eff_name FStar_Syntax_Const.effect_GTot_lid)) || (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags (FStar_Util.for_some (fun uu___165_644 -> (match (uu___165_644) with
| (FStar_Syntax_Syntax.TOTAL) | (FStar_Syntax_Syntax.RETURN) -> begin
true
end
| uu____645 -> begin
false
end))))))


let is_partial_return = (fun c -> (FStar_All.pipe_right (comp_flags c) (FStar_Util.for_some (fun uu___166_658 -> (match (uu___166_658) with
| (FStar_Syntax_Syntax.RETURN) | (FStar_Syntax_Syntax.PARTIAL_RETURN) -> begin
true
end
| uu____659 -> begin
false
end)))))


let is_lcomp_partial_return : FStar_Syntax_Syntax.lcomp  ->  Prims.bool = (fun c -> (FStar_All.pipe_right c.FStar_Syntax_Syntax.cflags (FStar_Util.for_some (fun uu___167_664 -> (match (uu___167_664) with
| (FStar_Syntax_Syntax.RETURN) | (FStar_Syntax_Syntax.PARTIAL_RETURN) -> begin
true
end
| uu____665 -> begin
false
end)))))


let is_tot_or_gtot_comp = (fun c -> ((is_total_comp c) || (FStar_Ident.lid_equals FStar_Syntax_Const.effect_GTot_lid (comp_effect_name c))))


let is_pure_effect : FStar_Ident.lident  ->  Prims.bool = (fun l -> (((FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Tot_lid) || (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_PURE_lid)) || (FStar_Ident.lid_equals l FStar_Syntax_Const.effect_Pure_lid)))


let is_pure_comp = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (uu____691) -> begin
true
end
| FStar_Syntax_Syntax.GTotal (uu____697) -> begin
false
end
| FStar_Syntax_Syntax.Comp (ct) -> begin
(((is_total_comp c) || (is_pure_effect ct.FStar_Syntax_Syntax.effect_name)) || (FStar_All.pipe_right ct.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun uu___168_705 -> (match (uu___168_705) with
| FStar_Syntax_Syntax.LEMMA -> begin
true
end
| uu____706 -> begin
false
end)))))
end))


let is_ghost_effect : FStar_Ident.lident  ->  Prims.bool = (fun l -> (((FStar_Ident.lid_equals FStar_Syntax_Const.effect_GTot_lid l) || (FStar_Ident.lid_equals FStar_Syntax_Const.effect_GHOST_lid l)) || (FStar_Ident.lid_equals FStar_Syntax_Const.effect_Ghost_lid l)))


let is_pure_or_ghost_comp = (fun c -> ((is_pure_comp c) || (is_ghost_effect (comp_effect_name c))))


let is_pure_lcomp : FStar_Syntax_Syntax.lcomp  ->  Prims.bool = (fun lc -> (((is_total_lcomp lc) || (is_pure_effect lc.FStar_Syntax_Syntax.eff_name)) || (FStar_All.pipe_right lc.FStar_Syntax_Syntax.cflags (FStar_Util.for_some (fun uu___169_725 -> (match (uu___169_725) with
| FStar_Syntax_Syntax.LEMMA -> begin
true
end
| uu____726 -> begin
false
end))))))


let is_pure_or_ghost_lcomp : FStar_Syntax_Syntax.lcomp  ->  Prims.bool = (fun lc -> ((is_pure_lcomp lc) || (is_ghost_effect lc.FStar_Syntax_Syntax.eff_name)))


let is_pure_or_ghost_function : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____733 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____733) with
| FStar_Syntax_Syntax.Tm_arrow (uu____734, c) -> begin
(is_pure_or_ghost_comp c)
end
| uu____746 -> begin
true
end)))


let is_lemma : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____750 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____750) with
| FStar_Syntax_Syntax.Tm_arrow (uu____751, c) -> begin
(match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (ct) -> begin
(FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name FStar_Syntax_Const.effect_Lemma_lid)
end
| uu____764 -> begin
false
end)
end
| uu____765 -> begin
false
end)))


let head_and_args : FStar_Syntax_Syntax.term  ->  ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list) = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
((head), (args))
end
| uu____811 -> begin
((t), ([]))
end)))


let un_uinst : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uinst (t, uu____826) -> begin
(FStar_Syntax_Subst.compress t)
end
| uu____831 -> begin
t
end)))


let is_smt_lemma : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____835 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____835) with
| FStar_Syntax_Syntax.Tm_arrow (uu____836, c) -> begin
(match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (ct) when (FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name FStar_Syntax_Const.effect_Lemma_lid) -> begin
(match (ct.FStar_Syntax_Syntax.effect_args) with
| (_req)::(_ens)::((pats, uu____852))::uu____853 -> begin
(

let pats' = (unmeta pats)
in (

let uu____884 = (head_and_args pats')
in (match (uu____884) with
| (head, uu____895) -> begin
(

let uu____910 = (un_uinst head).FStar_Syntax_Syntax.n
in (match (uu____910) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.cons_lid)
end
| uu____912 -> begin
false
end))
end)))
end
| uu____913 -> begin
false
end)
end
| uu____919 -> begin
false
end)
end
| uu____920 -> begin
false
end)))


let is_ml_comp = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp (c) -> begin
((FStar_Ident.lid_equals c.FStar_Syntax_Syntax.effect_name FStar_Syntax_Const.effect_ML_lid) || (FStar_All.pipe_right c.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun uu___170_934 -> (match (uu___170_934) with
| FStar_Syntax_Syntax.MLEFFECT -> begin
true
end
| uu____935 -> begin
false
end)))))
end
| uu____936 -> begin
false
end))


let comp_result = (fun c -> (match (c.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Total (t, _)) | (FStar_Syntax_Syntax.GTotal (t, _)) -> begin
t
end
| FStar_Syntax_Syntax.Comp (ct) -> begin
ct.FStar_Syntax_Syntax.result_typ
end))


let set_result_typ = (fun c t -> (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (uu____980) -> begin
(FStar_Syntax_Syntax.mk_Total t)
end
| FStar_Syntax_Syntax.GTotal (uu____986) -> begin
(FStar_Syntax_Syntax.mk_GTotal t)
end
| FStar_Syntax_Syntax.Comp (ct) -> begin
(FStar_Syntax_Syntax.mk_Comp (

let uu___177_993 = ct
in {FStar_Syntax_Syntax.comp_univs = uu___177_993.FStar_Syntax_Syntax.comp_univs; FStar_Syntax_Syntax.effect_name = uu___177_993.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = t; FStar_Syntax_Syntax.effect_args = uu___177_993.FStar_Syntax_Syntax.effect_args; FStar_Syntax_Syntax.flags = uu___177_993.FStar_Syntax_Syntax.flags}))
end))


let is_trivial_wp = (fun c -> (FStar_All.pipe_right (comp_flags c) (FStar_Util.for_some (fun uu___171_1006 -> (match (uu___171_1006) with
| (FStar_Syntax_Syntax.TOTAL) | (FStar_Syntax_Syntax.RETURN) -> begin
true
end
| uu____1007 -> begin
false
end)))))


let primops : FStar_Ident.lident Prims.list = (FStar_Syntax_Const.op_Eq)::(FStar_Syntax_Const.op_notEq)::(FStar_Syntax_Const.op_LT)::(FStar_Syntax_Const.op_LTE)::(FStar_Syntax_Const.op_GT)::(FStar_Syntax_Const.op_GTE)::(FStar_Syntax_Const.op_Subtraction)::(FStar_Syntax_Const.op_Minus)::(FStar_Syntax_Const.op_Addition)::(FStar_Syntax_Const.op_Multiply)::(FStar_Syntax_Const.op_Division)::(FStar_Syntax_Const.op_Modulus)::(FStar_Syntax_Const.op_And)::(FStar_Syntax_Const.op_Or)::(FStar_Syntax_Const.op_Negation)::[]


let is_primop_lid : FStar_Ident.lident  ->  Prims.bool = (fun l -> (FStar_All.pipe_right primops (FStar_Util.for_some (FStar_Ident.lid_equals l))))


let is_primop = (fun f -> (match (f.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(is_primop_lid fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end
| uu____1029 -> begin
false
end))


let rec unascribe : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun e -> (

let e = (FStar_Syntax_Subst.compress e)
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_ascribed (e, uu____1035, uu____1036) -> begin
(unascribe e)
end
| uu____1055 -> begin
e
end)))


let rec ascribe = (fun t k -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_ascribed (t', uu____1087, uu____1088) -> begin
(ascribe t' k)
end
| uu____1107 -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed (((t), (k), (None)))) None t.FStar_Syntax_Syntax.pos)
end))

type eq_result =
| Equal
| NotEqual
| Unknown


let uu___is_Equal : eq_result  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Equal -> begin
true
end
| uu____1124 -> begin
false
end))


let uu___is_NotEqual : eq_result  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NotEqual -> begin
true
end
| uu____1128 -> begin
false
end))


let uu___is_Unknown : eq_result  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Unknown -> begin
true
end
| uu____1132 -> begin
false
end))


let rec eq_tm : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  eq_result = (fun t1 t2 -> (

let t1 = (unascribe t1)
in (

let t2 = (unascribe t2)
in (

let equal_if = (fun uu___172_1152 -> (match (uu___172_1152) with
| true -> begin
Equal
end
| uu____1153 -> begin
Unknown
end))
in (

let equal_iff = (fun uu___173_1157 -> (match (uu___173_1157) with
| true -> begin
Equal
end
| uu____1158 -> begin
NotEqual
end))
in (

let eq_and = (fun f g -> (match (f) with
| Equal -> begin
(g ())
end
| uu____1171 -> begin
Unknown
end))
in (match (((t1.FStar_Syntax_Syntax.n), (t2.FStar_Syntax_Syntax.n))) with
| (FStar_Syntax_Syntax.Tm_name (a), FStar_Syntax_Syntax.Tm_name (b)) -> begin
(equal_if (FStar_Syntax_Syntax.bv_eq a b))
end
| (FStar_Syntax_Syntax.Tm_fvar (f), FStar_Syntax_Syntax.Tm_fvar (g)) -> begin
(equal_if (FStar_Syntax_Syntax.fv_eq f g))
end
| (FStar_Syntax_Syntax.Tm_uinst (f, us), FStar_Syntax_Syntax.Tm_uinst (g, vs)) -> begin
(let _0_214 = (eq_tm f g)
in (eq_and _0_214 (fun uu____1188 -> (equal_if (eq_univs_list us vs)))))
end
| (FStar_Syntax_Syntax.Tm_constant (c), FStar_Syntax_Syntax.Tm_constant (d)) -> begin
(equal_iff (FStar_Const.eq_const c d))
end
| (FStar_Syntax_Syntax.Tm_uvar (u1, uu____1192), FStar_Syntax_Syntax.Tm_uvar (u2, uu____1194)) -> begin
(equal_if (FStar_Unionfind.equivalent u1 u2))
end
| (FStar_Syntax_Syntax.Tm_app (h1, args1), FStar_Syntax_Syntax.Tm_app (h2, args2)) -> begin
(let _0_215 = (eq_tm h1 h2)
in (eq_and _0_215 (fun uu____1254 -> (eq_args args1 args2))))
end
| (FStar_Syntax_Syntax.Tm_type (u), FStar_Syntax_Syntax.Tm_type (v)) -> begin
(equal_if (eq_univs u v))
end
| (FStar_Syntax_Syntax.Tm_meta (t1, uu____1258), uu____1259) -> begin
(eq_tm t1 t2)
end
| (uu____1264, FStar_Syntax_Syntax.Tm_meta (t2, uu____1266)) -> begin
(eq_tm t1 t2)
end
| uu____1271 -> begin
Unknown
end)))))))
and eq_args : FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.args  ->  eq_result = (fun a1 a2 -> (match (((a1), (a2))) with
| ([], []) -> begin
Equal
end
| (((a, uu____1295))::a1, ((b, uu____1298))::b1) -> begin
(

let uu____1336 = (eq_tm a b)
in (match (uu____1336) with
| Equal -> begin
(eq_args a1 b1)
end
| uu____1337 -> begin
Unknown
end))
end
| uu____1338 -> begin
Unknown
end))
and eq_univs_list : FStar_Syntax_Syntax.universes  ->  FStar_Syntax_Syntax.universes  ->  Prims.bool = (fun us vs -> (((FStar_List.length us) = (FStar_List.length vs)) && (FStar_List.forall2 eq_univs us vs)))


let rec unrefine : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_refine (x, uu____1352) -> begin
(unrefine x.FStar_Syntax_Syntax.sort)
end
| FStar_Syntax_Syntax.Tm_ascribed (t, uu____1358, uu____1359) -> begin
(unrefine t)
end
| uu____1378 -> begin
t
end)))


let rec is_unit : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____1382 = (unrefine t).FStar_Syntax_Syntax.n
in (match (uu____1382) with
| FStar_Syntax_Syntax.Tm_type (uu____1383) -> begin
true
end
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid))
end
| FStar_Syntax_Syntax.Tm_uinst (t, uu____1386) -> begin
(is_unit t)
end
| uu____1391 -> begin
false
end)))


let rec non_informative : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____1395 = (unrefine t).FStar_Syntax_Syntax.n
in (match (uu____1395) with
| FStar_Syntax_Syntax.Tm_type (uu____1396) -> begin
true
end
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.squash_lid)) || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.erased_lid))
end
| FStar_Syntax_Syntax.Tm_app (head, uu____1399) -> begin
(non_informative head)
end
| FStar_Syntax_Syntax.Tm_uinst (t, uu____1415) -> begin
(non_informative t)
end
| FStar_Syntax_Syntax.Tm_arrow (uu____1420, c) -> begin
((is_tot_or_gtot_comp c) && (non_informative (comp_result c)))
end
| uu____1432 -> begin
false
end)))


let is_fun : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun e -> (

let uu____1436 = (FStar_Syntax_Subst.compress e).FStar_Syntax_Syntax.n
in (match (uu____1436) with
| FStar_Syntax_Syntax.Tm_abs (uu____1437) -> begin
true
end
| uu____1452 -> begin
false
end)))


let is_function_typ : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____1456 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____1456) with
| FStar_Syntax_Syntax.Tm_arrow (uu____1457) -> begin
true
end
| uu____1465 -> begin
false
end)))


let rec pre_typ : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_refine (x, uu____1471) -> begin
(pre_typ x.FStar_Syntax_Syntax.sort)
end
| FStar_Syntax_Syntax.Tm_ascribed (t, uu____1477, uu____1478) -> begin
(pre_typ t)
end
| uu____1497 -> begin
t
end)))


let destruct : FStar_Syntax_Syntax.term  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list Prims.option = (fun typ lid -> (

let typ = (FStar_Syntax_Subst.compress typ)
in (

let uu____1511 = (un_uinst typ).FStar_Syntax_Syntax.n
in (match (uu____1511) with
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let head = (un_uinst head)
in (match (head.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (tc) when (FStar_Syntax_Syntax.fv_eq_lid tc lid) -> begin
Some (args)
end
| uu____1547 -> begin
None
end))
end
| FStar_Syntax_Syntax.Tm_fvar (tc) when (FStar_Syntax_Syntax.fv_eq_lid tc lid) -> begin
Some ([])
end
| uu____1563 -> begin
None
end))))


let lids_of_sigelt : FStar_Syntax_Syntax.sigelt  ->  FStar_Ident.lident Prims.list = (fun se -> (match (se) with
| (FStar_Syntax_Syntax.Sig_let (_, _, lids, _, _)) | (FStar_Syntax_Syntax.Sig_bundle (_, _, lids, _)) -> begin
lids
end
| (FStar_Syntax_Syntax.Sig_inductive_typ (lid, _, _, _, _, _, _, _)) | (FStar_Syntax_Syntax.Sig_effect_abbrev (lid, _, _, _, _, _, _)) | (FStar_Syntax_Syntax.Sig_datacon (lid, _, _, _, _, _, _, _)) | (FStar_Syntax_Syntax.Sig_declare_typ (lid, _, _, _, _)) | (FStar_Syntax_Syntax.Sig_assume (lid, _, _, _)) -> begin
(lid)::[]
end
| (FStar_Syntax_Syntax.Sig_new_effect_for_free (n, _)) | (FStar_Syntax_Syntax.Sig_new_effect (n, _)) -> begin
(n.FStar_Syntax_Syntax.mname)::[]
end
| (FStar_Syntax_Syntax.Sig_sub_effect (_)) | (FStar_Syntax_Syntax.Sig_pragma (_)) | (FStar_Syntax_Syntax.Sig_main (_)) -> begin
[]
end))


let lid_of_sigelt : FStar_Syntax_Syntax.sigelt  ->  FStar_Ident.lident Prims.option = (fun se -> (match ((lids_of_sigelt se)) with
| (l)::[] -> begin
Some (l)
end
| uu____1640 -> begin
None
end))


let quals_of_sigelt : FStar_Syntax_Syntax.sigelt  ->  FStar_Syntax_Syntax.qualifier Prims.list = (fun x -> (match (x) with
| (FStar_Syntax_Syntax.Sig_bundle (_, quals, _, _)) | (FStar_Syntax_Syntax.Sig_inductive_typ (_, _, _, _, _, _, quals, _)) | (FStar_Syntax_Syntax.Sig_effect_abbrev (_, _, _, _, quals, _, _)) | (FStar_Syntax_Syntax.Sig_datacon (_, _, _, _, _, quals, _, _)) | (FStar_Syntax_Syntax.Sig_declare_typ (_, _, _, quals, _)) | (FStar_Syntax_Syntax.Sig_assume (_, _, quals, _)) | (FStar_Syntax_Syntax.Sig_let (_, _, _, quals, _)) | (FStar_Syntax_Syntax.Sig_new_effect ({FStar_Syntax_Syntax.qualifiers = quals; FStar_Syntax_Syntax.cattributes = _; FStar_Syntax_Syntax.mname = _; FStar_Syntax_Syntax.univs = _; FStar_Syntax_Syntax.binders = _; FStar_Syntax_Syntax.signature = _; FStar_Syntax_Syntax.ret_wp = _; FStar_Syntax_Syntax.bind_wp = _; FStar_Syntax_Syntax.if_then_else = _; FStar_Syntax_Syntax.ite_wp = _; FStar_Syntax_Syntax.stronger = _; FStar_Syntax_Syntax.close_wp = _; FStar_Syntax_Syntax.assert_p = _; FStar_Syntax_Syntax.assume_p = _; FStar_Syntax_Syntax.null_wp = _; FStar_Syntax_Syntax.trivial = _; FStar_Syntax_Syntax.repr = _; FStar_Syntax_Syntax.return_repr = _; FStar_Syntax_Syntax.bind_repr = _; FStar_Syntax_Syntax.actions = _}, _)) | (FStar_Syntax_Syntax.Sig_new_effect_for_free ({FStar_Syntax_Syntax.qualifiers = quals; FStar_Syntax_Syntax.cattributes = _; FStar_Syntax_Syntax.mname = _; FStar_Syntax_Syntax.univs = _; FStar_Syntax_Syntax.binders = _; FStar_Syntax_Syntax.signature = _; FStar_Syntax_Syntax.ret_wp = _; FStar_Syntax_Syntax.bind_wp = _; FStar_Syntax_Syntax.if_then_else = _; FStar_Syntax_Syntax.ite_wp = _; FStar_Syntax_Syntax.stronger = _; FStar_Syntax_Syntax.close_wp = _; FStar_Syntax_Syntax.assert_p = _; FStar_Syntax_Syntax.assume_p = _; FStar_Syntax_Syntax.null_wp = _; FStar_Syntax_Syntax.trivial = _; FStar_Syntax_Syntax.repr = _; FStar_Syntax_Syntax.return_repr = _; FStar_Syntax_Syntax.bind_repr = _; FStar_Syntax_Syntax.actions = _}, _)) -> begin
quals
end
| (FStar_Syntax_Syntax.Sig_sub_effect (_, _)) | (FStar_Syntax_Syntax.Sig_pragma (_, _)) | (FStar_Syntax_Syntax.Sig_main (_, _)) -> begin
[]
end))


let range_of_sigelt : FStar_Syntax_Syntax.sigelt  ->  FStar_Range.range = (fun x -> (match (x) with
| (FStar_Syntax_Syntax.Sig_bundle (_, _, _, r)) | (FStar_Syntax_Syntax.Sig_inductive_typ (_, _, _, _, _, _, _, r)) | (FStar_Syntax_Syntax.Sig_effect_abbrev (_, _, _, _, _, _, r)) | (FStar_Syntax_Syntax.Sig_datacon (_, _, _, _, _, _, _, r)) | (FStar_Syntax_Syntax.Sig_declare_typ (_, _, _, _, r)) | (FStar_Syntax_Syntax.Sig_assume (_, _, _, r)) | (FStar_Syntax_Syntax.Sig_let (_, r, _, _, _)) | (FStar_Syntax_Syntax.Sig_main (_, r)) | (FStar_Syntax_Syntax.Sig_pragma (_, r)) | (FStar_Syntax_Syntax.Sig_new_effect (_, r)) | (FStar_Syntax_Syntax.Sig_new_effect_for_free (_, r)) | (FStar_Syntax_Syntax.Sig_sub_effect (_, r)) -> begin
r
end))


let range_of_lb = (fun uu___174_1823 -> (match (uu___174_1823) with
| (FStar_Util.Inl (x), uu____1830, uu____1831) -> begin
(FStar_Syntax_Syntax.range_of_bv x)
end
| (FStar_Util.Inr (l), uu____1835, uu____1836) -> begin
(FStar_Ident.range_of_lid l)
end))


let range_of_arg = (fun uu____1853 -> (match (uu____1853) with
| (hd, uu____1859) -> begin
hd.FStar_Syntax_Syntax.pos
end))


let range_of_args = (fun args r -> (FStar_All.pipe_right args (FStar_List.fold_left (fun r a -> (FStar_Range.union_ranges r (range_of_arg a))) r)))


let mk_app = (fun f args -> (

let r = (range_of_args args f.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (((f), (args)))) None r)))


let mk_data = (fun l args -> (match (args) with
| [] -> begin
((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta ((let _0_216 = (FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))
in ((_0_216), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Data_app))))))) None (FStar_Ident.range_of_lid l))
end
| uu____1981 -> begin
(

let e = (let _0_217 = (FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))
in (mk_app _0_217 args))
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((e), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Data_app))))) None e.FStar_Syntax_Syntax.pos))
end))


let mangle_field_name : FStar_Ident.ident  ->  FStar_Ident.ident = (fun x -> (FStar_Ident.mk_ident (((Prims.strcat "^fname^" x.FStar_Ident.idText)), (x.FStar_Ident.idRange))))


let unmangle_field_name : FStar_Ident.ident  ->  FStar_Ident.ident = (fun x -> (match ((FStar_Util.starts_with x.FStar_Ident.idText "^fname^")) with
| true -> begin
(FStar_Ident.mk_ident (let _0_218 = (FStar_Util.substring_from x.FStar_Ident.idText (Prims.parse_int "7"))
in ((_0_218), (x.FStar_Ident.idRange))))
end
| uu____2002 -> begin
x
end))


let field_projector_prefix : Prims.string = "__proj__"


let field_projector_sep : Prims.string = "__item__"


let field_projector_contains_constructor : Prims.string  ->  Prims.bool = (fun s -> (FStar_Util.starts_with s field_projector_prefix))


let mk_field_projector_name_from_string : Prims.string  ->  Prims.string  ->  Prims.string = (fun constr field -> (Prims.strcat field_projector_prefix (Prims.strcat constr (Prims.strcat field_projector_sep field))))


let mk_field_projector_name_from_ident : FStar_Ident.lident  ->  FStar_Ident.ident  ->  FStar_Ident.lident = (fun lid i -> (

let j = (unmangle_field_name i)
in (

let jtext = j.FStar_Ident.idText
in (

let newi = (match ((field_projector_contains_constructor jtext)) with
| true -> begin
j
end
| uu____2021 -> begin
(FStar_Ident.mk_ident (((mk_field_projector_name_from_string lid.FStar_Ident.ident.FStar_Ident.idText jtext)), (i.FStar_Ident.idRange)))
end)
in (FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns ((newi)::[])))))))


let mk_field_projector_name : FStar_Ident.lident  ->  FStar_Syntax_Syntax.bv  ->  Prims.int  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.bv) = (fun lid x i -> (

let nm = (

let uu____2034 = (FStar_Syntax_Syntax.is_null_bv x)
in (match (uu____2034) with
| true -> begin
(FStar_Ident.mk_ident (let _0_221 = (let _0_219 = (FStar_Util.string_of_int i)
in (Prims.strcat "_" _0_219))
in (let _0_220 = (FStar_Syntax_Syntax.range_of_bv x)
in ((_0_221), (_0_220)))))
end
| uu____2035 -> begin
x.FStar_Syntax_Syntax.ppname
end))
in (

let y = (

let uu___178_2037 = x
in {FStar_Syntax_Syntax.ppname = nm; FStar_Syntax_Syntax.index = uu___178_2037.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = uu___178_2037.FStar_Syntax_Syntax.sort})
in (let _0_222 = (mk_field_projector_name_from_ident lid nm)
in ((_0_222), (y))))))


let set_uvar = (fun uv t -> (

let uu____2054 = (FStar_Unionfind.find uv)
in (match (uu____2054) with
| FStar_Syntax_Syntax.Fixed (uu____2057) -> begin
(failwith (let _0_224 = (let _0_223 = (FStar_Unionfind.uvar_id uv)
in (FStar_All.pipe_left FStar_Util.string_of_int _0_223))
in (FStar_Util.format1 "Changing a fixed uvar! ?%s\n" _0_224)))
end
| uu____2059 -> begin
(FStar_Unionfind.change uv (FStar_Syntax_Syntax.Fixed (t)))
end)))


let qualifier_equal : FStar_Syntax_Syntax.qualifier  ->  FStar_Syntax_Syntax.qualifier  ->  Prims.bool = (fun q1 q2 -> (match (((q1), (q2))) with
| (FStar_Syntax_Syntax.Discriminator (l1), FStar_Syntax_Syntax.Discriminator (l2)) -> begin
(FStar_Ident.lid_equals l1 l2)
end
| (FStar_Syntax_Syntax.Projector (l1a, l1b), FStar_Syntax_Syntax.Projector (l2a, l2b)) -> begin
((FStar_Ident.lid_equals l1a l2a) && (l1b.FStar_Ident.idText = l2b.FStar_Ident.idText))
end
| ((FStar_Syntax_Syntax.RecordType (ns1, f1), FStar_Syntax_Syntax.RecordType (ns2, f2))) | ((FStar_Syntax_Syntax.RecordConstructor (ns1, f1), FStar_Syntax_Syntax.RecordConstructor (ns2, f2))) -> begin
(((((FStar_List.length ns1) = (FStar_List.length ns2)) && (FStar_List.forall2 (fun x1 x2 -> (x1.FStar_Ident.idText = x2.FStar_Ident.idText)) f1 f2)) && ((FStar_List.length f1) = (FStar_List.length f2))) && (FStar_List.forall2 (fun x1 x2 -> (x1.FStar_Ident.idText = x2.FStar_Ident.idText)) f1 f2))
end
| uu____2106 -> begin
(q1 = q2)
end))


let abs : (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.lcomp, (FStar_Ident.lident * FStar_Syntax_Syntax.cflags Prims.list)) FStar_Util.either Prims.option  ->  FStar_Syntax_Syntax.term = (fun bs t lopt -> (match (((FStar_List.length bs) = (Prims.parse_int "0"))) with
| true -> begin
t
end
| uu____2140 -> begin
(

let close_lopt = (fun lopt -> (match (lopt) with
| (None) | (Some (FStar_Util.Inr (_))) -> begin
lopt
end
| Some (FStar_Util.Inl (lc)) -> begin
Some (FStar_Util.Inl ((FStar_Syntax_Subst.close_lcomp bs lc)))
end))
in (match (bs) with
| [] -> begin
t
end
| uu____2202 -> begin
(

let body = (FStar_Syntax_Subst.compress (FStar_Syntax_Subst.close bs t))
in (match (((body.FStar_Syntax_Syntax.n), (lopt))) with
| (FStar_Syntax_Syntax.Tm_abs (bs', t, lopt'), None) -> begin
((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_abs ((let _0_227 = (let _0_225 = (FStar_Syntax_Subst.close_binders bs)
in (FStar_List.append _0_225 bs'))
in (let _0_226 = (close_lopt lopt')
in ((_0_227), (t), (_0_226))))))) None t.FStar_Syntax_Syntax.pos)
end
| uu____2270 -> begin
((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_abs ((let _0_229 = (FStar_Syntax_Subst.close_binders bs)
in (let _0_228 = (close_lopt lopt)
in ((_0_229), (body), (_0_228))))))) None t.FStar_Syntax_Syntax.pos)
end))
end))
end))


let arrow : (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun bs c -> (match (bs) with
| [] -> begin
(comp_result c)
end
| uu____2315 -> begin
((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((let _0_231 = (FStar_Syntax_Subst.close_binders bs)
in (let _0_230 = (FStar_Syntax_Subst.close_comp bs c)
in ((_0_231), (_0_230))))))) None c.FStar_Syntax_Syntax.pos)
end))


let flat_arrow : (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun bs c -> (

let t = (arrow bs c)
in (

let uu____2348 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____2348) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (tres, uu____2366) -> begin
(

let uu____2373 = (FStar_Syntax_Subst.compress tres).FStar_Syntax_Syntax.n
in (match (uu____2373) with
| FStar_Syntax_Syntax.Tm_arrow (bs', c') -> begin
(let _0_232 = (FStar_ST.read t.FStar_Syntax_Syntax.tk)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((((FStar_List.append bs bs')), (c'))))) _0_232 t.FStar_Syntax_Syntax.pos))
end
| uu____2406 -> begin
t
end))
end
| uu____2407 -> begin
t
end)
end
| uu____2408 -> begin
t
end))))


let refine : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun b t -> (let _0_238 = (FStar_ST.read b.FStar_Syntax_Syntax.sort.FStar_Syntax_Syntax.tk)
in (let _0_237 = (let _0_236 = (FStar_Syntax_Syntax.range_of_bv b)
in (FStar_Range.union_ranges _0_236 t.FStar_Syntax_Syntax.pos))
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_refine ((let _0_235 = (let _0_234 = (let _0_233 = (FStar_Syntax_Syntax.mk_binder b)
in (_0_233)::[])
in (FStar_Syntax_Subst.close _0_234 t))
in ((b), (_0_235)))))) _0_238 _0_237))))


let branch : FStar_Syntax_Syntax.branch  ->  FStar_Syntax_Syntax.branch = (fun b -> (FStar_Syntax_Subst.close_branch b))


let rec arrow_formals_comp : FStar_Syntax_Syntax.term  ->  ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list * FStar_Syntax_Syntax.comp) = (fun k -> (

let k = (FStar_Syntax_Subst.compress k)
in (match (k.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let uu____2457 = (FStar_Syntax_Subst.open_comp bs c)
in (match (uu____2457) with
| (bs, c) -> begin
(

let uu____2467 = (is_tot_or_gtot_comp c)
in (match (uu____2467) with
| true -> begin
(

let uu____2473 = (arrow_formals_comp (comp_result c))
in (match (uu____2473) with
| (bs', k) -> begin
(((FStar_List.append bs bs')), (k))
end))
end
| uu____2497 -> begin
((bs), (c))
end))
end))
end
| uu____2498 -> begin
(let _0_239 = (FStar_Syntax_Syntax.mk_Total k)
in (([]), (_0_239)))
end)))


let rec arrow_formals : FStar_Syntax_Syntax.term  ->  ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list * (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax) = (fun k -> (

let uu____2514 = (arrow_formals_comp k)
in (match (uu____2514) with
| (bs, c) -> begin
((bs), ((comp_result c)))
end)))


let abs_formals : FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.term * (FStar_Syntax_Syntax.lcomp, (FStar_Ident.lident * FStar_Syntax_Syntax.cflags Prims.list)) FStar_Util.either Prims.option) = (fun t -> (

let subst_lcomp_opt = (fun s l -> (match (l) with
| Some (FStar_Util.Inl (l)) -> begin
(

let l = (

let uu___179_2595 = l
in (let _0_241 = (FStar_Syntax_Subst.subst s l.FStar_Syntax_Syntax.res_typ)
in {FStar_Syntax_Syntax.eff_name = uu___179_2595.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = _0_241; FStar_Syntax_Syntax.cflags = uu___179_2595.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun uu____2596 -> (let _0_240 = (l.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Subst.subst_comp s _0_240)))}))
in Some (FStar_Util.Inl (l)))
end
| uu____2605 -> begin
l
end))
in (

let rec aux = (fun t abs_body_lcomp -> (

let uu____2643 = (let _0_242 = (FStar_Syntax_Subst.compress t)
in (FStar_All.pipe_left unascribe _0_242)).FStar_Syntax_Syntax.n
in (match (uu____2643) with
| FStar_Syntax_Syntax.Tm_abs (bs, t, what) -> begin
(

let uu____2681 = (aux t what)
in (match (uu____2681) with
| (bs', t, what) -> begin
(((FStar_List.append bs bs')), (t), (what))
end))
end
| uu____2738 -> begin
(([]), (t), (abs_body_lcomp))
end)))
in (

let uu____2750 = (aux t None)
in (match (uu____2750) with
| (bs, t, abs_body_lcomp) -> begin
(

let uu____2798 = (FStar_Syntax_Subst.open_term' bs t)
in (match (uu____2798) with
| (bs, t, opening) -> begin
(

let abs_body_lcomp = (subst_lcomp_opt opening abs_body_lcomp)
in ((bs), (t), (abs_body_lcomp)))
end))
end)))))


let mk_letbinding : (FStar_Syntax_Syntax.bv, FStar_Syntax_Syntax.fv) FStar_Util.either  ->  FStar_Syntax_Syntax.univ_name Prims.list  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.letbinding = (fun lbname univ_vars typ eff def -> {FStar_Syntax_Syntax.lbname = lbname; FStar_Syntax_Syntax.lbunivs = univ_vars; FStar_Syntax_Syntax.lbtyp = typ; FStar_Syntax_Syntax.lbeff = eff; FStar_Syntax_Syntax.lbdef = def})


let close_univs_and_mk_letbinding : FStar_Syntax_Syntax.fv Prims.list Prims.option  ->  (FStar_Syntax_Syntax.bv, FStar_Syntax_Syntax.fv) FStar_Util.either  ->  FStar_Ident.ident Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.letbinding = (fun recs lbname univ_vars typ eff def -> (

let def = (match (((recs), (univ_vars))) with
| ((None, _)) | ((_, [])) -> begin
def
end
| (Some (fvs), uu____2898) -> begin
(

let universes = (FStar_All.pipe_right univ_vars (FStar_List.map (fun _0_243 -> FStar_Syntax_Syntax.U_name (_0_243))))
in (

let inst = (FStar_All.pipe_right fvs (FStar_List.map (fun fv -> ((fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v), (universes)))))
in (FStar_Syntax_InstFV.instantiate inst def)))
end)
in (

let typ = (FStar_Syntax_Subst.close_univ_vars univ_vars typ)
in (

let def = (FStar_Syntax_Subst.close_univ_vars univ_vars def)
in (mk_letbinding lbname univ_vars typ eff def)))))


let open_univ_vars_binders_and_comp : FStar_Syntax_Syntax.univ_names  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.univ_names * (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) Prims.list * FStar_Syntax_Syntax.comp) = (fun uvs binders c -> (match (binders) with
| [] -> begin
(

let uu____2959 = (FStar_Syntax_Subst.open_univ_vars_comp uvs c)
in (match (uu____2959) with
| (uvs, c) -> begin
((uvs), ([]), (c))
end))
end
| uu____2975 -> begin
(

let t' = (arrow binders c)
in (

let uu____2982 = (FStar_Syntax_Subst.open_univ_vars uvs t')
in (match (uu____2982) with
| (uvs, t') -> begin
(

let uu____2993 = (FStar_Syntax_Subst.compress t').FStar_Syntax_Syntax.n
in (match (uu____2993) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
((uvs), (binders), (c))
end
| uu____3017 -> begin
(failwith "Impossible")
end))
end)))
end))


let is_tuple_constructor : FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(FStar_Util.starts_with fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v.FStar_Ident.str "Prims.tuple")
end
| uu____3032 -> begin
false
end))


let mk_tuple_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n r -> (

let t = (let _0_244 = (FStar_Util.string_of_int n)
in (FStar_Util.format1 "tuple%s" _0_244))
in (let _0_245 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range _0_245 r))))


let mk_tuple_data_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n r -> (

let t = (let _0_246 = (FStar_Util.string_of_int n)
in (FStar_Util.format1 "Mktuple%s" _0_246))
in (let _0_247 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range _0_247 r))))


let is_tuple_data_lid : FStar_Ident.lident  ->  Prims.int  ->  Prims.bool = (fun f n -> (let _0_248 = (mk_tuple_data_lid n FStar_Range.dummyRange)
in (FStar_Ident.lid_equals f _0_248)))


let is_tuple_data_lid' : FStar_Ident.lident  ->  Prims.bool = (fun f -> ((f.FStar_Ident.nsstr = "Prims") && (FStar_Util.starts_with f.FStar_Ident.ident.FStar_Ident.idText "Mktuple")))


let is_tuple_constructor_lid : FStar_Ident.lident  ->  Prims.bool = (fun lid -> (FStar_Util.starts_with (FStar_Ident.text_of_lid lid) "Prims.tuple"))


let is_dtuple_constructor_lid : FStar_Ident.lident  ->  Prims.bool = (fun lid -> ((lid.FStar_Ident.nsstr = "Prims") && (FStar_Util.starts_with lid.FStar_Ident.ident.FStar_Ident.idText "Prims.dtuple")))


let is_dtuple_constructor : FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(is_dtuple_constructor_lid fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end
| uu____3070 -> begin
false
end))


let mk_dtuple_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n r -> (

let t = (let _0_249 = (FStar_Util.string_of_int n)
in (FStar_Util.format1 "dtuple%s" _0_249))
in (let _0_250 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range _0_250 r))))


let mk_dtuple_data_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n r -> (

let t = (let _0_251 = (FStar_Util.string_of_int n)
in (FStar_Util.format1 "Mkdtuple%s" _0_251))
in (let _0_252 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range _0_252 r))))


let is_dtuple_data_lid' : FStar_Ident.lident  ->  Prims.bool = (fun f -> (FStar_Util.starts_with (FStar_Ident.text_of_lid f) "Mkdtuple"))


let is_lid_equality : FStar_Ident.lident  ->  Prims.bool = (fun x -> (FStar_Ident.lid_equals x FStar_Syntax_Const.eq2_lid))


let is_forall : FStar_Ident.lident  ->  Prims.bool = (fun lid -> (FStar_Ident.lid_equals lid FStar_Syntax_Const.forall_lid))


let is_exists : FStar_Ident.lident  ->  Prims.bool = (fun lid -> (FStar_Ident.lid_equals lid FStar_Syntax_Const.exists_lid))


let is_qlid : FStar_Ident.lident  ->  Prims.bool = (fun lid -> ((is_forall lid) || (is_exists lid)))


let is_equality = (fun x -> (is_lid_equality x.FStar_Syntax_Syntax.v))


let lid_is_connective : FStar_Ident.lident  ->  Prims.bool = (

let lst = (FStar_Syntax_Const.and_lid)::(FStar_Syntax_Const.or_lid)::(FStar_Syntax_Const.not_lid)::(FStar_Syntax_Const.iff_lid)::(FStar_Syntax_Const.imp_lid)::[]
in (fun lid -> (FStar_Util.for_some (FStar_Ident.lid_equals lid) lst)))


let is_constructor : FStar_Syntax_Syntax.term  ->  FStar_Ident.lident  ->  Prims.bool = (fun t lid -> (

let uu____3122 = (pre_typ t).FStar_Syntax_Syntax.n
in (match (uu____3122) with
| FStar_Syntax_Syntax.Tm_fvar (tc) -> begin
(FStar_Ident.lid_equals tc.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v lid)
end
| uu____3128 -> begin
false
end)))


let rec is_constructed_typ : FStar_Syntax_Syntax.term  ->  FStar_Ident.lident  ->  Prims.bool = (fun t lid -> (

let uu____3135 = (pre_typ t).FStar_Syntax_Syntax.n
in (match (uu____3135) with
| FStar_Syntax_Syntax.Tm_fvar (uu____3136) -> begin
(is_constructor t lid)
end
| FStar_Syntax_Syntax.Tm_app (t, uu____3138) -> begin
(is_constructed_typ t lid)
end
| uu____3153 -> begin
false
end)))


let rec get_tycon : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term Prims.option = (fun t -> (

let t = (pre_typ t)
in (match (t.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) -> begin
Some (t)
end
| FStar_Syntax_Syntax.Tm_app (t, uu____3164) -> begin
(get_tycon t)
end
| uu____3179 -> begin
None
end)))


let is_interpreted : FStar_Ident.lident  ->  Prims.bool = (fun l -> (

let theory_syms = (FStar_Syntax_Const.op_Eq)::(FStar_Syntax_Const.op_notEq)::(FStar_Syntax_Const.op_LT)::(FStar_Syntax_Const.op_LTE)::(FStar_Syntax_Const.op_GT)::(FStar_Syntax_Const.op_GTE)::(FStar_Syntax_Const.op_Subtraction)::(FStar_Syntax_Const.op_Minus)::(FStar_Syntax_Const.op_Addition)::(FStar_Syntax_Const.op_Multiply)::(FStar_Syntax_Const.op_Division)::(FStar_Syntax_Const.op_Modulus)::(FStar_Syntax_Const.op_And)::(FStar_Syntax_Const.op_Or)::(FStar_Syntax_Const.op_Negation)::[]
in (FStar_Util.for_some (FStar_Ident.lid_equals l) theory_syms)))


let ktype : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_unknown))) None FStar_Range.dummyRange)


let ktype0 : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_zero))) None FStar_Range.dummyRange)


let type_u : Prims.unit  ->  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.universe) = (fun uu____3209 -> (

let u = (let _0_254 = (FStar_Unionfind.fresh None)
in (FStar_All.pipe_left (fun _0_253 -> FStar_Syntax_Syntax.U_unif (_0_253)) _0_254))
in (let _0_255 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u))) None FStar_Range.dummyRange)
in ((_0_255), (u)))))


let kt_kt : FStar_Syntax_Syntax.term = (FStar_Syntax_Const.kunary ktype0 ktype0)


let kt_kt_kt : FStar_Syntax_Syntax.term = (FStar_Syntax_Const.kbin ktype0 ktype0 ktype0)


let fvar_const : FStar_Ident.lident  ->  FStar_Syntax_Syntax.term = (fun l -> (FStar_Syntax_Syntax.fvar l FStar_Syntax_Syntax.Delta_constant None))


let tand : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.and_lid)


let tor : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.or_lid)


let timp : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.imp_lid)


let tiff : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.iff_lid)


let t_bool : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.bool_lid)


let t_false : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.false_lid)


let t_true : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.true_lid)


let b2t_v : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.b2t_lid)


let t_not : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.not_lid)


let mk_conj_opt : FStar_Syntax_Syntax.term Prims.option  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term Prims.option = (fun phi1 phi2 -> (match (phi1) with
| None -> begin
Some (phi2)
end
| Some (phi1) -> begin
Some ((let _0_260 = (FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos phi2.FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_259 = (let _0_258 = (FStar_Syntax_Syntax.as_arg phi1)
in (let _0_257 = (let _0_256 = (FStar_Syntax_Syntax.as_arg phi2)
in (_0_256)::[])
in (_0_258)::_0_257))
in ((tand), (_0_259)))))) None _0_260)))
end))


let mk_binop = (fun op_t phi1 phi2 -> (let _0_265 = (FStar_Range.union_ranges phi1.FStar_Syntax_Syntax.pos phi2.FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_264 = (let _0_263 = (FStar_Syntax_Syntax.as_arg phi1)
in (let _0_262 = (let _0_261 = (FStar_Syntax_Syntax.as_arg phi2)
in (_0_261)::[])
in (_0_263)::_0_262))
in ((op_t), (_0_264)))))) None _0_265)))


let mk_neg = (fun phi -> ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_267 = (let _0_266 = (FStar_Syntax_Syntax.as_arg phi)
in (_0_266)::[])
in ((t_not), (_0_267)))))) None phi.FStar_Syntax_Syntax.pos))


let mk_conj = (fun phi1 phi2 -> (mk_binop tand phi1 phi2))


let mk_conj_l : FStar_Syntax_Syntax.term Prims.list  ->  FStar_Syntax_Syntax.term = (fun phi -> (match (phi) with
| [] -> begin
(FStar_Syntax_Syntax.fvar FStar_Syntax_Const.true_lid FStar_Syntax_Syntax.Delta_constant None)
end
| (hd)::tl -> begin
(FStar_List.fold_right mk_conj tl hd)
end))


let mk_disj = (fun phi1 phi2 -> (mk_binop tor phi1 phi2))


let mk_disj_l : FStar_Syntax_Syntax.term Prims.list  ->  FStar_Syntax_Syntax.term = (fun phi -> (match (phi) with
| [] -> begin
t_false
end
| (hd)::tl -> begin
(FStar_List.fold_right mk_disj tl hd)
end))


let mk_imp : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun phi1 phi2 -> (

let uu____3361 = (FStar_Syntax_Subst.compress phi1).FStar_Syntax_Syntax.n
in (match (uu____3361) with
| FStar_Syntax_Syntax.Tm_fvar (tc) when (FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.false_lid) -> begin
t_true
end
| FStar_Syntax_Syntax.Tm_fvar (tc) when (FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.true_lid) -> begin
phi2
end
| uu____3364 -> begin
(

let uu____3365 = (FStar_Syntax_Subst.compress phi2).FStar_Syntax_Syntax.n
in (match (uu____3365) with
| FStar_Syntax_Syntax.Tm_fvar (tc) when ((FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.true_lid) || (FStar_Syntax_Syntax.fv_eq_lid tc FStar_Syntax_Const.false_lid)) -> begin
phi2
end
| uu____3367 -> begin
(mk_binop timp phi1 phi2)
end))
end)))


let mk_iff = (fun phi1 phi2 -> (mk_binop tiff phi1 phi2))


let b2t = (fun e -> ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_269 = (let _0_268 = (FStar_Syntax_Syntax.as_arg e)
in (_0_268)::[])
in ((b2t_v), (_0_269)))))) None e.FStar_Syntax_Syntax.pos))


let teq : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.eq2_lid)


let mk_eq = (fun t1 t2 e1 e2 -> (let _0_274 = (FStar_Range.union_ranges e1.FStar_Syntax_Syntax.pos e2.FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_273 = (let _0_272 = (FStar_Syntax_Syntax.as_arg e1)
in (let _0_271 = (let _0_270 = (FStar_Syntax_Syntax.as_arg e2)
in (_0_270)::[])
in (_0_272)::_0_271))
in ((teq), (_0_273)))))) None _0_274)))


let mk_has_type = (fun t x t' -> (

let t_has_type = (fvar_const FStar_Syntax_Const.has_type_lid)
in (

let t_has_type = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uinst (((t_has_type), ((FStar_Syntax_Syntax.U_zero)::(FStar_Syntax_Syntax.U_zero)::[])))) None FStar_Range.dummyRange)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_280 = (let _0_279 = (FStar_Syntax_Syntax.iarg t)
in (let _0_278 = (let _0_277 = (FStar_Syntax_Syntax.as_arg x)
in (let _0_276 = (let _0_275 = (FStar_Syntax_Syntax.as_arg t')
in (_0_275)::[])
in (_0_277)::_0_276))
in (_0_279)::_0_278))
in ((t_has_type), (_0_280)))))) None FStar_Range.dummyRange))))


let lex_t : FStar_Syntax_Syntax.term = (fvar_const FStar_Syntax_Const.lex_t_lid)


let lex_top : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.lextop_lid FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))


let lex_pair : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.lexcons_lid FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))


let tforall : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.forall_lid (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))) None)


let t_haseq : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.haseq_lid FStar_Syntax_Syntax.Delta_constant None)


let lcomp_of_comp : (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.lcomp = (fun c0 -> (

let uu____3483 = (match (c0.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (uu____3490) -> begin
((FStar_Syntax_Const.effect_Tot_lid), ((FStar_Syntax_Syntax.TOTAL)::[]))
end
| FStar_Syntax_Syntax.GTotal (uu____3497) -> begin
((FStar_Syntax_Const.effect_GTot_lid), ((FStar_Syntax_Syntax.SOMETRIVIAL)::[]))
end
| FStar_Syntax_Syntax.Comp (c) -> begin
((c.FStar_Syntax_Syntax.effect_name), (c.FStar_Syntax_Syntax.flags))
end)
in (match (uu____3483) with
| (eff_name, flags) -> begin
{FStar_Syntax_Syntax.eff_name = eff_name; FStar_Syntax_Syntax.res_typ = (comp_result c0); FStar_Syntax_Syntax.cflags = flags; FStar_Syntax_Syntax.comp = (fun uu____3510 -> c0)}
end)))


let mk_forall : FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ = (fun x body -> ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_288 = (let _0_287 = (FStar_Syntax_Syntax.iarg x.FStar_Syntax_Syntax.sort)
in (let _0_286 = (let _0_285 = (FStar_Syntax_Syntax.as_arg (let _0_284 = (let _0_281 = (FStar_Syntax_Syntax.mk_binder x)
in (_0_281)::[])
in (let _0_283 = Some (FStar_Util.Inl ((let _0_282 = (FStar_Syntax_Syntax.mk_Total ktype0)
in (FStar_All.pipe_left lcomp_of_comp _0_282))))
in (abs _0_284 body _0_283))))
in (_0_285)::[])
in (_0_287)::_0_286))
in ((tforall), (_0_288)))))) None FStar_Range.dummyRange))


let rec close_forall : FStar_Syntax_Syntax.binder Prims.list  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ = (fun bs f -> (FStar_List.fold_right (fun b f -> (

let uu____3546 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____3546) with
| true -> begin
f
end
| uu____3547 -> begin
(mk_forall (Prims.fst b) f)
end))) bs f))


let rec is_wild_pat = (fun p -> (match (p.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_wild (uu____3559) -> begin
true
end
| uu____3560 -> begin
false
end))


let if_then_else = (fun b t1 t2 -> (

let then_branch = (let _0_289 = (FStar_Syntax_Syntax.withinfo (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool (true))) FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n t1.FStar_Syntax_Syntax.pos)
in ((_0_289), (None), (t1)))
in (

let else_branch = (let _0_290 = (FStar_Syntax_Syntax.withinfo (FStar_Syntax_Syntax.Pat_constant (FStar_Const.Const_bool (false))) FStar_Syntax_Syntax.tun.FStar_Syntax_Syntax.n t2.FStar_Syntax_Syntax.pos)
in ((_0_290), (None), (t2)))
in (let _0_292 = (let _0_291 = (FStar_Range.union_ranges t1.FStar_Syntax_Syntax.pos t2.FStar_Syntax_Syntax.pos)
in (FStar_Range.union_ranges b.FStar_Syntax_Syntax.pos _0_291))
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_match (((b), ((then_branch)::(else_branch)::[])))) None _0_292)))))


type qpats =
FStar_Syntax_Syntax.args Prims.list

type connective =
| QAll of (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ)
| QEx of (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ)
| BaseConn of (FStar_Ident.lident * FStar_Syntax_Syntax.args)


let uu___is_QAll : connective  ->  Prims.bool = (fun projectee -> (match (projectee) with
| QAll (_0) -> begin
true
end
| uu____3704 -> begin
false
end))


let __proj__QAll__item___0 : connective  ->  (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ) = (fun projectee -> (match (projectee) with
| QAll (_0) -> begin
_0
end))


let uu___is_QEx : connective  ->  Prims.bool = (fun projectee -> (match (projectee) with
| QEx (_0) -> begin
true
end
| uu____3728 -> begin
false
end))


let __proj__QEx__item___0 : connective  ->  (FStar_Syntax_Syntax.binders * qpats * FStar_Syntax_Syntax.typ) = (fun projectee -> (match (projectee) with
| QEx (_0) -> begin
_0
end))


let uu___is_BaseConn : connective  ->  Prims.bool = (fun projectee -> (match (projectee) with
| BaseConn (_0) -> begin
true
end
| uu____3751 -> begin
false
end))


let __proj__BaseConn__item___0 : connective  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.args) = (fun projectee -> (match (projectee) with
| BaseConn (_0) -> begin
_0
end))


let destruct_typ_as_formula : FStar_Syntax_Syntax.term  ->  connective Prims.option = (fun f -> (

let rec unmeta_monadic = (fun f -> (

let f = (FStar_Syntax_Subst.compress f)
in (match (f.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_monadic (_))) | (FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_monadic_lift (_))) -> begin
(unmeta_monadic t)
end
| uu____3786 -> begin
f
end)))
in (

let destruct_base_conn = (fun f -> (

let connectives = (((FStar_Syntax_Const.true_lid), ((Prims.parse_int "0"))))::(((FStar_Syntax_Const.false_lid), ((Prims.parse_int "0"))))::(((FStar_Syntax_Const.and_lid), ((Prims.parse_int "2"))))::(((FStar_Syntax_Const.or_lid), ((Prims.parse_int "2"))))::(((FStar_Syntax_Const.imp_lid), ((Prims.parse_int "2"))))::(((FStar_Syntax_Const.iff_lid), ((Prims.parse_int "2"))))::(((FStar_Syntax_Const.ite_lid), ((Prims.parse_int "3"))))::(((FStar_Syntax_Const.not_lid), ((Prims.parse_int "1"))))::(((FStar_Syntax_Const.eq2_lid), ((Prims.parse_int "3"))))::(((FStar_Syntax_Const.eq2_lid), ((Prims.parse_int "2"))))::(((FStar_Syntax_Const.eq3_lid), ((Prims.parse_int "4"))))::(((FStar_Syntax_Const.eq3_lid), ((Prims.parse_int "2"))))::[]
in (

let rec aux = (fun f uu____3831 -> (match (uu____3831) with
| (lid, arity) -> begin
(

let uu____3837 = (head_and_args (unmeta_monadic f))
in (match (uu____3837) with
| (t, args) -> begin
(

let t = (un_uinst t)
in (

let uu____3865 = ((is_constructor t lid) && ((FStar_List.length args) = arity))
in (match (uu____3865) with
| true -> begin
Some (BaseConn (((lid), (args))))
end
| uu____3880 -> begin
None
end)))
end))
end))
in (FStar_Util.find_map connectives (aux f)))))
in (

let patterns = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_pattern (pats)) -> begin
(let _0_293 = (FStar_Syntax_Subst.compress t)
in ((pats), (_0_293)))
end
| uu____3922 -> begin
(let _0_294 = (FStar_Syntax_Subst.compress t)
in (([]), (_0_294)))
end)))
in (

let destruct_q_conn = (fun t -> (

let is_q = (fun fa fv -> (match (fa) with
| true -> begin
(is_forall fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end
| uu____3950 -> begin
(is_exists fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end))
in (

let flat = (fun t -> (

let uu____3964 = (head_and_args t)
in (match (uu____3964) with
| (t, args) -> begin
(let _0_297 = (un_uinst t)
in (let _0_296 = (FStar_All.pipe_right args (FStar_List.map (fun uu____4010 -> (match (uu____4010) with
| (t, imp) -> begin
(let _0_295 = (unascribe t)
in ((_0_295), (imp)))
end))))
in ((_0_297), (_0_296))))
end)))
in (

let rec aux = (fun qopt out t -> (

let uu____4036 = (let _0_298 = (flat t)
in ((qopt), (_0_298)))
in (match (uu____4036) with
| ((Some (fa), ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (tc); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, (({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs ((b)::[], t2, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))::[]))) | ((Some (fa), ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (tc); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, (_)::(({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs ((b)::[], t2, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))::[]))) when (is_q fa tc) -> begin
(aux qopt ((b)::out) t2)
end
| ((None, ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (tc); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, (({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs ((b)::[], t2, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))::[]))) | ((None, ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (tc); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, (_)::(({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs ((b)::[], t2, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))::[]))) when (is_qlid tc.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v) -> begin
(aux (Some ((is_forall tc.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v))) ((b)::out) t2)
end
| (Some (b), uu____4298) -> begin
(

let bs = (FStar_List.rev out)
in (

let uu____4316 = (FStar_Syntax_Subst.open_term bs t)
in (match (uu____4316) with
| (bs, t) -> begin
(

let uu____4322 = (patterns t)
in (match (uu____4322) with
| (pats, body) -> begin
(match (b) with
| true -> begin
Some (QAll (((bs), (pats), (body))))
end
| uu____4353 -> begin
Some (QEx (((bs), (pats), (body))))
end)
end))
end)))
end
| uu____4360 -> begin
None
end)))
in (aux None [] t)))))
in (

let phi = (unmeta_monadic f)
in (

let uu____4372 = (destruct_base_conn phi)
in (match (uu____4372) with
| Some (b) -> begin
Some (b)
end
| None -> begin
(destruct_q_conn phi)
end))))))))


let action_as_lb : FStar_Ident.lident  ->  FStar_Syntax_Syntax.action  ->  FStar_Syntax_Syntax.sigelt = (fun eff_lid a -> (

let lb = (let _0_299 = FStar_Util.Inr ((FStar_Syntax_Syntax.lid_as_fv a.FStar_Syntax_Syntax.action_name FStar_Syntax_Syntax.Delta_equational None))
in (close_univs_and_mk_letbinding None _0_299 a.FStar_Syntax_Syntax.action_univs a.FStar_Syntax_Syntax.action_typ FStar_Syntax_Const.effect_Tot_lid a.FStar_Syntax_Syntax.action_defn))
in FStar_Syntax_Syntax.Sig_let (((((false), ((lb)::[]))), (a.FStar_Syntax_Syntax.action_defn.FStar_Syntax_Syntax.pos), ((a.FStar_Syntax_Syntax.action_name)::[]), ((FStar_Syntax_Syntax.Visible_default)::(FStar_Syntax_Syntax.Action (eff_lid))::[]), ([])))))


let mk_reify = (fun t -> (

let reify_ = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reify)) None t.FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_301 = (let _0_300 = (FStar_Syntax_Syntax.as_arg t)
in (_0_300)::[])
in ((reify_), (_0_301)))))) None t.FStar_Syntax_Syntax.pos)))


let rec delta_qualifier : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.delta_depth = (fun t -> (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (uu____4426) -> begin
(failwith "Impossible")
end
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
fv.FStar_Syntax_Syntax.fv_delta
end
| (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_match (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
FStar_Syntax_Syntax.Delta_equational
end
| (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) -> begin
FStar_Syntax_Syntax.Delta_constant
end
| (FStar_Syntax_Syntax.Tm_uinst (t, _)) | (FStar_Syntax_Syntax.Tm_refine ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t}, _)) | (FStar_Syntax_Syntax.Tm_meta (t, _)) | (FStar_Syntax_Syntax.Tm_ascribed (t, _, _)) | (FStar_Syntax_Syntax.Tm_app (t, _)) | (FStar_Syntax_Syntax.Tm_abs (_, t, _)) | (FStar_Syntax_Syntax.Tm_let (_, t)) -> begin
(delta_qualifier t)
end)))


let incr_delta_qualifier : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.delta_depth = (fun t -> (

let d = (delta_qualifier t)
in (

let rec aux = (fun d -> (match (d) with
| FStar_Syntax_Syntax.Delta_equational -> begin
d
end
| FStar_Syntax_Syntax.Delta_constant -> begin
FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))
end
| FStar_Syntax_Syntax.Delta_defined_at_level (i) -> begin
FStar_Syntax_Syntax.Delta_defined_at_level ((i + (Prims.parse_int "1")))
end
| FStar_Syntax_Syntax.Delta_abstract (d) -> begin
(aux d)
end))
in (aux d))))


let is_unknown : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun t -> (

let uu____4532 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____4532) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
true
end
| uu____4533 -> begin
false
end)))


let rec list_elements : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term Prims.list Prims.option = (fun e -> (

let uu____4541 = (head_and_args (unmeta e))
in (match (uu____4541) with
| (head, args) -> begin
(

let uu____4569 = (let _0_302 = (un_uinst head).FStar_Syntax_Syntax.n
in ((_0_302), (args)))
in (match (uu____4569) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), uu____4585) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.nil_lid) -> begin
Some ([])
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), (uu____4598)::((hd, uu____4600))::((tl, uu____4602))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.cons_lid) -> begin
Some ((let _0_303 = (FStar_Util.must (list_elements tl))
in (hd)::_0_303))
end
| uu____4642 -> begin
None
end))
end)))




