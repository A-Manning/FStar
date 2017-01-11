
open Prims

let gen_wps_for_free : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.eff_decl  ->  (FStar_Syntax_Syntax.sigelts * FStar_Syntax_Syntax.eff_decl) = (fun env binders a wp_a ed -> (

let wp_a = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env wp_a)
in (

let a = (

let _59_19 = a
in (let _158_11 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.EraseUniverses)::[]) env a.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _59_19.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_19.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _158_11}))
in (

let d = (fun s -> (FStar_Util.print1 "[01;36m%s[00m\n" s))
in (

let _59_26 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(

let _59_24 = (d "Elaborating extra WP combinators")
in (let _158_14 = (FStar_Syntax_Print.term_to_string wp_a)
in (FStar_Util.print1 "wp_a is: %s\n" _158_14)))
end else begin
()
end
in (

let rec collect_binders = (fun t -> (match ((let _158_18 = (let _158_17 = (FStar_Syntax_Subst.compress t)
in (FStar_All.pipe_left FStar_Syntax_Util.unascribe _158_17))
in _158_18.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (bs, comp) -> begin
(

let rest = (match (comp.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (t, _59_36) -> begin
t
end
| _59_40 -> begin
(failwith "wp_a contains non-Tot arrow")
end)
in (let _158_19 = (collect_binders rest)
in (FStar_List.append bs _158_19)))
end
| FStar_Syntax_Syntax.Tm_type (_59_43) -> begin
[]
end
| _59_46 -> begin
(failwith "wp_a doesn\'t end in Type0")
end))
in (

let mk_lid = (fun name -> (FStar_Ident.lid_of_path (FStar_Ident.path_of_text (Prims.strcat (FStar_Ident.text_of_lid ed.FStar_Syntax_Syntax.mname) (Prims.strcat "_" name))) FStar_Range.dummyRange))
in (

let gamma = (let _158_22 = (collect_binders wp_a)
in (FStar_All.pipe_right _158_22 FStar_Syntax_Util.name_binders))
in (

let _59_50 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(let _158_24 = (let _158_23 = (FStar_Syntax_Print.binders_to_string ", " gamma)
in (FStar_Util.format1 "Gamma is %s\n" _158_23))
in (d _158_24))
end else begin
()
end
in (

let unknown = FStar_Syntax_Syntax.tun
in (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None FStar_Range.dummyRange))
in (

let sigelts = (FStar_ST.alloc [])
in (

let register = (fun env lident def -> (

let _59_62 = (FStar_TypeChecker_Util.mk_toplevel_definition env lident def)
in (match (_59_62) with
| (sigelt, fv) -> begin
(

let _59_63 = (let _158_34 = (let _158_33 = (FStar_ST.read sigelts)
in (sigelt)::_158_33)
in (FStar_ST.op_Colon_Equals sigelts _158_34))
in fv)
end)))
in (

let binders_of_list = (FStar_List.map (fun _59_67 -> (match (_59_67) with
| (t, b) -> begin
(let _158_37 = (FStar_Syntax_Syntax.as_implicit b)
in ((t), (_158_37)))
end)))
in (

let mk_all_implicit = (FStar_List.map (fun t -> (let _158_40 = (FStar_Syntax_Syntax.as_implicit true)
in (((Prims.fst t)), (_158_40)))))
in (

let args_of_binders = (FStar_List.map (fun bv -> (let _158_43 = (FStar_Syntax_Syntax.bv_to_name (Prims.fst bv))
in (FStar_Syntax_Syntax.as_arg _158_43))))
in (

let _59_94 = (

let _59_79 = (

let mk = (fun f -> (

let t = (FStar_Syntax_Syntax.gen_bv "t" None FStar_Syntax_Util.ktype)
in (

let body = (let _158_56 = (let _158_55 = (FStar_Syntax_Syntax.bv_to_name t)
in (f _158_55))
in (FStar_Syntax_Util.arrow gamma _158_56))
in (let _158_61 = (let _158_60 = (let _158_59 = (FStar_Syntax_Syntax.mk_binder a)
in (let _158_58 = (let _158_57 = (FStar_Syntax_Syntax.mk_binder t)
in (_158_57)::[])
in (_158_59)::_158_58))
in (FStar_List.append binders _158_60))
in (FStar_Syntax_Util.abs _158_61 body None)))))
in (let _158_63 = (mk FStar_Syntax_Syntax.mk_Total)
in (let _158_62 = (mk FStar_Syntax_Syntax.mk_GTotal)
in ((_158_63), (_158_62)))))
in (match (_59_79) with
| (ctx_def, gctx_def) -> begin
(

let ctx_lid = (mk_lid "ctx")
in (

let ctx_fv = (register env ctx_lid ctx_def)
in (

let gctx_lid = (mk_lid "gctx")
in (

let gctx_fv = (register env gctx_lid gctx_def)
in (

let mk_app = (fun fv t -> (let _158_85 = (let _158_84 = (let _158_83 = (let _158_82 = (FStar_List.map (fun _59_90 -> (match (_59_90) with
| (bv, _59_89) -> begin
(let _158_74 = (FStar_Syntax_Syntax.bv_to_name bv)
in (let _158_73 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_74), (_158_73))))
end)) binders)
in (let _158_81 = (let _158_80 = (let _158_76 = (FStar_Syntax_Syntax.bv_to_name a)
in (let _158_75 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_76), (_158_75))))
in (let _158_79 = (let _158_78 = (let _158_77 = (FStar_Syntax_Syntax.as_implicit false)
in ((t), (_158_77)))
in (_158_78)::[])
in (_158_80)::_158_79))
in (FStar_List.append _158_82 _158_81)))
in ((fv), (_158_83)))
in FStar_Syntax_Syntax.Tm_app (_158_84))
in (mk _158_85)))
in ((env), ((mk_app ctx_fv)), ((mk_app gctx_fv))))))))
end))
in (match (_59_94) with
| (env, mk_ctx, mk_gctx) -> begin
(

let c_pure = (

let t = (FStar_Syntax_Syntax.gen_bv "t" None FStar_Syntax_Util.ktype)
in (

let x = (let _158_90 = (FStar_Syntax_Syntax.bv_to_name t)
in (FStar_Syntax_Syntax.gen_bv "x" None _158_90))
in (

let ret = (let _158_95 = (let _158_94 = (let _158_93 = (let _158_92 = (let _158_91 = (FStar_Syntax_Syntax.bv_to_name t)
in (mk_ctx _158_91))
in (FStar_Syntax_Syntax.mk_Total _158_92))
in (FStar_Syntax_Util.lcomp_of_comp _158_93))
in FStar_Util.Inl (_158_94))
in Some (_158_95))
in (

let body = (let _158_96 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Util.abs gamma _158_96 ret))
in (let _158_99 = (let _158_98 = (mk_all_implicit binders)
in (let _158_97 = (binders_of_list ((((a), (true)))::(((t), (true)))::(((x), (false)))::[]))
in (FStar_List.append _158_98 _158_97)))
in (FStar_Syntax_Util.abs _158_99 body ret))))))
in (

let c_pure = (let _158_100 = (mk_lid "pure")
in (register env _158_100 c_pure))
in (

let c_app = (

let t1 = (FStar_Syntax_Syntax.gen_bv "t1" None FStar_Syntax_Util.ktype)
in (

let t2 = (FStar_Syntax_Syntax.gen_bv "t2" None FStar_Syntax_Util.ktype)
in (

let l = (let _158_108 = (let _158_107 = (let _158_106 = (let _158_103 = (let _158_102 = (let _158_101 = (FStar_Syntax_Syntax.bv_to_name t1)
in (FStar_Syntax_Syntax.new_bv None _158_101))
in (FStar_Syntax_Syntax.mk_binder _158_102))
in (_158_103)::[])
in (let _158_105 = (let _158_104 = (FStar_Syntax_Syntax.bv_to_name t2)
in (FStar_Syntax_Syntax.mk_GTotal _158_104))
in (FStar_Syntax_Util.arrow _158_106 _158_105)))
in (mk_gctx _158_107))
in (FStar_Syntax_Syntax.gen_bv "l" None _158_108))
in (

let r = (let _158_110 = (let _158_109 = (FStar_Syntax_Syntax.bv_to_name t1)
in (mk_gctx _158_109))
in (FStar_Syntax_Syntax.gen_bv "r" None _158_110))
in (

let ret = (let _158_115 = (let _158_114 = (let _158_113 = (let _158_112 = (let _158_111 = (FStar_Syntax_Syntax.bv_to_name t2)
in (mk_gctx _158_111))
in (FStar_Syntax_Syntax.mk_Total _158_112))
in (FStar_Syntax_Util.lcomp_of_comp _158_113))
in FStar_Util.Inl (_158_114))
in Some (_158_115))
in (

let outer_body = (

let gamma_as_args = (args_of_binders gamma)
in (

let inner_body = (let _158_121 = (FStar_Syntax_Syntax.bv_to_name l)
in (let _158_120 = (let _158_119 = (let _158_118 = (let _158_117 = (let _158_116 = (FStar_Syntax_Syntax.bv_to_name r)
in (FStar_Syntax_Util.mk_app _158_116 gamma_as_args))
in (FStar_Syntax_Syntax.as_arg _158_117))
in (_158_118)::[])
in (FStar_List.append gamma_as_args _158_119))
in (FStar_Syntax_Util.mk_app _158_121 _158_120)))
in (FStar_Syntax_Util.abs gamma inner_body ret)))
in (let _158_124 = (let _158_123 = (mk_all_implicit binders)
in (let _158_122 = (binders_of_list ((((a), (true)))::(((t1), (true)))::(((t2), (true)))::(((l), (false)))::(((r), (false)))::[]))
in (FStar_List.append _158_123 _158_122)))
in (FStar_Syntax_Util.abs _158_124 outer_body ret))))))))
in (

let c_app = (let _158_125 = (mk_lid "app")
in (register env _158_125 c_app))
in (

let c_lift1 = (

let t1 = (FStar_Syntax_Syntax.gen_bv "t1" None FStar_Syntax_Util.ktype)
in (

let t2 = (FStar_Syntax_Syntax.gen_bv "t2" None FStar_Syntax_Util.ktype)
in (

let t_f = (let _158_130 = (let _158_127 = (let _158_126 = (FStar_Syntax_Syntax.bv_to_name t1)
in (FStar_Syntax_Syntax.null_binder _158_126))
in (_158_127)::[])
in (let _158_129 = (let _158_128 = (FStar_Syntax_Syntax.bv_to_name t2)
in (FStar_Syntax_Syntax.mk_GTotal _158_128))
in (FStar_Syntax_Util.arrow _158_130 _158_129)))
in (

let f = (FStar_Syntax_Syntax.gen_bv "f" None t_f)
in (

let a1 = (let _158_132 = (let _158_131 = (FStar_Syntax_Syntax.bv_to_name t1)
in (mk_gctx _158_131))
in (FStar_Syntax_Syntax.gen_bv "a1" None _158_132))
in (

let ret = (let _158_137 = (let _158_136 = (let _158_135 = (let _158_134 = (let _158_133 = (FStar_Syntax_Syntax.bv_to_name t2)
in (mk_gctx _158_133))
in (FStar_Syntax_Syntax.mk_Total _158_134))
in (FStar_Syntax_Util.lcomp_of_comp _158_135))
in FStar_Util.Inl (_158_136))
in Some (_158_137))
in (let _158_149 = (let _158_139 = (mk_all_implicit binders)
in (let _158_138 = (binders_of_list ((((a), (true)))::(((t1), (true)))::(((t2), (true)))::(((f), (false)))::(((a1), (false)))::[]))
in (FStar_List.append _158_139 _158_138)))
in (let _158_148 = (let _158_147 = (let _158_146 = (let _158_145 = (let _158_142 = (let _158_141 = (let _158_140 = (FStar_Syntax_Syntax.bv_to_name f)
in (_158_140)::[])
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_141))
in (FStar_Syntax_Util.mk_app c_pure _158_142))
in (let _158_144 = (let _158_143 = (FStar_Syntax_Syntax.bv_to_name a1)
in (_158_143)::[])
in (_158_145)::_158_144))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_146))
in (FStar_Syntax_Util.mk_app c_app _158_147))
in (FStar_Syntax_Util.abs _158_149 _158_148 ret)))))))))
in (

let c_lift1 = (let _158_150 = (mk_lid "lift1")
in (register env _158_150 c_lift1))
in (

let c_lift2 = (

let t1 = (FStar_Syntax_Syntax.gen_bv "t1" None FStar_Syntax_Util.ktype)
in (

let t2 = (FStar_Syntax_Syntax.gen_bv "t2" None FStar_Syntax_Util.ktype)
in (

let t3 = (FStar_Syntax_Syntax.gen_bv "t3" None FStar_Syntax_Util.ktype)
in (

let t_f = (let _158_158 = (let _158_155 = (let _158_151 = (FStar_Syntax_Syntax.bv_to_name t1)
in (FStar_Syntax_Syntax.null_binder _158_151))
in (let _158_154 = (let _158_153 = (let _158_152 = (FStar_Syntax_Syntax.bv_to_name t2)
in (FStar_Syntax_Syntax.null_binder _158_152))
in (_158_153)::[])
in (_158_155)::_158_154))
in (let _158_157 = (let _158_156 = (FStar_Syntax_Syntax.bv_to_name t3)
in (FStar_Syntax_Syntax.mk_GTotal _158_156))
in (FStar_Syntax_Util.arrow _158_158 _158_157)))
in (

let f = (FStar_Syntax_Syntax.gen_bv "f" None t_f)
in (

let a1 = (let _158_160 = (let _158_159 = (FStar_Syntax_Syntax.bv_to_name t1)
in (mk_gctx _158_159))
in (FStar_Syntax_Syntax.gen_bv "a1" None _158_160))
in (

let a2 = (let _158_162 = (let _158_161 = (FStar_Syntax_Syntax.bv_to_name t2)
in (mk_gctx _158_161))
in (FStar_Syntax_Syntax.gen_bv "a2" None _158_162))
in (

let ret = (let _158_167 = (let _158_166 = (let _158_165 = (let _158_164 = (let _158_163 = (FStar_Syntax_Syntax.bv_to_name t3)
in (mk_gctx _158_163))
in (FStar_Syntax_Syntax.mk_Total _158_164))
in (FStar_Syntax_Util.lcomp_of_comp _158_165))
in FStar_Util.Inl (_158_166))
in Some (_158_167))
in (let _158_184 = (let _158_169 = (mk_all_implicit binders)
in (let _158_168 = (binders_of_list ((((a), (true)))::(((t1), (true)))::(((t2), (true)))::(((t3), (true)))::(((f), (false)))::(((a1), (false)))::(((a2), (false)))::[]))
in (FStar_List.append _158_169 _158_168)))
in (let _158_183 = (let _158_182 = (let _158_181 = (let _158_180 = (let _158_177 = (let _158_176 = (let _158_175 = (let _158_172 = (let _158_171 = (let _158_170 = (FStar_Syntax_Syntax.bv_to_name f)
in (_158_170)::[])
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_171))
in (FStar_Syntax_Util.mk_app c_pure _158_172))
in (let _158_174 = (let _158_173 = (FStar_Syntax_Syntax.bv_to_name a1)
in (_158_173)::[])
in (_158_175)::_158_174))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_176))
in (FStar_Syntax_Util.mk_app c_app _158_177))
in (let _158_179 = (let _158_178 = (FStar_Syntax_Syntax.bv_to_name a2)
in (_158_178)::[])
in (_158_180)::_158_179))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_181))
in (FStar_Syntax_Util.mk_app c_app _158_182))
in (FStar_Syntax_Util.abs _158_184 _158_183 ret)))))))))))
in (

let c_lift2 = (let _158_185 = (mk_lid "lift2")
in (register env _158_185 c_lift2))
in (

let c_push = (

let t1 = (FStar_Syntax_Syntax.gen_bv "t1" None FStar_Syntax_Util.ktype)
in (

let t2 = (FStar_Syntax_Syntax.gen_bv "t2" None FStar_Syntax_Util.ktype)
in (

let t_f = (let _158_191 = (let _158_187 = (let _158_186 = (FStar_Syntax_Syntax.bv_to_name t1)
in (FStar_Syntax_Syntax.null_binder _158_186))
in (_158_187)::[])
in (let _158_190 = (let _158_189 = (let _158_188 = (FStar_Syntax_Syntax.bv_to_name t2)
in (mk_gctx _158_188))
in (FStar_Syntax_Syntax.mk_Total _158_189))
in (FStar_Syntax_Util.arrow _158_191 _158_190)))
in (

let f = (FStar_Syntax_Syntax.gen_bv "f" None t_f)
in (

let ret = (let _158_201 = (let _158_200 = (let _158_199 = (let _158_198 = (let _158_197 = (let _158_196 = (let _158_193 = (let _158_192 = (FStar_Syntax_Syntax.bv_to_name t1)
in (FStar_Syntax_Syntax.null_binder _158_192))
in (_158_193)::[])
in (let _158_195 = (let _158_194 = (FStar_Syntax_Syntax.bv_to_name t2)
in (FStar_Syntax_Syntax.mk_GTotal _158_194))
in (FStar_Syntax_Util.arrow _158_196 _158_195)))
in (mk_ctx _158_197))
in (FStar_Syntax_Syntax.mk_Total _158_198))
in (FStar_Syntax_Util.lcomp_of_comp _158_199))
in FStar_Util.Inl (_158_200))
in Some (_158_201))
in (

let e1 = (let _158_202 = (FStar_Syntax_Syntax.bv_to_name t1)
in (FStar_Syntax_Syntax.gen_bv "e1" None _158_202))
in (

let body = (let _158_211 = (let _158_204 = (let _158_203 = (FStar_Syntax_Syntax.mk_binder e1)
in (_158_203)::[])
in (FStar_List.append gamma _158_204))
in (let _158_210 = (let _158_209 = (FStar_Syntax_Syntax.bv_to_name f)
in (let _158_208 = (let _158_207 = (let _158_205 = (FStar_Syntax_Syntax.bv_to_name e1)
in (FStar_Syntax_Syntax.as_arg _158_205))
in (let _158_206 = (args_of_binders gamma)
in (_158_207)::_158_206))
in (FStar_Syntax_Util.mk_app _158_209 _158_208)))
in (FStar_Syntax_Util.abs _158_211 _158_210 ret)))
in (let _158_214 = (let _158_213 = (mk_all_implicit binders)
in (let _158_212 = (binders_of_list ((((a), (true)))::(((t1), (true)))::(((t2), (true)))::(((f), (false)))::[]))
in (FStar_List.append _158_213 _158_212)))
in (FStar_Syntax_Util.abs _158_214 body ret)))))))))
in (

let c_push = (let _158_215 = (mk_lid "push")
in (register env _158_215 c_push))
in (

let ret_tot_wp_a = (let _158_218 = (let _158_217 = (let _158_216 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.lcomp_of_comp _158_216))
in FStar_Util.Inl (_158_217))
in Some (_158_218))
in (

let mk_generic_app = (fun c -> if ((FStar_List.length binders) > (Prims.parse_int "0")) then begin
(let _158_223 = (let _158_222 = (let _158_221 = (args_of_binders binders)
in ((c), (_158_221)))
in FStar_Syntax_Syntax.Tm_app (_158_222))
in (mk _158_223))
end else begin
c
end)
in (

let wp_if_then_else = (

let result_comp = (let _158_229 = (let _158_228 = (let _158_226 = (FStar_Syntax_Syntax.null_binder wp_a)
in (let _158_225 = (let _158_224 = (FStar_Syntax_Syntax.null_binder wp_a)
in (_158_224)::[])
in (_158_226)::_158_225))
in (let _158_227 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _158_228 _158_227)))
in (FStar_Syntax_Syntax.mk_Total _158_229))
in (

let c = (FStar_Syntax_Syntax.gen_bv "c" None FStar_Syntax_Util.ktype)
in (let _158_239 = (let _158_230 = (FStar_Syntax_Syntax.binders_of_list ((a)::(c)::[]))
in (FStar_List.append binders _158_230))
in (let _158_238 = (

let l_ite = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.ite_lid (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "2"))) None)
in (let _158_237 = (let _158_236 = (let _158_235 = (let _158_234 = (let _158_233 = (let _158_232 = (let _158_231 = (FStar_Syntax_Syntax.bv_to_name c)
in (FStar_Syntax_Syntax.as_arg _158_231))
in (_158_232)::[])
in (FStar_Syntax_Util.mk_app l_ite _158_233))
in (_158_234)::[])
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_235))
in (FStar_Syntax_Util.mk_app c_lift2 _158_236))
in (FStar_Syntax_Util.ascribe _158_237 (FStar_Util.Inr (result_comp)))))
in (FStar_Syntax_Util.abs _158_239 _158_238 (Some (FStar_Util.Inl ((FStar_Syntax_Util.lcomp_of_comp result_comp)))))))))
in (

let wp_if_then_else = (let _158_240 = (mk_lid "wp_if_then_else")
in (register env _158_240 wp_if_then_else))
in (

let wp_if_then_else = (mk_generic_app wp_if_then_else)
in (

let wp_assert = (

let q = (FStar_Syntax_Syntax.gen_bv "q" None FStar_Syntax_Util.ktype)
in (

let wp = (FStar_Syntax_Syntax.gen_bv "wp" None wp_a)
in (

let l_and = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.and_lid (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))) None)
in (

let body = (let _158_251 = (let _158_250 = (let _158_249 = (let _158_246 = (let _158_245 = (let _158_244 = (let _158_243 = (let _158_242 = (let _158_241 = (FStar_Syntax_Syntax.bv_to_name q)
in (FStar_Syntax_Syntax.as_arg _158_241))
in (_158_242)::[])
in (FStar_Syntax_Util.mk_app l_and _158_243))
in (_158_244)::[])
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_245))
in (FStar_Syntax_Util.mk_app c_pure _158_246))
in (let _158_248 = (let _158_247 = (FStar_Syntax_Syntax.bv_to_name wp)
in (_158_247)::[])
in (_158_249)::_158_248))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_250))
in (FStar_Syntax_Util.mk_app c_app _158_251))
in (let _158_253 = (let _158_252 = (FStar_Syntax_Syntax.binders_of_list ((a)::(q)::(wp)::[]))
in (FStar_List.append binders _158_252))
in (FStar_Syntax_Util.abs _158_253 body ret_tot_wp_a))))))
in (

let wp_assert = (let _158_254 = (mk_lid "wp_assert")
in (register env _158_254 wp_assert))
in (

let wp_assert = (mk_generic_app wp_assert)
in (

let wp_assume = (

let q = (FStar_Syntax_Syntax.gen_bv "q" None FStar_Syntax_Util.ktype)
in (

let wp = (FStar_Syntax_Syntax.gen_bv "wp" None wp_a)
in (

let l_imp = (FStar_Syntax_Syntax.fvar FStar_Syntax_Const.imp_lid (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))) None)
in (

let body = (let _158_265 = (let _158_264 = (let _158_263 = (let _158_260 = (let _158_259 = (let _158_258 = (let _158_257 = (let _158_256 = (let _158_255 = (FStar_Syntax_Syntax.bv_to_name q)
in (FStar_Syntax_Syntax.as_arg _158_255))
in (_158_256)::[])
in (FStar_Syntax_Util.mk_app l_imp _158_257))
in (_158_258)::[])
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_259))
in (FStar_Syntax_Util.mk_app c_pure _158_260))
in (let _158_262 = (let _158_261 = (FStar_Syntax_Syntax.bv_to_name wp)
in (_158_261)::[])
in (_158_263)::_158_262))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_264))
in (FStar_Syntax_Util.mk_app c_app _158_265))
in (let _158_267 = (let _158_266 = (FStar_Syntax_Syntax.binders_of_list ((a)::(q)::(wp)::[]))
in (FStar_List.append binders _158_266))
in (FStar_Syntax_Util.abs _158_267 body ret_tot_wp_a))))))
in (

let wp_assume = (let _158_268 = (mk_lid "wp_assume")
in (register env _158_268 wp_assume))
in (

let wp_assume = (mk_generic_app wp_assume)
in (

let wp_close = (

let b = (FStar_Syntax_Syntax.gen_bv "b" None FStar_Syntax_Util.ktype)
in (

let t_f = (let _158_272 = (let _158_270 = (let _158_269 = (FStar_Syntax_Syntax.bv_to_name b)
in (FStar_Syntax_Syntax.null_binder _158_269))
in (_158_270)::[])
in (let _158_271 = (FStar_Syntax_Syntax.mk_Total wp_a)
in (FStar_Syntax_Util.arrow _158_272 _158_271)))
in (

let f = (FStar_Syntax_Syntax.gen_bv "f" None t_f)
in (

let body = (let _158_281 = (let _158_280 = (let _158_279 = (let _158_273 = (FStar_List.map FStar_Syntax_Syntax.as_arg ((FStar_Syntax_Util.tforall)::[]))
in (FStar_Syntax_Util.mk_app c_pure _158_273))
in (let _158_278 = (let _158_277 = (let _158_276 = (let _158_275 = (let _158_274 = (FStar_Syntax_Syntax.bv_to_name f)
in (_158_274)::[])
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_275))
in (FStar_Syntax_Util.mk_app c_push _158_276))
in (_158_277)::[])
in (_158_279)::_158_278))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_280))
in (FStar_Syntax_Util.mk_app c_app _158_281))
in (let _158_283 = (let _158_282 = (FStar_Syntax_Syntax.binders_of_list ((a)::(b)::(f)::[]))
in (FStar_List.append binders _158_282))
in (FStar_Syntax_Util.abs _158_283 body ret_tot_wp_a))))))
in (

let wp_close = (let _158_284 = (mk_lid "wp_close")
in (register env _158_284 wp_close))
in (

let wp_close = (mk_generic_app wp_close)
in (

let ret_tot_type = (let _158_287 = (let _158_286 = (let _158_285 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _158_285))
in FStar_Util.Inl (_158_286))
in Some (_158_287))
in (

let ret_gtot_type = (let _158_290 = (let _158_289 = (let _158_288 = (FStar_Syntax_Syntax.mk_GTotal FStar_Syntax_Util.ktype)
in (FStar_All.pipe_left FStar_Syntax_Util.lcomp_of_comp _158_288))
in FStar_Util.Inl (_158_289))
in Some (_158_290))
in (

let mk_forall = (fun x body -> (let _158_301 = (let _158_300 = (let _158_299 = (let _158_298 = (let _158_297 = (let _158_296 = (let _158_295 = (FStar_Syntax_Syntax.mk_binder x)
in (_158_295)::[])
in (FStar_Syntax_Util.abs _158_296 body ret_tot_type))
in (FStar_Syntax_Syntax.as_arg _158_297))
in (_158_298)::[])
in ((FStar_Syntax_Util.tforall), (_158_299)))
in FStar_Syntax_Syntax.Tm_app (_158_300))
in (FStar_Syntax_Syntax.mk _158_301 None FStar_Range.dummyRange)))
in (

let rec is_discrete = (fun t -> (match ((let _158_304 = (FStar_Syntax_Subst.compress t)
in _158_304.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_59_176) -> begin
false
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
((FStar_List.for_all (fun _59_185 -> (match (_59_185) with
| (b, _59_184) -> begin
(is_discrete b.FStar_Syntax_Syntax.sort)
end)) bs) && (is_discrete (FStar_Syntax_Util.comp_result c)))
end
| _59_187 -> begin
true
end))
in (

let rec is_monotonic = (fun t -> (match ((let _158_308 = (FStar_Syntax_Subst.compress t)
in _158_308.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_59_191) -> begin
true
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
((FStar_List.for_all (fun _59_200 -> (match (_59_200) with
| (b, _59_199) -> begin
(is_discrete b.FStar_Syntax_Syntax.sort)
end)) bs) && (is_monotonic (FStar_Syntax_Util.comp_result c)))
end
| _59_202 -> begin
(is_discrete t)
end))
in (

let rec mk_rel = (fun rel t x y -> (

let mk_rel = (mk_rel rel)
in (

let t = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eager_unfolding)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env t)
in (match ((let _158_331 = (FStar_Syntax_Subst.compress t)
in _158_331.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_59_211) -> begin
(rel x y)
end
| (FStar_Syntax_Syntax.Tm_arrow ((binder)::[], {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.GTotal (b, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _})) | (FStar_Syntax_Syntax.Tm_arrow ((binder)::[], {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Total (b, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _})) -> begin
(

let a = (Prims.fst binder).FStar_Syntax_Syntax.sort
in if ((is_monotonic a) || (is_monotonic b)) then begin
(

let a1 = (FStar_Syntax_Syntax.gen_bv "a1" None a)
in (

let body = (let _158_339 = (let _158_334 = (let _158_333 = (let _158_332 = (FStar_Syntax_Syntax.bv_to_name a1)
in (FStar_Syntax_Syntax.as_arg _158_332))
in (_158_333)::[])
in (FStar_Syntax_Util.mk_app x _158_334))
in (let _158_338 = (let _158_337 = (let _158_336 = (let _158_335 = (FStar_Syntax_Syntax.bv_to_name a1)
in (FStar_Syntax_Syntax.as_arg _158_335))
in (_158_336)::[])
in (FStar_Syntax_Util.mk_app y _158_337))
in (mk_rel b _158_339 _158_338)))
in (mk_forall a1 body)))
end else begin
(

let a1 = (FStar_Syntax_Syntax.gen_bv "a1" None a)
in (

let a2 = (FStar_Syntax_Syntax.gen_bv "a2" None a)
in (

let body = (let _158_351 = (let _158_341 = (FStar_Syntax_Syntax.bv_to_name a1)
in (let _158_340 = (FStar_Syntax_Syntax.bv_to_name a2)
in (mk_rel a _158_341 _158_340)))
in (let _158_350 = (let _158_349 = (let _158_344 = (let _158_343 = (let _158_342 = (FStar_Syntax_Syntax.bv_to_name a1)
in (FStar_Syntax_Syntax.as_arg _158_342))
in (_158_343)::[])
in (FStar_Syntax_Util.mk_app x _158_344))
in (let _158_348 = (let _158_347 = (let _158_346 = (let _158_345 = (FStar_Syntax_Syntax.bv_to_name a2)
in (FStar_Syntax_Syntax.as_arg _158_345))
in (_158_346)::[])
in (FStar_Syntax_Util.mk_app y _158_347))
in (mk_rel b _158_349 _158_348)))
in (FStar_Syntax_Util.mk_imp _158_351 _158_350)))
in (let _158_352 = (mk_forall a2 body)
in (mk_forall a1 _158_352)))))
end)
end
| FStar_Syntax_Syntax.Tm_arrow ((binder)::binders, comp) -> begin
(

let t = (

let _59_255 = t
in (let _158_356 = (let _158_355 = (let _158_354 = (let _158_353 = (FStar_Syntax_Util.arrow binders comp)
in (FStar_Syntax_Syntax.mk_Total _158_353))
in (((binder)::[]), (_158_354)))
in FStar_Syntax_Syntax.Tm_arrow (_158_355))
in {FStar_Syntax_Syntax.n = _158_356; FStar_Syntax_Syntax.tk = _59_255.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = _59_255.FStar_Syntax_Syntax.pos; FStar_Syntax_Syntax.vars = _59_255.FStar_Syntax_Syntax.vars}))
in (mk_rel t x y))
end
| FStar_Syntax_Syntax.Tm_arrow (_59_259) -> begin
(failwith "unhandled arrow")
end
| _59_262 -> begin
(FStar_Syntax_Util.mk_eq t t x y)
end))))
in (

let stronger = (

let wp1 = (FStar_Syntax_Syntax.gen_bv "wp1" None wp_a)
in (

let wp2 = (FStar_Syntax_Syntax.gen_bv "wp2" None wp_a)
in (

let rec mk_stronger = (fun t x y -> (

let t = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eager_unfolding)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env t)
in (match ((let _158_363 = (FStar_Syntax_Subst.compress t)
in _158_363.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_59_271) -> begin
(FStar_Syntax_Util.mk_imp x y)
end
| FStar_Syntax_Syntax.Tm_app (head, args) when (let _158_364 = (FStar_Syntax_Subst.compress head)
in (FStar_Syntax_Util.is_tuple_constructor _158_364)) -> begin
(

let project = (fun i tuple -> (

let projector = (let _158_370 = (let _158_369 = (FStar_Syntax_Util.mk_tuple_data_lid (FStar_List.length args) FStar_Range.dummyRange)
in (FStar_TypeChecker_Env.lookup_projector env _158_369 i))
in (FStar_Syntax_Syntax.fvar _158_370 (FStar_Syntax_Syntax.Delta_defined_at_level ((Prims.parse_int "1"))) None))
in (FStar_Syntax_Util.mk_app projector ((((tuple), (None)))::[]))))
in (

let _59_291 = (match ((FStar_List.mapi (fun i _59_284 -> (match (_59_284) with
| (t, q) -> begin
(let _158_374 = (project i x)
in (let _158_373 = (project i y)
in (mk_stronger t _158_374 _158_373)))
end)) args)) with
| [] -> begin
(failwith "Impossible : Empty application when creating stronger relation in DM4F")
end
| (rel0)::rels -> begin
((rel0), (rels))
end)
in (match (_59_291) with
| (rel0, rels) -> begin
(FStar_List.fold_left FStar_Syntax_Util.mk_conj rel0 rels)
end)))
end
| (FStar_Syntax_Syntax.Tm_arrow (binders, {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.GTotal (b, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _})) | (FStar_Syntax_Syntax.Tm_arrow (binders, {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Total (b, _); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _})) -> begin
(

let bvs = (FStar_List.mapi (fun i _59_323 -> (match (_59_323) with
| (bv, q) -> begin
(let _158_378 = (let _158_377 = (FStar_Util.string_of_int i)
in (Prims.strcat "a" _158_377))
in (FStar_Syntax_Syntax.gen_bv _158_378 None bv.FStar_Syntax_Syntax.sort))
end)) binders)
in (

let args = (FStar_List.map (fun ai -> (let _158_380 = (FStar_Syntax_Syntax.bv_to_name ai)
in (FStar_Syntax_Syntax.as_arg _158_380))) bvs)
in (

let body = (let _158_382 = (FStar_Syntax_Util.mk_app x args)
in (let _158_381 = (FStar_Syntax_Util.mk_app y args)
in (mk_stronger b _158_382 _158_381)))
in (FStar_List.fold_right (fun bv body -> (mk_forall bv body)) bvs body))))
end
| _59_331 -> begin
(failwith "Not a DM elaborated type")
end)))
in (

let body = (let _158_387 = (FStar_Syntax_Util.unascribe wp_a)
in (let _158_386 = (FStar_Syntax_Syntax.bv_to_name wp1)
in (let _158_385 = (FStar_Syntax_Syntax.bv_to_name wp2)
in (mk_stronger _158_387 _158_386 _158_385))))
in (let _158_389 = (let _158_388 = (binders_of_list ((((a), (false)))::(((wp1), (false)))::(((wp2), (false)))::[]))
in (FStar_List.append binders _158_388))
in (FStar_Syntax_Util.abs _158_389 body ret_tot_type))))))
in (

let stronger = (let _158_390 = (mk_lid "stronger")
in (register env _158_390 stronger))
in (

let stronger = (mk_generic_app stronger)
in (

let wp_ite = (

let wp = (FStar_Syntax_Syntax.gen_bv "wp" None wp_a)
in (

let _59_339 = (FStar_Util.prefix gamma)
in (match (_59_339) with
| (wp_args, post) -> begin
(

let k = (FStar_Syntax_Syntax.gen_bv "k" None (Prims.fst post).FStar_Syntax_Syntax.sort)
in (

let equiv = (

let k_tm = (FStar_Syntax_Syntax.bv_to_name k)
in (

let eq = (let _158_391 = (FStar_Syntax_Syntax.bv_to_name (Prims.fst post))
in (mk_rel FStar_Syntax_Util.mk_iff k.FStar_Syntax_Syntax.sort k_tm _158_391))
in (match ((FStar_Syntax_Util.destruct_typ_as_formula eq)) with
| Some (FStar_Syntax_Util.QAll (binders, [], body)) -> begin
(

let k_app = (let _158_392 = (args_of_binders binders)
in (FStar_Syntax_Util.mk_app k_tm _158_392))
in (

let guard_free = (let _158_393 = (FStar_Syntax_Syntax.lid_as_fv FStar_Syntax_Const.guard_free FStar_Syntax_Syntax.Delta_constant None)
in (FStar_Syntax_Syntax.fv_to_tm _158_393))
in (

let pat = (let _158_395 = (let _158_394 = (FStar_Syntax_Syntax.as_arg k_app)
in (_158_394)::[])
in (FStar_Syntax_Util.mk_app guard_free _158_395))
in (

let pattern_guarded_body = (let _158_401 = (let _158_400 = (let _158_399 = (let _158_398 = (let _158_397 = (let _158_396 = (FStar_Syntax_Syntax.as_arg pat)
in (_158_396)::[])
in (_158_397)::[])
in FStar_Syntax_Syntax.Meta_pattern (_158_398))
in ((body), (_158_399)))
in FStar_Syntax_Syntax.Tm_meta (_158_400))
in (mk _158_401))
in (FStar_Syntax_Util.close_forall binders pattern_guarded_body)))))
end
| _59_354 -> begin
(failwith "Impossible: Expected the equivalence to be a quantified formula")
end)))
in (

let body = (let _158_410 = (let _158_409 = (let _158_408 = (let _158_407 = (FStar_Syntax_Syntax.bv_to_name wp)
in (let _158_406 = (let _158_405 = (args_of_binders wp_args)
in (let _158_404 = (let _158_403 = (let _158_402 = (FStar_Syntax_Syntax.bv_to_name k)
in (FStar_Syntax_Syntax.as_arg _158_402))
in (_158_403)::[])
in (FStar_List.append _158_405 _158_404)))
in (FStar_Syntax_Util.mk_app _158_407 _158_406)))
in (FStar_Syntax_Util.mk_imp equiv _158_408))
in (FStar_Syntax_Util.mk_forall k _158_409))
in (FStar_Syntax_Util.abs gamma _158_410 ret_gtot_type))
in (let _158_412 = (let _158_411 = (FStar_Syntax_Syntax.binders_of_list ((a)::(wp)::[]))
in (FStar_List.append binders _158_411))
in (FStar_Syntax_Util.abs _158_412 body ret_gtot_type)))))
end)))
in (

let wp_ite = (let _158_413 = (mk_lid "wp_ite")
in (register env _158_413 wp_ite))
in (

let wp_ite = (mk_generic_app wp_ite)
in (

let null_wp = (

let wp = (FStar_Syntax_Syntax.gen_bv "wp" None wp_a)
in (

let _59_363 = (FStar_Util.prefix gamma)
in (match (_59_363) with
| (wp_args, post) -> begin
(

let x = (FStar_Syntax_Syntax.gen_bv "x" None FStar_Syntax_Syntax.tun)
in (

let body = (let _158_418 = (let _158_417 = (FStar_All.pipe_left FStar_Syntax_Syntax.bv_to_name (Prims.fst post))
in (let _158_416 = (let _158_415 = (let _158_414 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Syntax.as_arg _158_414))
in (_158_415)::[])
in (FStar_Syntax_Util.mk_app _158_417 _158_416)))
in (FStar_Syntax_Util.mk_forall x _158_418))
in (let _158_421 = (let _158_420 = (let _158_419 = (FStar_Syntax_Syntax.binders_of_list ((a)::[]))
in (FStar_List.append _158_419 gamma))
in (FStar_List.append binders _158_420))
in (FStar_Syntax_Util.abs _158_421 body ret_gtot_type))))
end)))
in (

let null_wp = (let _158_422 = (mk_lid "null_wp")
in (register env _158_422 null_wp))
in (

let null_wp = (mk_generic_app null_wp)
in (

let wp_trivial = (

let wp = (FStar_Syntax_Syntax.gen_bv "wp" None wp_a)
in (

let body = (let _158_432 = (let _158_431 = (let _158_430 = (FStar_Syntax_Syntax.bv_to_name a)
in (let _158_429 = (let _158_428 = (let _158_425 = (let _158_424 = (let _158_423 = (FStar_Syntax_Syntax.bv_to_name a)
in (FStar_Syntax_Syntax.as_arg _158_423))
in (_158_424)::[])
in (FStar_Syntax_Util.mk_app null_wp _158_425))
in (let _158_427 = (let _158_426 = (FStar_Syntax_Syntax.bv_to_name wp)
in (_158_426)::[])
in (_158_428)::_158_427))
in (_158_430)::_158_429))
in (FStar_List.map FStar_Syntax_Syntax.as_arg _158_431))
in (FStar_Syntax_Util.mk_app stronger _158_432))
in (let _158_434 = (let _158_433 = (FStar_Syntax_Syntax.binders_of_list ((a)::(wp)::[]))
in (FStar_List.append binders _158_433))
in (FStar_Syntax_Util.abs _158_434 body ret_tot_type))))
in (

let wp_trivial = (let _158_435 = (mk_lid "wp_trivial")
in (register env _158_435 wp_trivial))
in (

let wp_trivial = (mk_generic_app wp_trivial)
in (

let _59_374 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("ED"))) then begin
(d "End Dijkstra monads for free")
end else begin
()
end
in (

let c = (FStar_Syntax_Subst.close binders)
in (let _158_455 = (let _158_437 = (FStar_ST.read sigelts)
in (FStar_List.rev _158_437))
in (let _158_454 = (

let _59_377 = ed
in (let _158_453 = (let _158_438 = (c wp_if_then_else)
in (([]), (_158_438)))
in (let _158_452 = (let _158_439 = (c wp_ite)
in (([]), (_158_439)))
in (let _158_451 = (let _158_440 = (c stronger)
in (([]), (_158_440)))
in (let _158_450 = (let _158_441 = (c wp_close)
in (([]), (_158_441)))
in (let _158_449 = (let _158_442 = (c wp_assert)
in (([]), (_158_442)))
in (let _158_448 = (let _158_443 = (c wp_assume)
in (([]), (_158_443)))
in (let _158_447 = (let _158_444 = (c null_wp)
in (([]), (_158_444)))
in (let _158_446 = (let _158_445 = (c wp_trivial)
in (([]), (_158_445)))
in {FStar_Syntax_Syntax.qualifiers = _59_377.FStar_Syntax_Syntax.qualifiers; FStar_Syntax_Syntax.cattributes = _59_377.FStar_Syntax_Syntax.cattributes; FStar_Syntax_Syntax.mname = _59_377.FStar_Syntax_Syntax.mname; FStar_Syntax_Syntax.univs = _59_377.FStar_Syntax_Syntax.univs; FStar_Syntax_Syntax.binders = _59_377.FStar_Syntax_Syntax.binders; FStar_Syntax_Syntax.signature = _59_377.FStar_Syntax_Syntax.signature; FStar_Syntax_Syntax.ret_wp = _59_377.FStar_Syntax_Syntax.ret_wp; FStar_Syntax_Syntax.bind_wp = _59_377.FStar_Syntax_Syntax.bind_wp; FStar_Syntax_Syntax.if_then_else = _158_453; FStar_Syntax_Syntax.ite_wp = _158_452; FStar_Syntax_Syntax.stronger = _158_451; FStar_Syntax_Syntax.close_wp = _158_450; FStar_Syntax_Syntax.assert_p = _158_449; FStar_Syntax_Syntax.assume_p = _158_448; FStar_Syntax_Syntax.null_wp = _158_447; FStar_Syntax_Syntax.trivial = _158_446; FStar_Syntax_Syntax.repr = _59_377.FStar_Syntax_Syntax.repr; FStar_Syntax_Syntax.return_repr = _59_377.FStar_Syntax_Syntax.return_repr; FStar_Syntax_Syntax.bind_repr = _59_377.FStar_Syntax_Syntax.bind_repr; FStar_Syntax_Syntax.actions = _59_377.FStar_Syntax_Syntax.actions})))))))))
in ((_158_455), (_158_454))))))))))))))))))))))))))))))))))))))))))))))))
end))))))))))))))))))


