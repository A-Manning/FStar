
open Prims

type binding =
| Binding_typ_var of FStar_Ident.ident
| Binding_var of FStar_Ident.ident
| Binding_let of FStar_Ident.lident
| Binding_tycon of FStar_Ident.lident


let is_Binding_typ_var = (fun _discr_ -> (match (_discr_) with
| Binding_typ_var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_var = (fun _discr_ -> (match (_discr_) with
| Binding_var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_let = (fun _discr_ -> (match (_discr_) with
| Binding_let (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_tycon = (fun _discr_ -> (match (_discr_) with
| Binding_tycon (_) -> begin
true
end
| _ -> begin
false
end))


let ___Binding_typ_var____0 = (fun projectee -> (match (projectee) with
| Binding_typ_var (_63_18) -> begin
_63_18
end))


let ___Binding_var____0 = (fun projectee -> (match (projectee) with
| Binding_var (_63_21) -> begin
_63_21
end))


let ___Binding_let____0 = (fun projectee -> (match (projectee) with
| Binding_let (_63_24) -> begin
_63_24
end))


let ___Binding_tycon____0 = (fun projectee -> (match (projectee) with
| Binding_tycon (_63_27) -> begin
_63_27
end))


type kind_abbrev =
(FStar_Ident.lident * (FStar_Absyn_Syntax.btvdef, FStar_Absyn_Syntax.bvvdef) FStar_Util.either Prims.list * FStar_Absyn_Syntax.knd)


type env =
{curmodule : FStar_Ident.lident Prims.option; modules : (FStar_Ident.lident * FStar_Absyn_Syntax.modul) Prims.list; open_namespaces : FStar_Ident.lident Prims.list; modul_abbrevs : (FStar_Ident.ident * FStar_Ident.lident) Prims.list; sigaccum : FStar_Absyn_Syntax.sigelts; localbindings : ((FStar_Absyn_Syntax.btvdef, FStar_Absyn_Syntax.bvvdef) FStar_Util.either * binding) Prims.list; recbindings : binding Prims.list; phase : FStar_Parser_AST.level; sigmap : (FStar_Absyn_Syntax.sigelt * Prims.bool) FStar_Util.smap Prims.list; default_result_effect : FStar_Absyn_Syntax.typ  ->  FStar_Range.range  ->  FStar_Absyn_Syntax.comp; iface : Prims.bool; admitted_iface : Prims.bool}


let is_Mkenv : env  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkenv"))))


type occurrence =
| OSig of FStar_Absyn_Syntax.sigelt
| OLet of FStar_Ident.lident
| ORec of FStar_Ident.lident


let is_OSig = (fun _discr_ -> (match (_discr_) with
| OSig (_) -> begin
true
end
| _ -> begin
false
end))


let is_OLet = (fun _discr_ -> (match (_discr_) with
| OLet (_) -> begin
true
end
| _ -> begin
false
end))


let is_ORec = (fun _discr_ -> (match (_discr_) with
| ORec (_) -> begin
true
end
| _ -> begin
false
end))


let ___OSig____0 = (fun projectee -> (match (projectee) with
| OSig (_63_43) -> begin
_63_43
end))


let ___OLet____0 = (fun projectee -> (match (projectee) with
| OLet (_63_46) -> begin
_63_46
end))


let ___ORec____0 = (fun projectee -> (match (projectee) with
| ORec (_63_49) -> begin
_63_49
end))


let range_of_occurrence : occurrence  ->  FStar_Range.range = (fun _63_1 -> (match (_63_1) with
| (OLet (l)) | (ORec (l)) -> begin
(FStar_Ident.range_of_lid l)
end
| OSig (se) -> begin
(FStar_Absyn_Util.range_of_sigelt se)
end))


type foundname =
| Exp_name of (occurrence * FStar_Absyn_Syntax.exp)
| Typ_name of (occurrence * FStar_Absyn_Syntax.typ)
| Eff_name of (occurrence * FStar_Ident.lident)
| Knd_name of (occurrence * FStar_Ident.lident)


let is_Exp_name = (fun _discr_ -> (match (_discr_) with
| Exp_name (_) -> begin
true
end
| _ -> begin
false
end))


let is_Typ_name = (fun _discr_ -> (match (_discr_) with
| Typ_name (_) -> begin
true
end
| _ -> begin
false
end))


let is_Eff_name = (fun _discr_ -> (match (_discr_) with
| Eff_name (_) -> begin
true
end
| _ -> begin
false
end))


let is_Knd_name = (fun _discr_ -> (match (_discr_) with
| Knd_name (_) -> begin
true
end
| _ -> begin
false
end))


let ___Exp_name____0 = (fun projectee -> (match (projectee) with
| Exp_name (_63_58) -> begin
_63_58
end))


let ___Typ_name____0 = (fun projectee -> (match (projectee) with
| Typ_name (_63_61) -> begin
_63_61
end))


let ___Eff_name____0 = (fun projectee -> (match (projectee) with
| Eff_name (_63_64) -> begin
_63_64
end))


let ___Knd_name____0 = (fun projectee -> (match (projectee) with
| Knd_name (_63_67) -> begin
_63_67
end))


type record_or_dc =
{typename : FStar_Ident.lident; constrname : FStar_Ident.lident; parms : FStar_Absyn_Syntax.binders; fields : (FStar_Absyn_Syntax.fieldname * FStar_Absyn_Syntax.typ) Prims.list; is_record : Prims.bool}


let is_Mkrecord_or_dc : record_or_dc  ->  Prims.bool = (Obj.magic ((fun _ -> (failwith "Not yet implemented:is_Mkrecord_or_dc"))))


let open_modules : env  ->  (FStar_Ident.lident * FStar_Absyn_Syntax.modul) Prims.list = (fun e -> e.modules)


let current_module : env  ->  FStar_Ident.lident = (fun env -> (match (env.curmodule) with
| None -> begin
(failwith "Unset current module")
end
| Some (m) -> begin
m
end))


let qual : FStar_Ident.lident  ->  FStar_Ident.ident  ->  FStar_Ident.lident = (fun lid id -> (let _162_230 = (FStar_Ident.lid_of_ids (FStar_List.append lid.FStar_Ident.ns ((lid.FStar_Ident.ident)::(id)::[])))
in (FStar_Ident.set_lid_range _162_230 id.FStar_Ident.idRange)))


let qualify : env  ->  FStar_Ident.ident  ->  FStar_Ident.lident = (fun env id -> (let _162_235 = (current_module env)
in (qual _162_235 id)))


let qualify_lid : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (fun env lid -> (

let cur = (current_module env)
in (let _162_240 = (FStar_Ident.lid_of_ids (FStar_List.append cur.FStar_Ident.ns (FStar_List.append ((cur.FStar_Ident.ident)::[]) (FStar_List.append lid.FStar_Ident.ns ((lid.FStar_Ident.ident)::[])))))
in (FStar_Ident.set_lid_range _162_240 (FStar_Ident.range_of_lid lid)))))


let new_sigmap = (fun _63_89 -> (match (()) with
| () -> begin
(FStar_Util.smap_create (Prims.parse_int "100"))
end))


let empty_env : Prims.unit  ->  env = (fun _63_90 -> (match (()) with
| () -> begin
(let _162_245 = (let _162_244 = (new_sigmap ())
in (_162_244)::[])
in {curmodule = None; modules = []; open_namespaces = []; modul_abbrevs = []; sigaccum = []; localbindings = []; recbindings = []; phase = FStar_Parser_AST.Un; sigmap = _162_245; default_result_effect = FStar_Absyn_Util.ml_comp; iface = false; admitted_iface = false})
end))


let sigmap : env  ->  (FStar_Absyn_Syntax.sigelt * Prims.bool) FStar_Util.smap = (fun env -> (FStar_List.hd env.sigmap))


let default_total : env  ->  env = (fun env -> (

let _63_93 = env
in {curmodule = _63_93.curmodule; modules = _63_93.modules; open_namespaces = _63_93.open_namespaces; modul_abbrevs = _63_93.modul_abbrevs; sigaccum = _63_93.sigaccum; localbindings = _63_93.localbindings; recbindings = _63_93.recbindings; phase = _63_93.phase; sigmap = _63_93.sigmap; default_result_effect = (fun t _63_96 -> (FStar_Absyn_Syntax.mk_Total t)); iface = _63_93.iface; admitted_iface = _63_93.admitted_iface}))


let default_ml : env  ->  env = (fun env -> (

let _63_99 = env
in {curmodule = _63_99.curmodule; modules = _63_99.modules; open_namespaces = _63_99.open_namespaces; modul_abbrevs = _63_99.modul_abbrevs; sigaccum = _63_99.sigaccum; localbindings = _63_99.localbindings; recbindings = _63_99.recbindings; phase = _63_99.phase; sigmap = _63_99.sigmap; default_result_effect = FStar_Absyn_Util.ml_comp; iface = _63_99.iface; admitted_iface = _63_99.admitted_iface}))


let range_of_binding : binding  ->  FStar_Range.range = (fun _63_2 -> (match (_63_2) with
| (Binding_typ_var (id)) | (Binding_var (id)) -> begin
id.FStar_Ident.idRange
end
| (Binding_let (lid)) | (Binding_tycon (lid)) -> begin
(FStar_Ident.range_of_lid lid)
end))


let try_lookup_typ_var : env  ->  FStar_Ident.ident  ->  FStar_Absyn_Syntax.typ Prims.option = (fun env id -> (

let fopt = (FStar_List.tryFind (fun _63_113 -> (match (_63_113) with
| (_63_111, b) -> begin
(match (b) with
| (Binding_typ_var (id')) | (Binding_var (id')) -> begin
(id.FStar_Ident.idText = id'.FStar_Ident.idText)
end
| _63_118 -> begin
false
end)
end)) env.localbindings)
in (match (fopt) with
| Some (FStar_Util.Inl (bvd), Binding_typ_var (_63_123)) -> begin
(let _162_261 = (FStar_Absyn_Util.bvd_to_typ (FStar_Absyn_Util.set_bvd_range bvd id.FStar_Ident.idRange) FStar_Absyn_Syntax.kun)
in Some (_162_261))
end
| _63_128 -> begin
None
end)))


let resolve_in_open_namespaces' = (fun env lid finder -> (

let aux = (fun namespaces -> (match ((finder lid)) with
| Some (r) -> begin
Some (r)
end
| _63_138 -> begin
(

let ids = (FStar_Ident.ids_of_lid lid)
in (FStar_Util.find_map namespaces (fun ns -> (

let full_name = (FStar_Ident.lid_of_ids (FStar_List.append (FStar_Ident.ids_of_lid ns) ids))
in (finder full_name)))))
end))
in (let _162_272 = (let _162_271 = (current_module env)
in (_162_271)::env.open_namespaces)
in (aux _162_272))))


let expand_module_abbrevs : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (fun env lid -> (match (lid.FStar_Ident.ns) with
| (id)::[] -> begin
(match ((FStar_All.pipe_right env.modul_abbrevs (FStar_List.tryFind (fun _63_149 -> (match (_63_149) with
| (id', _63_148) -> begin
(id.FStar_Ident.idText = id'.FStar_Ident.idText)
end))))) with
| None -> begin
lid
end
| Some (_63_152, lid') -> begin
(FStar_Ident.lid_of_ids (FStar_List.append (FStar_Ident.ids_of_lid lid') ((lid.FStar_Ident.ident)::[])))
end)
end
| _63_157 -> begin
lid
end))


let resolve_in_open_namespaces = (fun env lid finder -> (let _162_288 = (expand_module_abbrevs env lid)
in (resolve_in_open_namespaces' env _162_288 finder)))


let unmangleMap : (Prims.string * Prims.string) Prims.list = ((("op_ColonColon"), ("Cons")))::((("not"), ("op_Negation")))::[]


let unmangleOpName : FStar_Ident.ident  ->  FStar_Ident.lident Prims.option = (fun id -> (FStar_Util.find_map unmangleMap (fun _63_165 -> (match (_63_165) with
| (x, y) -> begin
if (id.FStar_Ident.idText = x) then begin
(let _162_292 = (FStar_Ident.lid_of_path (("Prims")::(y)::[]) id.FStar_Ident.idRange)
in Some (_162_292))
end else begin
None
end
end))))


let try_lookup_id' : env  ->  FStar_Ident.ident  ->  (FStar_Ident.lident * FStar_Absyn_Syntax.exp) Prims.option = (fun env id -> (match ((unmangleOpName id)) with
| Some (l) -> begin
(let _162_298 = (let _162_297 = (FStar_Absyn_Syntax.mk_Exp_fvar (((FStar_Absyn_Util.fv l)), (None)) None id.FStar_Ident.idRange)
in ((l), (_162_297)))
in Some (_162_298))
end
| _63_171 -> begin
(

let found = (FStar_Util.find_map env.localbindings (fun _63_3 -> (match (_63_3) with
| (FStar_Util.Inl (_63_174), Binding_typ_var (id')) when (id'.FStar_Ident.idText = id.FStar_Ident.idText) -> begin
Some (FStar_Util.Inl (()))
end
| (FStar_Util.Inr (bvd), Binding_var (id')) when (id'.FStar_Ident.idText = id.FStar_Ident.idText) -> begin
(let _162_303 = (let _162_302 = (let _162_301 = (FStar_Ident.lid_of_ids ((id')::[]))
in (let _162_300 = (FStar_Absyn_Util.bvd_to_exp (FStar_Absyn_Util.set_bvd_range bvd id.FStar_Ident.idRange) FStar_Absyn_Syntax.tun)
in ((_162_301), (_162_300))))
in FStar_Util.Inr (_162_302))
in Some (_162_303))
end
| _63_185 -> begin
None
end)))
in (match (found) with
| Some (FStar_Util.Inr (x)) -> begin
Some (x)
end
| _63_191 -> begin
None
end))
end))


let try_lookup_id : env  ->  FStar_Ident.ident  ->  FStar_Absyn_Syntax.exp Prims.option = (fun env id -> (match ((try_lookup_id' env id)) with
| Some (_63_195, e) -> begin
Some (e)
end
| None -> begin
None
end))


let fv_qual_of_se : FStar_Absyn_Syntax.sigelt  ->  FStar_Absyn_Syntax.fv_qual Prims.option = (fun _63_5 -> (match (_63_5) with
| FStar_Absyn_Syntax.Sig_datacon (_63_202, _63_204, (l, _63_207, _63_209), quals, _63_213, _63_215) -> begin
(

let qopt = (FStar_Util.find_map quals (fun _63_4 -> (match (_63_4) with
| FStar_Absyn_Syntax.RecordConstructor (fs) -> begin
Some (FStar_Absyn_Syntax.Record_ctor (((l), (fs))))
end
| _63_222 -> begin
None
end)))
in (match (qopt) with
| None -> begin
Some (FStar_Absyn_Syntax.Data_ctor)
end
| x -> begin
x
end))
end
| FStar_Absyn_Syntax.Sig_val_decl (_63_227, _63_229, quals, _63_232) -> begin
None
end
| _63_236 -> begin
None
end))


let try_lookup_name : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  foundname Prims.option = (fun any_val exclude_interf env lid -> (

let find_in_sig = (fun lid -> (match ((let _162_321 = (sigmap env)
in (FStar_Util.smap_try_find _162_321 lid.FStar_Ident.str))) with
| Some (_63_244, true) when exclude_interf -> begin
None
end
| None -> begin
None
end
| Some (se, _63_251) -> begin
(match (se) with
| (FStar_Absyn_Syntax.Sig_typ_abbrev (_)) | (FStar_Absyn_Syntax.Sig_tycon (_)) -> begin
(let _162_324 = (let _162_323 = (let _162_322 = (FStar_Absyn_Util.ftv lid FStar_Absyn_Syntax.kun)
in ((OSig (se)), (_162_322)))
in Typ_name (_162_323))
in Some (_162_324))
end
| FStar_Absyn_Syntax.Sig_kind_abbrev (_63_261) -> begin
Some (Knd_name (((OSig (se)), (lid))))
end
| FStar_Absyn_Syntax.Sig_new_effect (ne, _63_265) -> begin
Some (Eff_name (((OSig (se)), ((FStar_Ident.set_lid_range ne.FStar_Absyn_Syntax.mname (FStar_Ident.range_of_lid lid))))))
end
| FStar_Absyn_Syntax.Sig_effect_abbrev (_63_269) -> begin
Some (Eff_name (((OSig (se)), (lid))))
end
| FStar_Absyn_Syntax.Sig_datacon (_63_272) -> begin
(let _162_328 = (let _162_327 = (let _162_326 = (let _162_325 = (fv_qual_of_se se)
in (FStar_Absyn_Util.fvar _162_325 lid (FStar_Ident.range_of_lid lid)))
in ((OSig (se)), (_162_326)))
in Exp_name (_162_327))
in Some (_162_328))
end
| FStar_Absyn_Syntax.Sig_let (_63_275) -> begin
(let _162_331 = (let _162_330 = (let _162_329 = (FStar_Absyn_Util.fvar None lid (FStar_Ident.range_of_lid lid))
in ((OSig (se)), (_162_329)))
in Exp_name (_162_330))
in Some (_162_331))
end
| FStar_Absyn_Syntax.Sig_val_decl (_63_278, _63_280, quals, _63_283) -> begin
if (any_val || (FStar_All.pipe_right quals (FStar_Util.for_some (fun _63_6 -> (match (_63_6) with
| FStar_Absyn_Syntax.Assumption -> begin
true
end
| _63_289 -> begin
false
end))))) then begin
(let _162_336 = (let _162_335 = (let _162_334 = (let _162_333 = (fv_qual_of_se se)
in (FStar_Absyn_Util.fvar _162_333 lid (FStar_Ident.range_of_lid lid)))
in ((OSig (se)), (_162_334)))
in Exp_name (_162_335))
in Some (_162_336))
end else begin
None
end
end
| _63_291 -> begin
None
end)
end))
in (

let found_id = (match (lid.FStar_Ident.ns) with
| [] -> begin
(match ((try_lookup_id' env lid.FStar_Ident.ident)) with
| Some (lid, e) -> begin
Some (Exp_name (((OLet (lid)), (e))))
end
| None -> begin
(

let recname = (qualify env lid.FStar_Ident.ident)
in (FStar_Util.find_map env.recbindings (fun _63_7 -> (match (_63_7) with
| Binding_let (l) when (FStar_Ident.lid_equals l recname) -> begin
(let _162_340 = (let _162_339 = (let _162_338 = (FStar_Absyn_Util.fvar None recname (FStar_Ident.range_of_lid recname))
in ((ORec (l)), (_162_338)))
in Exp_name (_162_339))
in Some (_162_340))
end
| Binding_tycon (l) when (FStar_Ident.lid_equals l recname) -> begin
(let _162_343 = (let _162_342 = (let _162_341 = (FStar_Absyn_Util.ftv recname FStar_Absyn_Syntax.kun)
in ((ORec (l)), (_162_341)))
in Typ_name (_162_342))
in Some (_162_343))
end
| _63_305 -> begin
None
end))))
end)
end
| _63_307 -> begin
None
end)
in (match (found_id) with
| Some (_63_310) -> begin
found_id
end
| _63_313 -> begin
(resolve_in_open_namespaces env lid find_in_sig)
end))))


let try_lookup_typ_name' : Prims.bool  ->  env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ Prims.option = (fun exclude_interf env lid -> (match ((try_lookup_name true exclude_interf env lid)) with
| Some (Typ_name (_63_318, t)) -> begin
Some (t)
end
| Some (Eff_name (_63_324, l)) -> begin
(let _162_350 = (FStar_Absyn_Util.ftv l FStar_Absyn_Syntax.mk_Kind_unknown)
in Some (_162_350))
end
| _63_330 -> begin
None
end))


let try_lookup_typ_name : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ Prims.option = (fun env l -> (try_lookup_typ_name' (not (env.iface)) env l))


let try_lookup_effect_name' : Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (occurrence * FStar_Ident.lident) Prims.option = (fun exclude_interf env lid -> (match ((try_lookup_name true exclude_interf env lid)) with
| Some (Eff_name (o, l)) -> begin
Some (((o), (l)))
end
| _63_342 -> begin
None
end))


let try_lookup_effect_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (match ((try_lookup_effect_name' (not (env.iface)) env l)) with
| Some (o, l) -> begin
Some (l)
end
| _63_350 -> begin
None
end))


let try_lookup_effect_defn : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.eff_decl Prims.option = (fun env l -> (match ((try_lookup_effect_name' (not (env.iface)) env l)) with
| Some (OSig (FStar_Absyn_Syntax.Sig_new_effect (ne, _63_355)), _63_360) -> begin
Some (ne)
end
| _63_364 -> begin
None
end))


let is_effect_name : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((try_lookup_effect_name env lid)) with
| None -> begin
false
end
| Some (_63_369) -> begin
true
end))


let try_resolve_typ_abbrev : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ Prims.option = (fun env lid -> (

let find_in_sig = (fun lid -> (match ((let _162_379 = (sigmap env)
in (FStar_Util.smap_try_find _162_379 lid.FStar_Ident.str))) with
| Some (FStar_Absyn_Syntax.Sig_typ_abbrev (lid, tps, k, def, _63_380, _63_382), _63_386) -> begin
(

let t = (let _162_382 = (let _162_381 = (let _162_380 = (FStar_Absyn_Util.close_with_lam tps def)
in ((_162_380), (lid)))
in FStar_Absyn_Syntax.Meta_named (_162_381))
in (FStar_Absyn_Syntax.mk_Typ_meta _162_382))
in Some (t))
end
| _63_391 -> begin
None
end))
in (resolve_in_open_namespaces env lid find_in_sig)))


let lookup_letbinding_quals : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.qualifier Prims.list = (fun env lid -> (

let find_in_sig = (fun lid -> (match ((let _162_389 = (sigmap env)
in (FStar_Util.smap_try_find _162_389 lid.FStar_Ident.str))) with
| Some (FStar_Absyn_Syntax.Sig_val_decl (lid, _63_398, quals, _63_401), _63_405) -> begin
Some (quals)
end
| _63_409 -> begin
None
end))
in (match ((resolve_in_open_namespaces env lid find_in_sig)) with
| Some (quals) -> begin
quals
end
| _63_413 -> begin
[]
end)))


let try_lookup_module : env  ->  Prims.string Prims.list  ->  FStar_Absyn_Syntax.modul Prims.option = (fun env path -> (match ((FStar_List.tryFind (fun _63_418 -> (match (_63_418) with
| (mlid, modul) -> begin
((FStar_Ident.path_of_lid mlid) = path)
end)) env.modules)) with
| Some (_63_420, modul) -> begin
Some (modul)
end
| None -> begin
None
end))


let try_lookup_let : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.exp Prims.option = (fun env lid -> (

let find_in_sig = (fun lid -> (match ((let _162_401 = (sigmap env)
in (FStar_Util.smap_try_find _162_401 lid.FStar_Ident.str))) with
| Some (FStar_Absyn_Syntax.Sig_let (_63_430), _63_433) -> begin
(let _162_402 = (FStar_Absyn_Util.fvar None lid (FStar_Ident.range_of_lid lid))
in Some (_162_402))
end
| _63_437 -> begin
None
end))
in (resolve_in_open_namespaces env lid find_in_sig)))


let try_lookup_lid' : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.exp Prims.option = (fun any_val exclude_interf env lid -> (match ((try_lookup_name any_val exclude_interf env lid)) with
| Some (Exp_name (_63_443, e)) -> begin
Some (e)
end
| _63_449 -> begin
None
end))


let try_lookup_lid : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.exp Prims.option = (fun env l -> (try_lookup_lid' env.iface false env l))


let try_lookup_datacon : env  ->  FStar_Ident.lident  ->  FStar_Absyn_Syntax.typ FStar_Absyn_Syntax.var Prims.option = (fun env lid -> (

let find_in_sig = (fun lid -> (match ((let _162_421 = (sigmap env)
in (FStar_Util.smap_try_find _162_421 lid.FStar_Ident.str))) with
| Some (FStar_Absyn_Syntax.Sig_val_decl (_63_457, _63_459, quals, _63_462), _63_466) -> begin
if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _63_8 -> (match (_63_8) with
| FStar_Absyn_Syntax.Assumption -> begin
true
end
| _63_472 -> begin
false
end)))) then begin
Some ((FStar_Absyn_Util.fv lid))
end else begin
None
end
end
| Some (FStar_Absyn_Syntax.Sig_datacon (_63_474), _63_477) -> begin
Some ((FStar_Absyn_Util.fv lid))
end
| _63_481 -> begin
None
end))
in (resolve_in_open_namespaces env lid find_in_sig)))


let find_all_datacons : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.list Prims.option = (fun env lid -> (

let find_in_sig = (fun lid -> (match ((let _162_429 = (sigmap env)
in (FStar_Util.smap_try_find _162_429 lid.FStar_Ident.str))) with
| Some (FStar_Absyn_Syntax.Sig_tycon (_63_487, _63_489, _63_491, _63_493, datas, _63_496, _63_498), _63_502) -> begin
Some (datas)
end
| _63_506 -> begin
None
end))
in (resolve_in_open_namespaces env lid find_in_sig)))


let record_cache_aux : ((Prims.unit  ->  Prims.unit) * (Prims.unit  ->  Prims.unit) * (Prims.unit  ->  record_or_dc Prims.list) * (record_or_dc  ->  Prims.unit)) = (

let record_cache = (FStar_Util.mk_ref (([])::[]))
in (

let push = (fun _63_509 -> (match (()) with
| () -> begin
(let _162_443 = (let _162_442 = (let _162_440 = (FStar_ST.read record_cache)
in (FStar_List.hd _162_440))
in (let _162_441 = (FStar_ST.read record_cache)
in (_162_442)::_162_441))
in (FStar_ST.op_Colon_Equals record_cache _162_443))
end))
in (

let pop = (fun _63_511 -> (match (()) with
| () -> begin
(let _162_447 = (let _162_446 = (FStar_ST.read record_cache)
in (FStar_List.tl _162_446))
in (FStar_ST.op_Colon_Equals record_cache _162_447))
end))
in (

let peek = (fun _63_513 -> (match (()) with
| () -> begin
(let _162_450 = (FStar_ST.read record_cache)
in (FStar_List.hd _162_450))
end))
in (

let insert = (fun r -> (let _162_457 = (let _162_456 = (let _162_453 = (peek ())
in (r)::_162_453)
in (let _162_455 = (let _162_454 = (FStar_ST.read record_cache)
in (FStar_List.tl _162_454))
in (_162_456)::_162_455))
in (FStar_ST.op_Colon_Equals record_cache _162_457)))
in ((push), (pop), (peek), (insert)))))))


let push_record_cache : Prims.unit  ->  Prims.unit = (

let _63_523 = record_cache_aux
in (match (_63_523) with
| (push, _63_518, _63_520, _63_522) -> begin
push
end))


let pop_record_cache : Prims.unit  ->  Prims.unit = (

let _63_531 = record_cache_aux
in (match (_63_531) with
| (_63_525, pop, _63_528, _63_530) -> begin
pop
end))


let peek_record_cache : Prims.unit  ->  record_or_dc Prims.list = (

let _63_539 = record_cache_aux
in (match (_63_539) with
| (_63_533, _63_535, peek, _63_538) -> begin
peek
end))


let insert_record_cache : record_or_dc  ->  Prims.unit = (

let _63_547 = record_cache_aux
in (match (_63_547) with
| (_63_541, _63_543, _63_545, insert) -> begin
insert
end))


let extract_record : env  ->  FStar_Absyn_Syntax.sigelt  ->  Prims.unit = (fun e _63_12 -> (match (_63_12) with
| FStar_Absyn_Syntax.Sig_bundle (sigs, _63_552, _63_554, _63_556) -> begin
(

let is_rec = (FStar_Util.for_some (fun _63_9 -> (match (_63_9) with
| (FStar_Absyn_Syntax.RecordType (_)) | (FStar_Absyn_Syntax.RecordConstructor (_)) -> begin
true
end
| _63_567 -> begin
false
end)))
in (

let find_dc = (fun dc -> (FStar_All.pipe_right sigs (FStar_Util.find_opt (fun _63_10 -> (match (_63_10) with
| FStar_Absyn_Syntax.Sig_datacon (lid, _63_574, _63_576, _63_578, _63_580, _63_582) -> begin
(FStar_Ident.lid_equals dc lid)
end
| _63_586 -> begin
false
end)))))
in (FStar_All.pipe_right sigs (FStar_List.iter (fun _63_11 -> (match (_63_11) with
| FStar_Absyn_Syntax.Sig_tycon (typename, parms, _63_591, _63_593, (dc)::[], tags, _63_598) -> begin
(match ((let _162_528 = (find_dc dc)
in (FStar_All.pipe_left FStar_Util.must _162_528))) with
| FStar_Absyn_Syntax.Sig_datacon (constrname, t, _63_604, _63_606, _63_608, _63_610) -> begin
(

let formals = (match ((FStar_Absyn_Util.function_formals t)) with
| Some (x, _63_615) -> begin
x
end
| _63_619 -> begin
[]
end)
in (

let is_rec = (is_rec tags)
in (

let fields = (FStar_All.pipe_right formals (FStar_List.collect (fun b -> (match (b) with
| (FStar_Util.Inr (x), q) -> begin
if ((FStar_Absyn_Syntax.is_null_binder b) || (is_rec && (match (q) with
| Some (FStar_Absyn_Syntax.Implicit (_63_628)) -> begin
true
end
| _63_632 -> begin
false
end))) then begin
[]
end else begin
(let _162_532 = (let _162_531 = (let _162_530 = if is_rec then begin
(FStar_Absyn_Util.unmangle_field_name x.FStar_Absyn_Syntax.v.FStar_Absyn_Syntax.ppname)
end else begin
x.FStar_Absyn_Syntax.v.FStar_Absyn_Syntax.ppname
end
in (qual constrname _162_530))
in ((_162_531), (x.FStar_Absyn_Syntax.sort)))
in (_162_532)::[])
end
end
| _63_634 -> begin
[]
end))))
in (

let record = {typename = typename; constrname = constrname; parms = parms; fields = fields; is_record = is_rec}
in (insert_record_cache record)))))
end
| _63_638 -> begin
()
end)
end
| _63_640 -> begin
()
end))))))
end
| _63_642 -> begin
()
end))


let try_lookup_record_or_dc_by_field_name : env  ->  FStar_Ident.lident  ->  (record_or_dc * FStar_Ident.lident) Prims.option = (fun env fieldname -> (

let maybe_add_constrname = (fun ns c -> (

let rec aux = (fun ns -> (match (ns) with
| [] -> begin
(c)::[]
end
| (c')::[] -> begin
if (c'.FStar_Ident.idText = c.FStar_Ident.idText) then begin
(c)::[]
end else begin
(c')::(c)::[]
end
end
| (hd)::tl -> begin
(let _162_543 = (aux tl)
in (hd)::_162_543)
end))
in (aux ns)))
in (

let find_in_cache = (fun fieldname -> (

let _63_660 = ((fieldname.FStar_Ident.ns), (fieldname.FStar_Ident.ident))
in (match (_63_660) with
| (ns, fieldname) -> begin
(let _162_548 = (peek_record_cache ())
in (FStar_Util.find_map _162_548 (fun record -> (

let constrname = record.constrname.FStar_Ident.ident
in (

let ns = (maybe_add_constrname ns constrname)
in (

let fname = (FStar_Ident.lid_of_ids (FStar_List.append ns ((fieldname)::[])))
in (FStar_Util.find_map record.fields (fun _63_668 -> (match (_63_668) with
| (f, _63_667) -> begin
if (FStar_Ident.lid_equals fname f) then begin
Some (((record), (fname)))
end else begin
None
end
end)))))))))
end)))
in (resolve_in_open_namespaces env fieldname find_in_cache))))


let try_lookup_record_by_field_name : env  ->  FStar_Ident.lident  ->  (record_or_dc * FStar_Ident.lident) Prims.option = (fun env fieldname -> (match ((try_lookup_record_or_dc_by_field_name env fieldname)) with
| Some (r, f) when r.is_record -> begin
Some (((r), (f)))
end
| _63_676 -> begin
None
end))


let try_lookup_projector_by_field_name : env  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * Prims.bool) Prims.option = (fun env fieldname -> (match ((try_lookup_record_or_dc_by_field_name env fieldname)) with
| Some (r, f) -> begin
Some (((f), (r.is_record)))
end
| _63_684 -> begin
None
end))


let qualify_field_to_record : env  ->  record_or_dc  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env recd f -> (

let qualify = (fun fieldname -> (

let _63_692 = ((fieldname.FStar_Ident.ns), (fieldname.FStar_Ident.ident))
in (match (_63_692) with
| (ns, fieldname) -> begin
(

let constrname = recd.constrname.FStar_Ident.ident
in (

let fname = (FStar_Ident.lid_of_ids (FStar_List.append ns (FStar_List.append ((constrname)::[]) ((fieldname)::[]))))
in (FStar_Util.find_map recd.fields (fun _63_698 -> (match (_63_698) with
| (f, _63_697) -> begin
if (FStar_Ident.lid_equals fname f) then begin
Some (fname)
end else begin
None
end
end)))))
end)))
in (resolve_in_open_namespaces env f qualify)))


let find_kind_abbrev : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (match ((try_lookup_name true (not (env.iface)) env l)) with
| Some (Knd_name (_63_702, l)) -> begin
Some (l)
end
| _63_708 -> begin
None
end))


let is_kind_abbrev : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (match ((find_kind_abbrev env l)) with
| None -> begin
false
end
| Some (_63_713) -> begin
true
end))


let unique_name : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  Prims.bool = (fun any_val exclude_if env lid -> (match ((try_lookup_lid' any_val exclude_if env lid)) with
| None -> begin
(match ((find_kind_abbrev env lid)) with
| None -> begin
true
end
| Some (_63_722) -> begin
false
end)
end
| Some (_63_725) -> begin
false
end))


let unique_typ_name : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((try_lookup_typ_name' true env lid)) with
| None -> begin
true
end
| Some (a) -> begin
false
end))


let unique : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  Prims.bool = (fun any_val exclude_if env lid -> (

let this_env = (

let _63_736 = env
in {curmodule = _63_736.curmodule; modules = _63_736.modules; open_namespaces = []; modul_abbrevs = _63_736.modul_abbrevs; sigaccum = _63_736.sigaccum; localbindings = _63_736.localbindings; recbindings = _63_736.recbindings; phase = _63_736.phase; sigmap = _63_736.sigmap; default_result_effect = _63_736.default_result_effect; iface = _63_736.iface; admitted_iface = _63_736.admitted_iface})
in ((unique_name any_val exclude_if this_env lid) && (unique_typ_name this_env lid))))


let gen_bvd = (fun _63_13 -> (match (_63_13) with
| Binding_typ_var (id) -> begin
(let _162_597 = (let _162_596 = (let _162_595 = (FStar_Absyn_Util.genident (Some (id.FStar_Ident.idRange)))
in ((id), (_162_595)))
in (FStar_Absyn_Util.mkbvd _162_596))
in FStar_Util.Inl (_162_597))
end
| Binding_var (id) -> begin
(let _162_600 = (let _162_599 = (let _162_598 = (FStar_Absyn_Util.genident (Some (id.FStar_Ident.idRange)))
in ((id), (_162_598)))
in (FStar_Absyn_Util.mkbvd _162_599))
in FStar_Util.Inr (_162_600))
end
| _63_745 -> begin
(failwith "Tried to generate a bound variable for a type constructor")
end))


let push_bvvdef : env  ->  FStar_Absyn_Syntax.bvvdef  ->  env = (fun env x -> (

let b = Binding_var (x.FStar_Absyn_Syntax.ppname)
in (

let _63_749 = env
in {curmodule = _63_749.curmodule; modules = _63_749.modules; open_namespaces = _63_749.open_namespaces; modul_abbrevs = _63_749.modul_abbrevs; sigaccum = _63_749.sigaccum; localbindings = (((FStar_Util.Inr (x)), (b)))::env.localbindings; recbindings = _63_749.recbindings; phase = _63_749.phase; sigmap = _63_749.sigmap; default_result_effect = _63_749.default_result_effect; iface = _63_749.iface; admitted_iface = _63_749.admitted_iface})))


let push_btvdef : env  ->  FStar_Absyn_Syntax.btvdef  ->  env = (fun env x -> (

let b = Binding_typ_var (x.FStar_Absyn_Syntax.ppname)
in (

let _63_754 = env
in {curmodule = _63_754.curmodule; modules = _63_754.modules; open_namespaces = _63_754.open_namespaces; modul_abbrevs = _63_754.modul_abbrevs; sigaccum = _63_754.sigaccum; localbindings = (((FStar_Util.Inl (x)), (b)))::env.localbindings; recbindings = _63_754.recbindings; phase = _63_754.phase; sigmap = _63_754.sigmap; default_result_effect = _63_754.default_result_effect; iface = _63_754.iface; admitted_iface = _63_754.admitted_iface})))


let push_local_binding : env  ->  binding  ->  (env * (FStar_Absyn_Syntax.btvdef, FStar_Absyn_Syntax.bvvdef) FStar_Util.either) = (fun env b -> (

let bvd = (gen_bvd b)
in (((

let _63_759 = env
in {curmodule = _63_759.curmodule; modules = _63_759.modules; open_namespaces = _63_759.open_namespaces; modul_abbrevs = _63_759.modul_abbrevs; sigaccum = _63_759.sigaccum; localbindings = (((bvd), (b)))::env.localbindings; recbindings = _63_759.recbindings; phase = _63_759.phase; sigmap = _63_759.sigmap; default_result_effect = _63_759.default_result_effect; iface = _63_759.iface; admitted_iface = _63_759.admitted_iface})), (bvd))))


let push_local_tbinding : env  ->  FStar_Ident.ident  ->  (env * FStar_Absyn_Syntax.btvdef) = (fun env a -> (match ((push_local_binding env (Binding_typ_var (a)))) with
| (env, FStar_Util.Inl (x)) -> begin
((env), (x))
end
| _63_768 -> begin
(failwith "impossible")
end))


let push_local_vbinding : env  ->  FStar_Ident.ident  ->  (env * FStar_Absyn_Syntax.bvvdef) = (fun env b -> (match ((push_local_binding env (Binding_var (b)))) with
| (env, FStar_Util.Inr (x)) -> begin
((env), (x))
end
| _63_776 -> begin
(failwith "impossible")
end))


let push_rec_binding : env  ->  binding  ->  env = (fun env b -> (match (b) with
| (Binding_let (lid)) | (Binding_tycon (lid)) -> begin
if (unique false true env lid) then begin
(

let _63_782 = env
in {curmodule = _63_782.curmodule; modules = _63_782.modules; open_namespaces = _63_782.open_namespaces; modul_abbrevs = _63_782.modul_abbrevs; sigaccum = _63_782.sigaccum; localbindings = _63_782.localbindings; recbindings = (b)::env.recbindings; phase = _63_782.phase; sigmap = _63_782.sigmap; default_result_effect = _63_782.default_result_effect; iface = _63_782.iface; admitted_iface = _63_782.admitted_iface})
end else begin
(Prims.raise (FStar_Absyn_Syntax.Error ((((Prims.strcat "Duplicate top-level names " lid.FStar_Ident.str)), ((FStar_Ident.range_of_lid lid))))))
end
end
| _63_785 -> begin
(failwith "Unexpected rec_binding")
end))


let push_sigelt : env  ->  FStar_Absyn_Syntax.sigelt  ->  env = (fun env s -> (

let err = (fun l -> (

let sopt = (let _162_631 = (sigmap env)
in (FStar_Util.smap_try_find _162_631 l.FStar_Ident.str))
in (

let r = (match (sopt) with
| Some (se, _63_793) -> begin
(match ((let _162_632 = (FStar_Absyn_Util.lids_of_sigelt se)
in (FStar_Util.find_opt (FStar_Ident.lid_equals l) _162_632))) with
| Some (l) -> begin
(FStar_All.pipe_left FStar_Range.string_of_range (FStar_Ident.range_of_lid l))
end
| None -> begin
"<unknown>"
end)
end
| None -> begin
"<unknown>"
end)
in (let _162_635 = (let _162_634 = (let _162_633 = (FStar_Util.format2 "Duplicate top-level names [%s]; previously declared at %s" (FStar_Ident.text_of_lid l) r)
in ((_162_633), ((FStar_Ident.range_of_lid l))))
in FStar_Absyn_Syntax.Error (_162_634))
in (Prims.raise _162_635)))))
in (

let env = (

let _63_811 = (match (s) with
| FStar_Absyn_Syntax.Sig_let (_63_802) -> begin
((false), (true))
end
| FStar_Absyn_Syntax.Sig_bundle (_63_805) -> begin
((true), (true))
end
| _63_808 -> begin
((false), (false))
end)
in (match (_63_811) with
| (any_val, exclude_if) -> begin
(

let lids = (FStar_Absyn_Util.lids_of_sigelt s)
in (match ((FStar_Util.find_map lids (fun l -> if (not ((unique any_val exclude_if env l))) then begin
Some (l)
end else begin
None
end))) with
| None -> begin
(

let _63_815 = (extract_record env s)
in (

let _63_817 = env
in {curmodule = _63_817.curmodule; modules = _63_817.modules; open_namespaces = _63_817.open_namespaces; modul_abbrevs = _63_817.modul_abbrevs; sigaccum = (s)::env.sigaccum; localbindings = _63_817.localbindings; recbindings = _63_817.recbindings; phase = _63_817.phase; sigmap = _63_817.sigmap; default_result_effect = _63_817.default_result_effect; iface = _63_817.iface; admitted_iface = _63_817.admitted_iface}))
end
| Some (l) -> begin
(err l)
end))
end))
in (

let _63_836 = (match (s) with
| FStar_Absyn_Syntax.Sig_bundle (ses, _63_824, _63_826, _63_828) -> begin
(let _162_639 = (FStar_List.map (fun se -> (let _162_638 = (FStar_Absyn_Util.lids_of_sigelt se)
in ((_162_638), (se)))) ses)
in ((env), (_162_639)))
end
| _63_833 -> begin
(let _162_642 = (let _162_641 = (let _162_640 = (FStar_Absyn_Util.lids_of_sigelt s)
in ((_162_640), (s)))
in (_162_641)::[])
in ((env), (_162_642)))
end)
in (match (_63_836) with
| (env, lss) -> begin
(

let _63_841 = (FStar_All.pipe_right lss (FStar_List.iter (fun _63_839 -> (match (_63_839) with
| (lids, se) -> begin
(FStar_All.pipe_right lids (FStar_List.iter (fun lid -> (let _162_645 = (sigmap env)
in (FStar_Util.smap_add _162_645 lid.FStar_Ident.str ((se), ((env.iface && (not (env.admitted_iface))))))))))
end))))
in env)
end)))))


let push_namespace : env  ->  FStar_Ident.lident  ->  env = (fun env lid -> (

let _63_845 = env
in {curmodule = _63_845.curmodule; modules = _63_845.modules; open_namespaces = (lid)::env.open_namespaces; modul_abbrevs = _63_845.modul_abbrevs; sigaccum = _63_845.sigaccum; localbindings = _63_845.localbindings; recbindings = _63_845.recbindings; phase = _63_845.phase; sigmap = _63_845.sigmap; default_result_effect = _63_845.default_result_effect; iface = _63_845.iface; admitted_iface = _63_845.admitted_iface}))


let push_module_abbrev : env  ->  FStar_Ident.ident  ->  FStar_Ident.lident  ->  env = (fun env x l -> if (FStar_All.pipe_right env.modul_abbrevs (FStar_Util.for_some (fun _63_853 -> (match (_63_853) with
| (y, _63_852) -> begin
(x.FStar_Ident.idText = y.FStar_Ident.idText)
end)))) then begin
(let _162_659 = (let _162_658 = (let _162_657 = (FStar_Util.format1 "Module %s is already defined" x.FStar_Ident.idText)
in ((_162_657), (x.FStar_Ident.idRange)))
in FStar_Absyn_Syntax.Error (_162_658))
in (Prims.raise _162_659))
end else begin
(

let _63_854 = env
in {curmodule = _63_854.curmodule; modules = _63_854.modules; open_namespaces = _63_854.open_namespaces; modul_abbrevs = (((x), (l)))::env.modul_abbrevs; sigaccum = _63_854.sigaccum; localbindings = _63_854.localbindings; recbindings = _63_854.recbindings; phase = _63_854.phase; sigmap = _63_854.sigmap; default_result_effect = _63_854.default_result_effect; iface = _63_854.iface; admitted_iface = _63_854.admitted_iface})
end)


let is_type_lid : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let aux = (fun _63_859 -> (match (()) with
| () -> begin
(match ((try_lookup_typ_name' false env lid)) with
| Some (_63_861) -> begin
true
end
| _63_864 -> begin
false
end)
end))
in if (lid.FStar_Ident.ns = []) then begin
(match ((try_lookup_id env lid.FStar_Ident.ident)) with
| Some (_63_866) -> begin
false
end
| _63_869 -> begin
(aux ())
end)
end else begin
(aux ())
end))


let check_admits : FStar_Ident.lident  ->  env  ->  Prims.unit = (fun nm env -> (FStar_All.pipe_right env.sigaccum (FStar_List.iter (fun se -> (match (se) with
| FStar_Absyn_Syntax.Sig_val_decl (l, t, quals, r) -> begin
(match ((try_lookup_lid env l)) with
| None -> begin
(

let _63_880 = (let _162_673 = (let _162_672 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid l))
in (let _162_671 = (FStar_Absyn_Print.sli l)
in (FStar_Util.format2 "%s: Warning: Admitting %s without a definition\n" _162_672 _162_671)))
in (FStar_Util.print_string _162_673))
in (let _162_674 = (sigmap env)
in (FStar_Util.smap_add _162_674 l.FStar_Ident.str ((FStar_Absyn_Syntax.Sig_val_decl (((l), (t), ((FStar_Absyn_Syntax.Assumption)::quals), (r)))), (false)))))
end
| Some (_63_883) -> begin
()
end)
end
| _63_886 -> begin
()
end)))))


let finish : env  ->  FStar_Absyn_Syntax.modul  ->  env = (fun env modul -> (

let _63_924 = (FStar_All.pipe_right modul.FStar_Absyn_Syntax.declarations (FStar_List.iter (fun _63_15 -> (match (_63_15) with
| FStar_Absyn_Syntax.Sig_bundle (ses, quals, _63_893, _63_895) -> begin
if (FStar_List.contains FStar_Absyn_Syntax.Private quals) then begin
(FStar_All.pipe_right ses (FStar_List.iter (fun _63_14 -> (match (_63_14) with
| FStar_Absyn_Syntax.Sig_datacon (lid, _63_901, _63_903, _63_905, _63_907, _63_909) -> begin
(let _162_681 = (sigmap env)
in (FStar_Util.smap_remove _162_681 lid.FStar_Ident.str))
end
| _63_913 -> begin
()
end))))
end else begin
()
end
end
| FStar_Absyn_Syntax.Sig_val_decl (lid, _63_916, quals, _63_919) -> begin
if (FStar_List.contains FStar_Absyn_Syntax.Private quals) then begin
(let _162_682 = (sigmap env)
in (FStar_Util.smap_remove _162_682 lid.FStar_Ident.str))
end else begin
()
end
end
| _63_923 -> begin
()
end))))
in (

let _63_926 = env
in {curmodule = None; modules = (((modul.FStar_Absyn_Syntax.name), (modul)))::env.modules; open_namespaces = []; modul_abbrevs = []; sigaccum = []; localbindings = []; recbindings = []; phase = FStar_Parser_AST.Un; sigmap = _63_926.sigmap; default_result_effect = _63_926.default_result_effect; iface = _63_926.iface; admitted_iface = _63_926.admitted_iface})))


let push : env  ->  env = (fun env -> (

let _63_929 = (push_record_cache ())
in (

let _63_931 = env
in (let _162_687 = (let _162_686 = (let _162_685 = (sigmap env)
in (FStar_Util.smap_copy _162_685))
in (_162_686)::env.sigmap)
in {curmodule = _63_931.curmodule; modules = _63_931.modules; open_namespaces = _63_931.open_namespaces; modul_abbrevs = _63_931.modul_abbrevs; sigaccum = _63_931.sigaccum; localbindings = _63_931.localbindings; recbindings = _63_931.recbindings; phase = _63_931.phase; sigmap = _162_687; default_result_effect = _63_931.default_result_effect; iface = _63_931.iface; admitted_iface = _63_931.admitted_iface}))))


let mark : env  ->  env = (fun env -> (push env))


let reset_mark : env  ->  env = (fun env -> (

let _63_935 = env
in (let _162_692 = (FStar_List.tl env.sigmap)
in {curmodule = _63_935.curmodule; modules = _63_935.modules; open_namespaces = _63_935.open_namespaces; modul_abbrevs = _63_935.modul_abbrevs; sigaccum = _63_935.sigaccum; localbindings = _63_935.localbindings; recbindings = _63_935.recbindings; phase = _63_935.phase; sigmap = _162_692; default_result_effect = _63_935.default_result_effect; iface = _63_935.iface; admitted_iface = _63_935.admitted_iface})))


let commit_mark : env  ->  env = (fun env -> (match (env.sigmap) with
| (hd)::(_63_940)::tl -> begin
(

let _63_944 = env
in {curmodule = _63_944.curmodule; modules = _63_944.modules; open_namespaces = _63_944.open_namespaces; modul_abbrevs = _63_944.modul_abbrevs; sigaccum = _63_944.sigaccum; localbindings = _63_944.localbindings; recbindings = _63_944.recbindings; phase = _63_944.phase; sigmap = (hd)::tl; default_result_effect = _63_944.default_result_effect; iface = _63_944.iface; admitted_iface = _63_944.admitted_iface})
end
| _63_947 -> begin
(failwith "Impossible")
end))


let pop : env  ->  env = (fun env -> (match (env.sigmap) with
| (_63_951)::maps -> begin
(

let _63_953 = (pop_record_cache ())
in (

let _63_955 = env
in {curmodule = _63_955.curmodule; modules = _63_955.modules; open_namespaces = _63_955.open_namespaces; modul_abbrevs = _63_955.modul_abbrevs; sigaccum = _63_955.sigaccum; localbindings = _63_955.localbindings; recbindings = _63_955.recbindings; phase = _63_955.phase; sigmap = maps; default_result_effect = _63_955.default_result_effect; iface = _63_955.iface; admitted_iface = _63_955.admitted_iface}))
end
| _63_958 -> begin
(failwith "No more modules to pop")
end))


let export_interface : FStar_Ident.lident  ->  env  ->  env = (fun m env -> (

let sigelt_in_m = (fun se -> (match ((FStar_Absyn_Util.lids_of_sigelt se)) with
| (l)::_63_964 -> begin
(l.FStar_Ident.nsstr = m.FStar_Ident.str)
end
| _63_968 -> begin
false
end))
in (

let sm = (sigmap env)
in (

let env = (pop env)
in (

let keys = (FStar_Util.smap_keys sm)
in (

let sm' = (sigmap env)
in (

let _63_991 = (FStar_All.pipe_right keys (FStar_List.iter (fun k -> (match ((FStar_Util.smap_try_find sm' k)) with
| Some (se, true) when (sigelt_in_m se) -> begin
(

let _63_978 = (FStar_Util.smap_remove sm' k)
in (

let se = (match (se) with
| FStar_Absyn_Syntax.Sig_val_decl (l, t, q, r) -> begin
FStar_Absyn_Syntax.Sig_val_decl (((l), (t), ((FStar_Absyn_Syntax.Assumption)::q), (r)))
end
| _63_987 -> begin
se
end)
in (FStar_Util.smap_add sm' k ((se), (false)))))
end
| _63_990 -> begin
()
end))))
in env)))))))


let finish_module_or_interface : env  ->  FStar_Absyn_Syntax.modul  ->  env = (fun env modul -> (

let _63_995 = if (not (modul.FStar_Absyn_Syntax.is_interface)) then begin
(check_admits modul.FStar_Absyn_Syntax.name env)
end else begin
()
end
in (finish env modul)))


let prepare_module_or_interface : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (env * Prims.bool) = (fun intf admitted env mname -> (

let prep = (fun env -> (

let open_ns = if (FStar_Ident.lid_equals mname FStar_Absyn_Const.prims_lid) then begin
[]
end else begin
if (FStar_Util.starts_with "FStar." (FStar_Ident.text_of_lid mname)) then begin
(FStar_Absyn_Const.prims_lid)::(FStar_Absyn_Const.fstar_ns_lid)::[]
end else begin
(FStar_Absyn_Const.prims_lid)::(FStar_Absyn_Const.st_lid)::(FStar_Absyn_Const.all_lid)::(FStar_Absyn_Const.fstar_ns_lid)::[]
end
end
in (

let _63_1004 = env
in {curmodule = Some (mname); modules = _63_1004.modules; open_namespaces = open_ns; modul_abbrevs = _63_1004.modul_abbrevs; sigaccum = _63_1004.sigaccum; localbindings = _63_1004.localbindings; recbindings = _63_1004.recbindings; phase = _63_1004.phase; sigmap = env.sigmap; default_result_effect = _63_1004.default_result_effect; iface = intf; admitted_iface = admitted})))
in (match ((FStar_All.pipe_right env.modules (FStar_Util.find_opt (fun _63_1009 -> (match (_63_1009) with
| (l, _63_1008) -> begin
(FStar_Ident.lid_equals l mname)
end))))) with
| None -> begin
(((prep env)), (false))
end
| Some (_63_1012, m) -> begin
(let _162_721 = (let _162_720 = (let _162_719 = (FStar_Util.format1 "Duplicate module or interface name: %s" mname.FStar_Ident.str)
in ((_162_719), ((FStar_Ident.range_of_lid mname))))
in FStar_Absyn_Syntax.Error (_162_720))
in (Prims.raise _162_721))
end)))


let enter_monad_scope : env  ->  FStar_Ident.ident  ->  env = (fun env mname -> (

let curmod = (current_module env)
in (

let mscope = (FStar_Ident.lid_of_ids (FStar_List.append curmod.FStar_Ident.ns ((curmod.FStar_Ident.ident)::(mname)::[])))
in (

let _63_1020 = env
in {curmodule = Some (mscope); modules = _63_1020.modules; open_namespaces = (curmod)::env.open_namespaces; modul_abbrevs = _63_1020.modul_abbrevs; sigaccum = _63_1020.sigaccum; localbindings = _63_1020.localbindings; recbindings = _63_1020.recbindings; phase = _63_1020.phase; sigmap = _63_1020.sigmap; default_result_effect = _63_1020.default_result_effect; iface = _63_1020.iface; admitted_iface = _63_1020.admitted_iface}))))


let exit_monad_scope : env  ->  env  ->  env = (fun env0 env -> (

let _63_1024 = env
in {curmodule = env0.curmodule; modules = _63_1024.modules; open_namespaces = env0.open_namespaces; modul_abbrevs = _63_1024.modul_abbrevs; sigaccum = _63_1024.sigaccum; localbindings = _63_1024.localbindings; recbindings = _63_1024.recbindings; phase = _63_1024.phase; sigmap = _63_1024.sigmap; default_result_effect = _63_1024.default_result_effect; iface = _63_1024.iface; admitted_iface = _63_1024.admitted_iface}))


let fail_or = (fun env lookup lid -> (match ((lookup lid)) with
| None -> begin
(

let r = (match ((try_lookup_name true false env lid)) with
| None -> begin
None
end
| (Some (Knd_name (o, _))) | (Some (Eff_name (o, _))) | (Some (Typ_name (o, _))) | (Some (Exp_name (o, _))) -> begin
Some ((range_of_occurrence o))
end)
in (

let msg = (match (r) with
| None -> begin
""
end
| Some (r) -> begin
(let _162_736 = (FStar_Range.string_of_range r)
in (FStar_Util.format1 "(Possible clash with related name at %s)" _162_736))
end)
in (let _162_739 = (let _162_738 = (let _162_737 = (FStar_Util.format2 "Identifier not found: [%s] %s" (FStar_Ident.text_of_lid lid) msg)
in ((_162_737), ((FStar_Ident.range_of_lid lid))))
in FStar_Absyn_Syntax.Error (_162_738))
in (Prims.raise _162_739))))
end
| Some (r) -> begin
r
end))


let fail_or2 = (fun lookup id -> (match ((lookup id)) with
| None -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((((Prims.strcat "Identifier not found [" (Prims.strcat id.FStar_Ident.idText "]"))), (id.FStar_Ident.idRange)))))
end
| Some (r) -> begin
r
end))




