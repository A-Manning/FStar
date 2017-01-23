
open Prims

let instantiate_both : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.env = (fun env -> (

let uu___80_4 = env
in {FStar_TypeChecker_Env.solver = uu___80_4.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___80_4.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___80_4.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___80_4.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___80_4.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___80_4.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___80_4.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___80_4.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___80_4.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = true; FStar_TypeChecker_Env.effects = uu___80_4.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___80_4.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___80_4.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___80_4.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___80_4.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___80_4.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___80_4.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___80_4.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___80_4.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___80_4.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___80_4.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___80_4.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___80_4.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___80_4.FStar_TypeChecker_Env.qname_and_index}))


let no_inst : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.env = (fun env -> (

let uu___81_8 = env
in {FStar_TypeChecker_Env.solver = uu___81_8.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___81_8.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___81_8.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___81_8.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___81_8.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___81_8.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___81_8.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___81_8.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___81_8.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = false; FStar_TypeChecker_Env.effects = uu___81_8.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___81_8.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___81_8.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___81_8.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___81_8.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___81_8.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___81_8.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___81_8.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___81_8.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___81_8.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___81_8.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___81_8.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___81_8.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___81_8.FStar_TypeChecker_Env.qname_and_index}))


let mk_lex_list : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax Prims.list  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun vs -> (FStar_List.fold_right (fun v tl -> (

let r = (match ((tl.FStar_Syntax_Syntax.pos = FStar_Range.dummyRange)) with
| true -> begin
v.FStar_Syntax_Syntax.pos
end
| uu____33 -> begin
(FStar_Range.union_ranges v.FStar_Syntax_Syntax.pos tl.FStar_Syntax_Syntax.pos)
end)
in ((let _0_229 = (let _0_228 = (FStar_Syntax_Syntax.as_arg v)
in (let _0_227 = (let _0_226 = (FStar_Syntax_Syntax.as_arg tl)
in (_0_226)::[])
in (_0_228)::_0_227))
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.lex_pair _0_229)) (Some (FStar_Syntax_Util.lex_t.FStar_Syntax_Syntax.n)) r))) vs FStar_Syntax_Util.lex_top))


let is_eq : FStar_Syntax_Syntax.arg_qualifier Prims.option  ->  Prims.bool = (fun uu___75_41 -> (match (uu___75_41) with
| Some (FStar_Syntax_Syntax.Equality) -> begin
true
end
| uu____43 -> begin
false
end))


let steps = (fun env -> (FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eager_unfolding)::[])


let unfold_whnf : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.WHNF)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::(FStar_TypeChecker_Normalize.Beta)::[]) env t))


let norm : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (FStar_TypeChecker_Normalize.normalize (steps env) env t))


let norm_c : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp = (fun env c -> (FStar_TypeChecker_Normalize.normalize_comp (steps env) env c))


let check_no_escape : FStar_Syntax_Syntax.term Prims.option  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.bv Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun head_opt env fvs kt -> (

let rec aux = (fun try_norm t -> (match (fvs) with
| [] -> begin
t
end
| uu____94 -> begin
(

let t = (match (try_norm) with
| true -> begin
(norm env t)
end
| uu____97 -> begin
t
end)
in (

let fvs' = (FStar_Syntax_Free.names t)
in (

let uu____100 = (FStar_List.tryFind (fun x -> (FStar_Util.set_mem x fvs')) fvs)
in (match (uu____100) with
| None -> begin
t
end
| Some (x) -> begin
(match ((not (try_norm))) with
| true -> begin
(aux true t)
end
| uu____104 -> begin
(

let fail = (fun uu____108 -> (

let msg = (match (head_opt) with
| None -> begin
(let _0_230 = (FStar_Syntax_Print.bv_to_string x)
in (FStar_Util.format1 "Bound variables \'%s\' escapes; add a type annotation" _0_230))
end
| Some (head) -> begin
(let _0_232 = (FStar_Syntax_Print.bv_to_string x)
in (let _0_231 = (FStar_TypeChecker_Normalize.term_to_string env head)
in (FStar_Util.format2 "Bound variables \'%s\' in the type of \'%s\' escape because of impure applications; add explicit let-bindings" _0_232 _0_231)))
end)
in (Prims.raise (FStar_Errors.Error ((let _0_233 = (FStar_TypeChecker_Env.get_range env)
in ((msg), (_0_233))))))))
in (

let s = (let _0_235 = (let _0_234 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_left Prims.fst _0_234))
in (FStar_TypeChecker_Util.new_uvar env _0_235))
in (

let uu____114 = (FStar_TypeChecker_Rel.try_teq env t s)
in (match (uu____114) with
| Some (g) -> begin
((FStar_TypeChecker_Rel.force_trivial_guard env g);
s;
)
end
| uu____118 -> begin
(fail ())
end))))
end)
end))))
end))
in (aux false kt)))


let push_binding = (fun env b -> (FStar_TypeChecker_Env.push_bv env (Prims.fst b)))


let maybe_extend_subst : FStar_Syntax_Syntax.subst_t  ->  FStar_Syntax_Syntax.binder  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.subst_t = (fun s b v -> (

let uu____149 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____149) with
| true -> begin
s
end
| uu____150 -> begin
(FStar_Syntax_Syntax.NT ((((Prims.fst b)), (v))))::s
end)))


let set_lcomp_result : FStar_Syntax_Syntax.lcomp  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.lcomp = (fun lc t -> (

let uu___82_163 = lc
in {FStar_Syntax_Syntax.eff_name = uu___82_163.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = t; FStar_Syntax_Syntax.cflags = uu___82_163.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun uu____164 -> (let _0_236 = (lc.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Util.set_result_typ _0_236 t)))}))


let memo_tk : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term = (fun e t -> ((FStar_ST.write e.FStar_Syntax_Syntax.tk (Some (t.FStar_Syntax_Syntax.n)));
e;
))


let value_check_expected_typ : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.lcomp) FStar_Util.either  ->  FStar_TypeChecker_Env.guard_t  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e tlc guard -> (

let should_return = (fun t -> (

let uu____201 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____201) with
| FStar_Syntax_Syntax.Tm_arrow (uu____202, c) -> begin
(

let uu____214 = (FStar_TypeChecker_Util.is_pure_or_ghost_effect env (FStar_Syntax_Util.comp_effect_name c))
in (match (uu____214) with
| true -> begin
(

let t = (FStar_All.pipe_left FStar_Syntax_Util.unrefine (FStar_Syntax_Util.comp_result c))
in (

let uu____216 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____216) with
| FStar_Syntax_Syntax.Tm_fvar (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.unit_lid) -> begin
false
end
| FStar_Syntax_Syntax.Tm_constant (uu____218) -> begin
false
end
| uu____219 -> begin
true
end)))
end
| uu____220 -> begin
false
end))
end
| uu____221 -> begin
true
end)))
in (

let lc = (match (tlc) with
| FStar_Util.Inl (t) -> begin
(FStar_Syntax_Util.lcomp_of_comp (

let uu____224 = ((not ((should_return t))) || (not ((FStar_TypeChecker_Env.should_verify env))))
in (match (uu____224) with
| true -> begin
(FStar_Syntax_Syntax.mk_Total t)
end
| uu____227 -> begin
(FStar_TypeChecker_Util.return_value env t e)
end)))
end
| FStar_Util.Inr (lc) -> begin
lc
end)
in (

let t = lc.FStar_Syntax_Syntax.res_typ
in (

let uu____232 = (

let uu____236 = (FStar_TypeChecker_Env.expected_typ env)
in (match (uu____236) with
| None -> begin
(let _0_237 = (memo_tk e t)
in ((_0_237), (lc), (guard)))
end
| Some (t') -> begin
((

let uu____243 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____243) with
| true -> begin
(let _0_239 = (FStar_Syntax_Print.term_to_string t)
in (let _0_238 = (FStar_Syntax_Print.term_to_string t')
in (FStar_Util.print2 "Computed return type %s; expected type %s\n" _0_239 _0_238)))
end
| uu____244 -> begin
()
end));
(

let uu____245 = (FStar_TypeChecker_Util.maybe_coerce_bool_to_type env e lc t')
in (match (uu____245) with
| (e, lc) -> begin
(

let t = lc.FStar_Syntax_Syntax.res_typ
in (

let uu____256 = (FStar_TypeChecker_Util.check_and_ascribe env e t t')
in (match (uu____256) with
| (e, g) -> begin
((

let uu____265 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____265) with
| true -> begin
(let _0_243 = (FStar_Syntax_Print.term_to_string t)
in (let _0_242 = (FStar_Syntax_Print.term_to_string t')
in (let _0_241 = (FStar_TypeChecker_Rel.guard_to_string env g)
in (let _0_240 = (FStar_TypeChecker_Rel.guard_to_string env guard)
in (FStar_Util.print4 "check_and_ascribe: type is %s<:%s \tguard is %s, %s\n" _0_243 _0_242 _0_241 _0_240)))))
end
| uu____266 -> begin
()
end));
(

let msg = (

let uu____271 = (FStar_TypeChecker_Rel.is_trivial g)
in (match (uu____271) with
| true -> begin
None
end
| uu____277 -> begin
(FStar_All.pipe_left (fun _0_244 -> Some (_0_244)) (FStar_TypeChecker_Err.subtyping_failed env t t'))
end))
in (

let g = (FStar_TypeChecker_Rel.conj_guard g guard)
in (

let uu____286 = (FStar_TypeChecker_Util.strengthen_precondition msg env e lc g)
in (match (uu____286) with
| (lc, g) -> begin
(let _0_245 = (memo_tk e t')
in ((_0_245), ((set_lcomp_result lc t')), (g)))
end))));
)
end)))
end));
)
end))
in (match (uu____232) with
| (e, lc, g) -> begin
((

let uu____301 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____301) with
| true -> begin
(let _0_246 = (FStar_Syntax_Print.lcomp_to_string lc)
in (FStar_Util.print1 "Return comp type is %s\n" _0_246))
end
| uu____302 -> begin
()
end));
((e), (lc), (g));
)
end))))))


let comp_check_expected_typ : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.lcomp  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e lc -> (

let uu____318 = (FStar_TypeChecker_Env.expected_typ env)
in (match (uu____318) with
| None -> begin
((e), (lc), (FStar_TypeChecker_Rel.trivial_guard))
end
| Some (t) -> begin
(

let uu____324 = (FStar_TypeChecker_Util.maybe_coerce_bool_to_type env e lc t)
in (match (uu____324) with
| (e, lc) -> begin
(FStar_TypeChecker_Util.weaken_result_typ env e lc t)
end))
end)))


let check_expected_effect : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp Prims.option  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp)  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp * FStar_TypeChecker_Env.guard_t) = (fun env copt uu____346 -> (match (uu____346) with
| (e, c) -> begin
(

let expected_c_opt = (match (copt) with
| Some (uu____361) -> begin
copt
end
| None -> begin
(

let uu____362 = (((FStar_Options.ml_ish ()) && (FStar_Ident.lid_equals FStar_Syntax_Const.effect_ALL_lid (FStar_Syntax_Util.comp_effect_name c))) || (((FStar_Options.ml_ish ()) && env.FStar_TypeChecker_Env.lax) && (not ((FStar_Syntax_Util.is_pure_or_ghost_comp c)))))
in (match (uu____362) with
| true -> begin
Some ((FStar_Syntax_Util.ml_comp (FStar_Syntax_Util.comp_result c) e.FStar_Syntax_Syntax.pos))
end
| uu____364 -> begin
(

let uu____365 = (FStar_Syntax_Util.is_tot_or_gtot_comp c)
in (match (uu____365) with
| true -> begin
None
end
| uu____367 -> begin
(

let uu____368 = (FStar_Syntax_Util.is_pure_comp c)
in (match (uu____368) with
| true -> begin
Some ((FStar_Syntax_Syntax.mk_Total (FStar_Syntax_Util.comp_result c)))
end
| uu____370 -> begin
(

let uu____371 = (FStar_Syntax_Util.is_pure_or_ghost_comp c)
in (match (uu____371) with
| true -> begin
Some ((FStar_Syntax_Syntax.mk_GTotal (FStar_Syntax_Util.comp_result c)))
end
| uu____373 -> begin
None
end))
end))
end))
end))
end)
in (match (expected_c_opt) with
| None -> begin
(let _0_247 = (norm_c env c)
in ((e), (_0_247), (FStar_TypeChecker_Rel.trivial_guard)))
end
| Some (expected_c) -> begin
((

let uu____379 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____379) with
| true -> begin
(let _0_250 = (FStar_Syntax_Print.term_to_string e)
in (let _0_249 = (FStar_Syntax_Print.comp_to_string c)
in (let _0_248 = (FStar_Syntax_Print.comp_to_string expected_c)
in (FStar_Util.print3 "\n\n(%s) About to check\n\t%s\nagainst expected effect\n\t%s\n" _0_250 _0_249 _0_248))))
end
| uu____380 -> begin
()
end));
(

let c = (norm_c env c)
in ((

let uu____383 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____383) with
| true -> begin
(let _0_253 = (FStar_Syntax_Print.term_to_string e)
in (let _0_252 = (FStar_Syntax_Print.comp_to_string c)
in (let _0_251 = (FStar_Syntax_Print.comp_to_string expected_c)
in (FStar_Util.print3 "\n\nAfter normalization (%s) About to check\n\t%s\nagainst expected effect\n\t%s\n" _0_253 _0_252 _0_251))))
end
| uu____384 -> begin
()
end));
(

let uu____385 = (FStar_TypeChecker_Util.check_comp env e c expected_c)
in (match (uu____385) with
| (e, uu____393, g) -> begin
(

let g = (let _0_254 = (FStar_TypeChecker_Env.get_range env)
in (FStar_TypeChecker_Util.label_guard _0_254 "could not prove post-condition" g))
in ((

let uu____397 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____397) with
| true -> begin
(let _0_256 = (FStar_Range.string_of_range e.FStar_Syntax_Syntax.pos)
in (let _0_255 = (FStar_TypeChecker_Rel.guard_to_string env g)
in (FStar_Util.print2 "(%s) DONE check_expected_effect; guard is: %s\n" _0_256 _0_255)))
end
| uu____398 -> begin
()
end));
(

let e = (FStar_TypeChecker_Util.maybe_lift env e (FStar_Syntax_Util.comp_effect_name c) (FStar_Syntax_Util.comp_effect_name expected_c) (FStar_Syntax_Util.comp_result c))
in ((e), (expected_c), (g)));
))
end));
));
)
end))
end))


let no_logical_guard = (fun env uu____419 -> (match (uu____419) with
| (te, kt, f) -> begin
(

let uu____426 = (FStar_TypeChecker_Rel.guard_form f)
in (match (uu____426) with
| FStar_TypeChecker_Common.Trivial -> begin
((te), (kt), (f))
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(Prims.raise (FStar_Errors.Error ((let _0_258 = (FStar_TypeChecker_Err.unexpected_non_trivial_precondition_on_term env f)
in (let _0_257 = (FStar_TypeChecker_Env.get_range env)
in ((_0_258), (_0_257)))))))
end))
end))


let print_expected_ty : FStar_TypeChecker_Env.env  ->  Prims.unit = (fun env -> (

let uu____437 = (FStar_TypeChecker_Env.expected_typ env)
in (match (uu____437) with
| None -> begin
(FStar_Util.print_string "Expected type is None")
end
| Some (t) -> begin
(let _0_259 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print1 "Expected type is %s" _0_259))
end)))


let check_smt_pat = (fun env t bs c -> (

let uu____474 = (FStar_Syntax_Util.is_smt_lemma t)
in (match (uu____474) with
| true -> begin
(match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Comp ({FStar_Syntax_Syntax.comp_univs = uu____475; FStar_Syntax_Syntax.effect_name = uu____476; FStar_Syntax_Syntax.result_typ = uu____477; FStar_Syntax_Syntax.effect_args = (_pre)::(_post)::((pats, uu____481))::[]; FStar_Syntax_Syntax.flags = uu____482}) -> begin
(

let pat_vars = (FStar_Syntax_Free.names (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env pats))
in (

let uu____516 = (FStar_All.pipe_right bs (FStar_Util.find_opt (fun uu____528 -> (match (uu____528) with
| (b, uu____532) -> begin
(not ((FStar_Util.set_mem b pat_vars)))
end))))
in (match (uu____516) with
| None -> begin
()
end
| Some (x, uu____536) -> begin
(let _0_261 = (let _0_260 = (FStar_Syntax_Print.bv_to_string x)
in (FStar_Util.format1 "Pattern misses at least one bound variable: %s" _0_260))
in (FStar_Errors.warn t.FStar_Syntax_Syntax.pos _0_261))
end)))
end
| uu____539 -> begin
(failwith "Impossible")
end)
end
| uu____540 -> begin
()
end)))


let guard_letrecs : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ) Prims.list = (fun env actuals expected_c -> (

let uu____560 = (not ((FStar_TypeChecker_Env.should_verify env)))
in (match (uu____560) with
| true -> begin
env.FStar_TypeChecker_Env.letrecs
end
| uu____564 -> begin
(match (env.FStar_TypeChecker_Env.letrecs) with
| [] -> begin
[]
end
| letrecs -> begin
(

let r = (FStar_TypeChecker_Env.get_range env)
in (

let env = (

let uu___83_578 = env
in {FStar_TypeChecker_Env.solver = uu___83_578.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___83_578.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___83_578.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___83_578.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___83_578.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___83_578.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___83_578.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___83_578.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___83_578.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___83_578.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___83_578.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___83_578.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = []; FStar_TypeChecker_Env.top_level = uu___83_578.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___83_578.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___83_578.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___83_578.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___83_578.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___83_578.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___83_578.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___83_578.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___83_578.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___83_578.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___83_578.FStar_TypeChecker_Env.qname_and_index})
in (

let precedes = (FStar_TypeChecker_Util.fvar_const env FStar_Syntax_Const.precedes_lid)
in (

let decreases_clause = (fun bs c -> (

let filter_types_and_functions = (fun bs -> (FStar_All.pipe_right bs (FStar_List.collect (fun uu____601 -> (match (uu____601) with
| (b, uu____606) -> begin
(

let t = (let _0_262 = (FStar_Syntax_Util.unrefine b.FStar_Syntax_Syntax.sort)
in (unfold_whnf env _0_262))
in (match (t.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) -> begin
[]
end
| uu____611 -> begin
(let _0_263 = (FStar_Syntax_Syntax.bv_to_name b)
in (_0_263)::[])
end))
end)))))
in (

let as_lex_list = (fun dec -> (

let uu____616 = (FStar_Syntax_Util.head_and_args dec)
in (match (uu____616) with
| (head, uu____627) -> begin
(match (head.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.lexcons_lid) -> begin
dec
end
| uu____643 -> begin
(mk_lex_list ((dec)::[]))
end)
end)))
in (

let cflags = (FStar_Syntax_Util.comp_flags c)
in (

let uu____646 = (FStar_All.pipe_right cflags (FStar_List.tryFind (fun uu___76_650 -> (match (uu___76_650) with
| FStar_Syntax_Syntax.DECREASES (uu____651) -> begin
true
end
| uu____654 -> begin
false
end))))
in (match (uu____646) with
| Some (FStar_Syntax_Syntax.DECREASES (dec)) -> begin
(as_lex_list dec)
end
| uu____658 -> begin
(

let xs = (FStar_All.pipe_right bs filter_types_and_functions)
in (match (xs) with
| (x)::[] -> begin
x
end
| uu____664 -> begin
(mk_lex_list xs)
end))
end))))))
in (

let previous_dec = (decreases_clause actuals expected_c)
in (

let guard_one_letrec = (fun uu____676 -> (match (uu____676) with
| (l, t) -> begin
(

let uu____685 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____685) with
| FStar_Syntax_Syntax.Tm_arrow (formals, c) -> begin
(

let formals = (FStar_All.pipe_right formals (FStar_List.map (fun uu____716 -> (match (uu____716) with
| (x, imp) -> begin
(

let uu____723 = (FStar_Syntax_Syntax.is_null_bv x)
in (match (uu____723) with
| true -> begin
(let _0_265 = (let _0_264 = Some ((FStar_Syntax_Syntax.range_of_bv x))
in (FStar_Syntax_Syntax.new_bv _0_264 x.FStar_Syntax_Syntax.sort))
in ((_0_265), (imp)))
end
| uu____726 -> begin
((x), (imp))
end))
end))))
in (

let uu____727 = (FStar_Syntax_Subst.open_comp formals c)
in (match (uu____727) with
| (formals, c) -> begin
(

let dec = (decreases_clause formals c)
in (

let precedes = ((let _0_269 = (let _0_268 = (FStar_Syntax_Syntax.as_arg dec)
in (let _0_267 = (let _0_266 = (FStar_Syntax_Syntax.as_arg previous_dec)
in (_0_266)::[])
in (_0_268)::_0_267))
in (FStar_Syntax_Syntax.mk_Tm_app precedes _0_269)) None r)
in (

let uu____744 = (FStar_Util.prefix formals)
in (match (uu____744) with
| (bs, (last, imp)) -> begin
(

let last = (

let uu___84_770 = last
in (let _0_270 = (FStar_Syntax_Util.refine last precedes)
in {FStar_Syntax_Syntax.ppname = uu___84_770.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___84_770.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _0_270}))
in (

let refined_formals = (FStar_List.append bs ((((last), (imp)))::[]))
in (

let t' = (FStar_Syntax_Util.arrow refined_formals c)
in ((

let uu____785 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____785) with
| true -> begin
(let _0_273 = (FStar_Syntax_Print.lbname_to_string l)
in (let _0_272 = (FStar_Syntax_Print.term_to_string t)
in (let _0_271 = (FStar_Syntax_Print.term_to_string t')
in (FStar_Util.print3 "Refined let rec %s\n\tfrom type %s\n\tto type %s\n" _0_273 _0_272 _0_271))))
end
| uu____786 -> begin
()
end));
((l), (t'));
))))
end))))
end)))
end
| uu____789 -> begin
(Prims.raise (FStar_Errors.Error ((("Annotated type of \'let rec\' must be an arrow"), (t.FStar_Syntax_Syntax.pos)))))
end))
end))
in (FStar_All.pipe_right letrecs (FStar_List.map guard_one_letrec))))))))
end)
end)))