type env =
{env : FStar_TypeChecker_Env.env; subst : FStar_Syntax_Syntax.subst_elt Prims.list; tc_const : FStar_Const.sconst  ->  FStar_Syntax_Syntax.typ}


let is_Mkenv : env  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkenv"))))


let empty : FStar_TypeChecker_Env.env  ->  (FStar_Const.sconst  ->  FStar_Syntax_Syntax.typ)  ->  env = (fun env tc_const -> {env = env; subst = []; tc_const = tc_const})


type env_ =
env


let get_env : env  ->  FStar_TypeChecker_Env.env = (fun env -> env.env)


type nm =
| N of FStar_Syntax_Syntax.typ
| M of FStar_Syntax_Syntax.typ


let is_N = (fun _discr_ -> (match (_discr_) with
| N (_) -> begin
true
end
| _ -> begin
false
end))


let is_M = (fun _discr_ -> (match (_discr_) with
| M (_) -> begin
true
end
| _ -> begin
false
end))


let ___N____0 = (fun projectee -> (match (projectee) with
| N (_59_388) -> begin
_59_388
end))


let ___M____0 = (fun projectee -> (match (projectee) with
| M (_59_391) -> begin
_59_391
end))


type nm_ =
nm


let nm_of_comp : FStar_Syntax_Syntax.comp'  ->  nm = (fun _59_2 -> (match (_59_2) with
| FStar_Syntax_Syntax.Total (t, _59_395) -> begin
N (t)
end
| FStar_Syntax_Syntax.Comp (c) when (FStar_All.pipe_right c.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun _59_1 -> (match (_59_1) with
| FStar_Syntax_Syntax.CPS -> begin
true
end
| _59_403 -> begin
false
end)))) -> begin
M (c.FStar_Syntax_Syntax.result_typ)
end
| FStar_Syntax_Syntax.Comp (c) -> begin
(let _158_516 = (let _158_515 = (let _158_514 = (FStar_Syntax_Syntax.mk_Comp c)
in (FStar_All.pipe_left FStar_Syntax_Print.comp_to_string _158_514))
in (FStar_Util.format1 "[nm_of_comp]: impossible (%s)" _158_515))
in (failwith _158_516))
end
| FStar_Syntax_Syntax.GTotal (_59_407) -> begin
(failwith "[nm_of_comp]: impossible (GTot)")
end))


let string_of_nm : nm  ->  Prims.string = (fun _59_3 -> (match (_59_3) with
| N (t) -> begin
(let _158_519 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "N[%s]" _158_519))
end
| M (t) -> begin
(let _158_520 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "M[%s]" _158_520))
end))


let is_monadic_arrow : FStar_Syntax_Syntax.term'  ->  nm = (fun n -> (match (n) with
| FStar_Syntax_Syntax.Tm_arrow (_59_416, {FStar_Syntax_Syntax.n = n; FStar_Syntax_Syntax.tk = _59_422; FStar_Syntax_Syntax.pos = _59_420; FStar_Syntax_Syntax.vars = _59_418}) -> begin
(nm_of_comp n)
end
| _59_428 -> begin
(failwith "unexpected_argument: [is_monadic_arrow]")
end))


let is_monadic_comp = (fun c -> (match ((nm_of_comp c.FStar_Syntax_Syntax.n)) with
| M (_59_431) -> begin
true
end
| N (_59_434) -> begin
false
end))


exception Not_found


let is_Not_found = (fun _discr_ -> (match (_discr_) with
| Not_found (_) -> begin
true
end
| _ -> begin
false
end))


let double_star : FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ = (fun typ -> (

let star_once = (fun typ -> (let _158_532 = (let _158_530 = (let _158_529 = (FStar_Syntax_Syntax.new_bv None typ)
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_binder _158_529))
in (_158_530)::[])
in (let _158_531 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0)
in (FStar_Syntax_Util.arrow _158_532 _158_531))))
in (let _158_533 = (FStar_All.pipe_right typ star_once)
in (FStar_All.pipe_left star_once _158_533))))