let rec tc_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (tc_maybe_toplevel_term (

let uu___85_1053 = env
in {FStar_TypeChecker_Env.solver = uu___85_1053.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___85_1053.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___85_1053.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___85_1053.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___85_1053.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___85_1053.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___85_1053.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___85_1053.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___85_1053.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___85_1053.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___85_1053.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___85_1053.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___85_1053.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = uu___85_1053.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___85_1053.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___85_1053.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___85_1053.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___85_1053.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___85_1053.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___85_1053.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___85_1053.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___85_1053.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___85_1053.FStar_TypeChecker_Env.qname_and_index}) e))
and tc_maybe_toplevel_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (

let env = (match ((e.FStar_Syntax_Syntax.pos = FStar_Range.dummyRange)) with
| true -> begin
env
end
| uu____1060 -> begin
(FStar_TypeChecker_Env.set_range env e.FStar_Syntax_Syntax.pos)
end)
in ((

let uu____1062 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____1062) with
| true -> begin
(let _0_276 = (let _0_274 = (FStar_TypeChecker_Env.get_range env)
in (FStar_All.pipe_left FStar_Range.string_of_range _0_274))
in (let _0_275 = (FStar_Syntax_Print.tag_of_term e)
in (FStar_Util.print2 "%s (%s)\n" _0_276 _0_275)))
end
| uu____1063 -> begin
()
end));
(

let top = (FStar_Syntax_Subst.compress e)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (uu____1068) -> begin
(failwith "Impossible")
end
| (FStar_Syntax_Syntax.Tm_uinst (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_refine (_)) | (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
(tc_value env e)
end
| FStar_Syntax_Syntax.Tm_meta (e, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Meta_smt_pat)) -> begin
(

let uu____1107 = (tc_tot_or_gtot_term env e)
in (match (uu____1107) with
| (e, c, g) -> begin
(

let g = (

let uu___86_1118 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = uu___86_1118.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = uu___86_1118.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = uu___86_1118.FStar_TypeChecker_Env.implicits})
in ((e), (c), (g)))
end))
end
| FStar_Syntax_Syntax.Tm_meta (e, FStar_Syntax_Syntax.Meta_pattern (pats)) -> begin
(

let uu____1131 = (FStar_Syntax_Util.type_u ())
in (match (uu____1131) with
| (t, u) -> begin
(

let uu____1139 = (tc_check_tot_or_gtot_term env e t)
in (match (uu____1139) with
| (e, c, g) -> begin
(

let uu____1149 = (

let uu____1158 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____1158) with
| (env, uu____1171) -> begin
(tc_pats env pats)
end))
in (match (uu____1149) with
| (pats, g') -> begin
(

let g' = (

let uu___87_1192 = g'
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = uu___87_1192.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = uu___87_1192.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = uu___87_1192.FStar_TypeChecker_Env.implicits})
in (let _0_278 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((e), (FStar_Syntax_Syntax.Meta_pattern (pats)))))) (Some (t.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (let _0_277 = (FStar_TypeChecker_Rel.conj_guard g g')
in ((_0_278), (c), (_0_277)))))
end))
end))
end))
end
| FStar_Syntax_Syntax.Tm_meta (e, FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence)) -> begin
(

let uu____1212 = (FStar_Syntax_Subst.compress e).FStar_Syntax_Syntax.n
in (match (uu____1212) with
| FStar_Syntax_Syntax.Tm_let ((uu____1216, ({FStar_Syntax_Syntax.lbname = x; FStar_Syntax_Syntax.lbunivs = uu____1218; FStar_Syntax_Syntax.lbtyp = uu____1219; FStar_Syntax_Syntax.lbeff = uu____1220; FStar_Syntax_Syntax.lbdef = e1})::[]), e2) -> begin
(

let uu____1238 = (let _0_279 = (FStar_TypeChecker_Env.set_expected_typ env FStar_TypeChecker_Common.t_unit)
in (tc_term _0_279 e1))
in (match (uu____1238) with
| (e1, c1, g1) -> begin
(

let uu____1248 = (tc_term env e2)
in (match (uu____1248) with
| (e2, c2, g2) -> begin
(

let c = (FStar_TypeChecker_Util.bind e1.FStar_Syntax_Syntax.pos env (Some (e1)) c1 ((None), (c2)))
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let ((let _0_282 = (let _0_281 = (let _0_280 = (FStar_Syntax_Syntax.mk_lb ((x), ([]), (c1.FStar_Syntax_Syntax.eff_name), (FStar_TypeChecker_Common.t_unit), (e1)))
in (_0_280)::[])
in ((false), (_0_281)))
in ((_0_282), (e2)))))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((e), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence)))))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (let _0_283 = (FStar_TypeChecker_Rel.conj_guard g1 g2)
in ((e), (c), (_0_283))))))
end))
end))
end
| uu____1295 -> begin
(

let uu____1296 = (tc_term env e)
in (match (uu____1296) with
| (e, c, g) -> begin
(

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((e), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Sequence)))))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in ((e), (c), (g)))
end))
end))
end
| FStar_Syntax_Syntax.Tm_meta (e, FStar_Syntax_Syntax.Meta_monadic (uu____1320)) -> begin
(tc_term env e)
end
| FStar_Syntax_Syntax.Tm_meta (e, m) -> begin
(

let uu____1335 = (tc_term env e)
in (match (uu____1335) with
| (e, c, g) -> begin
(

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((e), (m))))) (Some (c.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in ((e), (c), (g)))
end))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, FStar_Util.Inr (expected_c), uu____1360) -> begin
(

let uu____1379 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____1379) with
| (env0, uu____1387) -> begin
(

let uu____1390 = (tc_comp env0 expected_c)
in (match (uu____1390) with
| (expected_c, uu____1398, g) -> begin
(

let t_res = (FStar_Syntax_Util.comp_result expected_c)
in (

let uu____1403 = (let _0_284 = (FStar_TypeChecker_Env.set_expected_typ env0 t_res)
in (tc_term _0_284 e))
in (match (uu____1403) with
| (e, c', g') -> begin
(

let uu____1413 = (let _0_286 = (let _0_285 = (c'.FStar_Syntax_Syntax.comp ())
in ((e), (_0_285)))
in (check_expected_effect env0 (Some (expected_c)) _0_286))
in (match (uu____1413) with
| (e, expected_c, g'') -> begin
(

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed (((e), (FStar_Util.Inl (t_res)), (Some ((FStar_Syntax_Util.comp_effect_name expected_c))))))) (Some (t_res.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (

let lc = (FStar_Syntax_Util.lcomp_of_comp expected_c)
in (

let f = (let _0_287 = (FStar_TypeChecker_Rel.conj_guard g' g'')
in (FStar_TypeChecker_Rel.conj_guard g _0_287))
in (

let uu____1449 = (comp_check_expected_typ env e lc)
in (match (uu____1449) with
| (e, c, f2) -> begin
(let _0_288 = (FStar_TypeChecker_Rel.conj_guard f f2)
in ((e), (c), (_0_288)))
end)))))
end))
end)))
end))
end))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, FStar_Util.Inl (t), uu____1461) -> begin
(

let uu____1480 = (FStar_Syntax_Util.type_u ())
in (match (uu____1480) with
| (k, u) -> begin
(

let uu____1488 = (tc_check_tot_or_gtot_term env t k)
in (match (uu____1488) with
| (t, uu____1496, f) -> begin
(

let uu____1498 = (let _0_289 = (FStar_TypeChecker_Env.set_expected_typ env t)
in (tc_term _0_289 e))
in (match (uu____1498) with
| (e, c, g) -> begin
(

let uu____1508 = (let _0_290 = (FStar_TypeChecker_Env.set_range env t.FStar_Syntax_Syntax.pos)
in (FStar_TypeChecker_Util.strengthen_precondition (Some ((fun uu____1513 -> FStar_TypeChecker_Err.ill_kinded_type))) _0_290 e c f))
in (match (uu____1508) with
| (c, f) -> begin
(

let uu____1519 = (let _0_291 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed (((e), (FStar_Util.Inl (t)), (Some (c.FStar_Syntax_Syntax.eff_name)))))) (Some (t.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (comp_check_expected_typ env _0_291 c))
in (match (uu____1519) with
| (e, c, f2) -> begin
(let _0_293 = (let _0_292 = (FStar_TypeChecker_Rel.conj_guard g f2)
in (FStar_TypeChecker_Rel.conj_guard f _0_292))
in ((e), (c), (_0_293)))
end))
end))
end))
end))
end))
end
| (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reify); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, (a)::(hd)::rest)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reflect (_)); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, (a)::(hd)::rest)) -> begin
(

let rest = (hd)::rest
in (

let uu____1624 = (FStar_Syntax_Util.head_and_args top)
in (match (uu____1624) with
| (unary_op, uu____1638) -> begin
(

let head = (let _0_294 = (FStar_Range.union_ranges unary_op.FStar_Syntax_Syntax.pos (Prims.fst a).FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (((unary_op), ((a)::[]))))) None _0_294))
in (

let t = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (((head), (rest))))) None top.FStar_Syntax_Syntax.pos)
in (tc_term env t)))
end)))
end
| FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reify); FStar_Syntax_Syntax.tk = uu____1699; FStar_Syntax_Syntax.pos = uu____1700; FStar_Syntax_Syntax.vars = uu____1701}, ((e, aqual))::[]) -> begin
((match ((FStar_Option.isSome aqual)) with
| true -> begin
(FStar_Errors.warn e.FStar_Syntax_Syntax.pos "Qualifier on argument to reify is irrelevant and will be ignored")
end
| uu____1726 -> begin
()
end);
(

let uu____1727 = (

let uu____1731 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____1731) with
| (env0, uu____1739) -> begin
(tc_term env0 e)
end))
in (match (uu____1727) with
| (e, c, g) -> begin
(

let uu____1748 = (FStar_Syntax_Util.head_and_args top)
in (match (uu____1748) with
| (reify_op, uu____1762) -> begin
(

let u_c = (

let uu____1778 = (tc_term env c.FStar_Syntax_Syntax.res_typ)
in (match (uu____1778) with
| (uu____1782, c, uu____1784) -> begin
(

let uu____1785 = (FStar_Syntax_Subst.compress c.FStar_Syntax_Syntax.res_typ).FStar_Syntax_Syntax.n
in (match (uu____1785) with
| FStar_Syntax_Syntax.Tm_type (u) -> begin
u
end
| uu____1787 -> begin
(failwith "Unexpected result type of computation")
end))
end))
in (

let repr = (FStar_TypeChecker_Util.reify_comp env c u_c)
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (((reify_op), ((((e), (aqual)))::[]))))) (Some (repr.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (

let c = (let _0_295 = (FStar_Syntax_Syntax.mk_Total repr)
in (FStar_All.pipe_right _0_295 FStar_Syntax_Util.lcomp_of_comp))
in (

let uu____1810 = (comp_check_expected_typ env e c)
in (match (uu____1810) with
| (e, c, g') -> begin
(let _0_296 = (FStar_TypeChecker_Rel.conj_guard g g')
in ((e), (c), (_0_296)))
end))))))
end))
end));
)
end
| FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reflect (l)); FStar_Syntax_Syntax.tk = uu____1821; FStar_Syntax_Syntax.pos = uu____1822; FStar_Syntax_Syntax.vars = uu____1823}, ((e, aqual))::[]) -> begin
((match ((FStar_Option.isSome aqual)) with
| true -> begin
(FStar_Errors.warn e.FStar_Syntax_Syntax.pos "Qualifier on argument to reflect is irrelevant and will be ignored")
end
| uu____1848 -> begin
()
end);
(

let no_reflect = (fun uu____1855 -> (Prims.raise (FStar_Errors.Error ((let _0_297 = (FStar_Util.format1 "Effect %s cannot be reified" l.FStar_Ident.str)
in ((_0_297), (e.FStar_Syntax_Syntax.pos)))))))
in (

let uu____1859 = (FStar_Syntax_Util.head_and_args top)
in (match (uu____1859) with
| (reflect_op, uu____1873) -> begin
(

let uu____1888 = (FStar_TypeChecker_Env.effect_decl_opt env l)
in (match (uu____1888) with
| None -> begin
(no_reflect ())
end
| Some (ed) -> begin
(

let uu____1894 = (not ((FStar_All.pipe_right ed.FStar_Syntax_Syntax.qualifiers FStar_Syntax_Syntax.contains_reflectable)))
in (match (uu____1894) with
| true -> begin
(no_reflect ())
end
| uu____1899 -> begin
(

let uu____1900 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____1900) with
| (env_no_ex, topt) -> begin
(

let uu____1911 = (

let u = (FStar_TypeChecker_Env.new_u_univ ())
in (

let repr = (FStar_TypeChecker_Env.inst_effect_fun_with ((u)::[]) env ed (([]), (ed.FStar_Syntax_Syntax.repr)))
in (

let t = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((let _0_301 = (let _0_300 = (FStar_Syntax_Syntax.as_arg FStar_Syntax_Syntax.tun)
in (let _0_299 = (let _0_298 = (FStar_Syntax_Syntax.as_arg FStar_Syntax_Syntax.tun)
in (_0_298)::[])
in (_0_300)::_0_299))
in ((repr), (_0_301)))))) None top.FStar_Syntax_Syntax.pos)
in (

let uu____1935 = (let _0_303 = (let _0_302 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _0_302 Prims.fst))
in (tc_tot_or_gtot_term _0_303 t))
in (match (uu____1935) with
| (t, uu____1952, g) -> begin
(

let uu____1954 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____1954) with
| FStar_Syntax_Syntax.Tm_app (uu____1963, ((res, uu____1965))::((wp, uu____1967))::[]) -> begin
((t), (res), (wp), (g))
end
| uu____2001 -> begin
(failwith "Impossible")
end))
end)))))
in (match (uu____1911) with
| (expected_repr_typ, res_typ, wp, g0) -> begin
(

let uu____2025 = (

let uu____2028 = (tc_tot_or_gtot_term env_no_ex e)
in (match (uu____2028) with
| (e, c, g) -> begin
((

let uu____2038 = (let _0_304 = (FStar_Syntax_Util.is_total_lcomp c)
in (FStar_All.pipe_left Prims.op_Negation _0_304))
in (match (uu____2038) with
| true -> begin
(FStar_TypeChecker_Err.add_errors env (((("Expected Tot, got a GTot computation"), (e.FStar_Syntax_Syntax.pos)))::[]))
end
| uu____2043 -> begin
()
end));
(

let uu____2044 = (FStar_TypeChecker_Rel.try_teq env_no_ex c.FStar_Syntax_Syntax.res_typ expected_repr_typ)
in (match (uu____2044) with
| None -> begin
((let _0_309 = (let _0_308 = (let _0_307 = (let _0_306 = (FStar_Syntax_Print.term_to_string ed.FStar_Syntax_Syntax.repr)
in (let _0_305 = (FStar_Syntax_Print.term_to_string c.FStar_Syntax_Syntax.res_typ)
in (FStar_Util.format2 "Expected an instance of %s; got %s" _0_306 _0_305)))
in ((_0_307), (e.FStar_Syntax_Syntax.pos)))
in (_0_308)::[])
in (FStar_TypeChecker_Err.add_errors env _0_309));
(let _0_310 = (FStar_TypeChecker_Rel.conj_guard g g0)
in ((e), (_0_310)));
)
end
| Some (g') -> begin
(let _0_312 = (let _0_311 = (FStar_TypeChecker_Rel.conj_guard g g0)
in (FStar_TypeChecker_Rel.conj_guard g' _0_311))
in ((e), (_0_312)))
end));
)
end))
in (match (uu____2025) with
| (e, g) -> begin
(

let c = (let _0_317 = (FStar_Syntax_Syntax.mk_Comp (let _0_316 = (let _0_313 = (env.FStar_TypeChecker_Env.universe_of env res_typ)
in (_0_313)::[])
in (let _0_315 = (let _0_314 = (FStar_Syntax_Syntax.as_arg wp)
in (_0_314)::[])
in {FStar_Syntax_Syntax.comp_univs = _0_316; FStar_Syntax_Syntax.effect_name = ed.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.result_typ = res_typ; FStar_Syntax_Syntax.effect_args = _0_315; FStar_Syntax_Syntax.flags = []})))
in (FStar_All.pipe_right _0_317 FStar_Syntax_Util.lcomp_of_comp))
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (((reflect_op), ((((e), (aqual)))::[]))))) (Some (res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (

let uu____2080 = (comp_check_expected_typ env e c)
in (match (uu____2080) with
| (e, c, g') -> begin
(let _0_318 = (FStar_TypeChecker_Rel.conj_guard g' g)
in ((e), (c), (_0_318)))
end))))
end))
end))
end))
end))
end))
end)));
)
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let env0 = env
in (

let env = (let _0_320 = (let _0_319 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _0_319 Prims.fst))
in (FStar_All.pipe_right _0_320 instantiate_both))
in ((

let uu____2113 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____2113) with
| true -> begin
(let _0_322 = (FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos)
in (let _0_321 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.print2 "(%s) Checking app %s\n" _0_322 _0_321)))
end
| uu____2114 -> begin
()
end));
(

let uu____2115 = (tc_term (no_inst env) head)
in (match (uu____2115) with
| (head, chead, g_head) -> begin
(

let uu____2125 = (

let uu____2129 = ((not (env.FStar_TypeChecker_Env.lax)) && (FStar_TypeChecker_Util.short_circuit_head head))
in (match (uu____2129) with
| true -> begin
(let _0_323 = (FStar_TypeChecker_Env.expected_typ env0)
in (check_short_circuit_args env head chead g_head args _0_323))
end
| uu____2133 -> begin
(let _0_324 = (FStar_TypeChecker_Env.expected_typ env0)
in (check_application_args env head chead g_head args _0_324))
end))
in (match (uu____2125) with
| (e, c, g) -> begin
((

let uu____2141 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____2141) with
| true -> begin
(let _0_325 = (FStar_TypeChecker_Rel.print_pending_implicits g)
in (FStar_Util.print1 "Introduced {%s} implicits in application\n" _0_325))
end
| uu____2142 -> begin
()
end));
(

let c = (

let uu____2144 = (((FStar_TypeChecker_Env.should_verify env) && (not ((FStar_Syntax_Util.is_lcomp_partial_return c)))) && (FStar_Syntax_Util.is_pure_or_ghost_lcomp c))
in (match (uu____2144) with
| true -> begin
(FStar_TypeChecker_Util.maybe_assume_result_eq_pure_term env e c)
end
| uu____2145 -> begin
c
end))
in (

let uu____2146 = (comp_check_expected_typ env0 e c)
in (match (uu____2146) with
| (e, c, g') -> begin
(

let gimp = (

let uu____2157 = (FStar_Syntax_Subst.compress head).FStar_Syntax_Syntax.n
in (match (uu____2157) with
| FStar_Syntax_Syntax.Tm_uvar (u, uu____2159) -> begin
(

let imp = (("head of application is a uvar"), (env0), (u), (e), (c.FStar_Syntax_Syntax.res_typ), (head.FStar_Syntax_Syntax.pos))
in (

let uu___88_2191 = FStar_TypeChecker_Rel.trivial_guard
in {FStar_TypeChecker_Env.guard_f = uu___88_2191.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = uu___88_2191.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = uu___88_2191.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = (imp)::[]}))
end
| uu____2216 -> begin
FStar_TypeChecker_Rel.trivial_guard
end))
in (

let gres = (let _0_326 = (FStar_TypeChecker_Rel.conj_guard g' gimp)
in (FStar_TypeChecker_Rel.conj_guard g _0_326))
in ((

let uu____2219 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____2219) with
| true -> begin
(let _0_328 = (FStar_Syntax_Print.term_to_string e)
in (let _0_327 = (FStar_TypeChecker_Rel.guard_to_string env gres)
in (FStar_Util.print2 "Guard from application node %s is %s\n" _0_328 _0_327)))
end
| uu____2220 -> begin
()
end));
((e), (c), (gres));
)))
end)));
)
end))
end));
)))
end
| FStar_Syntax_Syntax.Tm_match (e1, eqns) -> begin
(

let uu____2249 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____2249) with
| (env1, topt) -> begin
(

let env1 = (instantiate_both env1)
in (

let uu____2261 = (tc_term env1 e1)
in (match (uu____2261) with
| (e1, c1, g1) -> begin
(

let uu____2271 = (match (topt) with
| Some (t) -> begin
((env), (t))
end
| None -> begin
(

let uu____2277 = (FStar_Syntax_Util.type_u ())
in (match (uu____2277) with
| (k, uu____2283) -> begin
(

let res_t = (FStar_TypeChecker_Util.new_uvar env k)
in (let _0_329 = (FStar_TypeChecker_Env.set_expected_typ env res_t)
in ((_0_329), (res_t))))
end))
end)
in (match (uu____2271) with
| (env_branches, res_t) -> begin
((

let uu____2291 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____2291) with
| true -> begin
(let _0_330 = (FStar_Syntax_Print.term_to_string res_t)
in (FStar_Util.print1 "Tm_match: expected type of branches is %s\n" _0_330))
end
| uu____2292 -> begin
()
end));
(

let guard_x = (FStar_Syntax_Syntax.new_bv (Some (e1.FStar_Syntax_Syntax.pos)) c1.FStar_Syntax_Syntax.res_typ)
in (

let t_eqns = (FStar_All.pipe_right eqns (FStar_List.map (tc_eqn guard_x env_branches)))
in (

let uu____2342 = (

let uu____2345 = (FStar_List.fold_right (fun uu____2364 uu____2365 -> (match (((uu____2364), (uu____2365))) with
| ((uu____2397, f, c, g), (caccum, gaccum)) -> begin
(let _0_331 = (FStar_TypeChecker_Rel.conj_guard g gaccum)
in (((((f), (c)))::caccum), (_0_331)))
end)) t_eqns (([]), (FStar_TypeChecker_Rel.trivial_guard)))
in (match (uu____2345) with
| (cases, g) -> begin
(let _0_332 = (FStar_TypeChecker_Util.bind_cases env res_t cases)
in ((_0_332), (g)))
end))
in (match (uu____2342) with
| (c_branches, g_branches) -> begin
(

let cres = (FStar_TypeChecker_Util.bind e1.FStar_Syntax_Syntax.pos env (Some (e1)) c1 ((Some (guard_x)), (c_branches)))
in (

let e = (

let mk_match = (fun scrutinee -> (

let branches = (FStar_All.pipe_right t_eqns (FStar_List.map (fun uu____2502 -> (match (uu____2502) with
| ((pat, wopt, br), uu____2518, lc, uu____2520) -> begin
(let _0_333 = (FStar_TypeChecker_Util.maybe_lift env br lc.FStar_Syntax_Syntax.eff_name cres.FStar_Syntax_Syntax.eff_name lc.FStar_Syntax_Syntax.res_typ)
in ((pat), (wopt), (_0_333)))
end))))
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_match (((scrutinee), (branches))))) (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_ascribed (((e), (FStar_Util.Inl (cres.FStar_Syntax_Syntax.res_typ)), (Some (cres.FStar_Syntax_Syntax.eff_name)))))) None e.FStar_Syntax_Syntax.pos))))
in (

let uu____2567 = (FStar_TypeChecker_Util.is_pure_or_ghost_effect env c1.FStar_Syntax_Syntax.eff_name)
in (match (uu____2567) with
| true -> begin
(mk_match e1)
end
| uu____2570 -> begin
(

let e_match = (mk_match (FStar_Syntax_Syntax.bv_to_name guard_x))
in (

let lb = (let _0_334 = (FStar_TypeChecker_Env.norm_eff_name env c1.FStar_Syntax_Syntax.eff_name)
in {FStar_Syntax_Syntax.lbname = FStar_Util.Inl (guard_x); FStar_Syntax_Syntax.lbunivs = []; FStar_Syntax_Syntax.lbtyp = c1.FStar_Syntax_Syntax.res_typ; FStar_Syntax_Syntax.lbeff = _0_334; FStar_Syntax_Syntax.lbdef = e1})
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let ((let _0_337 = (let _0_336 = (let _0_335 = (FStar_Syntax_Syntax.mk_binder guard_x)
in (_0_335)::[])
in (FStar_Syntax_Subst.close _0_336 e_match))
in ((((false), ((lb)::[]))), (_0_337)))))) (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (FStar_TypeChecker_Util.maybe_monadic env e cres.FStar_Syntax_Syntax.eff_name cres.FStar_Syntax_Syntax.res_typ))))
end)))
in ((

let uu____2591 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____2591) with
| true -> begin
(let _0_340 = (FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos)
in (let _0_339 = (let _0_338 = (cres.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _0_338))
in (FStar_Util.print2 "(%s) comp type = %s\n" _0_340 _0_339)))
end
| uu____2592 -> begin
()
end));
(let _0_341 = (FStar_TypeChecker_Rel.conj_guard g1 g_branches)
in ((e), (cres), (_0_341)));
)))
end))));
)
end))
end)))
end))
end
| FStar_Syntax_Syntax.Tm_let ((false, ({FStar_Syntax_Syntax.lbname = FStar_Util.Inr (uu____2595); FStar_Syntax_Syntax.lbunivs = uu____2596; FStar_Syntax_Syntax.lbtyp = uu____2597; FStar_Syntax_Syntax.lbeff = uu____2598; FStar_Syntax_Syntax.lbdef = uu____2599})::[]), uu____2600) -> begin
((

let uu____2615 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____2615) with
| true -> begin
(let _0_342 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.print1 "%s\n" _0_342))
end
| uu____2616 -> begin
()
end));
(check_top_level_let env top);
)
end
| FStar_Syntax_Syntax.Tm_let ((false, uu____2617), uu____2618) -> begin
(check_inner_let env top)
end
| FStar_Syntax_Syntax.Tm_let ((true, ({FStar_Syntax_Syntax.lbname = FStar_Util.Inr (uu____2628); FStar_Syntax_Syntax.lbunivs = uu____2629; FStar_Syntax_Syntax.lbtyp = uu____2630; FStar_Syntax_Syntax.lbeff = uu____2631; FStar_Syntax_Syntax.lbdef = uu____2632})::uu____2633), uu____2634) -> begin
((

let uu____2650 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____2650) with
| true -> begin
(let _0_343 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.print1 "%s\n" _0_343))
end
| uu____2651 -> begin
()
end));
(check_top_level_let_rec env top);
)
end
| FStar_Syntax_Syntax.Tm_let ((true, uu____2652), uu____2653) -> begin
(check_inner_let_rec env top)
end));
)))
and tc_value : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (

let check_instantiated_fvar = (fun env v dc e t -> (

let uu____2697 = (FStar_TypeChecker_Util.maybe_instantiate env e t)
in (match (uu____2697) with
| (e, t, implicits) -> begin
(

let tc = (

let uu____2710 = (FStar_TypeChecker_Env.should_verify env)
in (match (uu____2710) with
| true -> begin
FStar_Util.Inl (t)
end
| uu____2713 -> begin
FStar_Util.Inr ((let _0_344 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _0_344)))
end))
in (

let is_data_ctor = (fun uu___77_2720 -> (match (uu___77_2720) with
| (Some (FStar_Syntax_Syntax.Data_ctor)) | (Some (FStar_Syntax_Syntax.Record_ctor (_))) -> begin
true
end
| uu____2723 -> begin
false
end))
in (

let uu____2725 = ((is_data_ctor dc) && (not ((FStar_TypeChecker_Env.is_datacon env v.FStar_Syntax_Syntax.v))))
in (match (uu____2725) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((let _0_346 = (FStar_Util.format1 "Expected a data constructor; got %s" v.FStar_Syntax_Syntax.v.FStar_Ident.str)
in (let _0_345 = (FStar_TypeChecker_Env.get_range env)
in ((_0_346), (_0_345)))))))
end
| uu____2736 -> begin
(value_check_expected_typ env e tc implicits)
end))))
end)))
in (

let env = (FStar_TypeChecker_Env.set_range env e.FStar_Syntax_Syntax.pos)
in (

let top = (FStar_Syntax_Subst.compress e)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_bvar (x) -> begin
(failwith (let _0_347 = (FStar_Syntax_Print.term_to_string top)
in (FStar_Util.format1 "Impossible: Violation of locally nameless convention: %s" _0_347)))
end
| FStar_Syntax_Syntax.Tm_uvar (u, t1) -> begin
(

let g = (

let uu____2761 = (FStar_Syntax_Subst.compress t1).FStar_Syntax_Syntax.n
in (match (uu____2761) with
| FStar_Syntax_Syntax.Tm_arrow (uu____2762) -> begin
FStar_TypeChecker_Rel.trivial_guard
end
| uu____2770 -> begin
(

let imp = (("uvar in term"), (env), (u), (top), (t1), (top.FStar_Syntax_Syntax.pos))
in (

let uu___89_2790 = FStar_TypeChecker_Rel.trivial_guard
in {FStar_TypeChecker_Env.guard_f = uu___89_2790.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = uu___89_2790.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = uu___89_2790.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = (imp)::[]}))
end))
in (value_check_expected_typ env e (FStar_Util.Inl (t1)) g))
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
(

let r = (FStar_TypeChecker_Env.get_range env)
in (

let uu____2818 = (

let uu____2825 = (FStar_TypeChecker_Env.expected_typ env)
in (match (uu____2825) with
| None -> begin
(

let uu____2833 = (FStar_Syntax_Util.type_u ())
in (match (uu____2833) with
| (k, u) -> begin
(FStar_TypeChecker_Util.new_implicit_var "type of user-provided implicit term" r env k)
end))
end
| Some (t) -> begin
((t), ([]), (FStar_TypeChecker_Rel.trivial_guard))
end))
in (match (uu____2818) with
| (t, uu____2854, g0) -> begin
(

let uu____2862 = (FStar_TypeChecker_Util.new_implicit_var "user-provided implicit term" r env t)
in (match (uu____2862) with
| (e, uu____2873, g1) -> begin
(let _0_350 = (let _0_348 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_All.pipe_right _0_348 FStar_Syntax_Util.lcomp_of_comp))
in (let _0_349 = (FStar_TypeChecker_Rel.conj_guard g0 g1)
in ((e), (_0_350), (_0_349))))
end))
end)))
end
| FStar_Syntax_Syntax.Tm_name (x) -> begin
(

let t = (match (env.FStar_TypeChecker_Env.use_bv_sorts) with
| true -> begin
x.FStar_Syntax_Syntax.sort
end
| uu____2887 -> begin
(FStar_TypeChecker_Env.lookup_bv env x)
end)
in (

let e = (FStar_Syntax_Syntax.bv_to_name (

let uu___90_2889 = x
in {FStar_Syntax_Syntax.ppname = uu___90_2889.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___90_2889.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}))
in (

let uu____2890 = (FStar_TypeChecker_Util.maybe_instantiate env e t)
in (match (uu____2890) with
| (e, t, implicits) -> begin
(

let tc = (

let uu____2903 = (FStar_TypeChecker_Env.should_verify env)
in (match (uu____2903) with
| true -> begin
FStar_Util.Inl (t)
end
| uu____2906 -> begin
FStar_Util.Inr ((let _0_351 = (FStar_Syntax_Syntax.mk_Total t)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _0_351)))
end))
in (value_check_expected_typ env e tc implicits))
end))))
end
| FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (fv); FStar_Syntax_Syntax.tk = uu____2910; FStar_Syntax_Syntax.pos = uu____2911; FStar_Syntax_Syntax.vars = uu____2912}, us) -> begin
(

let us = (FStar_List.map (tc_universe env) us)
in (

let uu____2920 = (FStar_TypeChecker_Env.lookup_lid env fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (match (uu____2920) with
| (us', t) -> begin
((match (((FStar_List.length us) <> (FStar_List.length us'))) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((let _0_352 = (FStar_TypeChecker_Env.get_range env)
in (("Unexpected number of universe instantiations"), (_0_352))))))
end
| uu____2937 -> begin
(FStar_List.iter2 (fun u' u -> (match (u') with
| FStar_Syntax_Syntax.U_unif (u'') -> begin
(FStar_Unionfind.change u'' (Some (u)))
end
| uu____2944 -> begin
(failwith "Impossible")
end)) us' us)
end);
(

let fv' = (

let uu___91_2946 = fv
in {FStar_Syntax_Syntax.fv_name = (

let uu___92_2947 = fv.FStar_Syntax_Syntax.fv_name
in {FStar_Syntax_Syntax.v = uu___92_2947.FStar_Syntax_Syntax.v; FStar_Syntax_Syntax.ty = t; FStar_Syntax_Syntax.p = uu___92_2947.FStar_Syntax_Syntax.p}); FStar_Syntax_Syntax.fv_delta = uu___91_2946.FStar_Syntax_Syntax.fv_delta; FStar_Syntax_Syntax.fv_qual = uu___91_2946.FStar_Syntax_Syntax.fv_qual})
in (

let e = (let _0_353 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_fvar (fv'))) (Some (t.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk_Tm_uinst _0_353 us))
in (check_instantiated_fvar env fv'.FStar_Syntax_Syntax.fv_name fv'.FStar_Syntax_Syntax.fv_qual e t)));
)
end)))
end
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(

let uu____2980 = (FStar_TypeChecker_Env.lookup_lid env fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (match (uu____2980) with
| (us, t) -> begin
((

let uu____2993 = (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Range")))
in (match (uu____2993) with
| true -> begin
(let _0_358 = (FStar_Syntax_Print.lid_to_string (FStar_Syntax_Syntax.lid_of_fv fv))
in (let _0_357 = (FStar_Range.string_of_range e.FStar_Syntax_Syntax.pos)
in (let _0_356 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid (FStar_Syntax_Syntax.lid_of_fv fv)))
in (let _0_355 = (FStar_Range.string_of_use_range (FStar_Ident.range_of_lid (FStar_Syntax_Syntax.lid_of_fv fv)))
in (let _0_354 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print5 "Lookup up fvar %s at location %s (lid range = %s, %s); got type %s" _0_358 _0_357 _0_356 _0_355 _0_354))))))
end
| uu____2994 -> begin
()
end));
(

let fv' = (

let uu___93_2996 = fv
in {FStar_Syntax_Syntax.fv_name = (

let uu___94_2997 = fv.FStar_Syntax_Syntax.fv_name
in {FStar_Syntax_Syntax.v = uu___94_2997.FStar_Syntax_Syntax.v; FStar_Syntax_Syntax.ty = t; FStar_Syntax_Syntax.p = uu___94_2997.FStar_Syntax_Syntax.p}); FStar_Syntax_Syntax.fv_delta = uu___93_2996.FStar_Syntax_Syntax.fv_delta; FStar_Syntax_Syntax.fv_qual = uu___93_2996.FStar_Syntax_Syntax.fv_qual})
in (

let e = (let _0_359 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_fvar (fv'))) (Some (t.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk_Tm_uinst _0_359 us))
in (check_instantiated_fvar env fv'.FStar_Syntax_Syntax.fv_name fv'.FStar_Syntax_Syntax.fv_qual e t)));
)
end))
end
| FStar_Syntax_Syntax.Tm_constant (c) -> begin
(

let t = (tc_constant top.FStar_Syntax_Syntax.pos c)
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (c))) (Some (t.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (value_check_expected_typ env e (FStar_Util.Inl (t)) FStar_TypeChecker_Rel.trivial_guard)))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let uu____3054 = (FStar_Syntax_Subst.open_comp bs c)
in (match (uu____3054) with
| (bs, c) -> begin
(

let env0 = env
in (

let uu____3063 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____3063) with
| (env, uu____3071) -> begin
(

let uu____3074 = (tc_binders env bs)
in (match (uu____3074) with
| (bs, env, g, us) -> begin
(

let uu____3086 = (tc_comp env c)
in (match (uu____3086) with
| (c, uc, f) -> begin
(

let e = (

let uu___95_3099 = (FStar_Syntax_Util.arrow bs c)
in {FStar_Syntax_Syntax.n = uu___95_3099.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = uu___95_3099.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = top.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = uu___95_3099.FStar_Syntax_Syntax.vars})
in ((check_smt_pat env e bs c);
(

let u = FStar_Syntax_Syntax.U_max ((uc)::us)
in (

let t = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u))) None top.FStar_Syntax_Syntax.pos)
in (

let g = (let _0_360 = (FStar_TypeChecker_Rel.close_guard bs f)
in (FStar_TypeChecker_Rel.conj_guard g _0_360))
in (value_check_expected_typ env0 e (FStar_Util.Inl (t)) g))));
))
end))
end))
end)))
end))
end
| FStar_Syntax_Syntax.Tm_type (u) -> begin
(

let u = (tc_universe env u)
in (

let t = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (FStar_Syntax_Syntax.U_succ (u)))) None top.FStar_Syntax_Syntax.pos)
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u))) (Some (t.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (value_check_expected_typ env e (FStar_Util.Inl (t)) FStar_TypeChecker_Rel.trivial_guard))))
end
| FStar_Syntax_Syntax.Tm_refine (x, phi) -> begin
(

let uu____3154 = (let _0_362 = (let _0_361 = (FStar_Syntax_Syntax.mk_binder x)
in (_0_361)::[])
in (FStar_Syntax_Subst.open_term _0_362 phi))
in (match (uu____3154) with
| (x, phi) -> begin
(

let env0 = env
in (

let uu____3163 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____3163) with
| (env, uu____3171) -> begin
(

let uu____3174 = (let _0_363 = (FStar_List.hd x)
in (tc_binder env _0_363))
in (match (uu____3174) with
| (x, env, f1, u) -> begin
((

let uu____3195 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____3195) with
| true -> begin
(let _0_366 = (FStar_Range.string_of_range top.FStar_Syntax_Syntax.pos)
in (let _0_365 = (FStar_Syntax_Print.term_to_string phi)
in (let _0_364 = (FStar_Syntax_Print.bv_to_string (Prims.fst x))
in (FStar_Util.print3 "(%s) Checking refinement formula %s; binder is %s\n" _0_366 _0_365 _0_364))))
end
| uu____3196 -> begin
()
end));
(

let uu____3197 = (FStar_Syntax_Util.type_u ())
in (match (uu____3197) with
| (t_phi, uu____3204) -> begin
(

let uu____3205 = (tc_check_tot_or_gtot_term env phi t_phi)
in (match (uu____3205) with
| (phi, uu____3213, f2) -> begin
(

let e = (

let uu___96_3218 = (FStar_Syntax_Util.refine (Prims.fst x) phi)
in {FStar_Syntax_Syntax.n = uu___96_3218.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = uu___96_3218.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = top.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = uu___96_3218.FStar_Syntax_Syntax.vars})
in (

let t = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_type (u))) None top.FStar_Syntax_Syntax.pos)
in (

let g = (let _0_367 = (FStar_TypeChecker_Rel.close_guard ((x)::[]) f2)
in (FStar_TypeChecker_Rel.conj_guard f1 _0_367))
in (value_check_expected_typ env0 e (FStar_Util.Inl (t)) g))))
end))
end));
)
end))
end)))
end))
end
| FStar_Syntax_Syntax.Tm_abs (bs, body, uu____3245) -> begin
(

let bs = (FStar_TypeChecker_Util.maybe_add_implicit_binders env bs)
in ((

let uu____3270 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____3270) with
| true -> begin
(let _0_368 = (FStar_Syntax_Print.term_to_string (

let uu___97_3271 = top
in {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_abs (((bs), (body), (None))); FStar_Syntax_Syntax.tk = uu___97_3271.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = uu___97_3271.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = uu___97_3271.FStar_Syntax_Syntax.vars}))
in (FStar_Util.print1 "Abstraction is: %s\n" _0_368))
end
| uu____3289 -> begin
()
end));
(

let uu____3290 = (FStar_Syntax_Subst.open_term bs body)
in (match (uu____3290) with
| (bs, body) -> begin
(tc_abs env top bs body)
end));
))
end
| uu____3298 -> begin
(failwith (let _0_370 = (FStar_Syntax_Print.term_to_string top)
in (let _0_369 = (FStar_Syntax_Print.tag_of_term top)
in (FStar_Util.format2 "Unexpected value: %s (%s)" _0_370 _0_369))))
end)))))
and tc_constant : FStar_Range.range  ->  FStar_Const.sconst  ->  FStar_Syntax_Syntax.typ = (fun r c -> (match (c) with
| FStar_Const.Const_unit -> begin
FStar_TypeChecker_Common.t_unit
end
| FStar_Const.Const_bool (uu____3304) -> begin
FStar_TypeChecker_Common.t_bool
end
| FStar_Const.Const_int (uu____3305, None) -> begin
FStar_TypeChecker_Common.t_int
end
| FStar_Const.Const_int (uu____3311, Some (uu____3312)) -> begin
(failwith "machine integers should be desugared")
end
| FStar_Const.Const_string (uu____3320) -> begin
FStar_TypeChecker_Common.t_string
end
| FStar_Const.Const_float (uu____3324) -> begin
FStar_TypeChecker_Common.t_float
end
| FStar_Const.Const_char (uu____3325) -> begin
FStar_TypeChecker_Common.t_char
end
| FStar_Const.Const_effect -> begin
FStar_Syntax_Util.ktype0
end
| FStar_Const.Const_range (uu____3326) -> begin
FStar_TypeChecker_Common.t_range
end
| uu____3327 -> begin
(Prims.raise (FStar_Errors.Error ((("Unsupported constant"), (r)))))
end))
and tc_comp : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp  ->  (FStar_Syntax_Syntax.comp * FStar_Syntax_Syntax.universe * FStar_TypeChecker_Env.guard_t) = (fun env c -> (

let c0 = c
in (match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (t, uu____3338) -> begin
(

let uu____3345 = (FStar_Syntax_Util.type_u ())
in (match (uu____3345) with
| (k, u) -> begin
(

let uu____3353 = (tc_check_tot_or_gtot_term env t k)
in (match (uu____3353) with
| (t, uu____3361, g) -> begin
(let _0_371 = (FStar_Syntax_Syntax.mk_Total' t (Some (u)))
in ((_0_371), (u), (g)))
end))
end))
end
| FStar_Syntax_Syntax.GTotal (t, uu____3364) -> begin
(

let uu____3371 = (FStar_Syntax_Util.type_u ())
in (match (uu____3371) with
| (k, u) -> begin
(

let uu____3379 = (tc_check_tot_or_gtot_term env t k)
in (match (uu____3379) with
| (t, uu____3387, g) -> begin
(let _0_372 = (FStar_Syntax_Syntax.mk_GTotal' t (Some (u)))
in ((_0_372), (u), (g)))
end))
end))
end
| FStar_Syntax_Syntax.Comp (c) -> begin
(

let head = (FStar_Syntax_Syntax.fvar c.FStar_Syntax_Syntax.effect_name FStar_Syntax_Syntax.Delta_constant None)
in (

let head = (match (c.FStar_Syntax_Syntax.comp_univs) with
| [] -> begin
head
end
| us -> begin
((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uinst (((head), (us))))) None c0.FStar_Syntax_Syntax.pos)
end)
in (

let tc = ((let _0_374 = (let _0_373 = (FStar_Syntax_Syntax.as_arg c.FStar_Syntax_Syntax.result_typ)
in (_0_373)::c.FStar_Syntax_Syntax.effect_args)
in (FStar_Syntax_Syntax.mk_Tm_app head _0_374)) None c.FStar_Syntax_Syntax.result_typ.FStar_Syntax_Syntax.pos)
in (

let uu____3408 = (tc_check_tot_or_gtot_term env tc FStar_Syntax_Syntax.teff)
in (match (uu____3408) with
| (tc, uu____3416, f) -> begin
(

let uu____3418 = (FStar_Syntax_Util.head_and_args tc)
in (match (uu____3418) with
| (head, args) -> begin
(

let comp_univs = (

let uu____3448 = (FStar_Syntax_Subst.compress head).FStar_Syntax_Syntax.n
in (match (uu____3448) with
| FStar_Syntax_Syntax.Tm_uinst (uu____3449, us) -> begin
us
end
| uu____3455 -> begin
[]
end))
in (

let uu____3456 = (FStar_Syntax_Util.head_and_args tc)
in (match (uu____3456) with
| (uu____3469, args) -> begin
(

let uu____3485 = (let _0_376 = (FStar_List.hd args)
in (let _0_375 = (FStar_List.tl args)
in ((_0_376), (_0_375))))
in (match (uu____3485) with
| (res, args) -> begin
(

let uu____3537 = (let _0_377 = (FStar_All.pipe_right c.FStar_Syntax_Syntax.flags (FStar_List.map (fun uu___78_3555 -> (match (uu___78_3555) with
| FStar_Syntax_Syntax.DECREASES (e) -> begin
(

let uu____3561 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____3561) with
| (env, uu____3568) -> begin
(

let uu____3571 = (tc_tot_or_gtot_term env e)
in (match (uu____3571) with
| (e, uu____3578, g) -> begin
((FStar_Syntax_Syntax.DECREASES (e)), (g))
end))
end))
end
| f -> begin
((f), (FStar_TypeChecker_Rel.trivial_guard))
end))))
in (FStar_All.pipe_right _0_377 FStar_List.unzip))
in (match (uu____3537) with
| (flags, guards) -> begin
(

let u = (env.FStar_TypeChecker_Env.universe_of env (Prims.fst res))
in (

let c = (FStar_Syntax_Syntax.mk_Comp (

let uu___98_3594 = c
in {FStar_Syntax_Syntax.comp_univs = comp_univs; FStar_Syntax_Syntax.effect_name = uu___98_3594.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = (Prims.fst res); FStar_Syntax_Syntax.effect_args = args; FStar_Syntax_Syntax.flags = uu___98_3594.FStar_Syntax_Syntax.flags}))
in (

let u_c = (

let uu____3598 = (FStar_TypeChecker_Util.effect_repr env c u)
in (match (uu____3598) with
| None -> begin
u
end
| Some (tm) -> begin
(env.FStar_TypeChecker_Env.universe_of env tm)
end))
in (let _0_378 = (FStar_List.fold_left FStar_TypeChecker_Rel.conj_guard f guards)
in ((c), (u_c), (_0_378))))))
end))
end))
end)))
end))
end)))))
end)))
and tc_universe : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe = (fun env u -> (

let rec aux = (fun u -> (

let u = (FStar_Syntax_Subst.compress_univ u)
in (match (u) with
| FStar_Syntax_Syntax.U_bvar (uu____3608) -> begin
(failwith "Impossible: locally nameless")
end
| FStar_Syntax_Syntax.U_unknown -> begin
(failwith "Unknown universe")
end
| (FStar_Syntax_Syntax.U_unif (_)) | (FStar_Syntax_Syntax.U_zero) -> begin
u
end
| FStar_Syntax_Syntax.U_succ (u) -> begin
FStar_Syntax_Syntax.U_succ ((aux u))
end
| FStar_Syntax_Syntax.U_max (us) -> begin
FStar_Syntax_Syntax.U_max ((FStar_List.map aux us))
end
| FStar_Syntax_Syntax.U_name (x) -> begin
u
end)))
in (match (env.FStar_TypeChecker_Env.lax_universes) with
| true -> begin
FStar_Syntax_Syntax.U_zero
end
| uu____3614 -> begin
(match (u) with
| FStar_Syntax_Syntax.U_unknown -> begin
(let _0_379 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _0_379 Prims.snd))
end
| uu____3617 -> begin
(aux u)
end)
end)))
and tc_abs : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env top bs body -> (

let fail = (fun msg t -> (Prims.raise (FStar_Errors.Error ((let _0_380 = (FStar_TypeChecker_Err.expected_a_term_of_type_t_got_a_function env msg t top)
in ((_0_380), (top.FStar_Syntax_Syntax.pos)))))))
in (

let check_binders = (fun env bs bs_expected -> (

let rec aux = (fun uu____3695 bs bs_expected -> (match (uu____3695) with
| (env, out, g, subst) -> begin
(match (((bs), (bs_expected))) with
| ([], []) -> begin
((env), ((FStar_List.rev out)), (None), (g), (subst))
end
| (((hd, imp))::bs, ((hd_expected, imp'))::bs_expected) -> begin
((match (((imp), (imp'))) with
| ((None, Some (FStar_Syntax_Syntax.Implicit (_)))) | ((Some (FStar_Syntax_Syntax.Implicit (_)), None)) -> begin
(Prims.raise (FStar_Errors.Error ((let _0_383 = (let _0_381 = (FStar_Syntax_Print.bv_to_string hd)
in (FStar_Util.format1 "Inconsistent implicit argument annotation on argument %s" _0_381))
in (let _0_382 = (FStar_Syntax_Syntax.range_of_bv hd)
in ((_0_383), (_0_382)))))))
end
| uu____3792 -> begin
()
end);
(

let expected_t = (FStar_Syntax_Subst.subst subst hd_expected.FStar_Syntax_Syntax.sort)
in (

let uu____3796 = (

let uu____3799 = (FStar_Syntax_Util.unmeta hd.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n
in (match (uu____3799) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
((expected_t), (g))
end
| uu____3802 -> begin
((

let uu____3804 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____3804) with
| true -> begin
(let _0_384 = (FStar_Syntax_Print.bv_to_string hd)
in (FStar_Util.print1 "Checking binder %s\n" _0_384))
end
| uu____3805 -> begin
()
end));
(

let uu____3806 = (tc_tot_or_gtot_term env hd.FStar_Syntax_Syntax.sort)
in (match (uu____3806) with
| (t, uu____3813, g1) -> begin
(

let g2 = (let _0_386 = (FStar_TypeChecker_Env.get_range env)
in (let _0_385 = (FStar_TypeChecker_Rel.teq env t expected_t)
in (FStar_TypeChecker_Util.label_guard _0_386 "Type annotation on parameter incompatible with the expected type" _0_385)))
in (

let g = (let _0_387 = (FStar_TypeChecker_Rel.conj_guard g1 g2)
in (FStar_TypeChecker_Rel.conj_guard g _0_387))
in ((t), (g))))
end));
)
end))
in (match (uu____3796) with
| (t, g) -> begin
(

let hd = (

let uu___99_3832 = hd
in {FStar_Syntax_Syntax.ppname = uu___99_3832.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___99_3832.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t})
in (

let b = ((hd), (imp))
in (

let b_expected = ((hd_expected), (imp'))
in (

let env = (push_binding env b)
in (

let subst = (let _0_388 = (FStar_Syntax_Syntax.bv_to_name hd)
in (maybe_extend_subst subst b_expected _0_388))
in (aux ((env), ((b)::out), (g), (subst)) bs bs_expected))))))
end)));
)
end
| (rest, []) -> begin
((env), ((FStar_List.rev out)), (Some (FStar_Util.Inl (rest))), (g), (subst))
end
| ([], rest) -> begin
((env), ((FStar_List.rev out)), (Some (FStar_Util.Inr (rest))), (g), (subst))
end)
end))
in (aux ((env), ([]), (FStar_TypeChecker_Rel.trivial_guard), ([])) bs bs_expected)))
in (

let rec expected_function_typ = (fun env t0 body -> (match (t0) with
| None -> begin
((match (env.FStar_TypeChecker_Env.letrecs) with
| [] -> begin
()
end
| uu____3934 -> begin
(failwith "Impossible: Can\'t have a let rec annotation but no expected type")
end);
(

let uu____3938 = (tc_binders env bs)
in (match (uu____3938) with
| (bs, envbody, g, uu____3957) -> begin
(

let uu____3958 = (

let uu____3963 = (FStar_Syntax_Subst.compress body).FStar_Syntax_Syntax.n
in (match (uu____3963) with
| FStar_Syntax_Syntax.Tm_ascribed (e, FStar_Util.Inr (c), uu____3970) -> begin
(

let uu____3989 = (tc_comp envbody c)
in (match (uu____3989) with
| (c, uu____3998, g') -> begin
(let _0_389 = (FStar_TypeChecker_Rel.conj_guard g g')
in ((Some (c)), (body), (_0_389)))
end))
end
| uu____4001 -> begin
((None), (body), (g))
end))
in (match (uu____3958) with
| (copt, body, g) -> begin
((None), (bs), ([]), (copt), (envbody), (body), (g))
end))
end));
)
end
| Some (t) -> begin
(

let t = (FStar_Syntax_Subst.compress t)
in (

let rec as_function_typ = (fun norm t -> (

let uu____4051 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____4051) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) -> begin
((match (env.FStar_TypeChecker_Env.letrecs) with
| [] -> begin
()
end
| uu____4080 -> begin
(failwith "Impossible")
end);
(

let uu____4084 = (tc_binders env bs)
in (match (uu____4084) with
| (bs, envbody, g, uu____4104) -> begin
(

let uu____4105 = (FStar_TypeChecker_Env.clear_expected_typ envbody)
in (match (uu____4105) with
| (envbody, uu____4122) -> begin
((Some (((t), (true)))), (bs), ([]), (None), (envbody), (body), (g))
end))
end));
)
end
| FStar_Syntax_Syntax.Tm_refine (b, uu____4133) -> begin
(

let uu____4138 = (as_function_typ norm b.FStar_Syntax_Syntax.sort)
in (match (uu____4138) with
| (uu____4163, bs, bs', copt, env, body, g) -> begin
((Some (((t), (false)))), (bs), (bs'), (copt), (env), (body), (g))
end))
end
| FStar_Syntax_Syntax.Tm_arrow (bs_expected, c_expected) -> begin
(

let uu____4199 = (FStar_Syntax_Subst.open_comp bs_expected c_expected)
in (match (uu____4199) with
| (bs_expected, c_expected) -> begin
(

let check_actuals_against_formals = (fun env bs bs_expected -> (

let rec handle_more = (fun uu____4260 c_expected -> (match (uu____4260) with
| (env, bs, more, guard, subst) -> begin
(match (more) with
| None -> begin
(let _0_390 = (FStar_Syntax_Subst.subst_comp subst c_expected)
in ((env), (bs), (guard), (_0_390)))
end
| Some (FStar_Util.Inr (more_bs_expected)) -> begin
(

let c = (FStar_Syntax_Syntax.mk_Total (FStar_Syntax_Util.arrow more_bs_expected c_expected))
in (let _0_391 = (FStar_Syntax_Subst.subst_comp subst c)
in ((env), (bs), (guard), (_0_391))))
end
| Some (FStar_Util.Inl (more_bs)) -> begin
(

let c = (FStar_Syntax_Subst.subst_comp subst c_expected)
in (match ((FStar_Syntax_Util.is_named_tot c)) with
| true -> begin
(

let t = (unfold_whnf env (FStar_Syntax_Util.comp_result c))
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs_expected, c_expected) -> begin
(

let uu____4377 = (check_binders env more_bs bs_expected)
in (match (uu____4377) with
| (env, bs', more, guard', subst) -> begin
(let _0_393 = (let _0_392 = (FStar_TypeChecker_Rel.conj_guard guard guard')
in ((env), ((FStar_List.append bs bs')), (more), (_0_392), (subst)))
in (handle_more _0_393 c_expected))
end))
end
| uu____4425 -> begin
(let _0_395 = (let _0_394 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "More arguments than annotated type (%s)" _0_394))
in (fail _0_395 t))
end))
end
| uu____4433 -> begin
(fail "Function definition takes more arguments than expected from its annotated type" t)
end))
end)
end))
in (let _0_396 = (check_binders env bs bs_expected)
in (handle_more _0_396 c_expected))))
in (

let mk_letrec_env = (fun envbody bs c -> (

let letrecs = (guard_letrecs envbody bs c)
in (

let envbody = (

let uu___100_4463 = envbody
in {FStar_TypeChecker_Env.solver = uu___100_4463.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___100_4463.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___100_4463.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___100_4463.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___100_4463.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___100_4463.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___100_4463.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___100_4463.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___100_4463.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___100_4463.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___100_4463.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___100_4463.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = []; FStar_TypeChecker_Env.top_level = uu___100_4463.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___100_4463.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___100_4463.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___100_4463.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___100_4463.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___100_4463.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___100_4463.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___100_4463.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___100_4463.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___100_4463.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___100_4463.FStar_TypeChecker_Env.qname_and_index})
in (FStar_All.pipe_right letrecs (FStar_List.fold_left (fun uu____4477 uu____4478 -> (match (((uu____4477), (uu____4478))) with
| ((env, letrec_binders), (l, t)) -> begin
(

let uu____4503 = (let _0_398 = (let _0_397 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _0_397 Prims.fst))
in (tc_term _0_398 t))
in (match (uu____4503) with
| (t, uu____4515, uu____4516) -> begin
(

let env = (FStar_TypeChecker_Env.push_let_binding env l (([]), (t)))
in (

let lb = (match (l) with
| FStar_Util.Inl (x) -> begin
(let _0_399 = (FStar_Syntax_Syntax.mk_binder (

let uu___101_4523 = x
in {FStar_Syntax_Syntax.ppname = uu___101_4523.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___101_4523.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}))
in (_0_399)::letrec_binders)
end
| uu____4524 -> begin
letrec_binders
end)
in ((env), (lb))))
end))
end)) ((envbody), ([])))))))
in (

let uu____4527 = (check_actuals_against_formals env bs bs_expected)
in (match (uu____4527) with
| (envbody, bs, g, c) -> begin
(

let uu____4557 = (

let uu____4561 = (FStar_TypeChecker_Env.should_verify env)
in (match (uu____4561) with
| true -> begin
(mk_letrec_env envbody bs c)
end
| uu____4565 -> begin
((envbody), ([]))
end))
in (match (uu____4557) with
| (envbody, letrecs) -> begin
(

let envbody = (FStar_TypeChecker_Env.set_expected_typ envbody (FStar_Syntax_Util.comp_result c))
in ((Some (((t), (false)))), (bs), (letrecs), (Some (c)), (envbody), (body), (g)))
end))
end))))
end))
end
| uu____4594 -> begin
(match ((not (norm))) with
| true -> begin
(let _0_400 = (unfold_whnf env t)
in (as_function_typ true _0_400))
end
| uu____4607 -> begin
(

let uu____4608 = (expected_function_typ env None body)
in (match (uu____4608) with
| (uu____4632, bs, uu____4634, c_opt, envbody, body, g) -> begin
((Some (((t), (false)))), (bs), ([]), (c_opt), (envbody), (body), (g))
end))
end)
end)))
in (as_function_typ false t)))
end))
in (

let use_eq = env.FStar_TypeChecker_Env.use_eq
in (

let uu____4655 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____4655) with
| (env, topt) -> begin
((

let uu____4667 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____4667) with
| true -> begin
(let _0_401 = (match (topt) with
| None -> begin
"None"
end
| Some (t) -> begin
(FStar_Syntax_Print.term_to_string t)
end)
in (FStar_Util.print2 "!!!!!!!!!!!!!!!Expected type is %s, top_level=%s\n" _0_401 (match (env.FStar_TypeChecker_Env.top_level) with
| true -> begin
"true"
end
| uu____4669 -> begin
"false"
end)))
end
| uu____4670 -> begin
()
end));
(

let uu____4671 = (expected_function_typ env topt body)
in (match (uu____4671) with
| (tfun_opt, bs, letrec_binders, c_opt, envbody, body, g) -> begin
(

let uu____4701 = (tc_term (

let uu___102_4705 = envbody
in {FStar_TypeChecker_Env.solver = uu___102_4705.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___102_4705.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___102_4705.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___102_4705.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___102_4705.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___102_4705.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___102_4705.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___102_4705.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___102_4705.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___102_4705.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___102_4705.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___102_4705.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___102_4705.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = uu___102_4705.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = use_eq; FStar_TypeChecker_Env.is_iface = uu___102_4705.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___102_4705.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___102_4705.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___102_4705.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___102_4705.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___102_4705.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___102_4705.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___102_4705.FStar_TypeChecker_Env.qname_and_index}) body)
in (match (uu____4701) with
| (body, cbody, guard_body) -> begin
(

let guard_body = (FStar_TypeChecker_Rel.solve_deferred_constraints envbody guard_body)
in ((

let uu____4714 = (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Implicits")))
in (match (uu____4714) with
| true -> begin
(let _0_404 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length guard_body.FStar_TypeChecker_Env.implicits))
in (let _0_403 = (let _0_402 = (cbody.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _0_402))
in (FStar_Util.print2 "Introduced %s implicits in body of abstraction\nAfter solving constraints, cbody is %s\n" _0_404 _0_403)))
end
| uu____4723 -> begin
()
end));
(

let uu____4724 = (let _0_406 = (let _0_405 = (cbody.FStar_Syntax_Syntax.comp ())
in ((body), (_0_405)))
in (check_expected_effect (

let uu___103_4728 = envbody
in {FStar_TypeChecker_Env.solver = uu___103_4728.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___103_4728.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___103_4728.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___103_4728.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___103_4728.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___103_4728.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___103_4728.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___103_4728.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___103_4728.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___103_4728.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___103_4728.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___103_4728.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___103_4728.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___103_4728.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___103_4728.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = use_eq; FStar_TypeChecker_Env.is_iface = uu___103_4728.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___103_4728.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___103_4728.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___103_4728.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___103_4728.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___103_4728.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___103_4728.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___103_4728.FStar_TypeChecker_Env.qname_and_index}) c_opt _0_406))
in (match (uu____4724) with
| (body, cbody, guard) -> begin
(

let guard = (FStar_TypeChecker_Rel.conj_guard guard_body guard)
in (

let guard = (

let uu____4739 = (env.FStar_TypeChecker_Env.top_level || (not ((FStar_TypeChecker_Env.should_verify env))))
in (match (uu____4739) with
| true -> begin
(let _0_407 = (FStar_TypeChecker_Rel.conj_guard g guard)
in (FStar_TypeChecker_Rel.discharge_guard envbody _0_407))
end
| uu____4740 -> begin
(

let guard = (let _0_408 = (FStar_TypeChecker_Rel.conj_guard g guard)
in (FStar_TypeChecker_Rel.close_guard (FStar_List.append bs letrec_binders) _0_408))
in guard)
end))
in (

let tfun_computed = (FStar_Syntax_Util.arrow bs cbody)
in (

let e = (let _0_411 = Some ((let _0_410 = (FStar_All.pipe_right (FStar_Util.dflt cbody c_opt) FStar_Syntax_Util.lcomp_of_comp)
in (FStar_All.pipe_right _0_410 (fun _0_409 -> FStar_Util.Inl (_0_409)))))
in (FStar_Syntax_Util.abs bs body _0_411))
in (

let uu____4761 = (match (tfun_opt) with
| Some (t, use_teq) -> begin
(

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (uu____4776) -> begin
((e), (t), (guard))
end
| uu____4784 -> begin
(

let uu____4785 = (match (use_teq) with
| true -> begin
(let _0_412 = (FStar_TypeChecker_Rel.teq env t tfun_computed)
in ((e), (_0_412)))
end
| uu____4790 -> begin
(FStar_TypeChecker_Util.check_and_ascribe env e tfun_computed t)
end)
in (match (uu____4785) with
| (e, guard') -> begin
(let _0_413 = (FStar_TypeChecker_Rel.conj_guard guard guard')
in ((e), (t), (_0_413)))
end))
end))
end
| None -> begin
((e), (tfun_computed), (guard))
end)
in (match (uu____4761) with
| (e, tfun, guard) -> begin
(

let c = (match (env.FStar_TypeChecker_Env.top_level) with
| true -> begin
(FStar_Syntax_Syntax.mk_Total tfun)
end
| uu____4807 -> begin
(FStar_TypeChecker_Util.return_value env tfun e)
end)
in (

let uu____4808 = (FStar_TypeChecker_Util.strengthen_precondition None env e (FStar_Syntax_Util.lcomp_of_comp c) guard)
in (match (uu____4808) with
| (c, g) -> begin
((e), (c), (g))
end)))
end))))))
end));
))
end))
end));
)
end)))))))
and check_application_args : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.lcomp  ->  FStar_TypeChecker_Env.guard_t  ->  ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list  ->  FStar_Syntax_Syntax.typ Prims.option  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env head chead ghead args expected_topt -> (

let n_args = (FStar_List.length args)
in (

let r = (FStar_TypeChecker_Env.get_range env)
in (

let thead = chead.FStar_Syntax_Syntax.res_typ
in ((

let uu____4844 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____4844) with
| true -> begin
(let _0_415 = (FStar_Range.string_of_range head.FStar_Syntax_Syntax.pos)
in (let _0_414 = (FStar_Syntax_Print.term_to_string thead)
in (FStar_Util.print2 "(%s) Type of head is %s\n" _0_415 _0_414)))
end
| uu____4845 -> begin
()
end));
(

let monadic_application = (fun uu____4886 subst arg_comps_rev arg_rets guard fvs bs -> (match (uu____4886) with
| (head, chead, ghead, cres) -> begin
(

let rt = (check_no_escape (Some (head)) env fvs cres.FStar_Syntax_Syntax.res_typ)
in (

let cres = (

let uu___104_4927 = cres
in {FStar_Syntax_Syntax.eff_name = uu___104_4927.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = rt; FStar_Syntax_Syntax.cflags = uu___104_4927.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = uu___104_4927.FStar_Syntax_Syntax.comp})
in (

let uu____4928 = (match (bs) with
| [] -> begin
(

let cres = (FStar_TypeChecker_Util.subst_lcomp subst cres)
in (

let g = (FStar_TypeChecker_Rel.conj_guard ghead guard)
in (

let refine_with_equality = ((FStar_Syntax_Util.is_pure_or_ghost_lcomp cres) && (FStar_All.pipe_right arg_comps_rev (FStar_Util.for_some (fun uu___79_4955 -> (match (uu___79_4955) with
| (uu____4964, uu____4965, FStar_Util.Inl (uu____4966)) -> begin
false
end
| (uu____4977, uu____4978, FStar_Util.Inr (c)) -> begin
(not ((FStar_Syntax_Util.is_pure_or_ghost_lcomp c)))
end)))))
in (

let cres = (match (refine_with_equality) with
| true -> begin
(let _0_416 = ((FStar_Syntax_Syntax.mk_Tm_app head (FStar_List.rev arg_rets)) (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) r)
in (FStar_TypeChecker_Util.maybe_assume_result_eq_pure_term env _0_416 cres))
end
| uu____4999 -> begin
((

let uu____5001 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____5001) with
| true -> begin
(let _0_419 = (FStar_Syntax_Print.term_to_string head)
in (let _0_418 = (FStar_Syntax_Print.lcomp_to_string cres)
in (let _0_417 = (FStar_TypeChecker_Rel.guard_to_string env g)
in (FStar_Util.print3 "Not refining result: f=%s; cres=%s; guard=%s\n" _0_419 _0_418 _0_417))))
end
| uu____5002 -> begin
()
end));
cres;
)
end)
in ((cres), (g))))))
end
| uu____5003 -> begin
(

let g = (let _0_420 = (FStar_TypeChecker_Rel.conj_guard ghead guard)
in (FStar_All.pipe_right _0_420 (FStar_TypeChecker_Rel.solve_deferred_constraints env)))
in (let _0_424 = (let _0_423 = (FStar_Syntax_Syntax.mk_Total (let _0_422 = (let _0_421 = (cres.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Util.arrow bs _0_421))
in (FStar_All.pipe_left (FStar_Syntax_Subst.subst subst) _0_422)))
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _0_423))
in ((_0_424), (g))))
end)
in (match (uu____4928) with
| (cres, guard) -> begin
((

let uu____5016 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____5016) with
| true -> begin
(let _0_425 = (FStar_Syntax_Print.lcomp_to_string cres)
in (FStar_Util.print1 "\t Type of result cres is %s\n" _0_425))
end
| uu____5017 -> begin
()
end));
(

let uu____5018 = (FStar_List.fold_left (fun uu____5041 uu____5042 -> (match (((uu____5041), (uu____5042))) with
| ((args, out_c, monadic), ((e, q), x, c)) -> begin
(match (c) with
| FStar_Util.Inl (eff_name, arg_typ) -> begin
(let _0_428 = (let _0_427 = (let _0_426 = (FStar_TypeChecker_Util.maybe_lift env e eff_name out_c.FStar_Syntax_Syntax.eff_name arg_typ)
in ((_0_426), (q)))
in (_0_427)::args)
in ((_0_428), (out_c), (monadic)))
end
| FStar_Util.Inr (c) -> begin
(

let monadic = (monadic || (not ((FStar_Syntax_Util.is_pure_or_ghost_lcomp c))))
in (

let out_c = (FStar_TypeChecker_Util.bind e.FStar_Syntax_Syntax.pos env None c ((x), (out_c)))
in (

let e = (FStar_TypeChecker_Util.maybe_lift env e c.FStar_Syntax_Syntax.eff_name out_c.FStar_Syntax_Syntax.eff_name c.FStar_Syntax_Syntax.res_typ)
in (

let e = (FStar_TypeChecker_Util.maybe_monadic env e c.FStar_Syntax_Syntax.eff_name c.FStar_Syntax_Syntax.res_typ)
in (((((e), (q)))::args), (out_c), (monadic))))))
end)
end)) (([]), (cres), (false)) arg_comps_rev)
in (match (uu____5018) with
| (args, comp, monadic) -> begin
(

let comp = (FStar_TypeChecker_Util.bind head.FStar_Syntax_Syntax.pos env None chead ((None), (comp)))
in (

let rec letbind_on_lift = (fun args acc -> (match (args) with
| [] -> begin
(match ((FStar_List.rev acc)) with
| [] -> begin
(failwith "letbind_on_lift should be always called with a non-empty list")
end
| ((head, uu____5195))::args -> begin
(

let body = ((FStar_Syntax_Syntax.mk_Tm_app head args) (Some (comp.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) r)
in (

let body = (FStar_TypeChecker_Util.maybe_lift env body cres.FStar_Syntax_Syntax.eff_name comp.FStar_Syntax_Syntax.eff_name comp.FStar_Syntax_Syntax.res_typ)
in (FStar_TypeChecker_Util.maybe_monadic env body comp.FStar_Syntax_Syntax.eff_name comp.FStar_Syntax_Syntax.res_typ)))
end)
end
| ((e, q))::es -> begin
(

let hoist_and_bind = (fun e m t' -> (

let x = (FStar_Syntax_Syntax.gen_bv "monadic_app_var" None t')
in (

let body = (let _0_431 = (let _0_430 = (let _0_429 = (FStar_Syntax_Syntax.bv_to_name x)
in ((_0_429), (q)))
in (_0_430)::acc)
in (letbind_on_lift es _0_431))
in (

let lb = (FStar_Syntax_Util.mk_letbinding (FStar_Util.Inl (x)) [] t' m e)
in (

let letbinding = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let ((let _0_434 = (let _0_433 = (let _0_432 = (FStar_Syntax_Syntax.mk_binder x)
in (_0_432)::[])
in (FStar_Syntax_Subst.close _0_433 body))
in ((((false), ((lb)::[]))), (_0_434)))))) None e.FStar_Syntax_Syntax.pos)
in ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((letbinding), (FStar_Syntax_Syntax.Meta_monadic (((m), (comp.FStar_Syntax_Syntax.res_typ)))))))) None e.FStar_Syntax_Syntax.pos))))))
in (

let uu____5266 = (FStar_Syntax_Subst.compress e).FStar_Syntax_Syntax.n
in (match (uu____5266) with
| (FStar_Syntax_Syntax.Tm_meta (e0, FStar_Syntax_Syntax.Meta_monadic (m, t'))) | (FStar_Syntax_Syntax.Tm_meta (e0, FStar_Syntax_Syntax.Meta_monadic_lift (_, m, t'))) -> begin
(hoist_and_bind e m t')
end
| uu____5287 -> begin
(letbind_on_lift es ((((e), (q)))::acc))
end)))
end))
in (

let app = (let _0_436 = (let _0_435 = (FStar_Syntax_Syntax.as_arg head)
in (_0_435)::args)
in (letbind_on_lift _0_436 []))
in (

let uu____5293 = (FStar_TypeChecker_Util.strengthen_precondition None env app comp guard)
in (match (uu____5293) with
| (comp, g) -> begin
((app), (comp), (g))
end)))))
end));
)
end))))
end))
in (

let rec tc_args = (fun head_info uu____5351 bs args -> (match (uu____5351) with
| (subst, outargs, arg_rets, g, fvs) -> begin
(match (((bs), (args))) with
| (((x, Some (FStar_Syntax_Syntax.Implicit (uu____5446))))::rest, ((uu____5448, None))::uu____5449) -> begin
(

let t = (FStar_Syntax_Subst.subst subst x.FStar_Syntax_Syntax.sort)
in (

let t = (check_no_escape (Some (head)) env fvs t)
in (

let uu____5486 = (FStar_TypeChecker_Util.new_implicit_var "Instantiating implicit argument in application" head.FStar_Syntax_Syntax.pos env t)
in (match (uu____5486) with
| (varg, uu____5497, implicits) -> begin
(

let subst = (FStar_Syntax_Syntax.NT (((x), (varg))))::subst
in (

let arg = (let _0_437 = (FStar_Syntax_Syntax.as_implicit true)
in ((varg), (_0_437)))
in (let _0_439 = (let _0_438 = (FStar_TypeChecker_Rel.conj_guard implicits g)
in ((subst), ((((arg), (None), (FStar_Util.Inl (((FStar_Syntax_Const.effect_Tot_lid), (t))))))::outargs), ((arg)::arg_rets), (_0_438), (fvs)))
in (tc_args head_info _0_439 rest args))))
end))))
end
| (((x, aqual))::rest, ((e, aq))::rest') -> begin
((match (((aqual), (aq))) with
| ((Some (FStar_Syntax_Syntax.Implicit (_)), Some (FStar_Syntax_Syntax.Implicit (_)))) | ((None, None)) | ((Some (FStar_Syntax_Syntax.Equality), None)) -> begin
()
end
| uu____5600 -> begin
(Prims.raise (FStar_Errors.Error ((("Inconsistent implicit qualifier"), (e.FStar_Syntax_Syntax.pos)))))
end);
(

let targ = (FStar_Syntax_Subst.subst subst x.FStar_Syntax_Syntax.sort)
in (

let x = (

let uu___105_5607 = x
in {FStar_Syntax_Syntax.ppname = uu___105_5607.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___105_5607.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = targ})
in ((

let uu____5609 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____5609) with
| true -> begin
(let _0_440 = (FStar_Syntax_Print.term_to_string targ)
in (FStar_Util.print1 "\tType of arg (after subst) = %s\n" _0_440))
end
| uu____5610 -> begin
()
end));
(

let targ = (check_no_escape (Some (head)) env fvs targ)
in (

let env = (FStar_TypeChecker_Env.set_expected_typ env targ)
in (

let env = (

let uu___106_5614 = env
in {FStar_TypeChecker_Env.solver = uu___106_5614.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___106_5614.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___106_5614.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___106_5614.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___106_5614.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___106_5614.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___106_5614.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___106_5614.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___106_5614.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___106_5614.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___106_5614.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___106_5614.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___106_5614.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___106_5614.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___106_5614.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = (is_eq aqual); FStar_TypeChecker_Env.is_iface = uu___106_5614.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___106_5614.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___106_5614.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___106_5614.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___106_5614.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___106_5614.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___106_5614.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___106_5614.FStar_TypeChecker_Env.qname_and_index})
in ((

let uu____5616 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____5616) with
| true -> begin
(let _0_443 = (FStar_Syntax_Print.tag_of_term e)
in (let _0_442 = (FStar_Syntax_Print.term_to_string e)
in (let _0_441 = (FStar_Syntax_Print.term_to_string targ)
in (FStar_Util.print3 "Checking arg (%s) %s at type %s\n" _0_443 _0_442 _0_441))))
end
| uu____5617 -> begin
()
end));
(

let uu____5618 = (tc_term env e)
in (match (uu____5618) with
| (e, c, g_e) -> begin
(

let g = (FStar_TypeChecker_Rel.conj_guard g g_e)
in (

let arg = ((e), (aq))
in (

let uu____5634 = (FStar_Syntax_Util.is_tot_or_gtot_lcomp c)
in (match (uu____5634) with
| true -> begin
(

let subst = (let _0_444 = (FStar_List.hd bs)
in (maybe_extend_subst subst _0_444 e))
in (tc_args head_info ((subst), ((((arg), (None), (FStar_Util.Inl (((c.FStar_Syntax_Syntax.eff_name), (c.FStar_Syntax_Syntax.res_typ))))))::outargs), ((arg)::arg_rets), (g), (fvs)) rest rest'))
end
| uu____5693 -> begin
(

let uu____5694 = (FStar_TypeChecker_Util.is_pure_or_ghost_effect env c.FStar_Syntax_Syntax.eff_name)
in (match (uu____5694) with
| true -> begin
(

let subst = (let _0_445 = (FStar_List.hd bs)
in (maybe_extend_subst subst _0_445 e))
in (tc_args head_info ((subst), ((((arg), (Some (x)), (FStar_Util.Inr (c))))::outargs), ((arg)::arg_rets), (g), (fvs)) rest rest'))
end
| uu____5743 -> begin
(

let uu____5744 = (FStar_Syntax_Syntax.is_null_binder (FStar_List.hd bs))
in (match (uu____5744) with
| true -> begin
(

let newx = (FStar_Syntax_Syntax.new_bv (Some (e.FStar_Syntax_Syntax.pos)) c.FStar_Syntax_Syntax.res_typ)
in (

let arg' = (let _0_446 = (FStar_Syntax_Syntax.bv_to_name newx)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _0_446))
in (tc_args head_info ((subst), ((((arg), (Some (newx)), (FStar_Util.Inr (c))))::outargs), ((arg')::arg_rets), (g), (fvs)) rest rest')))
end
| uu____5789 -> begin
(let _0_449 = (let _0_448 = (let _0_447 = (FStar_Syntax_Syntax.as_arg (FStar_Syntax_Syntax.bv_to_name x))
in (_0_447)::arg_rets)
in ((subst), ((((arg), (Some (x)), (FStar_Util.Inr (c))))::outargs), (_0_448), (g), ((x)::fvs)))
in (tc_args head_info _0_449 rest rest'))
end))
end))
end))))
end));
))));
)));
)
end
| (uu____5826, []) -> begin
(monadic_application head_info subst outargs arg_rets g fvs bs)
end
| ([], (arg)::uu____5847) -> begin
(

let uu____5877 = (monadic_application head_info subst outargs arg_rets g fvs [])
in (match (uu____5877) with
| (head, chead, ghead) -> begin
(

let rec aux = (fun norm tres -> (

let tres = (let _0_450 = (FStar_Syntax_Subst.compress tres)
in (FStar_All.pipe_right _0_450 FStar_Syntax_Util.unrefine))
in (match (tres.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, cres') -> begin
(

let uu____5915 = (FStar_Syntax_Subst.open_comp bs cres')
in (match (uu____5915) with
| (bs, cres') -> begin
(

let head_info = ((head), (chead), (ghead), ((FStar_Syntax_Util.lcomp_of_comp cres')))
in ((

let uu____5929 = (FStar_TypeChecker_Env.debug env FStar_Options.Low)
in (match (uu____5929) with
| true -> begin
(let _0_451 = (FStar_Range.string_of_range tres.FStar_Syntax_Syntax.pos)
in (FStar_Util.print1 "%s: Warning: Potentially redundant explicit currying of a function type \n" _0_451))
end
| uu____5930 -> begin
()
end));
(tc_args head_info (([]), ([]), ([]), (FStar_TypeChecker_Rel.trivial_guard), ([])) bs args);
))
end))
end
| uu____5959 when (not (norm)) -> begin
(let _0_452 = (unfold_whnf env tres)
in (aux true _0_452))
end
| uu____5960 -> begin
(Prims.raise (FStar_Errors.Error ((let _0_456 = (let _0_454 = (FStar_TypeChecker_Normalize.term_to_string env thead)
in (let _0_453 = (FStar_Util.string_of_int n_args)
in (FStar_Util.format2 "Too many arguments to function of type %s; got %s arguments" _0_454 _0_453)))
in (let _0_455 = (FStar_Syntax_Syntax.argpos arg)
in ((_0_456), (_0_455)))))))
end)))
in (aux false chead.FStar_Syntax_Syntax.res_typ))
end))
end)
end))
in (

let rec check_function_app = (fun norm tf -> (

let uu____5979 = (FStar_Syntax_Util.unrefine tf).FStar_Syntax_Syntax.n
in (match (uu____5979) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) -> begin
(

let rec tc_args = (fun env args -> (match (args) with
| [] -> begin
(([]), ([]), (FStar_TypeChecker_Rel.trivial_guard))
end
| ((e, imp))::tl -> begin
(

let uu____6053 = (tc_term env e)
in (match (uu____6053) with
| (e, c, g_e) -> begin
(

let uu____6066 = (tc_args env tl)
in (match (uu____6066) with
| (args, comps, g_rest) -> begin
(let _0_457 = (FStar_TypeChecker_Rel.conj_guard g_e g_rest)
in (((((e), (imp)))::args), ((((e.FStar_Syntax_Syntax.pos), (c)))::comps), (_0_457)))
end))
end))
end))
in (

let uu____6098 = (tc_args env args)
in (match (uu____6098) with
| (args, comps, g_args) -> begin
(

let bs = (FStar_Syntax_Util.null_binders_of_tks (FStar_All.pipe_right comps (FStar_List.map (fun uu____6139 -> (match (uu____6139) with
| (uu____6147, c) -> begin
((c.FStar_Syntax_Syntax.res_typ), (None))
end)))))
in (

let ml_or_tot = (

let uu____6157 = (FStar_TypeChecker_Env.try_lookup_effect_lid env FStar_Syntax_Const.effect_ML_lid)
in (match (uu____6157) with
| None -> begin
(fun t r -> (FStar_Syntax_Syntax.mk_Total t))
end
| uu____6165 -> begin
FStar_Syntax_Util.ml_comp
end))
in (

let ml_or_tot = (match (expected_topt) with
| None -> begin
ml_or_tot
end
| Some (t) -> begin
(

let uu____6177 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____6177) with
| FStar_Syntax_Syntax.Tm_type (uu____6182) -> begin
(fun t r -> (FStar_Syntax_Syntax.mk_GTotal t))
end
| uu____6185 -> begin
ml_or_tot
end))
end)
in (

let cres = (let _0_460 = (let _0_459 = (let _0_458 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_right _0_458 Prims.fst))
in (FStar_TypeChecker_Util.new_uvar env _0_459))
in (ml_or_tot _0_460 r))
in (

let bs_cres = (FStar_Syntax_Util.arrow bs cres)
in ((

let uu____6193 = (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) FStar_Options.Extreme)
in (match (uu____6193) with
| true -> begin
(let _0_463 = (FStar_Syntax_Print.term_to_string head)
in (let _0_462 = (FStar_Syntax_Print.term_to_string tf)
in (let _0_461 = (FStar_Syntax_Print.term_to_string bs_cres)
in (FStar_Util.print3 "Forcing the type of %s from %s to %s\n" _0_463 _0_462 _0_461))))
end
| uu____6194 -> begin
()
end));
(let _0_464 = (FStar_TypeChecker_Rel.teq env tf bs_cres)
in (FStar_All.pipe_left (FStar_TypeChecker_Rel.force_trivial_guard env) _0_464));
(

let comp = (let _0_465 = (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp cres)
in (FStar_List.fold_right (fun uu____6199 out -> (match (uu____6199) with
| (r1, c) -> begin
(FStar_TypeChecker_Util.bind r1 env None c ((None), (out)))
end)) ((((head.FStar_Syntax_Syntax.pos), (chead)))::comps) _0_465))
in (let _0_467 = ((FStar_Syntax_Syntax.mk_Tm_app head args) (Some (comp.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) r)
in (let _0_466 = (FStar_TypeChecker_Rel.conj_guard ghead g_args)
in ((_0_467), (comp), (_0_466)))));
))))))
end)))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let uu____6230 = (FStar_Syntax_Subst.open_comp bs c)
in (match (uu____6230) with
| (bs, c) -> begin
(

let head_info = ((head), (chead), (ghead), ((FStar_Syntax_Util.lcomp_of_comp c)))
in (tc_args head_info (([]), ([]), ([]), (FStar_TypeChecker_Rel.trivial_guard), ([])) bs args))
end))
end
| uu____6273 -> begin
(match ((not (norm))) with
| true -> begin
(let _0_468 = (unfold_whnf env tf)
in (check_function_app true _0_468))
end
| uu____6279 -> begin
(Prims.raise (FStar_Errors.Error ((let _0_469 = (FStar_TypeChecker_Err.expected_function_typ env tf)
in ((_0_469), (head.FStar_Syntax_Syntax.pos))))))
end)
end)))
in (let _0_471 = (let _0_470 = (FStar_Syntax_Util.unrefine thead)
in (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.WHNF)::[]) env _0_470))
in (check_function_app false _0_471)))));
)))))
and check_short_circuit_args : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.lcomp  ->  FStar_TypeChecker_Env.guard_t  ->  ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list  ->  FStar_Syntax_Syntax.typ Prims.option  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env head chead g_head args expected_topt -> (

let r = (FStar_TypeChecker_Env.get_range env)
in (

let tf = (FStar_Syntax_Subst.compress chead.FStar_Syntax_Syntax.res_typ)
in (match (tf.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c) when ((FStar_Syntax_Util.is_total_comp c) && ((FStar_List.length bs) = (FStar_List.length args))) -> begin
(

let res_t = (FStar_Syntax_Util.comp_result c)
in (

let uu____6330 = (FStar_List.fold_left2 (fun uu____6343 uu____6344 uu____6345 -> (match (((uu____6343), (uu____6344), (uu____6345))) with
| ((seen, guard, ghost), (e, aq), (b, aq')) -> begin
((match ((aq <> aq')) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((("Inconsistent implicit qualifiers"), (e.FStar_Syntax_Syntax.pos)))))
end
| uu____6388 -> begin
()
end);
(

let uu____6389 = (tc_check_tot_or_gtot_term env e b.FStar_Syntax_Syntax.sort)
in (match (uu____6389) with
| (e, c, g) -> begin
(

let short = (FStar_TypeChecker_Util.short_circuit head seen)
in (

let g = (let _0_472 = (FStar_TypeChecker_Rel.guard_of_guard_formula short)
in (FStar_TypeChecker_Rel.imp_guard _0_472 g))
in (

let ghost = (ghost || ((not ((FStar_Syntax_Util.is_total_lcomp c))) && (not ((FStar_TypeChecker_Util.is_pure_effect env c.FStar_Syntax_Syntax.eff_name)))))
in (let _0_476 = (let _0_474 = (let _0_473 = (FStar_Syntax_Syntax.as_arg e)
in (_0_473)::[])
in (FStar_List.append seen _0_474))
in (let _0_475 = (FStar_TypeChecker_Rel.conj_guard guard g)
in ((_0_476), (_0_475), (ghost)))))))
end));
)
end)) (([]), (g_head), (false)) args bs)
in (match (uu____6330) with
| (args, guard, ghost) -> begin
(

let e = ((FStar_Syntax_Syntax.mk_Tm_app head args) (Some (res_t.FStar_Syntax_Syntax.n)) r)
in (

let c = (match (ghost) with
| true -> begin
(let _0_477 = (FStar_Syntax_Syntax.mk_GTotal res_t)
in (FStar_All.pipe_right _0_477 FStar_Syntax_Util.lcomp_of_comp))
end
| uu____6434 -> begin
(FStar_Syntax_Util.lcomp_of_comp c)
end)
in (

let uu____6435 = (FStar_TypeChecker_Util.strengthen_precondition None env e c guard)
in (match (uu____6435) with
| (c, g) -> begin
((e), (c), (g))
end))))
end)))
end
| uu____6447 -> begin
(check_application_args env head chead g_head args expected_topt)
end))))
and tc_eqn : FStar_Syntax_Syntax.bv  ->  FStar_TypeChecker_Env.env  ->  ((FStar_Syntax_Syntax.pat', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.withinfo_t * (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax Prims.option * (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax)  ->  ((FStar_Syntax_Syntax.pat * FStar_Syntax_Syntax.term Prims.option * FStar_Syntax_Syntax.term) * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun scrutinee env branch -> (

let uu____6469 = (FStar_Syntax_Subst.open_branch branch)
in (match (uu____6469) with
| (pattern, when_clause, branch_exp) -> begin
(

let uu____6495 = branch
in (match (uu____6495) with
| (cpat, uu____6515, cbr) -> begin
(

let tc_pat = (fun allow_implicits pat_t p0 -> (

let uu____6557 = (FStar_TypeChecker_Util.pat_as_exps allow_implicits env p0)
in (match (uu____6557) with
| (pat_bvs, exps, p) -> begin
((

let uu____6579 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____6579) with
| true -> begin
(let _0_479 = (FStar_Syntax_Print.pat_to_string p0)
in (let _0_478 = (FStar_Syntax_Print.pat_to_string p)
in (FStar_Util.print2 "Pattern %s elaborated to %s\n" _0_479 _0_478)))
end
| uu____6580 -> begin
()
end));
(

let pat_env = (FStar_List.fold_left FStar_TypeChecker_Env.push_bv env pat_bvs)
in (

let uu____6582 = (FStar_TypeChecker_Env.clear_expected_typ pat_env)
in (match (uu____6582) with
| (env1, uu____6595) -> begin
(

let env1 = (

let uu___107_6599 = env1
in {FStar_TypeChecker_Env.solver = uu___107_6599.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___107_6599.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___107_6599.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___107_6599.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___107_6599.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___107_6599.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___107_6599.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___107_6599.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = true; FStar_TypeChecker_Env.instantiate_imp = uu___107_6599.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___107_6599.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___107_6599.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___107_6599.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___107_6599.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___107_6599.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___107_6599.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___107_6599.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___107_6599.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___107_6599.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___107_6599.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___107_6599.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___107_6599.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___107_6599.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___107_6599.FStar_TypeChecker_Env.qname_and_index})
in (

let expected_pat_t = (FStar_TypeChecker_Rel.unrefine env pat_t)
in (

let uu____6601 = (let _0_495 = (FStar_All.pipe_right exps (FStar_List.map (fun e -> ((

let uu____6621 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____6621) with
| true -> begin
(let _0_481 = (FStar_Syntax_Print.term_to_string e)
in (let _0_480 = (FStar_Syntax_Print.term_to_string pat_t)
in (FStar_Util.print2 "Checking pattern expression %s against expected type %s\n" _0_481 _0_480)))
end
| uu____6622 -> begin
()
end));
(

let uu____6623 = (tc_term env1 e)
in (match (uu____6623) with
| (e, lc, g) -> begin
((

let uu____6633 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____6633) with
| true -> begin
(let _0_483 = (FStar_TypeChecker_Normalize.term_to_string env e)
in (let _0_482 = (FStar_TypeChecker_Normalize.term_to_string env lc.FStar_Syntax_Syntax.res_typ)
in (FStar_Util.print2 "Pre-checked pattern expression %s at type %s\n" _0_483 _0_482)))
end
| uu____6634 -> begin
()
end));
(

let g' = (FStar_TypeChecker_Rel.teq env lc.FStar_Syntax_Syntax.res_typ expected_pat_t)
in (

let g = (FStar_TypeChecker_Rel.conj_guard g g')
in (

let uu____6637 = (let _0_484 = (FStar_TypeChecker_Rel.discharge_guard env (

let uu___108_6638 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = uu___108_6638.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = uu___108_6638.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = uu___108_6638.FStar_TypeChecker_Env.implicits}))
in (FStar_All.pipe_right _0_484 FStar_TypeChecker_Rel.resolve_implicits))
in (

let e' = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env e)
in (

let uvars_to_string = (fun uvs -> (let _0_486 = (let _0_485 = (FStar_All.pipe_right uvs FStar_Util.set_elements)
in (FStar_All.pipe_right _0_485 (FStar_List.map (fun uu____6672 -> (match (uu____6672) with
| (u, uu____6677) -> begin
(FStar_Syntax_Print.uvar_to_string u)
end)))))
in (FStar_All.pipe_right _0_486 (FStar_String.concat ", "))))
in (

let uvs1 = (FStar_Syntax_Free.uvars e')
in (

let uvs2 = (FStar_Syntax_Free.uvars expected_pat_t)
in ((

let uu____6689 = (let _0_487 = (FStar_Util.set_is_subset_of uvs1 uvs2)
in (FStar_All.pipe_left Prims.op_Negation _0_487))
in (match (uu____6689) with
| true -> begin
(

let unresolved = (let _0_488 = (FStar_Util.set_difference uvs1 uvs2)
in (FStar_All.pipe_right _0_488 FStar_Util.set_elements))
in (Prims.raise (FStar_Errors.Error ((let _0_493 = (let _0_492 = (FStar_TypeChecker_Normalize.term_to_string env e')
in (let _0_491 = (FStar_TypeChecker_Normalize.term_to_string env expected_pat_t)
in (let _0_490 = (let _0_489 = (FStar_All.pipe_right unresolved (FStar_List.map (fun uu____6717 -> (match (uu____6717) with
| (u, uu____6725) -> begin
(FStar_Syntax_Print.uvar_to_string u)
end))))
in (FStar_All.pipe_right _0_489 (FStar_String.concat ", ")))
in (FStar_Util.format3 "Implicit pattern variables in %s could not be resolved against expected type %s;Variables {%s} were unresolved; please bind them explicitly" _0_492 _0_491 _0_490))))
in ((_0_493), (p.FStar_Syntax_Syntax.p)))))))
end
| uu____6737 -> begin
()
end));
(

let uu____6739 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____6739) with
| true -> begin
(let _0_494 = (FStar_TypeChecker_Normalize.term_to_string env e)
in (FStar_Util.print1 "Done checking pattern expression %s\n" _0_494))
end
| uu____6740 -> begin
()
end));
((e), (e'));
))))))));
)
end));
))))
in (FStar_All.pipe_right _0_495 FStar_List.unzip))
in (match (uu____6601) with
| (exps, norm_exps) -> begin
(

let p = (FStar_TypeChecker_Util.decorate_pattern env p exps)
in ((p), (pat_bvs), (pat_env), (exps), (norm_exps)))
end))))
end)));
)
end)))
in (

let pat_t = scrutinee.FStar_Syntax_Syntax.sort
in (

let scrutinee_tm = (FStar_Syntax_Syntax.bv_to_name scrutinee)
in (

let uu____6763 = (let _0_496 = (FStar_TypeChecker_Env.push_bv env scrutinee)
in (FStar_All.pipe_right _0_496 FStar_TypeChecker_Env.clear_expected_typ))
in (match (uu____6763) with
| (scrutinee_env, uu____6779) -> begin
(

let uu____6782 = (tc_pat true pat_t pattern)
in (match (uu____6782) with
| (pattern, pat_bvs, pat_env, disj_exps, norm_disj_exps) -> begin
(

let uu____6810 = (match (when_clause) with
| None -> begin
((None), (FStar_TypeChecker_Rel.trivial_guard))
end
| Some (e) -> begin
(

let uu____6825 = (FStar_TypeChecker_Env.should_verify env)
in (match (uu____6825) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((("When clauses are not yet supported in --verify mode; they will be some day"), (e.FStar_Syntax_Syntax.pos)))))
end
| uu____6832 -> begin
(

let uu____6833 = (let _0_497 = (FStar_TypeChecker_Env.set_expected_typ pat_env FStar_TypeChecker_Common.t_bool)
in (tc_term _0_497 e))
in (match (uu____6833) with
| (e, c, g) -> begin
((Some (e)), (g))
end))
end))
end)
in (match (uu____6810) with
| (when_clause, g_when) -> begin
(

let uu____6856 = (tc_term pat_env branch_exp)
in (match (uu____6856) with
| (branch_exp, c, g_branch) -> begin
(

let when_condition = (match (when_clause) with
| None -> begin
None
end
| Some (w) -> begin
(let _0_499 = (FStar_Syntax_Util.mk_eq FStar_Syntax_Util.t_bool FStar_Syntax_Util.t_bool w FStar_Syntax_Const.exp_true_bool)
in (FStar_All.pipe_left (fun _0_498 -> Some (_0_498)) _0_499))
end)
in (

let uu____6888 = (

let eqs = (

let uu____6896 = (not ((FStar_TypeChecker_Env.should_verify env)))
in (match (uu____6896) with
| true -> begin
None
end
| uu____6902 -> begin
(FStar_All.pipe_right disj_exps (FStar_List.fold_left (fun fopt e -> (

let e = (FStar_Syntax_Subst.compress e)
in (match (e.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) -> begin
fopt
end
| uu____6922 -> begin
(

let clause = (FStar_Syntax_Util.mk_eq pat_t pat_t scrutinee_tm e)
in (match (fopt) with
| None -> begin
Some (clause)
end
| Some (f) -> begin
(let _0_501 = (FStar_Syntax_Util.mk_disj clause f)
in (FStar_All.pipe_left (fun _0_500 -> Some (_0_500)) _0_501))
end))
end))) None))
end))
in (

let uu____6951 = (FStar_TypeChecker_Util.strengthen_precondition None env branch_exp c g_branch)
in (match (uu____6951) with
| (c, g_branch) -> begin
(

let uu____6961 = (match (((eqs), (when_condition))) with
| uu____6972 when (not ((FStar_TypeChecker_Env.should_verify env))) -> begin
((c), (g_when))
end
| (None, None) -> begin
((c), (g_when))
end
| (Some (f), None) -> begin
(

let gf = FStar_TypeChecker_Common.NonTrivial (f)
in (

let g = (FStar_TypeChecker_Rel.guard_of_guard_formula gf)
in (let _0_503 = (FStar_TypeChecker_Util.weaken_precondition env c gf)
in (let _0_502 = (FStar_TypeChecker_Rel.imp_guard g g_when)
in ((_0_503), (_0_502))))))
end
| (Some (f), Some (w)) -> begin
(

let g_f = FStar_TypeChecker_Common.NonTrivial (f)
in (

let g_fw = FStar_TypeChecker_Common.NonTrivial ((FStar_Syntax_Util.mk_conj f w))
in (let _0_506 = (FStar_TypeChecker_Util.weaken_precondition env c g_fw)
in (let _0_505 = (let _0_504 = (FStar_TypeChecker_Rel.guard_of_guard_formula g_f)
in (FStar_TypeChecker_Rel.imp_guard _0_504 g_when))
in ((_0_506), (_0_505))))))
end
| (None, Some (w)) -> begin
(

let g_w = FStar_TypeChecker_Common.NonTrivial (w)
in (

let g = (FStar_TypeChecker_Rel.guard_of_guard_formula g_w)
in (let _0_507 = (FStar_TypeChecker_Util.weaken_precondition env c g_w)
in ((_0_507), (g_when)))))
end)
in (match (uu____6961) with
| (c_weak, g_when_weak) -> begin
(

let binders = (FStar_List.map FStar_Syntax_Syntax.mk_binder pat_bvs)
in (let _0_509 = (FStar_TypeChecker_Util.close_comp env pat_bvs c_weak)
in (let _0_508 = (FStar_TypeChecker_Rel.close_guard binders g_when_weak)
in ((_0_509), (_0_508), (g_branch)))))
end))
end)))
in (match (uu____6888) with
| (c, g_when, g_branch) -> begin
(

let branch_guard = (

let uu____7058 = (not ((FStar_TypeChecker_Env.should_verify env)))
in (match (uu____7058) with
| true -> begin
FStar_Syntax_Util.t_true
end
| uu____7059 -> begin
(

let rec build_branch_guard = (fun scrutinee_tm pat_exp -> (

let discriminate = (fun scrutinee_tm f -> (

let uu____7091 = (let _0_511 = (FStar_List.length (let _0_510 = (FStar_TypeChecker_Env.typ_of_datacon env f.FStar_Syntax_Syntax.v)
in (FStar_TypeChecker_Env.datacons_of_typ env _0_510)))
in (_0_511 > (Prims.parse_int "1")))
in (match (uu____7091) with
| true -> begin
(

let discriminator = (FStar_Syntax_Util.mk_discriminator f.FStar_Syntax_Syntax.v)
in (

let uu____7103 = (FStar_TypeChecker_Env.try_lookup_lid env discriminator)
in (match (uu____7103) with
| None -> begin
[]
end
| uu____7114 -> begin
(

let disc = (FStar_Syntax_Syntax.fvar discriminator FStar_Syntax_Syntax.Delta_equational None)
in (

let disc = ((let _0_513 = (let _0_512 = (FStar_Syntax_Syntax.as_arg scrutinee_tm)
in (_0_512)::[])
in (FStar_Syntax_Syntax.mk_Tm_app disc _0_513)) None scrutinee_tm.FStar_Syntax_Syntax.pos)
in (let _0_514 = (FStar_Syntax_Util.mk_eq FStar_Syntax_Util.t_bool FStar_Syntax_Util.t_bool disc FStar_Syntax_Const.exp_true_bool)
in (_0_514)::[])))
end)))
end
| uu____7130 -> begin
[]
end)))
in (

let fail = (fun uu____7139 -> (failwith (let _0_517 = (FStar_Range.string_of_range pat_exp.FStar_Syntax_Syntax.pos)
in (let _0_516 = (FStar_Syntax_Print.term_to_string pat_exp)
in (let _0_515 = (FStar_Syntax_Print.tag_of_term pat_exp)
in (FStar_Util.format3 "tc_eqn: Impossible (%s) %s (%s)" _0_517 _0_516 _0_515))))))
in (

let rec head_constructor = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
fv.FStar_Syntax_Syntax.fv_name
end
| FStar_Syntax_Syntax.Tm_uinst (t, uu____7160) -> begin
(head_constructor t)
end
| uu____7166 -> begin
(fail ())
end))
in (

let pat_exp = (let _0_518 = (FStar_Syntax_Subst.compress pat_exp)
in (FStar_All.pipe_right _0_518 FStar_Syntax_Util.unmeta))
in (match (pat_exp.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_uvar (_)) | (FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_unit)) -> begin
[]
end
| FStar_Syntax_Syntax.Tm_constant (uu____7184) -> begin
(let _0_523 = ((let _0_522 = (let _0_521 = (FStar_Syntax_Syntax.as_arg scrutinee_tm)
in (let _0_520 = (let _0_519 = (FStar_Syntax_Syntax.as_arg pat_exp)
in (_0_519)::[])
in (_0_521)::_0_520))
in (FStar_Syntax_Syntax.mk_Tm_app FStar_Syntax_Util.teq _0_522)) None scrutinee_tm.FStar_Syntax_Syntax.pos)
in (_0_523)::[])
end
| (FStar_Syntax_Syntax.Tm_uinst (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) -> begin
(

let f = (head_constructor pat_exp)
in (

let uu____7202 = (not ((FStar_TypeChecker_Env.is_datacon env f.FStar_Syntax_Syntax.v)))
in (match (uu____7202) with
| true -> begin
[]
end
| uu____7208 -> begin
(let _0_524 = (head_constructor pat_exp)
in (discriminate scrutinee_tm _0_524))
end)))
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let f = (head_constructor head)
in (

let uu____7232 = (not ((FStar_TypeChecker_Env.is_datacon env f.FStar_Syntax_Syntax.v)))
in (match (uu____7232) with
| true -> begin
[]
end
| uu____7238 -> begin
(

let sub_term_guards = (let _0_528 = (FStar_All.pipe_right args (FStar_List.mapi (fun i uu____7257 -> (match (uu____7257) with
| (ei, uu____7264) -> begin
(

let projector = (FStar_TypeChecker_Env.lookup_projector env f.FStar_Syntax_Syntax.v i)
in (

let uu____7274 = (FStar_TypeChecker_Env.try_lookup_lid env projector)
in (match (uu____7274) with
| None -> begin
[]
end
| uu____7281 -> begin
(

let sub_term = ((let _0_527 = (FStar_Syntax_Syntax.fvar (FStar_Ident.set_lid_range projector f.FStar_Syntax_Syntax.p) FStar_Syntax_Syntax.Delta_equational None)
in (let _0_526 = (let _0_525 = (FStar_Syntax_Syntax.as_arg scrutinee_tm)
in (_0_525)::[])
in (FStar_Syntax_Syntax.mk_Tm_app _0_527 _0_526))) None f.FStar_Syntax_Syntax.p)
in (build_branch_guard sub_term ei))
end)))
end))))
in (FStar_All.pipe_right _0_528 FStar_List.flatten))
in (let _0_529 = (discriminate scrutinee_tm f)
in (FStar_List.append _0_529 sub_term_guards)))
end)))
end
| uu____7304 -> begin
[]
end))))))
in (

let build_and_check_branch_guard = (fun scrutinee_tm pat -> (

let uu____7316 = (not ((FStar_TypeChecker_Env.should_verify env)))
in (match (uu____7316) with
| true -> begin
(FStar_TypeChecker_Util.fvar_const env FStar_Syntax_Const.true_lid)
end
| uu____7317 -> begin
(

let t = (let _0_530 = (build_branch_guard scrutinee_tm pat)
in (FStar_All.pipe_left FStar_Syntax_Util.mk_conj_l _0_530))
in (

let uu____7320 = (FStar_Syntax_Util.type_u ())
in (match (uu____7320) with
| (k, uu____7324) -> begin
(

let uu____7325 = (tc_check_tot_or_gtot_term scrutinee_env t k)
in (match (uu____7325) with
| (t, uu____7330, uu____7331) -> begin
t
end))
end)))
end)))
in (

let branch_guard = (let _0_531 = (FStar_All.pipe_right norm_disj_exps (FStar_List.map (build_and_check_branch_guard scrutinee_tm)))
in (FStar_All.pipe_right _0_531 FStar_Syntax_Util.mk_disj_l))
in (

let branch_guard = (match (when_condition) with
| None -> begin
branch_guard
end
| Some (w) -> begin
(FStar_Syntax_Util.mk_conj branch_guard w)
end)
in branch_guard))))
end))
in (

let guard = (FStar_TypeChecker_Rel.conj_guard g_when g_branch)
in ((

let uu____7348 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____7348) with
| true -> begin
(let _0_532 = (FStar_TypeChecker_Rel.guard_to_string env guard)
in (FStar_All.pipe_left (FStar_Util.print1 "Carrying guard from match: %s\n") _0_532))
end
| uu____7349 -> begin
()
end));
(let _0_533 = (FStar_Syntax_Subst.close_branch ((pattern), (when_clause), (branch_exp)))
in ((_0_533), (branch_guard), (c), (guard)));
)))
end)))
end))
end))
end))
end)))))
end))
end)))
and check_top_level_let : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (

let env = (instantiate_both env)
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((false, (lb)::[]), e2) -> begin
(

let uu____7367 = (check_let_bound_def true env lb)
in (match (uu____7367) with
| (e1, univ_vars, c1, g1, annotated) -> begin
(

let uu____7381 = (match ((annotated && (not (env.FStar_TypeChecker_Env.generalize)))) with
| true -> begin
((g1), (e1), (univ_vars), (c1))
end
| uu____7390 -> begin
(

let g1 = (let _0_534 = (FStar_TypeChecker_Rel.solve_deferred_constraints env g1)
in (FStar_All.pipe_right _0_534 FStar_TypeChecker_Rel.resolve_implicits))
in (

let uu____7393 = (FStar_List.hd (let _0_537 = (let _0_536 = (let _0_535 = (c1.FStar_Syntax_Syntax.comp ())
in ((lb.FStar_Syntax_Syntax.lbname), (e1), (_0_535)))
in (_0_536)::[])
in (FStar_TypeChecker_Util.generalize env _0_537)))
in (match (uu____7393) with
| (uu____7424, univs, e1, c1) -> begin
((g1), (e1), (univs), ((FStar_Syntax_Util.lcomp_of_comp c1)))
end)))
end)
in (match (uu____7381) with
| (g1, e1, univ_vars, c1) -> begin
(

let uu____7435 = (

let uu____7440 = (FStar_TypeChecker_Env.should_verify env)
in (match (uu____7440) with
| true -> begin
(

let uu____7445 = (FStar_TypeChecker_Util.check_top_level env g1 c1)
in (match (uu____7445) with
| (ok, c1) -> begin
(match (ok) with
| true -> begin
((e2), (c1))
end
| uu____7460 -> begin
((

let uu____7462 = (FStar_Options.warn_top_level_effects ())
in (match (uu____7462) with
| true -> begin
(let _0_538 = (FStar_TypeChecker_Env.get_range env)
in (FStar_Errors.warn _0_538 FStar_TypeChecker_Err.top_level_effect))
end
| uu____7463 -> begin
()
end));
(let _0_539 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_meta (((e2), (FStar_Syntax_Syntax.Meta_desugared (FStar_Syntax_Syntax.Masked_effect)))))) None e2.FStar_Syntax_Syntax.pos)
in ((_0_539), (c1)));
)
end)
end))
end
| uu____7480 -> begin
((FStar_TypeChecker_Rel.force_trivial_guard env g1);
(

let c = (let _0_540 = (c1.FStar_Syntax_Syntax.comp ())
in (FStar_All.pipe_right _0_540 (FStar_TypeChecker_Normalize.normalize_comp ((FStar_TypeChecker_Normalize.Beta)::[]) env)))
in ((e2), (c)));
)
end))
in (match (uu____7435) with
| (e2, c1) -> begin
(

let cres = (let _0_541 = (FStar_Syntax_Util.ml_comp FStar_TypeChecker_Common.t_unit e.FStar_Syntax_Syntax.pos)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _0_541))
in ((FStar_ST.write e2.FStar_Syntax_Syntax.tk (Some (FStar_TypeChecker_Common.t_unit.FStar_Syntax_Syntax.n)));
(

let lb = (FStar_Syntax_Util.close_univs_and_mk_letbinding None lb.FStar_Syntax_Syntax.lbname univ_vars (FStar_Syntax_Util.comp_result c1) (FStar_Syntax_Util.comp_effect_name c1) e1)
in (let _0_542 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((((false), ((lb)::[]))), (e2))))) (Some (FStar_TypeChecker_Common.t_unit.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in ((_0_542), (cres), (FStar_TypeChecker_Rel.trivial_guard))));
))
end))
end))
end))
end
| uu____7525 -> begin
(failwith "Impossible")
end)))
and check_inner_let : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (

let env = (instantiate_both env)
in (match (e.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((false, (lb)::[]), e2) -> begin
(

let env = (

let uu___109_7546 = env
in {FStar_TypeChecker_Env.solver = uu___109_7546.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___109_7546.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___109_7546.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___109_7546.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___109_7546.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___109_7546.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___109_7546.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___109_7546.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___109_7546.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___109_7546.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___109_7546.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___109_7546.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___109_7546.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = uu___109_7546.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___109_7546.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___109_7546.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___109_7546.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___109_7546.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___109_7546.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___109_7546.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___109_7546.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___109_7546.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___109_7546.FStar_TypeChecker_Env.qname_and_index})
in (

let uu____7547 = (let _0_544 = (let _0_543 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (FStar_All.pipe_right _0_543 Prims.fst))
in (check_let_bound_def false _0_544 lb))
in (match (uu____7547) with
| (e1, uu____7561, c1, g1, annotated) -> begin
(

let x = (

let uu___110_7566 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in {FStar_Syntax_Syntax.ppname = uu___110_7566.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___110_7566.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = c1.FStar_Syntax_Syntax.res_typ})
in (

let uu____7567 = (let _0_546 = (let _0_545 = (FStar_Syntax_Syntax.mk_binder x)
in (_0_545)::[])
in (FStar_Syntax_Subst.open_term _0_546 e2))
in (match (uu____7567) with
| (xb, e2) -> begin
(

let xbinder = (FStar_List.hd xb)
in (

let x = (Prims.fst xbinder)
in (

let uu____7581 = (let _0_547 = (FStar_TypeChecker_Env.push_bv env x)
in (tc_term _0_547 e2))
in (match (uu____7581) with
| (e2, c2, g2) -> begin
(

let cres = (FStar_TypeChecker_Util.bind e1.FStar_Syntax_Syntax.pos env (Some (e1)) c1 ((Some (x)), (c2)))
in (

let e1 = (FStar_TypeChecker_Util.maybe_lift env e1 c1.FStar_Syntax_Syntax.eff_name cres.FStar_Syntax_Syntax.eff_name c1.FStar_Syntax_Syntax.res_typ)
in (

let e2 = (FStar_TypeChecker_Util.maybe_lift env e2 c2.FStar_Syntax_Syntax.eff_name cres.FStar_Syntax_Syntax.eff_name c2.FStar_Syntax_Syntax.res_typ)
in (

let lb = (FStar_Syntax_Util.mk_letbinding (FStar_Util.Inl (x)) [] c1.FStar_Syntax_Syntax.res_typ c1.FStar_Syntax_Syntax.eff_name e1)
in (

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let ((let _0_548 = (FStar_Syntax_Subst.close xb e2)
in ((((false), ((lb)::[]))), (_0_548)))))) (Some (cres.FStar_Syntax_Syntax.res_typ.FStar_Syntax_Syntax.n)) e.FStar_Syntax_Syntax.pos)
in (

let e = (FStar_TypeChecker_Util.maybe_monadic env e cres.FStar_Syntax_Syntax.eff_name cres.FStar_Syntax_Syntax.res_typ)
in (

let x_eq_e1 = (let _0_551 = (let _0_550 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Util.mk_eq c1.FStar_Syntax_Syntax.res_typ c1.FStar_Syntax_Syntax.res_typ _0_550 e1))
in (FStar_All.pipe_left (fun _0_549 -> FStar_TypeChecker_Common.NonTrivial (_0_549)) _0_551))
in (

let g2 = (let _0_553 = (let _0_552 = (FStar_TypeChecker_Rel.guard_of_guard_formula x_eq_e1)
in (FStar_TypeChecker_Rel.imp_guard _0_552 g2))
in (FStar_TypeChecker_Rel.close_guard xb _0_553))
in (

let guard = (FStar_TypeChecker_Rel.conj_guard g1 g2)
in (

let uu____7619 = (FStar_Option.isSome (FStar_TypeChecker_Env.expected_typ env))
in (match (uu____7619) with
| true -> begin
(

let tt = (let _0_554 = (FStar_TypeChecker_Env.expected_typ env)
in (FStar_All.pipe_right _0_554 FStar_Option.get))
in ((

let uu____7626 = (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Exports")))
in (match (uu____7626) with
| true -> begin
(let _0_556 = (FStar_Syntax_Print.term_to_string tt)
in (let _0_555 = (FStar_Syntax_Print.term_to_string cres.FStar_Syntax_Syntax.res_typ)
in (FStar_Util.print2 "Got expected type from env %s\ncres.res_typ=%s\n" _0_556 _0_555)))
end
| uu____7627 -> begin
()
end));
((e), (cres), (guard));
))
end
| uu____7628 -> begin
(

let t = (check_no_escape None env ((x)::[]) cres.FStar_Syntax_Syntax.res_typ)
in ((

let uu____7631 = (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Exports")))
in (match (uu____7631) with
| true -> begin
(let _0_558 = (FStar_Syntax_Print.term_to_string cres.FStar_Syntax_Syntax.res_typ)
in (let _0_557 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "Checked %s has no escaping types; normalized to %s\n" _0_558 _0_557)))
end
| uu____7632 -> begin
()
end));
((e), ((

let uu___111_7633 = cres
in {FStar_Syntax_Syntax.eff_name = uu___111_7633.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = t; FStar_Syntax_Syntax.cflags = uu___111_7633.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = uu___111_7633.FStar_Syntax_Syntax.comp})), (guard));
))
end)))))))))))
end))))
end)))
end)))
end
| uu____7634 -> begin
(failwith "Impossible")
end)))
and check_top_level_let_rec : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env top -> (

let env = (instantiate_both env)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((true, lbs), e2) -> begin
(

let uu____7655 = (FStar_Syntax_Subst.open_let_rec lbs e2)
in (match (uu____7655) with
| (lbs, e2) -> begin
(

let uu____7666 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____7666) with
| (env0, topt) -> begin
(

let uu____7677 = (build_let_rec_env true env0 lbs)
in (match (uu____7677) with
| (lbs, rec_env) -> begin
(

let uu____7688 = (check_let_recs rec_env lbs)
in (match (uu____7688) with
| (lbs, g_lbs) -> begin
(

let g_lbs = (let _0_559 = (FStar_TypeChecker_Rel.solve_deferred_constraints env g_lbs)
in (FStar_All.pipe_right _0_559 FStar_TypeChecker_Rel.resolve_implicits))
in (

let all_lb_names = (let _0_561 = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (FStar_Util.right lb.FStar_Syntax_Syntax.lbname))))
in (FStar_All.pipe_right _0_561 (fun _0_560 -> Some (_0_560))))
in (

let lbs = (match ((not (env.FStar_TypeChecker_Env.generalize))) with
| true -> begin
(FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (match ((lb.FStar_Syntax_Syntax.lbunivs = [])) with
| true -> begin
lb
end
| uu____7717 -> begin
(FStar_Syntax_Util.close_univs_and_mk_letbinding all_lb_names lb.FStar_Syntax_Syntax.lbname lb.FStar_Syntax_Syntax.lbunivs lb.FStar_Syntax_Syntax.lbtyp lb.FStar_Syntax_Syntax.lbeff lb.FStar_Syntax_Syntax.lbdef)
end))))
end
| uu____7718 -> begin
(

let ecs = (let _0_563 = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (let _0_562 = (FStar_Syntax_Syntax.mk_Total lb.FStar_Syntax_Syntax.lbtyp)
in ((lb.FStar_Syntax_Syntax.lbname), (lb.FStar_Syntax_Syntax.lbdef), (_0_562))))))
in (FStar_TypeChecker_Util.generalize env _0_563))
in (FStar_All.pipe_right ecs (FStar_List.map (fun uu____7761 -> (match (uu____7761) with
| (x, uvs, e, c) -> begin
(FStar_Syntax_Util.close_univs_and_mk_letbinding all_lb_names x uvs (FStar_Syntax_Util.comp_result c) (FStar_Syntax_Util.comp_effect_name c) e)
end)))))
end)
in (

let cres = (let _0_564 = (FStar_Syntax_Syntax.mk_Total FStar_TypeChecker_Common.t_unit)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _0_564))
in ((FStar_ST.write e2.FStar_Syntax_Syntax.tk (Some (FStar_TypeChecker_Common.t_unit.FStar_Syntax_Syntax.n)));
(

let uu____7792 = (FStar_Syntax_Subst.close_let_rec lbs e2)
in (match (uu____7792) with
| (lbs, e2) -> begin
(let _0_566 = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((((true), (lbs))), (e2))))) (Some (FStar_TypeChecker_Common.t_unit.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (let _0_565 = (FStar_TypeChecker_Rel.discharge_guard env g_lbs)
in ((_0_566), (cres), (_0_565))))
end));
)))))
end))
end))
end))
end))
end
| uu____7821 -> begin
(failwith "Impossible")
end)))
and check_inner_let_rec : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env top -> (

let env = (instantiate_both env)
in (match (top.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_let ((true, lbs), e2) -> begin
(

let uu____7842 = (FStar_Syntax_Subst.open_let_rec lbs e2)
in (match (uu____7842) with
| (lbs, e2) -> begin
(

let uu____7853 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____7853) with
| (env0, topt) -> begin
(

let uu____7864 = (build_let_rec_env false env0 lbs)
in (match (uu____7864) with
| (lbs, rec_env) -> begin
(

let uu____7875 = (check_let_recs rec_env lbs)
in (match (uu____7875) with
| (lbs, g_lbs) -> begin
(

let uu____7886 = (FStar_All.pipe_right lbs (FStar_Util.fold_map (fun env lb -> (

let x = (

let uu___112_7897 = (FStar_Util.left lb.FStar_Syntax_Syntax.lbname)
in {FStar_Syntax_Syntax.ppname = uu___112_7897.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___112_7897.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = lb.FStar_Syntax_Syntax.lbtyp})
in (

let lb = (

let uu___113_7899 = lb
in {FStar_Syntax_Syntax.lbname = FStar_Util.Inl (x); FStar_Syntax_Syntax.lbunivs = uu___113_7899.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = uu___113_7899.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = uu___113_7899.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = uu___113_7899.FStar_Syntax_Syntax.lbdef})
in (

let env = (FStar_TypeChecker_Env.push_let_binding env lb.FStar_Syntax_Syntax.lbname (([]), (lb.FStar_Syntax_Syntax.lbtyp)))
in ((env), (lb)))))) env))
in (match (uu____7886) with
| (env, lbs) -> begin
(

let bvs = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (FStar_Util.left lb.FStar_Syntax_Syntax.lbname))))
in (

let uu____7916 = (tc_term env e2)
in (match (uu____7916) with
| (e2, cres, g2) -> begin
(

let guard = (FStar_TypeChecker_Rel.conj_guard g_lbs g2)
in (

let cres = (FStar_TypeChecker_Util.close_comp env bvs cres)
in (

let tres = (norm env cres.FStar_Syntax_Syntax.res_typ)
in (

let cres = (

let uu___114_7930 = cres
in {FStar_Syntax_Syntax.eff_name = uu___114_7930.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = tres; FStar_Syntax_Syntax.cflags = uu___114_7930.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = uu___114_7930.FStar_Syntax_Syntax.comp})
in (

let uu____7931 = (FStar_Syntax_Subst.close_let_rec lbs e2)
in (match (uu____7931) with
| (lbs, e2) -> begin
(

let e = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_let (((((true), (lbs))), (e2))))) (Some (tres.FStar_Syntax_Syntax.n)) top.FStar_Syntax_Syntax.pos)
in (match (topt) with
| Some (uu____7960) -> begin
((e), (cres), (guard))
end
| None -> begin
(

let tres = (check_no_escape None env bvs tres)
in (

let cres = (

let uu___115_7965 = cres
in {FStar_Syntax_Syntax.eff_name = uu___115_7965.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = tres; FStar_Syntax_Syntax.cflags = uu___115_7965.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = uu___115_7965.FStar_Syntax_Syntax.comp})
in ((e), (cres), (guard))))
end))
end))))))
end)))
end))
end))
end))
end))
end))
end
| uu____7968 -> begin
(failwith "Impossible")
end)))
and build_let_rec_env : Prims.bool  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.letbinding Prims.list  ->  (FStar_Syntax_Syntax.letbinding Prims.list * FStar_TypeChecker_Env.env_t) = (fun top_level env lbs -> (

let env0 = env
in (

let termination_check_enabled = (fun t -> (

let uu____7984 = (FStar_Syntax_Util.arrow_formals_comp t)
in (match (uu____7984) with
| (uu____7990, c) -> begin
(

let quals = (FStar_TypeChecker_Env.lookup_effect_quals env (FStar_Syntax_Util.comp_effect_name c))
in (FStar_All.pipe_right quals (FStar_List.contains FStar_Syntax_Syntax.TotalEffect)))
end)))
in (

let uu____8001 = (FStar_List.fold_left (fun uu____8008 lb -> (match (uu____8008) with
| (lbs, env) -> begin
(

let uu____8020 = (FStar_TypeChecker_Util.extract_let_rec_annotation env lb)
in (match (uu____8020) with
| (univ_vars, t, check_t) -> begin
(

let env = (FStar_TypeChecker_Env.push_univ_vars env univ_vars)
in (

let e = (FStar_Syntax_Util.unascribe lb.FStar_Syntax_Syntax.lbdef)
in (

let t = (match ((not (check_t))) with
| true -> begin
t
end
| uu____8033 -> begin
(

let uu____8034 = (let _0_568 = (let _0_567 = (FStar_Syntax_Util.type_u ())
in (FStar_All.pipe_left Prims.fst _0_567))
in (tc_check_tot_or_gtot_term (

let uu___116_8038 = env0
in {FStar_TypeChecker_Env.solver = uu___116_8038.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___116_8038.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___116_8038.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___116_8038.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___116_8038.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___116_8038.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___116_8038.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___116_8038.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___116_8038.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___116_8038.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___116_8038.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___116_8038.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___116_8038.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___116_8038.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = true; FStar_TypeChecker_Env.use_eq = uu___116_8038.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___116_8038.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___116_8038.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___116_8038.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___116_8038.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___116_8038.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___116_8038.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___116_8038.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___116_8038.FStar_TypeChecker_Env.qname_and_index}) t _0_568))
in (match (uu____8034) with
| (t, uu____8042, g) -> begin
(

let g = (FStar_TypeChecker_Rel.resolve_implicits g)
in ((let _0_569 = (FStar_TypeChecker_Rel.discharge_guard env g)
in (FStar_All.pipe_left Prims.ignore _0_569));
(norm env0 t);
))
end))
end)
in (

let env = (

let uu____8047 = ((termination_check_enabled t) && (FStar_TypeChecker_Env.should_verify env))
in (match (uu____8047) with
| true -> begin
(

let uu___117_8048 = env
in {FStar_TypeChecker_Env.solver = uu___117_8048.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___117_8048.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___117_8048.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___117_8048.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___117_8048.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___117_8048.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___117_8048.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___117_8048.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___117_8048.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___117_8048.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___117_8048.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___117_8048.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = (((lb.FStar_Syntax_Syntax.lbname), (t)))::env.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = uu___117_8048.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = uu___117_8048.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___117_8048.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___117_8048.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___117_8048.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___117_8048.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___117_8048.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___117_8048.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___117_8048.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___117_8048.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___117_8048.FStar_TypeChecker_Env.qname_and_index})
end
| uu____8055 -> begin
(FStar_TypeChecker_Env.push_let_binding env lb.FStar_Syntax_Syntax.lbname (([]), (t)))
end))
in (

let lb = (

let uu___118_8058 = lb
in {FStar_Syntax_Syntax.lbname = uu___118_8058.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = univ_vars; FStar_Syntax_Syntax.lbtyp = t; FStar_Syntax_Syntax.lbeff = uu___118_8058.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = e})
in (((lb)::lbs), (env)))))))
end))
end)) (([]), (env)) lbs)
in (match (uu____8001) with
| (lbs, env) -> begin
(((FStar_List.rev lbs)), (env))
end)))))
and check_let_recs : FStar_TypeChecker_Env.env_t  ->  FStar_Syntax_Syntax.letbinding Prims.list  ->  (FStar_Syntax_Syntax.letbinding Prims.list * FStar_TypeChecker_Env.guard_t) = (fun env lbs -> (

let uu____8072 = (let _0_571 = (FStar_All.pipe_right lbs (FStar_List.map (fun lb -> (

let uu____8091 = (let _0_570 = (FStar_TypeChecker_Env.set_expected_typ env lb.FStar_Syntax_Syntax.lbtyp)
in (tc_tot_or_gtot_term _0_570 lb.FStar_Syntax_Syntax.lbdef))
in (match (uu____8091) with
| (e, c, g) -> begin
((

let uu____8101 = (not ((FStar_Syntax_Util.is_total_lcomp c)))
in (match (uu____8101) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((("Expected let rec to be a Tot term; got effect GTot"), (e.FStar_Syntax_Syntax.pos)))))
end
| uu____8102 -> begin
()
end));
(

let lb = (FStar_Syntax_Util.mk_letbinding lb.FStar_Syntax_Syntax.lbname lb.FStar_Syntax_Syntax.lbunivs lb.FStar_Syntax_Syntax.lbtyp FStar_Syntax_Const.effect_Tot_lid e)
in ((lb), (g)));
)
end)))))
in (FStar_All.pipe_right _0_571 FStar_List.unzip))
in (match (uu____8072) with
| (lbs, gs) -> begin
(

let g_lbs = (FStar_List.fold_right FStar_TypeChecker_Rel.conj_guard gs FStar_TypeChecker_Rel.trivial_guard)
in ((lbs), (g_lbs)))
end)))
and check_let_bound_def : Prims.bool  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.letbinding  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t * Prims.bool) = (fun top_level env lb -> (

let uu____8123 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____8123) with
| (env1, uu____8133) -> begin
(

let e1 = lb.FStar_Syntax_Syntax.lbdef
in (

let uu____8139 = (check_lbtyp top_level env lb)
in (match (uu____8139) with
| (topt, wf_annot, univ_vars, univ_opening, env1) -> begin
((match (((not (top_level)) && (univ_vars <> []))) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((("Inner let-bound definitions cannot be universe polymorphic"), (e1.FStar_Syntax_Syntax.pos)))))
end
| uu____8162 -> begin
()
end);
(

let e1 = (FStar_Syntax_Subst.subst univ_opening e1)
in (

let uu____8165 = (tc_maybe_toplevel_term (

let uu___119_8169 = env1
in {FStar_TypeChecker_Env.solver = uu___119_8169.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___119_8169.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___119_8169.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___119_8169.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___119_8169.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___119_8169.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___119_8169.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___119_8169.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___119_8169.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___119_8169.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___119_8169.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___119_8169.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___119_8169.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = top_level; FStar_TypeChecker_Env.check_uvars = uu___119_8169.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___119_8169.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___119_8169.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___119_8169.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___119_8169.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___119_8169.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___119_8169.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___119_8169.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___119_8169.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___119_8169.FStar_TypeChecker_Env.qname_and_index}) e1)
in (match (uu____8165) with
| (e1, c1, g1) -> begin
(

let uu____8178 = (let _0_572 = (FStar_TypeChecker_Env.set_range env1 e1.FStar_Syntax_Syntax.pos)
in (FStar_TypeChecker_Util.strengthen_precondition (Some ((fun uu____8183 -> FStar_TypeChecker_Err.ill_kinded_type))) _0_572 e1 c1 wf_annot))
in (match (uu____8178) with
| (c1, guard_f) -> begin
(

let g1 = (FStar_TypeChecker_Rel.conj_guard g1 guard_f)
in ((

let uu____8193 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____8193) with
| true -> begin
(let _0_575 = (FStar_Syntax_Print.lbname_to_string lb.FStar_Syntax_Syntax.lbname)
in (let _0_574 = (FStar_Syntax_Print.term_to_string c1.FStar_Syntax_Syntax.res_typ)
in (let _0_573 = (FStar_TypeChecker_Rel.guard_to_string env g1)
in (FStar_Util.print3 "checked top-level def %s, result type is %s, guard is %s\n" _0_575 _0_574 _0_573))))
end
| uu____8194 -> begin
()
end));
((e1), (univ_vars), (c1), (g1), ((FStar_Option.isSome topt)));
))
end))
end)));
)
end)))
end)))
and check_lbtyp : Prims.bool  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.letbinding  ->  (FStar_Syntax_Syntax.typ Prims.option * FStar_TypeChecker_Env.guard_t * FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.subst_elt Prims.list * FStar_TypeChecker_Env.env) = (fun top_level env lb -> (

let t = (FStar_Syntax_Subst.compress lb.FStar_Syntax_Syntax.lbtyp)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
((match ((lb.FStar_Syntax_Syntax.lbunivs <> [])) with
| true -> begin
(failwith "Impossible: non-empty universe variables but the type is unknown")
end
| uu____8215 -> begin
()
end);
((None), (FStar_TypeChecker_Rel.trivial_guard), ([]), ([]), (env));
)
end
| uu____8219 -> begin
(

let uu____8220 = (FStar_Syntax_Subst.univ_var_opening lb.FStar_Syntax_Syntax.lbunivs)
in (match (uu____8220) with
| (univ_opening, univ_vars) -> begin
(

let t = (FStar_Syntax_Subst.subst univ_opening t)
in (

let env1 = (FStar_TypeChecker_Env.push_univ_vars env univ_vars)
in (match ((top_level && (not (env.FStar_TypeChecker_Env.generalize)))) with
| true -> begin
(let _0_576 = (FStar_TypeChecker_Env.set_expected_typ env1 t)
in ((Some (t)), (FStar_TypeChecker_Rel.trivial_guard), (univ_vars), (univ_opening), (_0_576)))
end
| uu____8250 -> begin
(

let uu____8251 = (FStar_Syntax_Util.type_u ())
in (match (uu____8251) with
| (k, uu____8262) -> begin
(

let uu____8263 = (tc_check_tot_or_gtot_term env1 t k)
in (match (uu____8263) with
| (t, uu____8275, g) -> begin
((

let uu____8278 = (FStar_TypeChecker_Env.debug env FStar_Options.Medium)
in (match (uu____8278) with
| true -> begin
(let _0_578 = (FStar_Range.string_of_range (FStar_Syntax_Syntax.range_of_lbname lb.FStar_Syntax_Syntax.lbname))
in (let _0_577 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "(%s) Checked type annotation %s\n" _0_578 _0_577)))
end
| uu____8279 -> begin
()
end));
(

let t = (norm env1 t)
in (let _0_579 = (FStar_TypeChecker_Env.set_expected_typ env1 t)
in ((Some (t)), (g), (univ_vars), (univ_opening), (_0_579))));
)
end))
end))
end)))
end))
end)))
and tc_binder : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual)  ->  ((FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.aqual) * FStar_TypeChecker_Env.env * FStar_TypeChecker_Env.guard_t * FStar_Syntax_Syntax.universe) = (fun env uu____8285 -> (match (uu____8285) with
| (x, imp) -> begin
(

let uu____8296 = (FStar_Syntax_Util.type_u ())
in (match (uu____8296) with
| (tu, u) -> begin
((

let uu____8308 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____8308) with
| true -> begin
(let _0_582 = (FStar_Syntax_Print.bv_to_string x)
in (let _0_581 = (FStar_Syntax_Print.term_to_string x.FStar_Syntax_Syntax.sort)
in (let _0_580 = (FStar_Syntax_Print.term_to_string tu)
in (FStar_Util.print3 "Checking binders %s:%s at type %s\n" _0_582 _0_581 _0_580))))
end
| uu____8309 -> begin
()
end));
(

let uu____8310 = (tc_check_tot_or_gtot_term env x.FStar_Syntax_Syntax.sort tu)
in (match (uu____8310) with
| (t, uu____8321, g) -> begin
(

let x = (((

let uu___120_8326 = x
in {FStar_Syntax_Syntax.ppname = uu___120_8326.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = uu___120_8326.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t})), (imp))
in ((

let uu____8328 = (FStar_TypeChecker_Env.debug env FStar_Options.High)
in (match (uu____8328) with
| true -> begin
(let _0_584 = (FStar_Syntax_Print.bv_to_string (Prims.fst x))
in (let _0_583 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.print2 "Pushing binder %s at type %s\n" _0_584 _0_583)))
end
| uu____8329 -> begin
()
end));
(let _0_585 = (push_binding env x)
in ((x), (_0_585), (g), (u)));
))
end));
)
end))
end))
and tc_binders : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.binders * FStar_TypeChecker_Env.env * FStar_TypeChecker_Env.guard_t * FStar_Syntax_Syntax.universes) = (fun env bs -> (

let rec aux = (fun env bs -> (match (bs) with
| [] -> begin
(([]), (env), (FStar_TypeChecker_Rel.trivial_guard), ([]))
end
| (b)::bs -> begin
(

let uu____8380 = (tc_binder env b)
in (match (uu____8380) with
| (b, env', g, u) -> begin
(

let uu____8403 = (aux env' bs)
in (match (uu____8403) with
| (bs, env', g', us) -> begin
(let _0_587 = (let _0_586 = (FStar_TypeChecker_Rel.close_guard ((b)::[]) g')
in (FStar_TypeChecker_Rel.conj_guard g _0_586))
in (((b)::bs), (env'), (_0_587), ((u)::us)))
end))
end))
end))
in (aux env bs)))
and tc_pats : FStar_TypeChecker_Env.env  ->  ((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list Prims.list  ->  (((FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax * FStar_Syntax_Syntax.aqual) Prims.list Prims.list * FStar_TypeChecker_Env.guard_t) = (fun env pats -> (

let tc_args = (fun env args -> (FStar_List.fold_right (fun uu____8477 uu____8478 -> (match (((uu____8477), (uu____8478))) with
| ((t, imp), (args, g)) -> begin
(

let uu____8515 = (tc_term env t)
in (match (uu____8515) with
| (t, uu____8525, g') -> begin
(let _0_588 = (FStar_TypeChecker_Rel.conj_guard g g')
in (((((t), (imp)))::args), (_0_588)))
end))
end)) args (([]), (FStar_TypeChecker_Rel.trivial_guard))))
in (FStar_List.fold_right (fun p uu____8547 -> (match (uu____8547) with
| (pats, g) -> begin
(

let uu____8573 = (tc_args env p)
in (match (uu____8573) with
| (args, g') -> begin
(let _0_589 = (FStar_TypeChecker_Rel.conj_guard g g')
in (((args)::pats), (_0_589)))
end))
end)) pats (([]), (FStar_TypeChecker_Rel.trivial_guard)))))
and tc_tot_or_gtot_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e -> (

let uu____8612 = (tc_maybe_toplevel_term env e)
in (match (uu____8612) with
| (e, c, g) -> begin
(

let uu____8622 = (FStar_Syntax_Util.is_tot_or_gtot_lcomp c)
in (match (uu____8622) with
| true -> begin
((e), (c), (g))
end
| uu____8626 -> begin
(

let g = (FStar_TypeChecker_Rel.solve_deferred_constraints env g)
in (

let c = (c.FStar_Syntax_Syntax.comp ())
in (

let c = (norm_c env c)
in (

let uu____8632 = (

let uu____8635 = (FStar_TypeChecker_Util.is_pure_effect env (FStar_Syntax_Util.comp_effect_name c))
in (match (uu____8635) with
| true -> begin
(let _0_590 = (FStar_Syntax_Syntax.mk_Total (FStar_Syntax_Util.comp_result c))
in ((_0_590), (false)))
end
| uu____8638 -> begin
(let _0_591 = (FStar_Syntax_Syntax.mk_GTotal (FStar_Syntax_Util.comp_result c))
in ((_0_591), (true)))
end))
in (match (uu____8632) with
| (target_comp, allow_ghost) -> begin
(

let uu____8644 = (FStar_TypeChecker_Rel.sub_comp env c target_comp)
in (match (uu____8644) with
| Some (g') -> begin
(let _0_592 = (FStar_TypeChecker_Rel.conj_guard g g')
in ((e), ((FStar_Syntax_Util.lcomp_of_comp target_comp)), (_0_592)))
end
| uu____8650 -> begin
(match (allow_ghost) with
| true -> begin
(Prims.raise (FStar_Errors.Error ((let _0_593 = (FStar_TypeChecker_Err.expected_ghost_expression e c)
in ((_0_593), (e.FStar_Syntax_Syntax.pos))))))
end
| uu____8658 -> begin
(Prims.raise (FStar_Errors.Error ((let _0_594 = (FStar_TypeChecker_Err.expected_pure_expression e c)
in ((_0_594), (e.FStar_Syntax_Syntax.pos))))))
end)
end))
end)))))
end))
end)))
and tc_check_tot_or_gtot_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.typ  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp * FStar_TypeChecker_Env.guard_t) = (fun env e t -> (

let env = (FStar_TypeChecker_Env.set_expected_typ env t)
in (tc_tot_or_gtot_term env e)))
and tc_trivial_guard : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.lcomp) = (fun env t -> (

let uu____8671 = (tc_tot_or_gtot_term env t)
in (match (uu____8671) with
| (t, c, g) -> begin
((FStar_TypeChecker_Rel.force_trivial_guard env g);
((t), (c));
)
end)))


let type_of_tot_term : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * FStar_TypeChecker_Env.guard_t) = (fun env e -> ((

let uu____8691 = (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck")))
in (match (uu____8691) with
| true -> begin
(let _0_595 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.print1 "Checking term %s\n" _0_595))
end
| uu____8692 -> begin
()
end));
(

let env = (

let uu___121_8694 = env
in {FStar_TypeChecker_Env.solver = uu___121_8694.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___121_8694.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___121_8694.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___121_8694.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___121_8694.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___121_8694.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___121_8694.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___121_8694.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___121_8694.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___121_8694.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___121_8694.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___121_8694.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___121_8694.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = uu___121_8694.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___121_8694.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___121_8694.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___121_8694.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = uu___121_8694.FStar_TypeChecker_Env.lax; FStar_TypeChecker_Env.lax_universes = uu___121_8694.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___121_8694.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___121_8694.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = uu___121_8694.FStar_TypeChecker_Env.use_bv_sorts; FStar_TypeChecker_Env.qname_and_index = uu___121_8694.FStar_TypeChecker_Env.qname_and_index})
in (

let uu____8695 = try
(match (()) with
| () -> begin
(tc_tot_or_gtot_term env e)
end)
with
| FStar_Errors.Error (msg, uu____8711) -> begin
(Prims.raise (FStar_Errors.Error ((let _0_596 = (FStar_TypeChecker_Env.get_range env)
in (((Prims.strcat "Implicit argument: " msg)), (_0_596))))))
end
in (match (uu____8695) with
| (t, c, g) -> begin
(

let uu____8721 = (FStar_Syntax_Util.is_total_lcomp c)
in (match (uu____8721) with
| true -> begin
((t), (c.FStar_Syntax_Syntax.res_typ), (g))
end
| uu____8727 -> begin
(Prims.raise (FStar_Errors.Error ((let _0_599 = (let _0_597 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "Implicit argument: Expected a total term; got a ghost term: %s" _0_597))
in (let _0_598 = (FStar_TypeChecker_Env.get_range env)
in ((_0_599), (_0_598)))))))
end))
end)));
))


let universe_or_type_of : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.universe) FStar_Util.either = (fun env e -> ((

let uu____8740 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____8740) with
| true -> begin
(let _0_600 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.print1 "<start> universe_of %s\n" _0_600))
end
| uu____8741 -> begin
()
end));
(

let uu____8742 = (FStar_TypeChecker_Env.clear_expected_typ env)
in (match (uu____8742) with
| (env, uu____8749) -> begin
(

let env = (

let uu___124_8753 = env
in {FStar_TypeChecker_Env.solver = uu___124_8753.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = uu___124_8753.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = uu___124_8753.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = uu___124_8753.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = uu___124_8753.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = uu___124_8753.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = uu___124_8753.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = uu___124_8753.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = uu___124_8753.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = uu___124_8753.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = uu___124_8753.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = uu___124_8753.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = uu___124_8753.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = false; FStar_TypeChecker_Env.check_uvars = uu___124_8753.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = uu___124_8753.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = uu___124_8753.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = uu___124_8753.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.lax = true; FStar_TypeChecker_Env.lax_universes = uu___124_8753.FStar_TypeChecker_Env.lax_universes; FStar_TypeChecker_Env.type_of = uu___124_8753.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = uu___124_8753.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = true; FStar_TypeChecker_Env.qname_and_index = uu___124_8753.FStar_TypeChecker_Env.qname_and_index})
in (

let fail = (fun e t -> FStar_Util.Inl (t))
in (

let ok = (fun u -> ((

let uu____8770 = (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
in (match (uu____8770) with
| true -> begin
(let _0_603 = (FStar_Syntax_Print.tag_of_term e)
in (let _0_602 = (FStar_Syntax_Print.term_to_string e)
in (let _0_601 = (FStar_Syntax_Print.univ_to_string u)
in (FStar_Util.print3 "<end> universe_of (%s) %s is %s\n" _0_603 _0_602 _0_601))))
end
| uu____8771 -> begin
()
end));
FStar_Util.Inr (u);
))
in (

let universe_of_type = (fun e t -> (

let uu____8781 = (FStar_Syntax_Util.unrefine t).FStar_Syntax_Syntax.n
in (match (uu____8781) with
| FStar_Syntax_Syntax.Tm_type (u) -> begin
(ok u)
end
| uu____8785 -> begin
(fail e t)
end)))
in (

let uu____8786 = (FStar_Syntax_Util.head_and_args e)
in (match (uu____8786) with
| (head, args) -> begin
(

let uu____8814 = (FStar_Syntax_Subst.compress head).FStar_Syntax_Syntax.n
in (match (uu____8814) with
| FStar_Syntax_Syntax.Tm_uvar (uu____8817, t) -> begin
(

let t = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env t)
in (

let uu____8832 = (FStar_Syntax_Subst.compress t).FStar_Syntax_Syntax.n
in (match (uu____8832) with
| FStar_Syntax_Syntax.Tm_arrow (uu____8835, t) -> begin
(universe_of_type e (FStar_Syntax_Util.comp_result t))
end
| uu____8847 -> begin
(universe_of_type e t)
end)))
end
| uu____8848 -> begin
(

let t = (

let uu____8852 = (FStar_ST.read e.FStar_Syntax_Syntax.tk)
in (match (uu____8852) with
| (None) | (Some (FStar_Syntax_Syntax.Tm_unknown)) -> begin
(

let e = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.NoDeltaSteps)::[]) env e)
in (

let uu____8860 = (tc_term env e)
in (match (uu____8860) with
| (uu____8866, {FStar_Syntax_Syntax.eff_name = uu____8867; FStar_Syntax_Syntax.res_typ = t; FStar_Syntax_Syntax.cflags = uu____8869; FStar_Syntax_Syntax.comp = uu____8870}, g) -> begin
((let _0_604 = (FStar_TypeChecker_Rel.solve_deferred_constraints env g)
in (FStar_All.pipe_right _0_604 Prims.ignore));
t;
)
end)))
end
| Some (t) -> begin
((FStar_Syntax_Syntax.mk t) None e.FStar_Syntax_Syntax.pos)
end))
in (let _0_605 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env t)
in (FStar_All.pipe_left (universe_of_type e) _0_605)))
end))
end))))))
end));
))


let universe_of : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe = (fun env e -> (

let uu____8897 = (universe_or_type_of env e)
in (match (uu____8897) with
| FStar_Util.Inl (t) -> begin
(Prims.raise (FStar_Errors.Error ((let _0_609 = (let _0_607 = (FStar_Syntax_Print.term_to_string e)
in (let _0_606 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format2 "Expected a term of type \'Type\'; got %s : %s" _0_607 _0_606)))
in (let _0_608 = (FStar_TypeChecker_Env.get_range env)
in ((_0_609), (_0_608)))))))
end
| FStar_Util.Inr (u) -> begin
u
end)))