let rec mk_star_to_type : (FStar_Syntax_Syntax.term'  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax)  ->  env  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax = (fun mk env a -> (let _158_554 = (let _158_553 = (let _158_552 = (let _158_550 = (let _158_549 = (let _158_547 = (star_type' env a)
in (FStar_Syntax_Syntax.null_bv _158_547))
in (let _158_548 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_549), (_158_548))))
in (_158_550)::[])
in (let _158_551 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0)
in ((_158_552), (_158_551))))
in FStar_Syntax_Syntax.Tm_arrow (_158_553))
in (mk _158_554)))
and star_type' : env  ->  (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.term = (fun env t -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None t.FStar_Syntax_Syntax.pos))
in (

let mk_star_to_type = (mk_star_to_type mk)
in (

let t = (FStar_Syntax_Subst.compress t)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (binders, _59_450) -> begin
(

let binders = (FStar_List.map (fun _59_455 -> (match (_59_455) with
| (bv, aqual) -> begin
(let _158_563 = (

let _59_456 = bv
in (let _158_562 = (star_type' env bv.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _59_456.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_456.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _158_562}))
in ((_158_563), (aqual)))
end)) binders)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_arrow (_59_460, {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.GTotal (hn, _59_469); FStar_Syntax_Syntax.tk = _59_466; FStar_Syntax_Syntax.pos = _59_464; FStar_Syntax_Syntax.vars = _59_462}) -> begin
(let _158_567 = (let _158_566 = (let _158_565 = (let _158_564 = (star_type' env hn)
in (FStar_Syntax_Syntax.mk_GTotal _158_564))
in ((binders), (_158_565)))
in FStar_Syntax_Syntax.Tm_arrow (_158_566))
in (mk _158_567))
end
| _59_476 -> begin
(match ((is_monadic_arrow t.FStar_Syntax_Syntax.n)) with
| N (hn) -> begin
(let _158_571 = (let _158_570 = (let _158_569 = (let _158_568 = (star_type' env hn)
in (FStar_Syntax_Syntax.mk_Total _158_568))
in ((binders), (_158_569)))
in FStar_Syntax_Syntax.Tm_arrow (_158_570))
in (mk _158_571))
end
| M (a) -> begin
(let _158_580 = (let _158_579 = (let _158_578 = (let _158_576 = (let _158_575 = (let _158_574 = (let _158_572 = (mk_star_to_type env a)
in (FStar_Syntax_Syntax.null_bv _158_572))
in (let _158_573 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_574), (_158_573))))
in (_158_575)::[])
in (FStar_List.append binders _158_576))
in (let _158_577 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0)
in ((_158_578), (_158_577))))
in FStar_Syntax_Syntax.Tm_arrow (_158_579))
in (mk _158_580))
end)
end))
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let debug = (fun t s -> (

let string_of_set = (fun f s -> (

let elts = (FStar_Util.set_elements s)
in (match (elts) with
| [] -> begin
"{}"
end
| (x)::xs -> begin
(

let strb = (FStar_Util.new_string_builder ())
in (

let _59_497 = (FStar_Util.string_builder_append strb "{")
in (

let _59_499 = (let _158_594 = (f x)
in (FStar_Util.string_builder_append strb _158_594))
in (

let _59_504 = (FStar_List.iter (fun x -> (

let _59_502 = (FStar_Util.string_builder_append strb ", ")
in (let _158_596 = (f x)
in (FStar_Util.string_builder_append strb _158_596)))) xs)
in (

let _59_506 = (FStar_Util.string_builder_append strb "}")
in (FStar_Util.string_of_string_builder strb))))))
end)))
in (let _158_598 = (FStar_Syntax_Print.term_to_string t)
in (let _158_597 = (string_of_set FStar_Syntax_Print.bv_to_string s)
in (FStar_Util.print2_warning "Dependency found in term %s : %s" _158_598 _158_597)))))
in (

let rec is_non_dependent_arrow = (fun ty n -> (match ((let _158_603 = (FStar_Syntax_Subst.compress ty)
in _158_603.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
if (not ((FStar_Syntax_Util.is_tot_or_gtot_comp c))) then begin
false
end else begin
try
(match (()) with
| () -> begin
(

let non_dependent_or_raise = (fun s ty -> (

let sinter = (let _158_609 = (FStar_Syntax_Free.names ty)
in (FStar_Util.set_intersect _158_609 s))
in if (not ((FStar_Util.set_is_empty sinter))) then begin
(

let _59_525 = (debug ty sinter)
in (Prims.raise Not_found))
end else begin
()
end))
in (

let _59_529 = (FStar_Syntax_Subst.open_comp binders c)
in (match (_59_529) with
| (binders, c) -> begin
(

let s = (FStar_List.fold_left (fun s _59_534 -> (match (_59_534) with
| (bv, _59_533) -> begin
(

let _59_535 = (non_dependent_or_raise s bv.FStar_Syntax_Syntax.sort)
in (FStar_Util.set_add bv s))
end)) FStar_Syntax_Syntax.no_names binders)
in (

let ct = (FStar_Syntax_Util.comp_result c)
in (

let _59_539 = (non_dependent_or_raise s ct)
in (

let k = (n - (FStar_List.length binders))
in if (k > (Prims.parse_int "0")) then begin
(is_non_dependent_arrow ct k)
end else begin
true
end))))
end)))
end)
with
| Not_found -> begin
false
end
end
end
| _59_543 -> begin
(

let _59_544 = (let _158_613 = (FStar_Syntax_Print.term_to_string ty)
in (FStar_Util.print1_warning "Not a dependent arrow : %s" _158_613))
in false)
end))
in (

let rec is_valid_application = (fun head -> (match ((let _158_616 = (FStar_Syntax_Subst.compress head)
in _158_616.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv) when ((((FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.option_lid) || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.either_lid)) || (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Syntax_Const.eq2_lid)) || (let _158_617 = (FStar_Syntax_Subst.compress head)
in (FStar_Syntax_Util.is_tuple_constructor _158_617))) -> begin
true
end
| FStar_Syntax_Syntax.Tm_fvar (fv) when (is_non_dependent_arrow fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.ty (FStar_List.length args)) -> begin
(

let res = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Inlining)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::[]) env.env t)
in (match (res.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_app (_59_554) -> begin
true
end
| _59_557 -> begin
(

let _59_558 = (let _158_618 = (FStar_Syntax_Print.term_to_string head)
in (FStar_Util.print1_warning "Got a term which might be a non-dependent user-defined data-type %s\n" _158_618))
in false)
end))
end
| (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) -> begin
true
end
| FStar_Syntax_Syntax.Tm_uinst (t, _59_568) -> begin
(is_valid_application t)
end
| _59_572 -> begin
false
end))
in if (is_valid_application head) then begin
(let _158_623 = (let _158_622 = (let _158_621 = (FStar_List.map (fun _59_575 -> (match (_59_575) with
| (t, qual) -> begin
(let _158_620 = (star_type' env t)
in ((_158_620), (qual)))
end)) args)
in ((head), (_158_621)))
in FStar_Syntax_Syntax.Tm_app (_158_622))
in (mk _158_623))
end else begin
(let _158_626 = (let _158_625 = (let _158_624 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "For now, only [either], [option] and [eq2] are supported in the definition language (got: %s)" _158_624))
in FStar_Syntax_Syntax.Err (_158_625))
in (Prims.raise _158_626))
end)))
end
| (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) -> begin
t
end
| FStar_Syntax_Syntax.Tm_abs (binders, repr, something) -> begin
(

let _59_595 = (FStar_Syntax_Subst.open_term binders repr)
in (match (_59_595) with
| (binders, repr) -> begin
(

let env = (

let _59_596 = env
in (let _158_627 = (FStar_TypeChecker_Env.push_binders env.env binders)
in {env = _158_627; subst = _59_596.subst; tc_const = _59_596.tc_const}))
in (

let repr = (star_type' env repr)
in (FStar_Syntax_Util.abs binders repr something)))
end))
end
| FStar_Syntax_Syntax.Tm_refine (x, t) when false -> begin
(

let x = (FStar_Syntax_Syntax.freshen_bv x)
in (

let sort = (star_type' env x.FStar_Syntax_Syntax.sort)
in (

let subst = (FStar_Syntax_Syntax.DB ((((Prims.parse_int "0")), (x))))::[]
in (

let t = (FStar_Syntax_Subst.subst subst t)
in (

let t = (star_type' env t)
in (

let subst = (FStar_Syntax_Syntax.NM (((x), ((Prims.parse_int "0")))))::[]
in (

let t = (FStar_Syntax_Subst.subst subst t)
in (mk (FStar_Syntax_Syntax.Tm_refine ((((

let _59_611 = x
in {FStar_Syntax_Syntax.ppname = _59_611.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_611.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = sort})), (t))))))))))))
end
| FStar_Syntax_Syntax.Tm_meta (t, m) -> begin
(let _158_630 = (let _158_629 = (let _158_628 = (star_type' env t)
in ((_158_628), (m)))
in FStar_Syntax_Syntax.Tm_meta (_158_629))
in (mk _158_630))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, FStar_Util.Inl (t), something) -> begin
(let _158_635 = (let _158_634 = (let _158_633 = (star_type' env e)
in (let _158_632 = (let _158_631 = (star_type' env t)
in FStar_Util.Inl (_158_631))
in ((_158_633), (_158_632), (something))))
in FStar_Syntax_Syntax.Tm_ascribed (_158_634))
in (mk _158_635))
end
| FStar_Syntax_Syntax.Tm_ascribed (_59_624) -> begin
(let _158_638 = (let _158_637 = (let _158_636 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_ascribed is outside of the definition language: %s" _158_636))
in FStar_Syntax_Syntax.Err (_158_637))
in (Prims.raise _158_638))
end
| FStar_Syntax_Syntax.Tm_refine (_59_627) -> begin
(let _158_641 = (let _158_640 = (let _158_639 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_refine is outside of the definition language: %s" _158_639))
in FStar_Syntax_Syntax.Err (_158_640))
in (Prims.raise _158_641))
end
| FStar_Syntax_Syntax.Tm_uinst (_59_630) -> begin
(let _158_644 = (let _158_643 = (let _158_642 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_uinst is outside of the definition language: %s" _158_642))
in FStar_Syntax_Syntax.Err (_158_643))
in (Prims.raise _158_644))
end
| FStar_Syntax_Syntax.Tm_constant (_59_633) -> begin
(let _158_647 = (let _158_646 = (let _158_645 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_constant is outside of the definition language: %s" _158_645))
in FStar_Syntax_Syntax.Err (_158_646))
in (Prims.raise _158_647))
end
| FStar_Syntax_Syntax.Tm_match (_59_636) -> begin
(let _158_650 = (let _158_649 = (let _158_648 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_match is outside of the definition language: %s" _158_648))
in FStar_Syntax_Syntax.Err (_158_649))
in (Prims.raise _158_650))
end
| FStar_Syntax_Syntax.Tm_let (_59_639) -> begin
(let _158_653 = (let _158_652 = (let _158_651 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_let is outside of the definition language: %s" _158_651))
in FStar_Syntax_Syntax.Err (_158_652))
in (Prims.raise _158_653))
end
| FStar_Syntax_Syntax.Tm_uvar (_59_642) -> begin
(let _158_656 = (let _158_655 = (let _158_654 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_uvar is outside of the definition language: %s" _158_654))
in FStar_Syntax_Syntax.Err (_158_655))
in (Prims.raise _158_656))
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
(let _158_659 = (let _158_658 = (let _158_657 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Tm_unknown is outside of the definition language: %s" _158_657))
in FStar_Syntax_Syntax.Err (_158_658))
in (Prims.raise _158_659))
end
| FStar_Syntax_Syntax.Tm_delayed (_59_646) -> begin
(failwith "impossible")
end)))))


let is_monadic = (fun _59_5 -> (match (_59_5) with
| None -> begin
(failwith "un-annotated lambda?!")
end
| (Some (FStar_Util.Inl ({FStar_Syntax_Syntax.eff_name = _; FStar_Syntax_Syntax.res_typ = _; FStar_Syntax_Syntax.cflags = flags; FStar_Syntax_Syntax.comp = _}))) | (Some (FStar_Util.Inr (_, flags))) -> begin
(FStar_All.pipe_right flags (FStar_Util.for_some (fun _59_4 -> (match (_59_4) with
| FStar_Syntax_Syntax.CPS -> begin
true
end
| _59_668 -> begin
false
end))))
end))


let rec is_C : FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t -> (match ((let _158_667 = (FStar_Syntax_Subst.compress t)
in _158_667.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_app (head, args) when (FStar_Syntax_Util.is_tuple_constructor head) -> begin
(

let r = (let _158_669 = (let _158_668 = (FStar_List.hd args)
in (Prims.fst _158_668))
in (is_C _158_669))
in if r then begin
(

let _59_679 = if (not ((FStar_List.for_all (fun _59_678 -> (match (_59_678) with
| (h, _59_677) -> begin
(is_C h)
end)) args))) then begin
(failwith "not a C (A * C)")
end else begin
()
end
in true)
end else begin
(

let _59_685 = if (not ((FStar_List.for_all (fun _59_684 -> (match (_59_684) with
| (h, _59_683) -> begin
(not ((is_C h)))
end)) args))) then begin
(failwith "not a C (C * A)")
end else begin
()
end
in false)
end)
end
| FStar_Syntax_Syntax.Tm_arrow (binders, comp) -> begin
(match ((nm_of_comp comp.FStar_Syntax_Syntax.n)) with
| M (t) -> begin
(

let _59_693 = if (is_C t) then begin
(failwith "not a C (C -> C)")
end else begin
()
end
in true)
end
| N (t) -> begin
(is_C t)
end)
end
| (FStar_Syntax_Syntax.Tm_meta (t, _)) | (FStar_Syntax_Syntax.Tm_uinst (t, _)) | (FStar_Syntax_Syntax.Tm_ascribed (t, _, _)) -> begin
(is_C t)
end
| _59_713 -> begin
false
end))


let mk_return : env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t e -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None e.FStar_Syntax_Syntax.pos))
in (

let p_type = (mk_star_to_type mk env t)
in (

let p = (FStar_Syntax_Syntax.gen_bv "p\'" None p_type)
in (

let body = (let _158_685 = (let _158_684 = (let _158_683 = (FStar_Syntax_Syntax.bv_to_name p)
in (let _158_682 = (let _158_681 = (let _158_680 = (FStar_Syntax_Syntax.as_implicit false)
in ((e), (_158_680)))
in (_158_681)::[])
in ((_158_683), (_158_682))))
in FStar_Syntax_Syntax.Tm_app (_158_684))
in (mk _158_685))
in (let _158_687 = (let _158_686 = (FStar_Syntax_Syntax.mk_binder p)
in (_158_686)::[])
in (FStar_Syntax_Util.abs _158_687 body None)))))))


let is_unknown : FStar_Syntax_Syntax.term'  ->  Prims.bool = (fun _59_6 -> (match (_59_6) with
| FStar_Syntax_Syntax.Tm_unknown -> begin
true
end
| _59_725 -> begin
false
end))


let rec check : env  ->  FStar_Syntax_Syntax.term  ->  nm  ->  (nm * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env e context_nm -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None e.FStar_Syntax_Syntax.pos))
in (

let return_if = (fun _59_735 -> (match (_59_735) with
| (rec_nm, s_e, u_e) -> begin
(

let check = (fun t1 t2 -> if ((not ((is_unknown t2.FStar_Syntax_Syntax.n))) && (not ((let _158_741 = (FStar_TypeChecker_Rel.teq env.env t1 t2)
in (FStar_TypeChecker_Rel.is_trivial _158_741))))) then begin
(let _158_746 = (let _158_745 = (let _158_744 = (FStar_Syntax_Print.term_to_string e)
in (let _158_743 = (FStar_Syntax_Print.term_to_string t1)
in (let _158_742 = (FStar_Syntax_Print.term_to_string t2)
in (FStar_Util.format3 "[check]: the expression [%s] has type [%s] but should have type [%s]" _158_744 _158_743 _158_742))))
in FStar_Syntax_Syntax.Err (_158_745))
in (Prims.raise _158_746))
end else begin
()
end)
in (match (((rec_nm), (context_nm))) with
| ((N (t1), N (t2))) | ((M (t1), M (t2))) -> begin
(

let _59_747 = (check t1 t2)
in ((rec_nm), (s_e), (u_e)))
end
| (N (t1), M (t2)) -> begin
(

let _59_754 = (check t1 t2)
in (let _158_747 = (mk_return env t1 s_e)
in ((M (t1)), (_158_747), (u_e))))
end
| (M (t1), N (t2)) -> begin
(let _158_752 = (let _158_751 = (let _158_750 = (FStar_Syntax_Print.term_to_string e)
in (let _158_749 = (FStar_Syntax_Print.term_to_string t1)
in (let _158_748 = (FStar_Syntax_Print.term_to_string t2)
in (FStar_Util.format3 "[check %s]: got an effectful computation [%s] in lieu of a pure computation [%s]" _158_750 _158_749 _158_748))))
in FStar_Syntax_Syntax.Err (_158_751))
in (Prims.raise _158_752))
end))
end))
in (

let ensure_m = (fun env e2 -> (

let strip_m = (fun _59_7 -> (match (_59_7) with
| (M (t), s_e, u_e) -> begin
((t), (s_e), (u_e))
end
| _59_771 -> begin
(failwith "impossible")
end))
in (match (context_nm) with
| N (t) -> begin
(let _158_762 = (let _158_761 = (let _158_760 = (let _158_759 = (FStar_Syntax_Print.term_to_string t)
in (Prims.strcat "let-bound monadic body has a non-monadic continuation or a branch of a match is monadic and the others aren\'t : " _158_759))
in ((_158_760), (e2.FStar_Syntax_Syntax.pos)))
in FStar_Syntax_Syntax.Error (_158_761))
in (Prims.raise _158_762))
end
| M (_59_776) -> begin
(let _158_763 = (check env e2 context_nm)
in (strip_m _158_763))
end)))
in (match ((let _158_764 = (FStar_Syntax_Subst.compress e)
in _158_764.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_app (_)) -> begin
(let _158_765 = (infer env e)
in (return_if _158_765))
end
| FStar_Syntax_Syntax.Tm_let ((false, (binding)::[]), e2) -> begin
(mk_let env binding e2 (fun env e2 -> (check env e2 context_nm)) ensure_m)
end
| FStar_Syntax_Syntax.Tm_match (e0, branches) -> begin
(mk_match env e0 branches (fun env body -> (check env body context_nm)))
end
| (FStar_Syntax_Syntax.Tm_meta (e, _)) | (FStar_Syntax_Syntax.Tm_uinst (e, _)) | (FStar_Syntax_Syntax.Tm_ascribed (e, _, _)) -> begin
(check env e context_nm)
end
| FStar_Syntax_Syntax.Tm_let (_59_827) -> begin
(let _158_773 = (let _158_772 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[check]: Tm_let %s" _158_772))
in (failwith _158_773))
end
| FStar_Syntax_Syntax.Tm_type (_59_830) -> begin
(failwith "impossible (stratified)")
end
| FStar_Syntax_Syntax.Tm_arrow (_59_833) -> begin
(failwith "impossible (stratified)")
end
| FStar_Syntax_Syntax.Tm_refine (_59_836) -> begin
(let _158_775 = (let _158_774 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[check]: Tm_refine %s" _158_774))
in (failwith _158_775))
end
| FStar_Syntax_Syntax.Tm_uvar (_59_839) -> begin
(let _158_777 = (let _158_776 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[check]: Tm_uvar %s" _158_776))
in (failwith _158_777))
end
| FStar_Syntax_Syntax.Tm_delayed (_59_842) -> begin
(failwith "impossible (compressed)")
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
(let _158_782 = (let _158_781 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[check]: Tm_unknown %s" _158_781))
in (failwith _158_782))
end)))))
and infer : env  ->  FStar_Syntax_Syntax.term  ->  (nm * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env e -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None e.FStar_Syntax_Syntax.pos))
in (

let normalize = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eager_unfolding)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::(FStar_TypeChecker_Normalize.EraseUniverses)::[]) env.env)
in (match ((let _158_788 = (FStar_Syntax_Subst.compress e)
in _158_788.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_bvar (bv) -> begin
(failwith "I failed to open a binder... boo")
end
| FStar_Syntax_Syntax.Tm_name (bv) -> begin
((N (bv.FStar_Syntax_Syntax.sort)), (e), (e))
end
| FStar_Syntax_Syntax.Tm_abs (binders, body, what) -> begin
(

let binders = (FStar_Syntax_Subst.open_binders binders)
in (

let subst = (FStar_Syntax_Subst.opening_of_binders binders)
in (

let body = (FStar_Syntax_Subst.subst subst body)
in (

let env = (

let _59_862 = env
in (let _158_789 = (FStar_TypeChecker_Env.push_binders env.env binders)
in {env = _158_789; subst = _59_862.subst; tc_const = _59_862.tc_const}))
in (

let s_binders = (FStar_List.map (fun _59_867 -> (match (_59_867) with
| (bv, qual) -> begin
(

let sort = (star_type' env bv.FStar_Syntax_Syntax.sort)
in (((

let _59_869 = bv
in {FStar_Syntax_Syntax.ppname = _59_869.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_869.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = sort})), (qual)))
end)) binders)
in (

let _59_891 = (FStar_List.fold_left (fun _59_874 _59_877 -> (match (((_59_874), (_59_877))) with
| ((env, acc), (bv, qual)) -> begin
(

let c = bv.FStar_Syntax_Syntax.sort
in if (is_C c) then begin
(

let xw = (let _158_793 = (star_type' env c)
in (FStar_Syntax_Syntax.gen_bv (Prims.strcat bv.FStar_Syntax_Syntax.ppname.FStar_Ident.idText "^w") None _158_793))
in (

let x = (

let _59_880 = bv
in (let _158_795 = (let _158_794 = (FStar_Syntax_Syntax.bv_to_name xw)
in (trans_F_ env c _158_794))
in {FStar_Syntax_Syntax.ppname = _59_880.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_880.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _158_795}))
in (

let env = (

let _59_883 = env
in (let _158_799 = (let _158_798 = (let _158_797 = (let _158_796 = (FStar_Syntax_Syntax.bv_to_name xw)
in ((bv), (_158_796)))
in FStar_Syntax_Syntax.NT (_158_797))
in (_158_798)::env.subst)
in {env = _59_883.env; subst = _158_799; tc_const = _59_883.tc_const}))
in (let _158_803 = (let _158_802 = (FStar_Syntax_Syntax.mk_binder x)
in (let _158_801 = (let _158_800 = (FStar_Syntax_Syntax.mk_binder xw)
in (_158_800)::acc)
in (_158_802)::_158_801))
in ((env), (_158_803))))))
end else begin
(

let x = (

let _59_886 = bv
in (let _158_804 = (star_type' env bv.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _59_886.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_886.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _158_804}))
in (let _158_806 = (let _158_805 = (FStar_Syntax_Syntax.mk_binder x)
in (_158_805)::acc)
in ((env), (_158_806))))
end)
end)) ((env), ([])) binders)
in (match (_59_891) with
| (env, u_binders) -> begin
(

let u_binders = (FStar_List.rev u_binders)
in (

let _59_901 = (

let check_what = if (is_monadic what) then begin
check_m
end else begin
check_n
end
in (

let _59_897 = (check_what env body)
in (match (_59_897) with
| (t, s_body, u_body) -> begin
(let _158_812 = (let _158_811 = if (is_monadic what) then begin
M (t)
end else begin
N (t)
end
in (comp_of_nm _158_811))
in ((_158_812), (s_body), (u_body)))
end)))
in (match (_59_901) with
| (comp, s_body, u_body) -> begin
(

let t = (FStar_Syntax_Util.arrow binders comp)
in (

let s_what = (match (what) with
| None -> begin
None
end
| Some (FStar_Util.Inl (lc)) -> begin
if (FStar_All.pipe_right lc.FStar_Syntax_Syntax.cflags (FStar_Util.for_some (fun _59_8 -> (match (_59_8) with
| FStar_Syntax_Syntax.CPS -> begin
true
end
| _59_910 -> begin
false
end)))) then begin
(

let double_starred_comp = (let _158_816 = (let _158_815 = (let _158_814 = (lc.FStar_Syntax_Syntax.comp ())
in (FStar_Syntax_Util.comp_result _158_814))
in (FStar_All.pipe_left double_star _158_815))
in (FStar_Syntax_Syntax.mk_Total _158_816))
in (

let flags = (FStar_List.filter (fun _59_9 -> (match (_59_9) with
| FStar_Syntax_Syntax.CPS -> begin
false
end
| _59_915 -> begin
true
end)) lc.FStar_Syntax_Syntax.cflags)
in (let _158_820 = (let _158_819 = (let _158_818 = (FStar_Syntax_Util.comp_set_flags double_starred_comp flags)
in (FStar_Syntax_Util.lcomp_of_comp _158_818))
in FStar_Util.Inl (_158_819))
in Some (_158_820))))
end else begin
Some (FStar_Util.Inl ((

let _59_917 = lc
in {FStar_Syntax_Syntax.eff_name = _59_917.FStar_Syntax_Syntax.eff_name; FStar_Syntax_Syntax.res_typ = _59_917.FStar_Syntax_Syntax.res_typ; FStar_Syntax_Syntax.cflags = _59_917.FStar_Syntax_Syntax.cflags; FStar_Syntax_Syntax.comp = (fun _59_919 -> (match (()) with
| () -> begin
(

let c = (lc.FStar_Syntax_Syntax.comp ())
in (

let result_typ = (star_type' env (FStar_Syntax_Util.comp_result c))
in (FStar_Syntax_Util.set_result_typ c result_typ)))
end))})))
end
end
| Some (FStar_Util.Inr (lid, flags)) -> begin
(let _158_826 = (let _158_825 = if (FStar_All.pipe_right flags (FStar_Util.for_some (fun _59_10 -> (match (_59_10) with
| FStar_Syntax_Syntax.CPS -> begin
true
end
| _59_930 -> begin
false
end)))) then begin
(let _158_824 = (FStar_List.filter (fun _59_11 -> (match (_59_11) with
| FStar_Syntax_Syntax.CPS -> begin
false
end
| _59_934 -> begin
true
end)) flags)
in ((FStar_Syntax_Const.effect_Tot_lid), (_158_824)))
end else begin
((lid), (flags))
end
in FStar_Util.Inr (_158_825))
in Some (_158_826))
end)
in (

let _59_939 = (

let comp = (let _158_828 = (is_monadic what)
in (let _158_827 = (FStar_Syntax_Subst.subst env.subst s_body)
in (trans_G env (FStar_Syntax_Util.comp_result comp) _158_828 _158_827)))
in (let _158_829 = (FStar_Syntax_Util.ascribe u_body (FStar_Util.Inr (comp)))
in ((_158_829), (Some (FStar_Util.Inl ((FStar_Syntax_Util.lcomp_of_comp comp)))))))
in (match (_59_939) with
| (u_body, u_what) -> begin
(

let s_body = (FStar_Syntax_Subst.close s_binders s_body)
in (

let s_binders = (FStar_Syntax_Subst.close_binders s_binders)
in (

let s_term = (mk (FStar_Syntax_Syntax.Tm_abs (((s_binders), (s_body), (s_what)))))
in (

let u_body = (FStar_Syntax_Subst.close u_binders u_body)
in (

let u_binders = (FStar_Syntax_Subst.close_binders u_binders)
in (

let u_term = (mk (FStar_Syntax_Syntax.Tm_abs (((u_binders), (u_body), (u_what)))))
in ((N (t)), (s_term), (u_term))))))))
end))))
end)))
end)))))))
end
| FStar_Syntax_Syntax.Tm_fvar ({FStar_Syntax_Syntax.fv_name = {FStar_Syntax_Syntax.v = lid; FStar_Syntax_Syntax.ty = _59_953; FStar_Syntax_Syntax.p = _59_951}; FStar_Syntax_Syntax.fv_delta = _59_949; FStar_Syntax_Syntax.fv_qual = _59_947}) -> begin
(

let _59_961 = (FStar_TypeChecker_Env.lookup_lid env.env lid)
in (match (_59_961) with
| (_59_959, t) -> begin
(

let txt = (FStar_Ident.text_of_lid lid)
in (let _158_831 = (let _158_830 = (normalize t)
in N (_158_830))
in ((_158_831), (e), (e))))
end))
end
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let _59_970 = (check_n env head)
in (match (_59_970) with
| (t_head, s_head, u_head) -> begin
(

let is_arrow = (fun t -> (match ((let _158_834 = (FStar_Syntax_Subst.compress t)
in _158_834.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (_59_974) -> begin
true
end
| _59_977 -> begin
false
end))
in (

let rec flatten = (fun t -> (match ((let _158_837 = (FStar_Syntax_Subst.compress t)
in _158_837.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Total (t, _59_989); FStar_Syntax_Syntax.tk = _59_986; FStar_Syntax_Syntax.pos = _59_984; FStar_Syntax_Syntax.vars = _59_982}) when (is_arrow t) -> begin
(

let _59_997 = (flatten t)
in (match (_59_997) with
| (binders', comp) -> begin
(((FStar_List.append binders binders')), (comp))
end))
end
| FStar_Syntax_Syntax.Tm_arrow (binders, comp) -> begin
((binders), (comp))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, _59_1004, _59_1006) -> begin
(flatten e)
end
| _59_1010 -> begin
(let _158_840 = (let _158_839 = (let _158_838 = (FStar_Syntax_Print.term_to_string t_head)
in (FStar_Util.format1 "%s: not a function type" _158_838))
in FStar_Syntax_Syntax.Err (_158_839))
in (Prims.raise _158_840))
end))
in (

let _59_1013 = (flatten t_head)
in (match (_59_1013) with
| (binders, comp) -> begin
(

let n = (FStar_List.length binders)
in (

let n' = (FStar_List.length args)
in (

let _59_1016 = if ((FStar_List.length binders) < (FStar_List.length args)) then begin
(let _158_845 = (let _158_844 = (let _158_843 = (FStar_Util.string_of_int n)
in (let _158_842 = (FStar_Util.string_of_int (n' - n))
in (let _158_841 = (FStar_Util.string_of_int n)
in (FStar_Util.format3 "The head of this application, after being applied to %s arguments, is an effectful computation (leaving %s arguments to be applied). Please let-bind the head applied to the %s first arguments." _158_843 _158_842 _158_841))))
in FStar_Syntax_Syntax.Err (_158_844))
in (Prims.raise _158_845))
end else begin
()
end
in (

let _59_1020 = (FStar_Syntax_Subst.open_comp binders comp)
in (match (_59_1020) with
| (binders, comp) -> begin
(

let rec final_type = (fun subst _59_1025 args -> (match (_59_1025) with
| (binders, comp) -> begin
(match (((binders), (args))) with
| ([], []) -> begin
(let _158_853 = (let _158_852 = (FStar_Syntax_Subst.subst_comp subst comp)
in _158_852.FStar_Syntax_Syntax.n)
in (nm_of_comp _158_853))
end
| (binders, []) -> begin
(match ((let _158_856 = (let _158_855 = (let _158_854 = (mk (FStar_Syntax_Syntax.Tm_arrow (((binders), (comp)))))
in (FStar_Syntax_Subst.subst subst _158_854))
in (FStar_Syntax_Subst.compress _158_855))
in _158_856.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, comp) -> begin
(let _158_860 = (let _158_859 = (let _158_858 = (let _158_857 = (FStar_Syntax_Subst.close_comp binders comp)
in ((binders), (_158_857)))
in FStar_Syntax_Syntax.Tm_arrow (_158_858))
in (mk _158_859))
in N (_158_860))
end
| _59_1038 -> begin
(failwith "wat?")
end)
end
| ([], (_59_1043)::_59_1041) -> begin
(failwith "just checked that?!")
end
| (((bv, _59_1049))::binders, ((arg, _59_1055))::args) -> begin
(final_type ((FStar_Syntax_Syntax.NT (((bv), (arg))))::subst) ((binders), (comp)) args)
end)
end))
in (

let final_type = (final_type [] ((binders), (comp)) args)
in (

let _59_1063 = (FStar_List.splitAt n' binders)
in (match (_59_1063) with
| (binders, _59_1062) -> begin
(

let _59_1084 = (let _158_867 = (FStar_List.map2 (fun _59_1067 _59_1070 -> (match (((_59_1067), (_59_1070))) with
| ((bv, _59_1066), (arg, q)) -> begin
(match ((let _158_863 = (FStar_Syntax_Subst.compress bv.FStar_Syntax_Syntax.sort)
in _158_863.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_type (_59_1072) -> begin
(

let arg = ((arg), (q))
in ((arg), ((arg)::[])))
end
| _59_1076 -> begin
(

let _59_1081 = (check_n env arg)
in (match (_59_1081) with
| (_59_1078, s_arg, u_arg) -> begin
(let _158_866 = if (is_C bv.FStar_Syntax_Syntax.sort) then begin
(let _158_865 = (let _158_864 = (FStar_Syntax_Subst.subst env.subst s_arg)
in ((_158_864), (q)))
in (_158_865)::(((u_arg), (q)))::[])
end else begin
(((u_arg), (q)))::[]
end
in ((((s_arg), (q))), (_158_866)))
end))
end)
end)) binders args)
in (FStar_List.split _158_867))
in (match (_59_1084) with
| (s_args, u_args) -> begin
(

let u_args = (FStar_List.flatten u_args)
in (let _158_869 = (mk (FStar_Syntax_Syntax.Tm_app (((s_head), (s_args)))))
in (let _158_868 = (mk (FStar_Syntax_Syntax.Tm_app (((u_head), (u_args)))))
in ((final_type), (_158_869), (_158_868)))))
end))
end))))
end)))))
end))))
end))
end
| FStar_Syntax_Syntax.Tm_let ((false, (binding)::[]), e2) -> begin
(mk_let env binding e2 infer check_m)
end
| FStar_Syntax_Syntax.Tm_match (e0, branches) -> begin
(mk_match env e0 branches infer)
end
| (FStar_Syntax_Syntax.Tm_uinst (e, _)) | (FStar_Syntax_Syntax.Tm_meta (e, _)) | (FStar_Syntax_Syntax.Tm_ascribed (e, _, _)) -> begin
(infer env e)
end
| FStar_Syntax_Syntax.Tm_constant (c) -> begin
(let _158_871 = (let _158_870 = (env.tc_const c)
in N (_158_870))
in ((_158_871), (e), (e)))
end
| FStar_Syntax_Syntax.Tm_let (_59_1115) -> begin
(let _158_873 = (let _158_872 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[infer]: Tm_let %s" _158_872))
in (failwith _158_873))
end
| FStar_Syntax_Syntax.Tm_type (_59_1118) -> begin
(failwith "impossible (stratified)")
end
| FStar_Syntax_Syntax.Tm_arrow (_59_1121) -> begin
(failwith "impossible (stratified)")
end
| FStar_Syntax_Syntax.Tm_refine (_59_1124) -> begin
(let _158_875 = (let _158_874 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[infer]: Tm_refine %s" _158_874))
in (failwith _158_875))
end
| FStar_Syntax_Syntax.Tm_uvar (_59_1127) -> begin
(let _158_877 = (let _158_876 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[infer]: Tm_uvar %s" _158_876))
in (failwith _158_877))
end
| FStar_Syntax_Syntax.Tm_delayed (_59_1130) -> begin
(failwith "impossible (compressed)")
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
(let _158_882 = (let _158_881 = (FStar_Syntax_Print.term_to_string e)
in (FStar_Util.format1 "[infer]: Tm_unknown %s" _158_881))
in (failwith _158_882))
end))))
and mk_match : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.branch Prims.list  ->  (env  ->  FStar_Syntax_Syntax.term  ->  (nm * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term))  ->  (nm * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env e0 branches f -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None e0.FStar_Syntax_Syntax.pos))
in (

let _59_1143 = (check_n env e0)
in (match (_59_1143) with
| (_59_1140, s_e0, u_e0) -> begin
(

let _59_1160 = (let _158_898 = (FStar_List.map (fun b -> (match ((FStar_Syntax_Subst.open_branch b)) with
| (pat, None, body) -> begin
(

let env = (

let _59_1149 = env
in (let _158_897 = (let _158_896 = (FStar_Syntax_Syntax.pat_bvs pat)
in (FStar_List.fold_left FStar_TypeChecker_Env.push_bv env.env _158_896))
in {env = _158_897; subst = _59_1149.subst; tc_const = _59_1149.tc_const}))
in (

let _59_1155 = (f env body)
in (match (_59_1155) with
| (nm, s_body, u_body) -> begin
((nm), (((pat), (None), (((s_body), (u_body), (body))))))
end)))
end
| _59_1157 -> begin
(Prims.raise (FStar_Syntax_Syntax.Err ("No when clauses in the definition language")))
end)) branches)
in (FStar_List.split _158_898))
in (match (_59_1160) with
| (nms, branches) -> begin
(

let t1 = (match ((FStar_List.hd nms)) with
| (M (t1)) | (N (t1)) -> begin
t1
end)
in (

let has_m = (FStar_List.existsb (fun _59_12 -> (match (_59_12) with
| M (_59_1167) -> begin
true
end
| _59_1170 -> begin
false
end)) nms)
in (

let _59_1204 = (let _158_902 = (FStar_List.map2 (fun nm _59_1179 -> (match (_59_1179) with
| (pat, guard, (s_body, u_body, original_body)) -> begin
(match (((nm), (has_m))) with
| ((N (t2), false)) | ((M (t2), true)) -> begin
((nm), (((pat), (guard), (s_body))), (((pat), (guard), (u_body))))
end
| (N (t2), true) -> begin
(

let _59_1195 = (check env original_body (M (t2)))
in (match (_59_1195) with
| (_59_1192, s_body, u_body) -> begin
((M (t2)), (((pat), (guard), (s_body))), (((pat), (guard), (u_body))))
end))
end
| (M (_59_1197), false) -> begin
(failwith "impossible")
end)
end)) nms branches)
in (FStar_List.unzip3 _158_902))
in (match (_59_1204) with
| (nms, s_branches, u_branches) -> begin
if has_m then begin
(

let p_type = (mk_star_to_type mk env t1)
in (

let p = (FStar_Syntax_Syntax.gen_bv "p\'\'" None p_type)
in (

let s_branches = (FStar_List.map (fun _59_1210 -> (match (_59_1210) with
| (pat, guard, s_body) -> begin
(

let s_body = (let _158_909 = (let _158_908 = (let _158_907 = (let _158_906 = (let _158_905 = (FStar_Syntax_Syntax.bv_to_name p)
in (let _158_904 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_905), (_158_904))))
in (_158_906)::[])
in ((s_body), (_158_907)))
in FStar_Syntax_Syntax.Tm_app (_158_908))
in (mk _158_909))
in ((pat), (guard), (s_body)))
end)) s_branches)
in (

let s_branches = (FStar_List.map FStar_Syntax_Subst.close_branch s_branches)
in (

let u_branches = (FStar_List.map FStar_Syntax_Subst.close_branch u_branches)
in (

let s_e = (let _158_912 = (let _158_910 = (FStar_Syntax_Syntax.mk_binder p)
in (_158_910)::[])
in (let _158_911 = (mk (FStar_Syntax_Syntax.Tm_match (((s_e0), (s_branches)))))
in (FStar_Syntax_Util.abs _158_912 _158_911 None)))
in (

let t1_star = (let _158_916 = (let _158_914 = (let _158_913 = (FStar_Syntax_Syntax.new_bv None p_type)
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_binder _158_913))
in (_158_914)::[])
in (let _158_915 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0)
in (FStar_Syntax_Util.arrow _158_916 _158_915)))
in (let _158_918 = (mk (FStar_Syntax_Syntax.Tm_ascribed (((s_e), (FStar_Util.Inl (t1_star)), (None)))))
in (let _158_917 = (mk (FStar_Syntax_Syntax.Tm_match (((u_e0), (u_branches)))))
in ((M (t1)), (_158_918), (_158_917)))))))))))
end else begin
(

let s_branches = (FStar_List.map FStar_Syntax_Subst.close_branch s_branches)
in (

let u_branches = (FStar_List.map FStar_Syntax_Subst.close_branch u_branches)
in (

let t1_star = t1
in (let _158_923 = (let _158_921 = (let _158_920 = (let _158_919 = (mk (FStar_Syntax_Syntax.Tm_match (((s_e0), (s_branches)))))
in ((_158_919), (FStar_Util.Inl (t1_star)), (None)))
in FStar_Syntax_Syntax.Tm_ascribed (_158_920))
in (mk _158_921))
in (let _158_922 = (mk (FStar_Syntax_Syntax.Tm_match (((u_e0), (u_branches)))))
in ((N (t1)), (_158_923), (_158_922)))))))
end
end))))
end))
end))))
and mk_let : env_  ->  FStar_Syntax_Syntax.letbinding  ->  FStar_Syntax_Syntax.term  ->  (env_  ->  FStar_Syntax_Syntax.term  ->  (nm * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term))  ->  (env_  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term))  ->  (nm * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env binding e2 proceed ensure_m -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None e2.FStar_Syntax_Syntax.pos))
in (

let e1 = binding.FStar_Syntax_Syntax.lbdef
in (

let x = (FStar_Util.left binding.FStar_Syntax_Syntax.lbname)
in (

let x_binders = (let _158_943 = (FStar_Syntax_Syntax.mk_binder x)
in (_158_943)::[])
in (

let _59_1232 = (FStar_Syntax_Subst.open_term x_binders e2)
in (match (_59_1232) with
| (x_binders, e2) -> begin
(match ((infer env e1)) with
| (N (t1), s_e1, u_e1) -> begin
(

let u_binding = if (is_C t1) then begin
(

let _59_1238 = binding
in (let _158_945 = (let _158_944 = (FStar_Syntax_Subst.subst env.subst s_e1)
in (trans_F_ env t1 _158_944))
in {FStar_Syntax_Syntax.lbname = _59_1238.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _59_1238.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _158_945; FStar_Syntax_Syntax.lbeff = _59_1238.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _59_1238.FStar_Syntax_Syntax.lbdef}))
end else begin
binding
end
in (

let env = (

let _59_1241 = env
in (let _158_946 = (FStar_TypeChecker_Env.push_bv env.env (

let _59_1243 = x
in {FStar_Syntax_Syntax.ppname = _59_1243.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_1243.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t1}))
in {env = _158_946; subst = _59_1241.subst; tc_const = _59_1241.tc_const}))
in (

let _59_1249 = (proceed env e2)
in (match (_59_1249) with
| (nm_rec, s_e2, u_e2) -> begin
(

let s_binding = (

let _59_1250 = binding
in (let _158_947 = (star_type' env binding.FStar_Syntax_Syntax.lbtyp)
in {FStar_Syntax_Syntax.lbname = _59_1250.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _59_1250.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _158_947; FStar_Syntax_Syntax.lbeff = _59_1250.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = _59_1250.FStar_Syntax_Syntax.lbdef}))
in (let _158_955 = (let _158_950 = (let _158_949 = (let _158_948 = (FStar_Syntax_Subst.close x_binders s_e2)
in ((((false), (((

let _59_1253 = s_binding
in {FStar_Syntax_Syntax.lbname = _59_1253.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _59_1253.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _59_1253.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _59_1253.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = s_e1}))::[]))), (_158_948)))
in FStar_Syntax_Syntax.Tm_let (_158_949))
in (mk _158_950))
in (let _158_954 = (let _158_953 = (let _158_952 = (let _158_951 = (FStar_Syntax_Subst.close x_binders u_e2)
in ((((false), (((

let _59_1255 = u_binding
in {FStar_Syntax_Syntax.lbname = _59_1255.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _59_1255.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _59_1255.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _59_1255.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = u_e1}))::[]))), (_158_951)))
in FStar_Syntax_Syntax.Tm_let (_158_952))
in (mk _158_953))
in ((nm_rec), (_158_955), (_158_954)))))
end))))
end
| (M (t1), s_e1, u_e1) -> begin
(

let u_binding = (

let _59_1262 = binding
in {FStar_Syntax_Syntax.lbname = _59_1262.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _59_1262.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = t1; FStar_Syntax_Syntax.lbeff = FStar_Syntax_Const.effect_PURE_lid; FStar_Syntax_Syntax.lbdef = _59_1262.FStar_Syntax_Syntax.lbdef})
in (

let env = (

let _59_1265 = env
in (let _158_956 = (FStar_TypeChecker_Env.push_bv env.env (

let _59_1267 = x
in {FStar_Syntax_Syntax.ppname = _59_1267.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _59_1267.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t1}))
in {env = _158_956; subst = _59_1265.subst; tc_const = _59_1265.tc_const}))
in (

let _59_1273 = (ensure_m env e2)
in (match (_59_1273) with
| (t2, s_e2, u_e2) -> begin
(

let p_type = (mk_star_to_type mk env t2)
in (

let p = (FStar_Syntax_Syntax.gen_bv "p\'\'" None p_type)
in (

let s_e2 = (let _158_962 = (let _158_961 = (let _158_960 = (let _158_959 = (let _158_958 = (FStar_Syntax_Syntax.bv_to_name p)
in (let _158_957 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_958), (_158_957))))
in (_158_959)::[])
in ((s_e2), (_158_960)))
in FStar_Syntax_Syntax.Tm_app (_158_961))
in (mk _158_962))
in (

let s_e2 = (FStar_Syntax_Util.abs x_binders s_e2 None)
in (

let body = (let _158_967 = (let _158_966 = (let _158_965 = (let _158_964 = (let _158_963 = (FStar_Syntax_Syntax.as_implicit false)
in ((s_e2), (_158_963)))
in (_158_964)::[])
in ((s_e1), (_158_965)))
in FStar_Syntax_Syntax.Tm_app (_158_966))
in (mk _158_967))
in (let _158_974 = (let _158_969 = (let _158_968 = (FStar_Syntax_Syntax.mk_binder p)
in (_158_968)::[])
in (FStar_Syntax_Util.abs _158_969 body None))
in (let _158_973 = (let _158_972 = (let _158_971 = (let _158_970 = (FStar_Syntax_Subst.close x_binders u_e2)
in ((((false), (((

let _59_1279 = u_binding
in {FStar_Syntax_Syntax.lbname = _59_1279.FStar_Syntax_Syntax.lbname; FStar_Syntax_Syntax.lbunivs = _59_1279.FStar_Syntax_Syntax.lbunivs; FStar_Syntax_Syntax.lbtyp = _59_1279.FStar_Syntax_Syntax.lbtyp; FStar_Syntax_Syntax.lbeff = _59_1279.FStar_Syntax_Syntax.lbeff; FStar_Syntax_Syntax.lbdef = u_e1}))::[]))), (_158_970)))
in FStar_Syntax_Syntax.Tm_let (_158_971))
in (mk _158_972))
in ((M (t2)), (_158_974), (_158_973)))))))))
end))))
end)
end)))))))
and check_n : env_  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env e -> (

let mn = (let _158_977 = (FStar_Syntax_Syntax.mk FStar_Syntax_Syntax.Tm_unknown None e.FStar_Syntax_Syntax.pos)
in N (_158_977))
in (match ((check env e mn)) with
| (N (t), s_e, u_e) -> begin
((t), (s_e), (u_e))
end
| _59_1290 -> begin
(failwith "[check_n]: impossible")
end)))
and check_m : env_  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env e -> (

let mn = (let _158_980 = (FStar_Syntax_Syntax.mk FStar_Syntax_Syntax.Tm_unknown None e.FStar_Syntax_Syntax.pos)
in M (_158_980))
in (match ((check env e mn)) with
| (M (t), s_e, u_e) -> begin
((t), (s_e), (u_e))
end
| _59_1300 -> begin
(failwith "[check_m]: impossible")
end)))
and comp_of_nm : nm_  ->  FStar_Syntax_Syntax.comp = (fun nm -> (match (nm) with
| N (t) -> begin
(FStar_Syntax_Syntax.mk_Total t)
end
| M (t) -> begin
(mk_M t)
end))
and mk_M : FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.comp = (fun t -> (FStar_Syntax_Syntax.mk_Comp {FStar_Syntax_Syntax.comp_univs = (FStar_Syntax_Syntax.U_unknown)::[]; FStar_Syntax_Syntax.effect_name = FStar_Syntax_Const.monadic_lid; FStar_Syntax_Syntax.result_typ = t; FStar_Syntax_Syntax.effect_args = []; FStar_Syntax_Syntax.flags = (FStar_Syntax_Syntax.CPS)::(FStar_Syntax_Syntax.TOTAL)::[]}))
and type_of_comp : (FStar_Syntax_Syntax.comp', Prims.unit) FStar_Syntax_Syntax.syntax  ->  FStar_Syntax_Syntax.typ = (fun t -> (FStar_Syntax_Util.comp_result t))
and trans_F_ : env_  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env c wp -> (

let _59_1311 = if (not ((is_C c))) then begin
(failwith "not a C")
end else begin
()
end
in (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None c.FStar_Syntax_Syntax.pos))
in (match ((let _158_989 = (FStar_Syntax_Subst.compress c)
in _158_989.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_app (head, args) -> begin
(

let _59_1321 = (FStar_Syntax_Util.head_and_args wp)
in (match (_59_1321) with
| (wp_head, wp_args) -> begin
(

let _59_1322 = if ((not (((FStar_List.length wp_args) = (FStar_List.length args)))) || (not ((let _158_990 = (FStar_Syntax_Util.mk_tuple_data_lid (FStar_List.length wp_args) FStar_Range.dummyRange)
in (FStar_Syntax_Util.is_constructor wp_head _158_990))))) then begin
(failwith "mismatch")
end else begin
()
end
in (let _158_1000 = (let _158_999 = (let _158_998 = (FStar_List.map2 (fun _59_1326 _59_1329 -> (match (((_59_1326), (_59_1329))) with
| ((arg, q), (wp_arg, q')) -> begin
(

let print_implicit = (fun q -> if (FStar_Syntax_Syntax.is_implicit q) then begin
"implicit"
end else begin
"explicit"
end)
in (

let _59_1332 = if (q <> q') then begin
(let _158_996 = (print_implicit q)
in (let _158_995 = (print_implicit q')
in (FStar_Util.print2_warning "Incoherent implicit qualifiers %b %b" _158_996 _158_995)))
end else begin
()
end
in (let _158_997 = (trans_F_ env arg wp_arg)
in ((_158_997), (q)))))
end)) args wp_args)
in ((head), (_158_998)))
in FStar_Syntax_Syntax.Tm_app (_158_999))
in (mk _158_1000)))
end))
end
| FStar_Syntax_Syntax.Tm_arrow (binders, comp) -> begin
(

let binders = (FStar_Syntax_Util.name_binders binders)
in (

let _59_1341 = (FStar_Syntax_Subst.open_comp binders comp)
in (match (_59_1341) with
| (binders_orig, comp) -> begin
(

let _59_1350 = (let _158_1010 = (FStar_List.map (fun _59_1344 -> (match (_59_1344) with
| (bv, q) -> begin
(

let h = bv.FStar_Syntax_Syntax.sort
in if (is_C h) then begin
(

let w' = (let _158_1002 = (star_type' env h)
in (FStar_Syntax_Syntax.gen_bv (Prims.strcat bv.FStar_Syntax_Syntax.ppname.FStar_Ident.idText "-w\'") None _158_1002))
in (let _158_1008 = (let _158_1007 = (let _158_1006 = (let _158_1005 = (let _158_1004 = (let _158_1003 = (FStar_Syntax_Syntax.bv_to_name w')
in (trans_F_ env h _158_1003))
in (FStar_Syntax_Syntax.null_bv _158_1004))
in ((_158_1005), (q)))
in (_158_1006)::[])
in (((w'), (q)))::_158_1007)
in ((w'), (_158_1008))))
end else begin
(

let x = (let _158_1009 = (star_type' env h)
in (FStar_Syntax_Syntax.gen_bv (Prims.strcat bv.FStar_Syntax_Syntax.ppname.FStar_Ident.idText "-x") None _158_1009))
in ((x), ((((x), (q)))::[])))
end)
end)) binders_orig)
in (FStar_List.split _158_1010))
in (match (_59_1350) with
| (bvs, binders) -> begin
(

let binders = (FStar_List.flatten binders)
in (

let comp = (let _158_1012 = (let _158_1011 = (FStar_Syntax_Syntax.binders_of_list bvs)
in (FStar_Syntax_Util.rename_binders binders_orig _158_1011))
in (FStar_Syntax_Subst.subst_comp _158_1012 comp))
in (

let app = (let _158_1018 = (let _158_1017 = (let _158_1016 = (FStar_List.map (fun bv -> (let _158_1015 = (FStar_Syntax_Syntax.bv_to_name bv)
in (let _158_1014 = (FStar_Syntax_Syntax.as_implicit false)
in ((_158_1015), (_158_1014))))) bvs)
in ((wp), (_158_1016)))
in FStar_Syntax_Syntax.Tm_app (_158_1017))
in (mk _158_1018))
in (

let comp = (let _158_1020 = (type_of_comp comp)
in (let _158_1019 = (is_monadic_comp comp)
in (trans_G env _158_1020 _158_1019 app)))
in (FStar_Syntax_Util.arrow binders comp)))))
end))
end)))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, _59_1358, _59_1360) -> begin
(trans_F_ env e wp)
end
| _59_1364 -> begin
(failwith "impossible trans_F_")
end))))
and trans_G : env_  ->  FStar_Syntax_Syntax.typ  ->  Prims.bool  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.comp = (fun env h is_monadic wp -> (

let mk = (fun x -> (FStar_Syntax_Syntax.mk x None h.FStar_Syntax_Syntax.pos))
in if is_monadic then begin
(let _158_1031 = (let _158_1030 = (star_type' env h)
in (let _158_1029 = (let _158_1028 = (let _158_1027 = (FStar_Syntax_Syntax.as_implicit false)
in ((wp), (_158_1027)))
in (_158_1028)::[])
in {FStar_Syntax_Syntax.comp_univs = (FStar_Syntax_Syntax.U_unknown)::[]; FStar_Syntax_Syntax.effect_name = FStar_Syntax_Const.effect_PURE_lid; FStar_Syntax_Syntax.result_typ = _158_1030; FStar_Syntax_Syntax.effect_args = _158_1029; FStar_Syntax_Syntax.flags = []}))
in (FStar_Syntax_Syntax.mk_Comp _158_1031))
end else begin
(let _158_1032 = (trans_F_ env h wp)
in (FStar_Syntax_Syntax.mk_Total _158_1032))
end))


let n : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.UnfoldUntil (FStar_Syntax_Syntax.Delta_constant))::(FStar_TypeChecker_Normalize.NoDeltaSteps)::(FStar_TypeChecker_Normalize.Eager_unfolding)::(FStar_TypeChecker_Normalize.EraseUniverses)::[]))


let star_type : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (let _158_1039 = (n env.env t)
in (star_type' env _158_1039)))


let star_expr : env_  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun env t -> (let _158_1044 = (n env.env t)
in (check_n env _158_1044)))


let trans_F : env_  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env c wp -> (let _158_1052 = (n env.env c)
in (let _158_1051 = (n env.env wp)
in (trans_F_ env _158_1052 _158_1051))))




