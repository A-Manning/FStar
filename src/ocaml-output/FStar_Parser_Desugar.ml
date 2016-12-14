
open Prims

let imp_tag : FStar_Absyn_Syntax.arg_qualifier = FStar_Absyn_Syntax.Implicit (false)


let as_imp : FStar_Parser_AST.imp  ->  FStar_Absyn_Syntax.arg_qualifier Prims.option = (fun _63_1 -> (match (_63_1) with
| (FStar_Parser_AST.Hash) | (FStar_Parser_AST.FsTypApp) -> begin
Some (imp_tag)
end
| _63_36 -> begin
None
end))


let arg_withimp_e = (fun imp t -> ((t), ((as_imp imp))))


let arg_withimp_t = (fun imp t -> (match (imp) with
| FStar_Parser_AST.Hash -> begin
((t), (Some (imp_tag)))
end
| _63_43 -> begin
((t), (None))
end))


let contains_binder : FStar_Parser_AST.binder Prims.list  ->  Prims.bool = (fun binders -> (FStar_All.pipe_right binders (FStar_Util.for_some (fun b -> (match (b.FStar_Parser_AST.b) with
| FStar_Parser_AST.Annotated (_63_47) -> begin
true
end
| _63_50 -> begin
false
end)))))


let rec unparen : FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Paren (t) -> begin
(unparen t)
end
| _63_55 -> begin
t
end))


let rec unlabel : FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Paren (t) -> begin
(unlabel t)
end
| FStar_Parser_AST.Labeled (t, _63_61, _63_63) -> begin
(unlabel t)
end
| _63_67 -> begin
t
end))


let kind_star : FStar_Range.range  ->  FStar_Parser_AST.term = (fun r -> (let _160_17 = (let _160_16 = (FStar_Ident.lid_of_path (("Type")::[]) r)
in FStar_Parser_AST.Name (_160_16))
in (FStar_Parser_AST.mk_term _160_17 r FStar_Parser_AST.Kind)))


let compile_op : Prims.int  ->  Prims.string  ->  Prims.string = (fun arity s -> (

let name_of_char = (fun _63_2 -> (match (_63_2) with
| '&' -> begin
"Amp"
end
| '@' -> begin
"At"
end
| '+' -> begin
"Plus"
end
| '-' when (arity = (Prims.parse_int "1")) -> begin
"Minus"
end
| '-' -> begin
"Subtraction"
end
| '/' -> begin
"Slash"
end
| '<' -> begin
"Less"
end
| '=' -> begin
"Equals"
end
| '>' -> begin
"Greater"
end
| '_' -> begin
"Underscore"
end
| '|' -> begin
"Bar"
end
| '!' -> begin
"Bang"
end
| '^' -> begin
"Hat"
end
| '%' -> begin
"Percent"
end
| '*' -> begin
"Star"
end
| '?' -> begin
"Question"
end
| ':' -> begin
"Colon"
end
| _63_90 -> begin
"UNKNOWN"
end))
in (

let rec aux = (fun i -> if (i = (FStar_String.length s)) then begin
[]
end else begin
(let _160_28 = (let _160_26 = (FStar_Util.char_at s i)
in (name_of_char _160_26))
in (let _160_27 = (aux (i + (Prims.parse_int "1")))
in (_160_28)::_160_27))
end)
in (let _160_30 = (let _160_29 = (aux (Prims.parse_int "0"))
in (FStar_String.concat "_" _160_29))
in (Prims.strcat "op_" _160_30)))))


let compile_op_lid : Prims.int  ->  Prims.string  ->  FStar_Range.range  ->  FStar_Absyn_Syntax.lident = (fun n s r -> (let _160_40 = (let _160_39 = (let _160_38 = (let _160_37 = (compile_op n s)
in ((_160_37), (r)))
in (FStar_Absyn_Syntax.mk_ident _160_38))
in (_160_39)::[])
in (FStar_All.pipe_right _160_40 FStar_Absyn_Syntax.lid_of_ids)))


let op_as_vlid : FStar_Parser_DesugarEnv.env  ->  Prims.int  ->  FStar_Range.range  ->  Prims.string  ->  FStar_Ident.lident Prims.option = (fun env arity rng s -> (

let r = (fun l -> Some ((FStar_Ident.set_lid_range l rng)))
in (

let fallback = (fun _63_104 -> (match (()) with
| () -> begin
(match (s) with
| "=" -> begin
(r FStar_Absyn_Const.op_Eq)
end
| ":=" -> begin
(r FStar_Absyn_Const.write_lid)
end
| "<" -> begin
(r FStar_Absyn_Const.op_LT)
end
| "<=" -> begin
(r FStar_Absyn_Const.op_LTE)
end
| ">" -> begin
(r FStar_Absyn_Const.op_GT)
end
| ">=" -> begin
(r FStar_Absyn_Const.op_GTE)
end
| "&&" -> begin
(r FStar_Absyn_Const.op_And)
end
| "||" -> begin
(r FStar_Absyn_Const.op_Or)
end
| "*" -> begin
(r FStar_Absyn_Const.op_Multiply)
end
| "+" -> begin
(r FStar_Absyn_Const.op_Addition)
end
| "-" when (arity = (Prims.parse_int "1")) -> begin
(r FStar_Absyn_Const.op_Minus)
end
| "-" -> begin
(r FStar_Absyn_Const.op_Subtraction)
end
| "/" -> begin
(r FStar_Absyn_Const.op_Division)
end
| "%" -> begin
(r FStar_Absyn_Const.op_Modulus)
end
| "!" -> begin
(r FStar_Absyn_Const.read_lid)
end
| "@" -> begin
(r FStar_Absyn_Const.list_append_lid)
end
| "^" -> begin
(r FStar_Absyn_Const.strcat_lid)
end
| "|>" -> begin
(r FStar_Absyn_Const.pipe_right_lid)
end
| "<|" -> begin
(r FStar_Absyn_Const.pipe_left_lid)
end
| "<>" -> begin
(r FStar_Absyn_Const.op_notEq)
end
| _63_126 -> begin
None
end)
end))
in (match ((let _160_53 = (compile_op_lid arity s rng)
in (FStar_Parser_DesugarEnv.try_lookup_lid env _160_53))) with
| Some ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _63_137); FStar_Absyn_Syntax.tk = _63_134; FStar_Absyn_Syntax.pos = _63_132; FStar_Absyn_Syntax.fvs = _63_130; FStar_Absyn_Syntax.uvs = _63_128}) -> begin
Some (fv.FStar_Absyn_Syntax.v)
end
| _63_143 -> begin
(fallback ())
end))))


let op_as_tylid : FStar_Parser_DesugarEnv.env  ->  Prims.int  ->  FStar_Range.range  ->  Prims.string  ->  FStar_Ident.lident Prims.option = (fun env arity rng s -> (

let r = (fun l -> Some ((FStar_Ident.set_lid_range l rng)))
in (match (s) with
| "~" -> begin
(r FStar_Absyn_Const.not_lid)
end
| "==" -> begin
(r FStar_Absyn_Const.eq2_lid)
end
| "=!=" -> begin
(r FStar_Absyn_Const.neq2_lid)
end
| "<<" -> begin
(r FStar_Absyn_Const.precedes_lid)
end
| "/\\" -> begin
(r FStar_Absyn_Const.and_lid)
end
| "\\/" -> begin
(r FStar_Absyn_Const.or_lid)
end
| "==>" -> begin
(r FStar_Absyn_Const.imp_lid)
end
| "<==>" -> begin
(r FStar_Absyn_Const.iff_lid)
end
| s -> begin
(match ((let _160_64 = (compile_op_lid arity s rng)
in (FStar_Parser_DesugarEnv.try_lookup_typ_name env _160_64))) with
| Some ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (ftv); FStar_Absyn_Syntax.tk = _63_166; FStar_Absyn_Syntax.pos = _63_164; FStar_Absyn_Syntax.fvs = _63_162; FStar_Absyn_Syntax.uvs = _63_160}) -> begin
Some (ftv.FStar_Absyn_Syntax.v)
end
| _63_172 -> begin
None
end)
end)))


let rec is_type : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  Prims.bool = (fun env t -> if (t.FStar_Parser_AST.level = FStar_Parser_AST.Type) then begin
true
end else begin
(match ((let _160_71 = (unparen t)
in _160_71.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Wild -> begin
true
end
| FStar_Parser_AST.Labeled (_63_177) -> begin
true
end
| FStar_Parser_AST.Op ("*", (hd)::_63_181) -> begin
(is_type env hd)
end
| (FStar_Parser_AST.Op ("==", _)) | (FStar_Parser_AST.Op ("=!=", _)) | (FStar_Parser_AST.Op ("~", _)) | (FStar_Parser_AST.Op ("/\\", _)) | (FStar_Parser_AST.Op ("\\/", _)) | (FStar_Parser_AST.Op ("==>", _)) | (FStar_Parser_AST.Op ("<==>", _)) | (FStar_Parser_AST.Op ("<<", _)) -> begin
true
end
| FStar_Parser_AST.Op (s, args) -> begin
(match ((op_as_tylid env (FStar_List.length args) t.FStar_Parser_AST.range s)) with
| None -> begin
false
end
| _63_232 -> begin
true
end)
end
| (FStar_Parser_AST.QForall (_)) | (FStar_Parser_AST.QExists (_)) | (FStar_Parser_AST.Sum (_)) | (FStar_Parser_AST.Refine (_)) | (FStar_Parser_AST.Tvar (_)) | (FStar_Parser_AST.NamedTyp (_)) -> begin
true
end
| (FStar_Parser_AST.Var (l)) | (FStar_Parser_AST.Name (l)) when ((FStar_List.length l.FStar_Ident.ns) = (Prims.parse_int "0")) -> begin
(match ((FStar_Parser_DesugarEnv.try_lookup_typ_var env l.FStar_Ident.ident)) with
| Some (_63_255) -> begin
true
end
| _63_258 -> begin
(FStar_Parser_DesugarEnv.is_type_lid env l)
end)
end
| (FStar_Parser_AST.Var (l)) | (FStar_Parser_AST.Name (l)) | (FStar_Parser_AST.Construct (l, _)) -> begin
(FStar_Parser_DesugarEnv.is_type_lid env l)
end
| (FStar_Parser_AST.App ({FStar_Parser_AST.tm = FStar_Parser_AST.Var (l); FStar_Parser_AST.range = _; FStar_Parser_AST.level = _}, arg, FStar_Parser_AST.Nothing)) | (FStar_Parser_AST.App ({FStar_Parser_AST.tm = FStar_Parser_AST.Name (l); FStar_Parser_AST.range = _; FStar_Parser_AST.level = _}, arg, FStar_Parser_AST.Nothing)) when (l.FStar_Ident.str = "ref") -> begin
(is_type env arg)
end
| (FStar_Parser_AST.App (t, _, _)) | (FStar_Parser_AST.Paren (t)) | (FStar_Parser_AST.Ascribed (t, _)) -> begin
(is_type env t)
end
| FStar_Parser_AST.Product (_63_299, t) -> begin
(not ((is_kind env t)))
end
| FStar_Parser_AST.If (t, t1, t2) -> begin
(((is_type env t) || (is_type env t1)) || (is_type env t2))
end
| FStar_Parser_AST.Abs (pats, t) -> begin
(

let rec aux = (fun env pats -> (match (pats) with
| [] -> begin
(is_type env t)
end
| (hd)::pats -> begin
(match (hd.FStar_Parser_AST.pat) with
| (FStar_Parser_AST.PatWild) | (FStar_Parser_AST.PatVar (_)) -> begin
(aux env pats)
end
| FStar_Parser_AST.PatTvar (id, _63_325) -> begin
(

let _63_331 = (FStar_Parser_DesugarEnv.push_local_tbinding env id)
in (match (_63_331) with
| (env, _63_330) -> begin
(aux env pats)
end))
end
| FStar_Parser_AST.PatAscribed (p, tm) -> begin
(

let env = if (is_kind env tm) then begin
(match (p.FStar_Parser_AST.pat) with
| (FStar_Parser_AST.PatVar (id, _)) | (FStar_Parser_AST.PatTvar (id, _)) -> begin
(let _160_76 = (FStar_Parser_DesugarEnv.push_local_tbinding env id)
in (FStar_All.pipe_right _160_76 Prims.fst))
end
| _63_346 -> begin
env
end)
end else begin
env
end
in (aux env pats))
end
| _63_349 -> begin
false
end)
end))
in (aux env pats))
end
| FStar_Parser_AST.Let (FStar_Parser_AST.NoLetQualifier, (({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (_63_354); FStar_Parser_AST.prange = _63_352}, _63_358))::[], t) -> begin
(is_type env t)
end
| FStar_Parser_AST.Let (FStar_Parser_AST.NoLetQualifier, (({FStar_Parser_AST.pat = FStar_Parser_AST.PatAscribed ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (_63_370); FStar_Parser_AST.prange = _63_368}, _63_374); FStar_Parser_AST.prange = _63_366}, _63_379))::[], t) -> begin
(is_type env t)
end
| FStar_Parser_AST.Let (FStar_Parser_AST.NoLetQualifier, (({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (_63_389); FStar_Parser_AST.prange = _63_387}, _63_393))::[], t) -> begin
(is_type env t)
end
| _63_400 -> begin
false
end)
end)
and is_kind : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  Prims.bool = (fun env t -> if (t.FStar_Parser_AST.level = FStar_Parser_AST.Kind) then begin
true
end else begin
(match ((let _160_79 = (unparen t)
in _160_79.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Name ({FStar_Ident.ns = _63_409; FStar_Ident.ident = _63_407; FStar_Ident.nsstr = _63_405; FStar_Ident.str = "Type"}) -> begin
true
end
| FStar_Parser_AST.Product (_63_413, t) -> begin
(is_kind env t)
end
| FStar_Parser_AST.Paren (t) -> begin
(is_kind env t)
end
| (FStar_Parser_AST.Construct (l, _)) | (FStar_Parser_AST.Name (l)) -> begin
(FStar_Parser_DesugarEnv.is_kind_abbrev env l)
end
| _63_426 -> begin
false
end)
end)


let rec is_type_binder : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder  ->  Prims.bool = (fun env b -> if (b.FStar_Parser_AST.blevel = FStar_Parser_AST.Formula) then begin
(match (b.FStar_Parser_AST.b) with
| FStar_Parser_AST.Variable (_63_430) -> begin
false
end
| (FStar_Parser_AST.TAnnotated (_)) | (FStar_Parser_AST.TVariable (_)) -> begin
true
end
| (FStar_Parser_AST.Annotated (_, t)) | (FStar_Parser_AST.NoName (t)) -> begin
(is_kind env t)
end)
end else begin
(match (b.FStar_Parser_AST.b) with
| FStar_Parser_AST.Variable (_63_445) -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected binder without annotation"), (b.FStar_Parser_AST.brange)))))
end
| FStar_Parser_AST.TVariable (_63_448) -> begin
false
end
| FStar_Parser_AST.TAnnotated (_63_451) -> begin
true
end
| (FStar_Parser_AST.Annotated (_, t)) | (FStar_Parser_AST.NoName (t)) -> begin
(is_kind env t)
end)
end)


let sort_ftv : FStar_Ident.ident Prims.list  ->  FStar_Ident.ident Prims.list = (fun ftv -> (let _160_90 = (FStar_Util.remove_dups (fun x y -> (x.FStar_Ident.idText = y.FStar_Ident.idText)) ftv)
in (FStar_All.pipe_left (FStar_Util.sort_with (fun x y -> (FStar_String.compare x.FStar_Ident.idText y.FStar_Ident.idText))) _160_90)))


let rec free_type_vars_b : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder  ->  (FStar_Parser_DesugarEnv.env * FStar_Ident.ident Prims.list) = (fun env binder -> (match (binder.FStar_Parser_AST.b) with
| FStar_Parser_AST.Variable (_63_467) -> begin
((env), ([]))
end
| FStar_Parser_AST.TVariable (x) -> begin
(

let _63_474 = (FStar_Parser_DesugarEnv.push_local_tbinding env x)
in (match (_63_474) with
| (env, _63_473) -> begin
((env), ((x)::[]))
end))
end
| FStar_Parser_AST.Annotated (_63_476, term) -> begin
(let _160_97 = (free_type_vars env term)
in ((env), (_160_97)))
end
| FStar_Parser_AST.TAnnotated (id, _63_482) -> begin
(

let _63_488 = (FStar_Parser_DesugarEnv.push_local_tbinding env id)
in (match (_63_488) with
| (env, _63_487) -> begin
((env), ([]))
end))
end
| FStar_Parser_AST.NoName (t) -> begin
(let _160_98 = (free_type_vars env t)
in ((env), (_160_98)))
end))
and free_type_vars : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Ident.ident Prims.list = (fun env t -> (match ((let _160_101 = (unparen t)
in _160_101.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Tvar (a) -> begin
(match ((FStar_Parser_DesugarEnv.try_lookup_typ_var env a)) with
| None -> begin
(a)::[]
end
| _63_497 -> begin
[]
end)
end
| (FStar_Parser_AST.Wild) | (FStar_Parser_AST.Const (_)) | (FStar_Parser_AST.Uvar (_)) | (FStar_Parser_AST.Var (_)) | (FStar_Parser_AST.Projector (_)) | (FStar_Parser_AST.Discrim (_)) | (FStar_Parser_AST.Name (_)) -> begin
[]
end
| (FStar_Parser_AST.Requires (t, _)) | (FStar_Parser_AST.Ensures (t, _)) | (FStar_Parser_AST.Labeled (t, _, _)) | (FStar_Parser_AST.NamedTyp (_, t)) | (FStar_Parser_AST.Paren (t)) | (FStar_Parser_AST.Ascribed (t, _)) -> begin
(free_type_vars env t)
end
| FStar_Parser_AST.Construct (_63_542, ts) -> begin
(FStar_List.collect (fun _63_549 -> (match (_63_549) with
| (t, _63_548) -> begin
(free_type_vars env t)
end)) ts)
end
| FStar_Parser_AST.Op (_63_551, ts) -> begin
(FStar_List.collect (free_type_vars env) ts)
end
| FStar_Parser_AST.App (t1, t2, _63_558) -> begin
(let _160_104 = (free_type_vars env t1)
in (let _160_103 = (free_type_vars env t2)
in (FStar_List.append _160_104 _160_103)))
end
| FStar_Parser_AST.Refine (b, t) -> begin
(

let _63_567 = (free_type_vars_b env b)
in (match (_63_567) with
| (env, f) -> begin
(let _160_105 = (free_type_vars env t)
in (FStar_List.append f _160_105))
end))
end
| (FStar_Parser_AST.Product (binders, body)) | (FStar_Parser_AST.Sum (binders, body)) -> begin
(

let _63_583 = (FStar_List.fold_left (fun _63_576 binder -> (match (_63_576) with
| (env, free) -> begin
(

let _63_580 = (free_type_vars_b env binder)
in (match (_63_580) with
| (env, f) -> begin
((env), ((FStar_List.append f free)))
end))
end)) ((env), ([])) binders)
in (match (_63_583) with
| (env, free) -> begin
(let _160_108 = (free_type_vars env body)
in (FStar_List.append free _160_108))
end))
end
| FStar_Parser_AST.Project (t, _63_586) -> begin
(free_type_vars env t)
end
| FStar_Parser_AST.Attributes (cattributes) -> begin
(FStar_List.collect (free_type_vars env) cattributes)
end
| (FStar_Parser_AST.Abs (_)) | (FStar_Parser_AST.Let (_)) | (FStar_Parser_AST.LetOpen (_)) | (FStar_Parser_AST.If (_)) | (FStar_Parser_AST.QForall (_)) | (FStar_Parser_AST.QExists (_)) -> begin
[]
end
| (FStar_Parser_AST.Record (_)) | (FStar_Parser_AST.Match (_)) | (FStar_Parser_AST.TryWith (_)) | (FStar_Parser_AST.Assign (_)) | (FStar_Parser_AST.Seq (_)) -> begin
(FStar_Parser_AST.error "Unexpected type in free_type_vars computation" t t.FStar_Parser_AST.range)
end))


let head_and_args : FStar_Parser_AST.term  ->  (FStar_Parser_AST.term * (FStar_Parser_AST.term * FStar_Parser_AST.imp) Prims.list) = (fun t -> (

let rec aux = (fun args t -> (match ((let _160_115 = (unparen t)
in _160_115.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App (t, arg, imp) -> begin
(aux ((((arg), (imp)))::args) t)
end
| FStar_Parser_AST.Construct (l, args') -> begin
(({FStar_Parser_AST.tm = FStar_Parser_AST.Name (l); FStar_Parser_AST.range = t.FStar_Parser_AST.range; FStar_Parser_AST.level = t.FStar_Parser_AST.level}), ((FStar_List.append args' args)))
end
| _63_638 -> begin
((t), (args))
end))
in (aux [] t)))


let close : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun env t -> (

let ftv = (let _160_120 = (free_type_vars env t)
in (FStar_All.pipe_left sort_ftv _160_120))
in if ((FStar_List.length ftv) = (Prims.parse_int "0")) then begin
t
end else begin
(

let binders = (FStar_All.pipe_right ftv (FStar_List.map (fun x -> (let _160_124 = (let _160_123 = (let _160_122 = (kind_star x.FStar_Ident.idRange)
in ((x), (_160_122)))
in FStar_Parser_AST.TAnnotated (_160_123))
in (FStar_Parser_AST.mk_binder _160_124 x.FStar_Ident.idRange FStar_Parser_AST.Type (Some (FStar_Parser_AST.Implicit)))))))
in (

let result = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((binders), (t)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
in result))
end))


let close_fun : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun env t -> (

let ftv = (let _160_129 = (free_type_vars env t)
in (FStar_All.pipe_left sort_ftv _160_129))
in if ((FStar_List.length ftv) = (Prims.parse_int "0")) then begin
t
end else begin
(

let binders = (FStar_All.pipe_right ftv (FStar_List.map (fun x -> (let _160_133 = (let _160_132 = (let _160_131 = (kind_star x.FStar_Ident.idRange)
in ((x), (_160_131)))
in FStar_Parser_AST.TAnnotated (_160_132))
in (FStar_Parser_AST.mk_binder _160_133 x.FStar_Ident.idRange FStar_Parser_AST.Type (Some (FStar_Parser_AST.Implicit)))))))
in (

let t = (match ((let _160_134 = (unlabel t)
in _160_134.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Product (_63_651) -> begin
t
end
| _63_654 -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.App ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Absyn_Const.effect_Tot_lid)) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)), (t), (FStar_Parser_AST.Nothing)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
end)
in (

let result = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((binders), (t)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
in result)))
end))


let rec uncurry : FStar_Parser_AST.binder Prims.list  ->  FStar_Parser_AST.term  ->  (FStar_Parser_AST.binder Prims.list * FStar_Parser_AST.term) = (fun bs t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Product (binders, t) -> begin
(uncurry (FStar_List.append bs binders) t)
end
| _63_664 -> begin
((bs), (t))
end))


let rec is_app_pattern : FStar_Parser_AST.pattern  ->  Prims.bool = (fun p -> (match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed (p, _63_668) -> begin
(is_app_pattern p)
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (_63_674); FStar_Parser_AST.prange = _63_672}, _63_678) -> begin
true
end
| _63_682 -> begin
false
end))


let rec destruct_app_pattern : FStar_Parser_DesugarEnv.env  ->  Prims.bool  ->  FStar_Parser_AST.pattern  ->  ((FStar_Ident.ident, FStar_Ident.lident) FStar_Util.either * FStar_Parser_AST.pattern Prims.list * FStar_Parser_AST.term Prims.option) = (fun env is_top_level p -> (match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed (p, t) -> begin
(

let _63_694 = (destruct_app_pattern env is_top_level p)
in (match (_63_694) with
| (name, args, _63_693) -> begin
((name), (args), (Some (t)))
end))
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (id, _63_699); FStar_Parser_AST.prange = _63_696}, args) when is_top_level -> begin
(let _160_148 = (let _160_147 = (FStar_Parser_DesugarEnv.qualify env id)
in FStar_Util.Inr (_160_147))
in ((_160_148), (args), (None)))
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (id, _63_710); FStar_Parser_AST.prange = _63_707}, args) -> begin
((FStar_Util.Inl (id)), (args), (None))
end
| _63_718 -> begin
(FStar_All.failwith "Not an app pattern")
end))


type bnd =
| TBinder of (FStar_Absyn_Syntax.btvdef * FStar_Absyn_Syntax.knd * FStar_Absyn_Syntax.aqual)
| VBinder of (FStar_Absyn_Syntax.bvvdef * FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.aqual)
| LetBinder of (FStar_Ident.lident * FStar_Absyn_Syntax.typ)


let is_TBinder = (fun _discr_ -> (match (_discr_) with
| TBinder (_) -> begin
true
end
| _ -> begin
false
end))


let is_VBinder = (fun _discr_ -> (match (_discr_) with
| VBinder (_) -> begin
true
end
| _ -> begin
false
end))


let is_LetBinder = (fun _discr_ -> (match (_discr_) with
| LetBinder (_) -> begin
true
end
| _ -> begin
false
end))


let ___TBinder____0 = (fun projectee -> (match (projectee) with
| TBinder (_63_721) -> begin
_63_721
end))


let ___VBinder____0 = (fun projectee -> (match (projectee) with
| VBinder (_63_724) -> begin
_63_724
end))


let ___LetBinder____0 = (fun projectee -> (match (projectee) with
| LetBinder (_63_727) -> begin
_63_727
end))


let binder_of_bnd : bnd  ->  ((((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, FStar_Absyn_Syntax.knd) FStar_Absyn_Syntax.withinfo_t, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, FStar_Absyn_Syntax.typ) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.aqual) = (fun _63_3 -> (match (_63_3) with
| TBinder (a, k, aq) -> begin
((FStar_Util.Inl ((FStar_Absyn_Util.bvd_to_bvar_s a k))), (aq))
end
| VBinder (x, t, aq) -> begin
((FStar_Util.Inr ((FStar_Absyn_Util.bvd_to_bvar_s x t))), (aq))
end
| _63_740 -> begin
(FStar_All.failwith "Impossible")
end))


let trans_aqual : FStar_Parser_AST.arg_qualifier Prims.option  ->  FStar_Absyn_Syntax.arg_qualifier Prims.option = (fun _63_4 -> (match (_63_4) with
| Some (FStar_Parser_AST.Implicit) -> begin
Some (imp_tag)
end
| Some (FStar_Parser_AST.Equality) -> begin
Some (FStar_Absyn_Syntax.Equality)
end
| _63_747 -> begin
None
end))


let as_binder : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.arg_qualifier Prims.option  ->  ((FStar_Ident.ident Prims.option * FStar_Absyn_Syntax.knd), (FStar_Ident.ident Prims.option * FStar_Absyn_Syntax.typ)) FStar_Util.either  ->  (FStar_Absyn_Syntax.binder * FStar_Parser_DesugarEnv.env) = (fun env imp _63_5 -> (match (_63_5) with
| FStar_Util.Inl (None, k) -> begin
(let _160_201 = (FStar_Absyn_Syntax.null_t_binder k)
in ((_160_201), (env)))
end
| FStar_Util.Inr (None, t) -> begin
(let _160_202 = (FStar_Absyn_Syntax.null_v_binder t)
in ((_160_202), (env)))
end
| FStar_Util.Inl (Some (a), k) -> begin
(

let _63_766 = (FStar_Parser_DesugarEnv.push_local_tbinding env a)
in (match (_63_766) with
| (env, a) -> begin
((((FStar_Util.Inl ((FStar_Absyn_Util.bvd_to_bvar_s a k))), ((trans_aqual imp)))), (env))
end))
end
| FStar_Util.Inr (Some (x), t) -> begin
(

let _63_774 = (FStar_Parser_DesugarEnv.push_local_vbinding env x)
in (match (_63_774) with
| (env, x) -> begin
((((FStar_Util.Inr ((FStar_Absyn_Util.bvd_to_bvar_s x t))), ((trans_aqual imp)))), (env))
end))
end))


type env_t =
FStar_Parser_DesugarEnv.env


type lenv_t =
(FStar_Absyn_Syntax.btvdef, FStar_Absyn_Syntax.bvvdef) FStar_Util.either Prims.list


let label_conjuncts : Prims.string  ->  Prims.bool  ->  Prims.string Prims.option  ->  FStar_Parser_AST.term  ->  FStar_Parser_AST.term = (fun tag polarity label_opt f -> (

let label = (fun f -> (

let msg = (match (label_opt) with
| Some (l) -> begin
l
end
| _63_784 -> begin
(let _160_213 = (FStar_Range.string_of_range f.FStar_Parser_AST.range)
in (FStar_Util.format2 "%s at %s" tag _160_213))
end)
in (FStar_Parser_AST.mk_term (FStar_Parser_AST.Labeled (((f), (msg), (polarity)))) f.FStar_Parser_AST.range f.FStar_Parser_AST.level)))
in (

let rec aux = (fun f -> (match (f.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Paren (g) -> begin
(let _160_217 = (let _160_216 = (aux g)
in FStar_Parser_AST.Paren (_160_216))
in (FStar_Parser_AST.mk_term _160_217 f.FStar_Parser_AST.range f.FStar_Parser_AST.level))
end
| FStar_Parser_AST.Op ("/\\", (f1)::(f2)::[]) -> begin
(let _160_223 = (let _160_222 = (let _160_221 = (let _160_220 = (aux f1)
in (let _160_219 = (let _160_218 = (aux f2)
in (_160_218)::[])
in (_160_220)::_160_219))
in (("/\\"), (_160_221)))
in FStar_Parser_AST.Op (_160_222))
in (FStar_Parser_AST.mk_term _160_223 f.FStar_Parser_AST.range f.FStar_Parser_AST.level))
end
| FStar_Parser_AST.If (f1, f2, f3) -> begin
(let _160_227 = (let _160_226 = (let _160_225 = (aux f2)
in (let _160_224 = (aux f3)
in ((f1), (_160_225), (_160_224))))
in FStar_Parser_AST.If (_160_226))
in (FStar_Parser_AST.mk_term _160_227 f.FStar_Parser_AST.range f.FStar_Parser_AST.level))
end
| FStar_Parser_AST.Abs (binders, g) -> begin
(let _160_230 = (let _160_229 = (let _160_228 = (aux g)
in ((binders), (_160_228)))
in FStar_Parser_AST.Abs (_160_229))
in (FStar_Parser_AST.mk_term _160_230 f.FStar_Parser_AST.range f.FStar_Parser_AST.level))
end
| _63_806 -> begin
(label f)
end))
in (aux f))))


let mk_lb : (FStar_Absyn_Syntax.lbname * FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.exp)  ->  FStar_Absyn_Syntax.letbinding = (fun _63_810 -> (match (_63_810) with
| (n, t, e) -> begin
{FStar_Absyn_Syntax.lbname = n; FStar_Absyn_Syntax.lbtyp = t; FStar_Absyn_Syntax.lbeff = FStar_Absyn_Const.effect_ALL_lid; FStar_Absyn_Syntax.lbdef = e}
end))


let rec desugar_data_pat : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.pattern  ->  (env_t * bnd * FStar_Absyn_Syntax.pat) = (fun env p -> (

let resolvex = (fun l e x -> (match ((FStar_All.pipe_right l (FStar_Util.find_opt (fun _63_6 -> (match (_63_6) with
| FStar_Util.Inr (y) -> begin
(y.FStar_Absyn_Syntax.ppname.FStar_Ident.idText = x.FStar_Ident.idText)
end
| _63_821 -> begin
false
end))))) with
| Some (FStar_Util.Inr (y)) -> begin
((l), (e), (y))
end
| _63_826 -> begin
(

let _63_829 = (FStar_Parser_DesugarEnv.push_local_vbinding e x)
in (match (_63_829) with
| (e, x) -> begin
(((FStar_Util.Inr (x))::l), (e), (x))
end))
end))
in (

let resolvea = (fun l e a -> (match ((FStar_All.pipe_right l (FStar_Util.find_opt (fun _63_7 -> (match (_63_7) with
| FStar_Util.Inl (b) -> begin
(b.FStar_Absyn_Syntax.ppname.FStar_Ident.idText = a.FStar_Ident.idText)
end
| _63_838 -> begin
false
end))))) with
| Some (FStar_Util.Inl (b)) -> begin
((l), (e), (b))
end
| _63_843 -> begin
(

let _63_846 = (FStar_Parser_DesugarEnv.push_local_tbinding e a)
in (match (_63_846) with
| (e, a) -> begin
(((FStar_Util.Inl (a))::l), (e), (a))
end))
end))
in (

let rec aux = (fun loc env p -> (

let pos = (fun q -> (FStar_Absyn_Syntax.withinfo q None p.FStar_Parser_AST.prange))
in (

let pos_r = (fun r q -> (FStar_Absyn_Syntax.withinfo q None r))
in (match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatOp (_63_857) -> begin
(FStar_All.failwith "let op not supported in stratified")
end
| FStar_Parser_AST.PatOr ([]) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Parser_AST.PatOr ((p)::ps) -> begin
(

let _63_871 = (aux loc env p)
in (match (_63_871) with
| (loc, env, var, p, _63_870) -> begin
(

let _63_888 = (FStar_List.fold_left (fun _63_875 p -> (match (_63_875) with
| (loc, env, ps) -> begin
(

let _63_884 = (aux loc env p)
in (match (_63_884) with
| (loc, env, _63_880, p, _63_883) -> begin
((loc), (env), ((p)::ps))
end))
end)) ((loc), (env), ([])) ps)
in (match (_63_888) with
| (loc, env, ps) -> begin
(

let pat = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_disj ((p)::(FStar_List.rev ps))))
in (

let _63_890 = (let _160_307 = (FStar_Absyn_Syntax.pat_vars pat)
in (Prims.ignore _160_307))
in ((loc), (env), (var), (pat), (false))))
end))
end))
end
| FStar_Parser_AST.PatAscribed (p, t) -> begin
(

let p = if (is_kind env t) then begin
(match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatTvar (_63_897) -> begin
p
end
| FStar_Parser_AST.PatVar (x, imp) -> begin
(

let _63_903 = p
in {FStar_Parser_AST.pat = FStar_Parser_AST.PatTvar (((x), (imp))); FStar_Parser_AST.prange = _63_903.FStar_Parser_AST.prange})
end
| _63_906 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected pattern"), (p.FStar_Parser_AST.prange)))))
end)
end else begin
p
end
in (

let _63_913 = (aux loc env p)
in (match (_63_913) with
| (loc, env', binder, p, imp) -> begin
(

let binder = (match (binder) with
| LetBinder (_63_915) -> begin
(FStar_All.failwith "impossible")
end
| TBinder (x, _63_919, aq) -> begin
(let _160_309 = (let _160_308 = (desugar_kind env t)
in ((x), (_160_308), (aq)))
in TBinder (_160_309))
end
| VBinder (x, _63_925, aq) -> begin
(

let t = (close_fun env t)
in (let _160_311 = (let _160_310 = (desugar_typ env t)
in ((x), (_160_310), (aq)))
in VBinder (_160_311)))
end)
in ((loc), (env'), (binder), (p), (imp)))
end)))
end
| FStar_Parser_AST.PatTvar (a, aq) -> begin
(

let imp = (aq = Some (FStar_Parser_AST.Implicit))
in (

let aq = (trans_aqual aq)
in if (a.FStar_Ident.idText = "\'_") then begin
(

let a = (FStar_All.pipe_left FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (let _160_312 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_twild ((FStar_Absyn_Util.bvd_to_bvar_s a FStar_Absyn_Syntax.kun))))
in ((loc), (env), (TBinder (((a), (FStar_Absyn_Syntax.kun), (aq)))), (_160_312), (imp))))
end else begin
(

let _63_941 = (resolvea loc env a)
in (match (_63_941) with
| (loc, env, abvd) -> begin
(let _160_313 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_tvar ((FStar_Absyn_Util.bvd_to_bvar_s abvd FStar_Absyn_Syntax.kun))))
in ((loc), (env), (TBinder (((abvd), (FStar_Absyn_Syntax.kun), (aq)))), (_160_313), (imp)))
end))
end))
end
| FStar_Parser_AST.PatWild -> begin
(

let x = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (

let y = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (let _160_314 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_wild ((FStar_Absyn_Util.bvd_to_bvar_s y FStar_Absyn_Syntax.tun))))
in ((loc), (env), (VBinder (((x), (FStar_Absyn_Syntax.tun), (None)))), (_160_314), (false)))))
end
| FStar_Parser_AST.PatConst (c) -> begin
(

let x = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (let _160_315 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_constant (c)))
in ((loc), (env), (VBinder (((x), (FStar_Absyn_Syntax.tun), (None)))), (_160_315), (false))))
end
| FStar_Parser_AST.PatVar (x, aq) -> begin
(

let imp = (aq = Some (FStar_Parser_AST.Implicit))
in (

let aq = (trans_aqual aq)
in (

let _63_957 = (resolvex loc env x)
in (match (_63_957) with
| (loc, env, xbvd) -> begin
(let _160_316 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_var ((FStar_Absyn_Util.bvd_to_bvar_s xbvd FStar_Absyn_Syntax.tun))))
in ((loc), (env), (VBinder (((xbvd), (FStar_Absyn_Syntax.tun), (aq)))), (_160_316), (imp)))
end))))
end
| FStar_Parser_AST.PatName (l) -> begin
(

let l = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_datacon env) l)
in (

let x = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (let _160_317 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_cons (((l), (Some (FStar_Absyn_Syntax.Data_ctor)), ([])))))
in ((loc), (env), (VBinder (((x), (FStar_Absyn_Syntax.tun), (None)))), (_160_317), (false)))))
end
| FStar_Parser_AST.PatApp ({FStar_Parser_AST.pat = FStar_Parser_AST.PatName (l); FStar_Parser_AST.prange = _63_963}, args) -> begin
(

let _63_985 = (FStar_List.fold_right (fun arg _63_974 -> (match (_63_974) with
| (loc, env, args) -> begin
(

let _63_981 = (aux loc env arg)
in (match (_63_981) with
| (loc, env, _63_978, arg, imp) -> begin
((loc), (env), ((((arg), (imp)))::args))
end))
end)) args ((loc), (env), ([])))
in (match (_63_985) with
| (loc, env, args) -> begin
(

let l = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_datacon env) l)
in (

let x = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (let _160_320 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_cons (((l), (Some (FStar_Absyn_Syntax.Data_ctor)), (args)))))
in ((loc), (env), (VBinder (((x), (FStar_Absyn_Syntax.tun), (None)))), (_160_320), (false)))))
end))
end
| FStar_Parser_AST.PatApp (_63_989) -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected pattern"), (p.FStar_Parser_AST.prange)))))
end
| FStar_Parser_AST.PatList (pats) -> begin
(

let _63_1009 = (FStar_List.fold_right (fun pat _63_997 -> (match (_63_997) with
| (loc, env, pats) -> begin
(

let _63_1005 = (aux loc env pat)
in (match (_63_1005) with
| (loc, env, _63_1001, pat, _63_1004) -> begin
((loc), (env), ((pat)::pats))
end))
end)) pats ((loc), (env), ([])))
in (match (_63_1009) with
| (loc, env, pats) -> begin
(

let pat = (let _160_327 = (let _160_326 = (let _160_325 = (FStar_Range.end_range p.FStar_Parser_AST.prange)
in (pos_r _160_325))
in (FStar_All.pipe_left _160_326 (FStar_Absyn_Syntax.Pat_cons ((((FStar_Absyn_Util.fv FStar_Absyn_Const.nil_lid)), (Some (FStar_Absyn_Syntax.Data_ctor)), ([]))))))
in (FStar_List.fold_right (fun hd tl -> (

let r = (FStar_Range.union_ranges hd.FStar_Absyn_Syntax.p tl.FStar_Absyn_Syntax.p)
in (FStar_All.pipe_left (pos_r r) (FStar_Absyn_Syntax.Pat_cons ((((FStar_Absyn_Util.fv FStar_Absyn_Const.cons_lid)), (Some (FStar_Absyn_Syntax.Data_ctor)), ((((hd), (false)))::(((tl), (false)))::[]))))))) pats _160_327))
in (

let x = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in ((loc), (env), (VBinder (((x), (FStar_Absyn_Syntax.tun), (None)))), (pat), (false))))
end))
end
| FStar_Parser_AST.PatTuple (args, dep) -> begin
(

let _63_1035 = (FStar_List.fold_left (fun _63_1022 p -> (match (_63_1022) with
| (loc, env, pats) -> begin
(

let _63_1031 = (aux loc env p)
in (match (_63_1031) with
| (loc, env, _63_1027, pat, _63_1030) -> begin
((loc), (env), ((((pat), (false)))::pats))
end))
end)) ((loc), (env), ([])) args)
in (match (_63_1035) with
| (loc, env, args) -> begin
(

let args = (FStar_List.rev args)
in (

let l = if dep then begin
(FStar_Absyn_Util.mk_dtuple_data_lid (FStar_List.length args) p.FStar_Parser_AST.prange)
end else begin
(FStar_Absyn_Util.mk_tuple_data_lid (FStar_List.length args) p.FStar_Parser_AST.prange)
end
in (

let constr = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_lid env) l)
in (

let l = (match (constr.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_fvar (v, _63_1041) -> begin
v
end
| _63_1045 -> begin
(FStar_All.failwith "impossible")
end)
in (

let x = (FStar_Absyn_Util.new_bvd (Some (p.FStar_Parser_AST.prange)))
in (let _160_330 = (FStar_All.pipe_left pos (FStar_Absyn_Syntax.Pat_cons (((l), (Some (FStar_Absyn_Syntax.Data_ctor)), (args)))))
in ((loc), (env), (VBinder (((x), (FStar_Absyn_Syntax.tun), (None)))), (_160_330), (false))))))))
end))
end
| FStar_Parser_AST.PatRecord ([]) -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected pattern"), (p.FStar_Parser_AST.prange)))))
end
| FStar_Parser_AST.PatRecord (fields) -> begin
(

let _63_1055 = (FStar_List.hd fields)
in (match (_63_1055) with
| (f, _63_1054) -> begin
(

let _63_1059 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_record_by_field_name env) f)
in (match (_63_1059) with
| (record, _63_1058) -> begin
(

let fields = (FStar_All.pipe_right fields (FStar_List.map (fun _63_1062 -> (match (_63_1062) with
| (f, p) -> begin
(let _160_332 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.qualify_field_to_record env record) f)
in ((_160_332), (p)))
end))))
in (

let args = (FStar_All.pipe_right record.FStar_Parser_DesugarEnv.fields (FStar_List.map (fun _63_1067 -> (match (_63_1067) with
| (f, _63_1066) -> begin
(match ((FStar_All.pipe_right fields (FStar_List.tryFind (fun _63_1071 -> (match (_63_1071) with
| (g, _63_1070) -> begin
(FStar_Ident.lid_equals f g)
end))))) with
| None -> begin
(FStar_Parser_AST.mk_pattern FStar_Parser_AST.PatWild p.FStar_Parser_AST.prange)
end
| Some (_63_1074, p) -> begin
p
end)
end))))
in (

let app = (FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatApp ((((FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatName (record.FStar_Parser_DesugarEnv.constrname)) p.FStar_Parser_AST.prange)), (args)))) p.FStar_Parser_AST.prange)
in (

let _63_1086 = (aux loc env app)
in (match (_63_1086) with
| (env, e, b, p, _63_1085) -> begin
(

let p = (match (p.FStar_Absyn_Syntax.v) with
| FStar_Absyn_Syntax.Pat_cons (fv, _63_1089, args) -> begin
(let _160_340 = (let _160_339 = (let _160_338 = (let _160_337 = (let _160_336 = (let _160_335 = (FStar_All.pipe_right record.FStar_Parser_DesugarEnv.fields (FStar_List.map Prims.fst))
in ((record.FStar_Parser_DesugarEnv.typename), (_160_335)))
in FStar_Absyn_Syntax.Record_ctor (_160_336))
in Some (_160_337))
in ((fv), (_160_338), (args)))
in FStar_Absyn_Syntax.Pat_cons (_160_339))
in (FStar_All.pipe_left pos _160_340))
end
| _63_1094 -> begin
p
end)
in ((env), (e), (b), (p), (false)))
end)))))
end))
end))
end))))
in (

let _63_1103 = (aux [] env p)
in (match (_63_1103) with
| (_63_1097, env, b, p, _63_1102) -> begin
((env), (b), (p))
end))))))
and desugar_binding_pat_maybe_top : Prims.bool  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.pattern  ->  (env_t * bnd * FStar_Absyn_Syntax.pat Prims.option) = (fun top env p -> if top then begin
(match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatVar (x, _63_1109) -> begin
(let _160_346 = (let _160_345 = (let _160_344 = (FStar_Parser_DesugarEnv.qualify env x)
in ((_160_344), (FStar_Absyn_Syntax.tun)))
in LetBinder (_160_345))
in ((env), (_160_346), (None)))
end
| FStar_Parser_AST.PatAscribed ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (x, _63_1116); FStar_Parser_AST.prange = _63_1113}, t) -> begin
(let _160_350 = (let _160_349 = (let _160_348 = (FStar_Parser_DesugarEnv.qualify env x)
in (let _160_347 = (desugar_typ env t)
in ((_160_348), (_160_347))))
in LetBinder (_160_349))
in ((env), (_160_350), (None)))
end
| _63_1124 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected pattern at the top-level"), (p.FStar_Parser_AST.prange)))))
end)
end else begin
(

let _63_1128 = (desugar_data_pat env p)
in (match (_63_1128) with
| (env, binder, p) -> begin
(

let p = (match (p.FStar_Absyn_Syntax.v) with
| (FStar_Absyn_Syntax.Pat_var (_)) | (FStar_Absyn_Syntax.Pat_tvar (_)) | (FStar_Absyn_Syntax.Pat_wild (_)) -> begin
None
end
| _63_1139 -> begin
Some (p)
end)
in ((env), (binder), (p)))
end))
end)
and desugar_binding_pat : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.pattern  ->  (env_t * bnd * FStar_Absyn_Syntax.pat Prims.option) = (fun env p -> (desugar_binding_pat_maybe_top false env p))
and desugar_match_pat_maybe_top : Prims.bool  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.pattern  ->  (env_t * FStar_Absyn_Syntax.pat) = (fun _63_1143 env pat -> (

let _63_1151 = (desugar_data_pat env pat)
in (match (_63_1151) with
| (env, _63_1149, pat) -> begin
((env), (pat))
end)))
and desugar_match_pat : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.pattern  ->  (env_t * FStar_Absyn_Syntax.pat) = (fun env p -> (desugar_match_pat_maybe_top false env p))
and desugar_typ_or_exp : env_t  ->  FStar_Parser_AST.term  ->  (FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) FStar_Util.either = (fun env t -> if (is_type env t) then begin
(let _160_360 = (desugar_typ env t)
in FStar_Util.Inl (_160_360))
end else begin
(let _160_361 = (desugar_exp env t)
in FStar_Util.Inr (_160_361))
end)
and desugar_exp : env_t  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.exp = (fun env e -> (desugar_exp_maybe_top false env e))
and desugar_name : (FStar_Absyn_Syntax.exp  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax)  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Ident.lident  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun setpos env l -> if (l.FStar_Ident.str = "ref") then begin
(match ((FStar_Parser_DesugarEnv.try_lookup_lid env FStar_Absyn_Const.alloc_lid)) with
| None -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Identifier \'ref\' not found; include lib/FStar.ST.fst in your path"), ((FStar_Ident.range_of_lid l))))))
end
| Some (e) -> begin
(setpos e)
end)
end else begin
(let _160_370 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_lid env) l)
in (FStar_All.pipe_left setpos _160_370))
end)
and desugar_exp_maybe_top : Prims.bool  ->  env_t  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.exp = (fun top_level env top -> (

let pos = (fun e -> (e None top.FStar_Parser_AST.range))
in (

let setpos = (fun e -> (

let _63_1171 = e
in {FStar_Absyn_Syntax.n = _63_1171.FStar_Absyn_Syntax.n; FStar_Absyn_Syntax.tk = _63_1171.FStar_Absyn_Syntax.tk; FStar_Absyn_Syntax.pos = top.FStar_Parser_AST.range; FStar_Absyn_Syntax.fvs = _63_1171.FStar_Absyn_Syntax.fvs; FStar_Absyn_Syntax.uvs = _63_1171.FStar_Absyn_Syntax.uvs}))
in (match ((let _160_388 = (unparen top)
in _160_388.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Const (c) -> begin
(FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Exp_constant c))
end
| FStar_Parser_AST.Op (s, args) -> begin
(match ((op_as_vlid env (FStar_List.length args) top.FStar_Parser_AST.range s)) with
| None -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((((Prims.strcat "Unexpected operator: " s)), (top.FStar_Parser_AST.range)))))
end
| Some (l) -> begin
(

let op = (FStar_Absyn_Util.fvar None l (FStar_Ident.range_of_lid l))
in (

let args = (FStar_All.pipe_right args (FStar_List.map (fun t -> (let _160_392 = (desugar_typ_or_exp env t)
in ((_160_392), (None))))))
in (let _160_393 = (FStar_Absyn_Util.mk_exp_app op args)
in (FStar_All.pipe_left setpos _160_393))))
end)
end
| (FStar_Parser_AST.Var (l)) | (FStar_Parser_AST.Name (l)) -> begin
(desugar_name setpos env l)
end
| FStar_Parser_AST.Construct (l, args) -> begin
(

let dt = (let _160_398 = (let _160_397 = (let _160_396 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_datacon env) l)
in ((_160_396), (Some (FStar_Absyn_Syntax.Data_ctor))))
in (FStar_Absyn_Syntax.mk_Exp_fvar _160_397))
in (FStar_All.pipe_left pos _160_398))
in (match (args) with
| [] -> begin
dt
end
| _63_1195 -> begin
(

let args = (FStar_List.map (fun _63_1198 -> (match (_63_1198) with
| (t, imp) -> begin
(

let te = (desugar_typ_or_exp env t)
in (arg_withimp_e imp te))
end)) args)
in (let _160_403 = (let _160_402 = (let _160_401 = (let _160_400 = (FStar_Absyn_Util.mk_exp_app dt args)
in ((_160_400), (FStar_Absyn_Syntax.Data_app)))
in FStar_Absyn_Syntax.Meta_desugared (_160_401))
in (FStar_Absyn_Syntax.mk_Exp_meta _160_402))
in (FStar_All.pipe_left setpos _160_403)))
end))
end
| FStar_Parser_AST.Abs (binders, body) -> begin
(

let _63_1235 = (FStar_List.fold_left (fun _63_1207 pat -> (match (_63_1207) with
| (env, ftvs) -> begin
(match (pat.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed ({FStar_Parser_AST.pat = FStar_Parser_AST.PatTvar (a, imp); FStar_Parser_AST.prange = _63_1210}, t) -> begin
(

let ftvs = (let _160_406 = (free_type_vars env t)
in (FStar_List.append _160_406 ftvs))
in (let _160_408 = (let _160_407 = (FStar_Parser_DesugarEnv.push_local_tbinding env a)
in (FStar_All.pipe_left Prims.fst _160_407))
in ((_160_408), (ftvs))))
end
| FStar_Parser_AST.PatTvar (a, _63_1222) -> begin
(let _160_410 = (let _160_409 = (FStar_Parser_DesugarEnv.push_local_tbinding env a)
in (FStar_All.pipe_left Prims.fst _160_409))
in ((_160_410), (ftvs)))
end
| FStar_Parser_AST.PatAscribed (_63_1226, t) -> begin
(let _160_412 = (let _160_411 = (free_type_vars env t)
in (FStar_List.append _160_411 ftvs))
in ((env), (_160_412)))
end
| _63_1231 -> begin
((env), (ftvs))
end)
end)) ((env), ([])) binders)
in (match (_63_1235) with
| (_63_1233, ftv) -> begin
(

let ftv = (sort_ftv ftv)
in (

let binders = (let _160_414 = (FStar_All.pipe_right ftv (FStar_List.map (fun a -> (FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatTvar (((a), (Some (FStar_Parser_AST.Implicit))))) top.FStar_Parser_AST.range))))
in (FStar_List.append _160_414 binders))
in (

let rec aux = (fun env bs sc_pat_opt _63_8 -> (match (_63_8) with
| [] -> begin
(

let body = (desugar_exp env body)
in (

let body = (match (sc_pat_opt) with
| Some (sc, pat) -> begin
(FStar_Absyn_Syntax.mk_Exp_match ((sc), ((((pat), (None), (body)))::[])) None body.FStar_Absyn_Syntax.pos)
end
| None -> begin
body
end)
in (FStar_Absyn_Syntax.mk_Exp_abs' (((FStar_List.rev bs)), (body)) None top.FStar_Parser_AST.range)))
end
| (p)::rest -> begin
(

let _63_1258 = (desugar_binding_pat env p)
in (match (_63_1258) with
| (env, b, pat) -> begin
(

let _63_1318 = (match (b) with
| LetBinder (_63_1260) -> begin
(FStar_All.failwith "Impossible")
end
| TBinder (a, k, aq) -> begin
(let _160_423 = (binder_of_bnd b)
in ((_160_423), (sc_pat_opt)))
end
| VBinder (x, t, aq) -> begin
(

let b = (FStar_Absyn_Util.bvd_to_bvar_s x t)
in (

let sc_pat_opt = (match (((pat), (sc_pat_opt))) with
| (None, _63_1275) -> begin
sc_pat_opt
end
| (Some (p), None) -> begin
(let _160_425 = (let _160_424 = (FStar_Absyn_Util.bvar_to_exp b)
in ((_160_424), (p)))
in Some (_160_425))
end
| (Some (p), Some (sc, p')) -> begin
(match (((sc.FStar_Absyn_Syntax.n), (p'.FStar_Absyn_Syntax.v))) with
| (FStar_Absyn_Syntax.Exp_bvar (_63_1289), _63_1292) -> begin
(

let tup = (FStar_Absyn_Util.mk_tuple_data_lid (Prims.parse_int "2") top.FStar_Parser_AST.range)
in (

let sc = (let _160_432 = (let _160_431 = (FStar_Absyn_Util.fvar (Some (FStar_Absyn_Syntax.Data_ctor)) tup top.FStar_Parser_AST.range)
in (let _160_430 = (let _160_429 = (FStar_Absyn_Syntax.varg sc)
in (let _160_428 = (let _160_427 = (let _160_426 = (FStar_Absyn_Util.bvar_to_exp b)
in (FStar_All.pipe_left FStar_Absyn_Syntax.varg _160_426))
in (_160_427)::[])
in (_160_429)::_160_428))
in ((_160_431), (_160_430))))
in (FStar_Absyn_Syntax.mk_Exp_app _160_432 None top.FStar_Parser_AST.range))
in (

let p = (let _160_433 = (FStar_Range.union_ranges p'.FStar_Absyn_Syntax.p p.FStar_Absyn_Syntax.p)
in (FStar_Absyn_Util.withinfo (FStar_Absyn_Syntax.Pat_cons ((((FStar_Absyn_Util.fv tup)), (Some (FStar_Absyn_Syntax.Data_ctor)), ((((p'), (false)))::(((p), (false)))::[])))) None _160_433))
in Some (((sc), (p))))))
end
| (FStar_Absyn_Syntax.Exp_app (_63_1298, args), FStar_Absyn_Syntax.Pat_cons (_63_1303, _63_1305, pats)) -> begin
(

let tup = (FStar_Absyn_Util.mk_tuple_data_lid ((Prims.parse_int "1") + (FStar_List.length args)) top.FStar_Parser_AST.range)
in (

let sc = (let _160_439 = (let _160_438 = (FStar_Absyn_Util.fvar (Some (FStar_Absyn_Syntax.Data_ctor)) tup top.FStar_Parser_AST.range)
in (let _160_437 = (let _160_436 = (let _160_435 = (let _160_434 = (FStar_Absyn_Util.bvar_to_exp b)
in (FStar_All.pipe_left FStar_Absyn_Syntax.varg _160_434))
in (_160_435)::[])
in (FStar_List.append args _160_436))
in ((_160_438), (_160_437))))
in (FStar_Absyn_Syntax.mk_Exp_app _160_439 None top.FStar_Parser_AST.range))
in (

let p = (let _160_440 = (FStar_Range.union_ranges p'.FStar_Absyn_Syntax.p p.FStar_Absyn_Syntax.p)
in (FStar_Absyn_Util.withinfo (FStar_Absyn_Syntax.Pat_cons ((((FStar_Absyn_Util.fv tup)), (Some (FStar_Absyn_Syntax.Data_ctor)), ((FStar_List.append pats ((((p), (false)))::[])))))) None _160_440))
in Some (((sc), (p))))))
end
| _63_1314 -> begin
(FStar_All.failwith "Impossible")
end)
end)
in ((((FStar_Util.Inr (b)), (aq))), (sc_pat_opt))))
end)
in (match (_63_1318) with
| (b, sc_pat_opt) -> begin
(aux env ((b)::bs) sc_pat_opt rest)
end))
end))
end))
in (aux env [] None binders))))
end))
end
| FStar_Parser_AST.App ({FStar_Parser_AST.tm = FStar_Parser_AST.Var (a); FStar_Parser_AST.range = _63_1322; FStar_Parser_AST.level = _63_1320}, arg, _63_1328) when ((FStar_Ident.lid_equals a FStar_Absyn_Const.assert_lid) || (FStar_Ident.lid_equals a FStar_Absyn_Const.assume_lid)) -> begin
(

let phi = (desugar_formula env arg)
in (let _160_450 = (let _160_449 = (let _160_448 = (FStar_Absyn_Util.fvar None a (FStar_Ident.range_of_lid a))
in (let _160_447 = (let _160_446 = (FStar_All.pipe_left FStar_Absyn_Syntax.targ phi)
in (let _160_445 = (let _160_444 = (let _160_443 = (FStar_Absyn_Syntax.mk_Exp_constant FStar_Const.Const_unit None top.FStar_Parser_AST.range)
in (FStar_All.pipe_left FStar_Absyn_Syntax.varg _160_443))
in (_160_444)::[])
in (_160_446)::_160_445))
in ((_160_448), (_160_447))))
in (FStar_Absyn_Syntax.mk_Exp_app _160_449))
in (FStar_All.pipe_left pos _160_450)))
end
| FStar_Parser_AST.App (_63_1333) -> begin
(

let rec aux = (fun args e -> (match ((let _160_455 = (unparen e)
in _160_455.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App (e, t, imp) -> begin
(

let arg = (let _160_456 = (desugar_typ_or_exp env t)
in (FStar_All.pipe_left (arg_withimp_e imp) _160_456))
in (aux ((arg)::args) e))
end
| _63_1345 -> begin
(

let head = (desugar_exp env e)
in (FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Exp_app ((head), (args)))))
end))
in (aux [] top))
end
| FStar_Parser_AST.Seq (t1, t2) -> begin
(let _160_462 = (let _160_461 = (let _160_460 = (let _160_459 = (desugar_exp env (FStar_Parser_AST.mk_term (FStar_Parser_AST.Let (((FStar_Parser_AST.NoLetQualifier), (((((FStar_Parser_AST.mk_pattern FStar_Parser_AST.PatWild t1.FStar_Parser_AST.range)), (t1)))::[]), (t2)))) top.FStar_Parser_AST.range FStar_Parser_AST.Expr))
in ((_160_459), (FStar_Absyn_Syntax.Sequence)))
in FStar_Absyn_Syntax.Meta_desugared (_160_460))
in (FStar_Absyn_Syntax.mk_Exp_meta _160_461))
in (FStar_All.pipe_left setpos _160_462))
end
| FStar_Parser_AST.LetOpen (_63_1352) -> begin
(FStar_All.failwith "let open in universes")
end
| FStar_Parser_AST.Let (is_rec, ((pat, _snd))::_tl, body) -> begin
(

let is_rec = (is_rec = FStar_Parser_AST.Rec)
in (

let ds_let_rec = (fun _63_1365 -> (match (()) with
| () -> begin
(

let bindings = (((pat), (_snd)))::_tl
in (

let funs = (FStar_All.pipe_right bindings (FStar_List.map (fun _63_1369 -> (match (_63_1369) with
| (p, def) -> begin
if (is_app_pattern p) then begin
(let _160_466 = (destruct_app_pattern env top_level p)
in ((_160_466), (def)))
end else begin
(match ((FStar_Parser_AST.un_function p def)) with
| Some (p, def) -> begin
(let _160_467 = (destruct_app_pattern env top_level p)
in ((_160_467), (def)))
end
| _63_1375 -> begin
(match (p.FStar_Parser_AST.pat) with
| FStar_Parser_AST.PatAscribed ({FStar_Parser_AST.pat = FStar_Parser_AST.PatVar (id, _63_1380); FStar_Parser_AST.prange = _63_1377}, t) -> begin
if top_level then begin
(let _160_470 = (let _160_469 = (let _160_468 = (FStar_Parser_DesugarEnv.qualify env id)
in FStar_Util.Inr (_160_468))
in ((_160_469), ([]), (Some (t))))
in ((_160_470), (def)))
end else begin
((((FStar_Util.Inl (id)), ([]), (Some (t)))), (def))
end
end
| FStar_Parser_AST.PatVar (id, _63_1389) -> begin
if top_level then begin
(let _160_473 = (let _160_472 = (let _160_471 = (FStar_Parser_DesugarEnv.qualify env id)
in FStar_Util.Inr (_160_471))
in ((_160_472), ([]), (None)))
in ((_160_473), (def)))
end else begin
((((FStar_Util.Inl (id)), ([]), (None))), (def))
end
end
| _63_1393 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected let binding"), (p.FStar_Parser_AST.prange)))))
end)
end)
end
end))))
in (

let _63_1419 = (FStar_List.fold_left (fun _63_1397 _63_1406 -> (match (((_63_1397), (_63_1406))) with
| ((env, fnames), ((f, _63_1400, _63_1402), _63_1405)) -> begin
(

let _63_1416 = (match (f) with
| FStar_Util.Inl (x) -> begin
(

let _63_1411 = (FStar_Parser_DesugarEnv.push_local_vbinding env x)
in (match (_63_1411) with
| (env, xx) -> begin
((env), (FStar_Util.Inl (xx)))
end))
end
| FStar_Util.Inr (l) -> begin
(let _160_476 = (FStar_Parser_DesugarEnv.push_rec_binding env (FStar_Parser_DesugarEnv.Binding_let (l)))
in ((_160_476), (FStar_Util.Inr (l))))
end)
in (match (_63_1416) with
| (env, lbname) -> begin
((env), ((lbname)::fnames))
end))
end)) ((env), ([])) funs)
in (match (_63_1419) with
| (env', fnames) -> begin
(

let fnames = (FStar_List.rev fnames)
in (

let desugar_one_def = (fun env lbname _63_1430 -> (match (_63_1430) with
| ((_63_1425, args, result_t), def) -> begin
(

let def = (match (result_t) with
| None -> begin
def
end
| Some (t) -> begin
(let _160_483 = (FStar_Range.union_ranges t.FStar_Parser_AST.range def.FStar_Parser_AST.range)
in (FStar_Parser_AST.mk_term (FStar_Parser_AST.Ascribed (((def), (t)))) _160_483 FStar_Parser_AST.Expr))
end)
in (

let def = (match (args) with
| [] -> begin
def
end
| _63_1437 -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.un_curry_abs args def) top.FStar_Parser_AST.range top.FStar_Parser_AST.level)
end)
in (

let body = (desugar_exp env def)
in (mk_lb ((lbname), (FStar_Absyn_Syntax.tun), (body))))))
end))
in (

let lbs = (FStar_List.map2 (desugar_one_def (if is_rec then begin
env'
end else begin
env
end)) fnames funs)
in (

let body = (desugar_exp env' body)
in (FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Exp_let ((((is_rec), (lbs))), (body))))))))
end))))
end))
in (

let ds_non_rec = (fun pat t1 t2 -> (

let t1 = (desugar_exp env t1)
in (

let _63_1450 = (desugar_binding_pat_maybe_top top_level env pat)
in (match (_63_1450) with
| (env, binder, pat) -> begin
(match (binder) with
| TBinder (_63_1452) -> begin
(FStar_All.failwith "Unexpected type binder in let")
end
| LetBinder (l, t) -> begin
(

let body = (desugar_exp env t2)
in (FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Exp_let ((((false), (({FStar_Absyn_Syntax.lbname = FStar_Util.Inr (l); FStar_Absyn_Syntax.lbtyp = t; FStar_Absyn_Syntax.lbeff = FStar_Absyn_Const.effect_ALL_lid; FStar_Absyn_Syntax.lbdef = t1})::[]))), (body)))))
end
| VBinder (x, t, _63_1462) -> begin
(

let body = (desugar_exp env t2)
in (

let body = (match (pat) with
| (None) | (Some ({FStar_Absyn_Syntax.v = FStar_Absyn_Syntax.Pat_wild (_); FStar_Absyn_Syntax.sort = _; FStar_Absyn_Syntax.p = _})) -> begin
body
end
| Some (pat) -> begin
(let _160_495 = (let _160_494 = (FStar_Absyn_Util.bvd_to_exp x t)
in ((_160_494), ((((pat), (None), (body)))::[])))
in (FStar_Absyn_Syntax.mk_Exp_match _160_495 None body.FStar_Absyn_Syntax.pos))
end)
in (FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Exp_let ((((false), (((mk_lb ((FStar_Util.Inl (x)), (t), (t1))))::[]))), (body))))))
end)
end))))
in if (is_rec || (is_app_pattern pat)) then begin
(ds_let_rec ())
end else begin
(ds_non_rec pat _snd body)
end)))
end
| FStar_Parser_AST.If (t1, t2, t3) -> begin
(let _160_508 = (let _160_507 = (let _160_506 = (desugar_exp env t1)
in (let _160_505 = (let _160_504 = (let _160_500 = (desugar_exp env t2)
in (((FStar_Absyn_Util.withinfo (FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (true))) None t2.FStar_Parser_AST.range)), (None), (_160_500)))
in (let _160_503 = (let _160_502 = (let _160_501 = (desugar_exp env t3)
in (((FStar_Absyn_Util.withinfo (FStar_Absyn_Syntax.Pat_constant (FStar_Const.Const_bool (false))) None t3.FStar_Parser_AST.range)), (None), (_160_501)))
in (_160_502)::[])
in (_160_504)::_160_503))
in ((_160_506), (_160_505))))
in (FStar_Absyn_Syntax.mk_Exp_match _160_507))
in (FStar_All.pipe_left pos _160_508))
end
| FStar_Parser_AST.TryWith (e, branches) -> begin
(

let r = top.FStar_Parser_AST.range
in (

let handler = (FStar_Parser_AST.mk_function branches r r)
in (

let body = (FStar_Parser_AST.mk_function (((((FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatConst (FStar_Const.Const_unit)) r)), (None), (e)))::[]) r r)
in (

let a1 = (FStar_Parser_AST.mk_term (FStar_Parser_AST.App ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Var (FStar_Absyn_Const.try_with_lid)) r top.FStar_Parser_AST.level)), (body), (FStar_Parser_AST.Nothing)))) r top.FStar_Parser_AST.level)
in (

let a2 = (FStar_Parser_AST.mk_term (FStar_Parser_AST.App (((a1), (handler), (FStar_Parser_AST.Nothing)))) r top.FStar_Parser_AST.level)
in (desugar_exp env a2))))))
end
| FStar_Parser_AST.Match (e, branches) -> begin
(

let desugar_branch = (fun _63_1501 -> (match (_63_1501) with
| (pat, wopt, b) -> begin
(

let _63_1504 = (desugar_match_pat env pat)
in (match (_63_1504) with
| (env, pat) -> begin
(

let wopt = (match (wopt) with
| None -> begin
None
end
| Some (e) -> begin
(let _160_511 = (desugar_exp env e)
in Some (_160_511))
end)
in (

let b = (desugar_exp env b)
in ((pat), (wopt), (b))))
end))
end))
in (let _160_517 = (let _160_516 = (let _160_515 = (desugar_exp env e)
in (let _160_514 = (FStar_List.map desugar_branch branches)
in ((_160_515), (_160_514))))
in (FStar_Absyn_Syntax.mk_Exp_match _160_516))
in (FStar_All.pipe_left pos _160_517)))
end
| FStar_Parser_AST.Ascribed (e, t) -> begin
(let _160_523 = (let _160_522 = (let _160_521 = (desugar_exp env e)
in (let _160_520 = (desugar_typ env t)
in ((_160_521), (_160_520), (None))))
in (FStar_Absyn_Syntax.mk_Exp_ascribed _160_522))
in (FStar_All.pipe_left pos _160_523))
end
| FStar_Parser_AST.Record (_63_1515, []) -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected empty record"), (top.FStar_Parser_AST.range)))))
end
| FStar_Parser_AST.Record (eopt, fields) -> begin
(

let _63_1526 = (FStar_List.hd fields)
in (match (_63_1526) with
| (f, _63_1525) -> begin
(

let qfn = (fun g -> (FStar_Ident.lid_of_ids (FStar_List.append f.FStar_Ident.ns ((g)::[]))))
in (

let _63_1532 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_record_by_field_name env) f)
in (match (_63_1532) with
| (record, _63_1531) -> begin
(

let get_field = (fun xopt f -> (

let fn = f.FStar_Ident.ident
in (

let found = (FStar_All.pipe_right fields (FStar_Util.find_opt (fun _63_1540 -> (match (_63_1540) with
| (g, _63_1539) -> begin
(

let gn = g.FStar_Ident.ident
in (fn.FStar_Ident.idText = gn.FStar_Ident.idText))
end))))
in (match (found) with
| Some (_63_1544, e) -> begin
(let _160_531 = (qfn fn)
in ((_160_531), (e)))
end
| None -> begin
(match (xopt) with
| None -> begin
(let _160_534 = (let _160_533 = (let _160_532 = (FStar_Util.format1 "Field %s is missing" (FStar_Ident.text_of_lid f))
in ((_160_532), (top.FStar_Parser_AST.range)))
in FStar_Absyn_Syntax.Error (_160_533))
in (Prims.raise _160_534))
end
| Some (x) -> begin
(let _160_535 = (qfn fn)
in ((_160_535), ((FStar_Parser_AST.mk_term (FStar_Parser_AST.Project (((x), (f)))) x.FStar_Parser_AST.range x.FStar_Parser_AST.level))))
end)
end))))
in (

let recterm = (match (eopt) with
| None -> begin
(let _160_540 = (let _160_539 = (FStar_All.pipe_right record.FStar_Parser_DesugarEnv.fields (FStar_List.map (fun _63_1556 -> (match (_63_1556) with
| (f, _63_1555) -> begin
(let _160_538 = (let _160_537 = (get_field None f)
in (FStar_All.pipe_left Prims.snd _160_537))
in ((_160_538), (FStar_Parser_AST.Nothing)))
end))))
in ((record.FStar_Parser_DesugarEnv.constrname), (_160_539)))
in FStar_Parser_AST.Construct (_160_540))
end
| Some (e) -> begin
(

let x = (FStar_Absyn_Util.genident (Some (e.FStar_Parser_AST.range)))
in (

let xterm = (let _160_542 = (let _160_541 = (FStar_Ident.lid_of_ids ((x)::[]))
in FStar_Parser_AST.Var (_160_541))
in (FStar_Parser_AST.mk_term _160_542 x.FStar_Ident.idRange FStar_Parser_AST.Expr))
in (

let record = (let _160_545 = (let _160_544 = (FStar_All.pipe_right record.FStar_Parser_DesugarEnv.fields (FStar_List.map (fun _63_1564 -> (match (_63_1564) with
| (f, _63_1563) -> begin
(get_field (Some (xterm)) f)
end))))
in ((None), (_160_544)))
in FStar_Parser_AST.Record (_160_545))
in FStar_Parser_AST.Let (((FStar_Parser_AST.NoLetQualifier), (((((FStar_Parser_AST.mk_pattern (FStar_Parser_AST.PatVar (((x), (None)))) x.FStar_Ident.idRange)), (e)))::[]), ((FStar_Parser_AST.mk_term record top.FStar_Parser_AST.range top.FStar_Parser_AST.level)))))))
end)
in (

let recterm = (FStar_Parser_AST.mk_term recterm top.FStar_Parser_AST.range top.FStar_Parser_AST.level)
in (

let e = (desugar_exp env recterm)
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_meta (FStar_Absyn_Syntax.Meta_desugared ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_fvar (fv, _63_1587); FStar_Absyn_Syntax.tk = _63_1584; FStar_Absyn_Syntax.pos = _63_1582; FStar_Absyn_Syntax.fvs = _63_1580; FStar_Absyn_Syntax.uvs = _63_1578}, args); FStar_Absyn_Syntax.tk = _63_1576; FStar_Absyn_Syntax.pos = _63_1574; FStar_Absyn_Syntax.fvs = _63_1572; FStar_Absyn_Syntax.uvs = _63_1570}, FStar_Absyn_Syntax.Data_app)) -> begin
(

let e = (let _160_555 = (let _160_554 = (let _160_553 = (let _160_552 = (let _160_551 = (let _160_550 = (let _160_549 = (let _160_548 = (FStar_All.pipe_right record.FStar_Parser_DesugarEnv.fields (FStar_List.map Prims.fst))
in ((record.FStar_Parser_DesugarEnv.typename), (_160_548)))
in FStar_Absyn_Syntax.Record_ctor (_160_549))
in Some (_160_550))
in ((fv), (_160_551)))
in (FStar_Absyn_Syntax.mk_Exp_fvar _160_552 None e.FStar_Absyn_Syntax.pos))
in ((_160_553), (args)))
in (FStar_Absyn_Syntax.mk_Exp_app _160_554))
in (FStar_All.pipe_left pos _160_555))
in (FStar_Absyn_Syntax.mk_Exp_meta (FStar_Absyn_Syntax.Meta_desugared (((e), (FStar_Absyn_Syntax.Data_app))))))
end
| _63_1601 -> begin
e
end)))))
end)))
end))
end
| FStar_Parser_AST.Project (e, f) -> begin
(

let _63_1608 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_projector_by_field_name env) f)
in (match (_63_1608) with
| (fieldname, is_rec) -> begin
(

let e = (desugar_exp env e)
in (

let fn = (

let _63_1613 = (FStar_Util.prefix fieldname.FStar_Ident.ns)
in (match (_63_1613) with
| (ns, _63_1612) -> begin
(FStar_Ident.lid_of_ids (FStar_List.append ns ((f.FStar_Ident.ident)::[])))
end))
in (

let qual = if is_rec then begin
Some (FStar_Absyn_Syntax.Record_projector (fn))
end else begin
None
end
in (let _160_562 = (let _160_561 = (let _160_560 = (FStar_Absyn_Util.fvar qual fieldname (FStar_Ident.range_of_lid f))
in (let _160_559 = (let _160_558 = (FStar_Absyn_Syntax.varg e)
in (_160_558)::[])
in ((_160_560), (_160_559))))
in (FStar_Absyn_Syntax.mk_Exp_app _160_561))
in (FStar_All.pipe_left pos _160_562)))))
end))
end
| FStar_Parser_AST.Paren (e) -> begin
(desugar_exp env e)
end
| FStar_Parser_AST.Projector (ns, id) -> begin
(

let l = (FStar_Parser_DesugarEnv.qual ns id)
in (desugar_name setpos env l))
end
| FStar_Parser_AST.Discrim (lid) -> begin
(

let lid' = (FStar_Absyn_Util.mk_discriminator lid)
in (desugar_name setpos env lid'))
end
| _63_1627 -> begin
(FStar_Parser_AST.error "Unexpected term" top top.FStar_Parser_AST.range)
end))))
and desugar_typ : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.typ = (fun env top -> (

let wpos = (fun t -> (t None top.FStar_Parser_AST.range))
in (

let setpos = (fun t -> (

let _63_1634 = t
in {FStar_Absyn_Syntax.n = _63_1634.FStar_Absyn_Syntax.n; FStar_Absyn_Syntax.tk = _63_1634.FStar_Absyn_Syntax.tk; FStar_Absyn_Syntax.pos = top.FStar_Parser_AST.range; FStar_Absyn_Syntax.fvs = _63_1634.FStar_Absyn_Syntax.fvs; FStar_Absyn_Syntax.uvs = _63_1634.FStar_Absyn_Syntax.uvs}))
in (

let top = (unparen top)
in (

let head_and_args = (fun t -> (

let rec aux = (fun args t -> (match ((let _160_585 = (unparen t)
in _160_585.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App (t, arg, imp) -> begin
(aux ((((arg), (imp)))::args) t)
end
| FStar_Parser_AST.Construct (l, args') -> begin
(({FStar_Parser_AST.tm = FStar_Parser_AST.Name (l); FStar_Parser_AST.range = t.FStar_Parser_AST.range; FStar_Parser_AST.level = t.FStar_Parser_AST.level}), ((FStar_List.append args' args)))
end
| _63_1652 -> begin
((t), (args))
end))
in (aux [] t)))
in (match (top.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Wild -> begin
(setpos FStar_Absyn_Syntax.tun)
end
| FStar_Parser_AST.Requires (t, lopt) -> begin
(

let t = (label_conjuncts "pre-condition" true lopt t)
in if (is_type env t) then begin
(desugar_typ env t)
end else begin
(let _160_586 = (desugar_exp env t)
in (FStar_All.pipe_right _160_586 FStar_Absyn_Util.b2t))
end)
end
| FStar_Parser_AST.Ensures (t, lopt) -> begin
(

let t = (label_conjuncts "post-condition" false lopt t)
in if (is_type env t) then begin
(desugar_typ env t)
end else begin
(let _160_587 = (desugar_exp env t)
in (FStar_All.pipe_right _160_587 FStar_Absyn_Util.b2t))
end)
end
| FStar_Parser_AST.Op ("*", (t1)::(_63_1666)::[]) -> begin
if (is_type env t1) then begin
(

let rec flatten = (fun t -> (match (t.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Op ("*", (t1)::(t2)::[]) -> begin
(let _160_590 = (flatten t1)
in (FStar_List.append _160_590 ((t2)::[])))
end
| _63_1680 -> begin
(t)::[]
end))
in (

let targs = (let _160_593 = (flatten top)
in (FStar_All.pipe_right _160_593 (FStar_List.map (fun t -> (let _160_592 = (desugar_typ env t)
in (FStar_Absyn_Syntax.targ _160_592))))))
in (

let tup = (let _160_594 = (FStar_Absyn_Util.mk_tuple_lid (FStar_List.length targs) top.FStar_Parser_AST.range)
in (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) _160_594))
in (FStar_All.pipe_left wpos (FStar_Absyn_Syntax.mk_Typ_app ((tup), (targs)))))))
end else begin
(let _160_600 = (let _160_599 = (let _160_598 = (let _160_597 = (FStar_Parser_AST.term_to_string t1)
in (FStar_Util.format1 "The operator \"*\" is resolved here as multiplication since \"%s\" is a term, although a type was expected" _160_597))
in ((_160_598), (top.FStar_Parser_AST.range)))
in FStar_Absyn_Syntax.Error (_160_599))
in (Prims.raise _160_600))
end
end
| FStar_Parser_AST.Op ("=!=", args) -> begin
(desugar_typ env (FStar_Parser_AST.mk_term (FStar_Parser_AST.Op ((("~"), (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Op ((("=="), (args)))) top.FStar_Parser_AST.range top.FStar_Parser_AST.level))::[])))) top.FStar_Parser_AST.range top.FStar_Parser_AST.level))
end
| FStar_Parser_AST.Op (s, args) -> begin
(match ((op_as_tylid env (FStar_List.length args) top.FStar_Parser_AST.range s)) with
| None -> begin
(let _160_601 = (desugar_exp env top)
in (FStar_All.pipe_right _160_601 FStar_Absyn_Util.b2t))
end
| Some (l) -> begin
(

let args = (FStar_List.map (fun t -> (let _160_603 = (desugar_typ_or_exp env t)
in (FStar_All.pipe_left (arg_withimp_t FStar_Parser_AST.Nothing) _160_603))) args)
in (let _160_604 = (FStar_Absyn_Util.ftv l FStar_Absyn_Syntax.kun)
in (FStar_Absyn_Util.mk_typ_app _160_604 args)))
end)
end
| FStar_Parser_AST.Tvar (a) -> begin
(let _160_605 = (FStar_Parser_DesugarEnv.fail_or2 (FStar_Parser_DesugarEnv.try_lookup_typ_var env) a)
in (FStar_All.pipe_left setpos _160_605))
end
| (FStar_Parser_AST.Var (l)) | (FStar_Parser_AST.Name (l)) when ((FStar_List.length l.FStar_Ident.ns) = (Prims.parse_int "0")) -> begin
(match ((FStar_Parser_DesugarEnv.try_lookup_typ_var env l.FStar_Ident.ident)) with
| Some (t) -> begin
(setpos t)
end
| None -> begin
(let _160_606 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) l)
in (FStar_All.pipe_left setpos _160_606))
end)
end
| (FStar_Parser_AST.Var (l)) | (FStar_Parser_AST.Name (l)) -> begin
(

let l = (FStar_Absyn_Util.set_lid_range l top.FStar_Parser_AST.range)
in (let _160_607 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) l)
in (FStar_All.pipe_left setpos _160_607)))
end
| FStar_Parser_AST.Construct (l, args) -> begin
(

let t = (let _160_608 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) l)
in (FStar_All.pipe_left setpos _160_608))
in (

let args = (FStar_List.map (fun _63_1716 -> (match (_63_1716) with
| (t, imp) -> begin
(let _160_610 = (desugar_typ_or_exp env t)
in (FStar_All.pipe_left (arg_withimp_t imp) _160_610))
end)) args)
in (FStar_Absyn_Util.mk_typ_app t args)))
end
| FStar_Parser_AST.Abs (binders, body) -> begin
(

let rec aux = (fun env bs _63_9 -> (match (_63_9) with
| [] -> begin
(

let body = (desugar_typ env body)
in (FStar_All.pipe_left wpos (FStar_Absyn_Syntax.mk_Typ_lam (((FStar_List.rev bs)), (body)))))
end
| (hd)::tl -> begin
(

let _63_1734 = (desugar_binding_pat env hd)
in (match (_63_1734) with
| (env, bnd, pat) -> begin
(match (pat) with
| Some (q) -> begin
(let _160_622 = (let _160_621 = (let _160_620 = (let _160_619 = (FStar_Absyn_Print.pat_to_string q)
in (FStar_Util.format1 "Pattern matching at the type level is not supported; got %s\n" _160_619))
in ((_160_620), (hd.FStar_Parser_AST.prange)))
in FStar_Absyn_Syntax.Error (_160_621))
in (Prims.raise _160_622))
end
| None -> begin
(

let b = (binder_of_bnd bnd)
in (aux env ((b)::bs) tl))
end)
end))
end))
in (aux env [] binders))
end
| FStar_Parser_AST.App (_63_1740) -> begin
(

let rec aux = (fun args e -> (match ((let _160_627 = (unparen e)
in _160_627.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App (e, arg, imp) -> begin
(

let arg = (let _160_628 = (desugar_typ_or_exp env arg)
in (FStar_All.pipe_left (arg_withimp_t imp) _160_628))
in (aux ((arg)::args) e))
end
| _63_1752 -> begin
(

let head = (desugar_typ env e)
in (FStar_All.pipe_left wpos (FStar_Absyn_Syntax.mk_Typ_app ((head), (args)))))
end))
in (aux [] top))
end
| FStar_Parser_AST.Product ([], t) -> begin
(FStar_All.failwith "Impossible: product with no binders")
end
| FStar_Parser_AST.Product (binders, t) -> begin
(

let _63_1764 = (uncurry binders t)
in (match (_63_1764) with
| (bs, t) -> begin
(

let rec aux = (fun env bs _63_10 -> (match (_63_10) with
| [] -> begin
(

let cod = (desugar_comp top.FStar_Parser_AST.range true env t)
in (FStar_All.pipe_left wpos (FStar_Absyn_Syntax.mk_Typ_fun (((FStar_List.rev bs)), (cod)))))
end
| (hd)::tl -> begin
(

let mlenv = (FStar_Parser_DesugarEnv.default_ml env)
in (

let bb = (desugar_binder mlenv hd)
in (

let _63_1778 = (as_binder env hd.FStar_Parser_AST.aqual bb)
in (match (_63_1778) with
| (b, env) -> begin
(aux env ((b)::bs) tl)
end))))
end))
in (aux env [] bs))
end))
end
| FStar_Parser_AST.Refine (b, f) -> begin
(match ((desugar_exp_binder env b)) with
| (None, _63_1785) -> begin
(FStar_All.failwith "Missing binder in refinement")
end
| b -> begin
(

let _63_1799 = (match ((as_binder env None (FStar_Util.Inr (b)))) with
| ((FStar_Util.Inr (x), _63_1791), env) -> begin
((x), (env))
end
| _63_1796 -> begin
(FStar_All.failwith "impossible")
end)
in (match (_63_1799) with
| (b, env) -> begin
(

let f = if (is_type env f) then begin
(desugar_formula env f)
end else begin
(let _160_639 = (desugar_exp env f)
in (FStar_All.pipe_right _160_639 FStar_Absyn_Util.b2t))
end
in (FStar_All.pipe_left wpos (FStar_Absyn_Syntax.mk_Typ_refine ((b), (f)))))
end))
end)
end
| (FStar_Parser_AST.NamedTyp (_, t)) | (FStar_Parser_AST.Paren (t)) -> begin
(desugar_typ env t)
end
| FStar_Parser_AST.Ascribed (t, k) -> begin
(let _160_647 = (let _160_646 = (let _160_645 = (desugar_typ env t)
in (let _160_644 = (desugar_kind env k)
in ((_160_645), (_160_644))))
in (FStar_Absyn_Syntax.mk_Typ_ascribed' _160_646))
in (FStar_All.pipe_left wpos _160_647))
end
| FStar_Parser_AST.Sum (binders, t) -> begin
(

let _63_1833 = (FStar_List.fold_left (fun _63_1818 b -> (match (_63_1818) with
| (env, tparams, typs) -> begin
(

let _63_1822 = (desugar_exp_binder env b)
in (match (_63_1822) with
| (xopt, t) -> begin
(

let _63_1828 = (match (xopt) with
| None -> begin
(let _160_650 = (FStar_Absyn_Util.new_bvd (Some (top.FStar_Parser_AST.range)))
in ((env), (_160_650)))
end
| Some (x) -> begin
(FStar_Parser_DesugarEnv.push_local_vbinding env x)
end)
in (match (_63_1828) with
| (env, x) -> begin
(let _160_654 = (let _160_653 = (let _160_652 = (let _160_651 = (FStar_Absyn_Util.close_with_lam tparams t)
in (FStar_All.pipe_left FStar_Absyn_Syntax.targ _160_651))
in (_160_652)::[])
in (FStar_List.append typs _160_653))
in ((env), ((FStar_List.append tparams ((((FStar_Util.Inr ((FStar_Absyn_Util.bvd_to_bvar_s x t))), (None)))::[]))), (_160_654)))
end))
end))
end)) ((env), ([]), ([])) (FStar_List.append binders (((FStar_Parser_AST.mk_binder (FStar_Parser_AST.NoName (t)) t.FStar_Parser_AST.range FStar_Parser_AST.Type None))::[])))
in (match (_63_1833) with
| (env, _63_1831, targs) -> begin
(

let tup = (let _160_655 = (FStar_Absyn_Util.mk_dtuple_lid (FStar_List.length targs) top.FStar_Parser_AST.range)
in (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) _160_655))
in (FStar_All.pipe_left wpos (FStar_Absyn_Syntax.mk_Typ_app ((tup), (targs)))))
end))
end
| FStar_Parser_AST.Record (_63_1836) -> begin
(FStar_All.failwith "Unexpected record type")
end
| FStar_Parser_AST.Let (FStar_Parser_AST.NoLetQualifier, ((x, v))::[], t) -> begin
(

let let_v = (FStar_Parser_AST.mk_term (FStar_Parser_AST.App ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Absyn_Const.let_in_typ)) top.FStar_Parser_AST.range top.FStar_Parser_AST.level)), (v), (FStar_Parser_AST.Nothing)))) v.FStar_Parser_AST.range v.FStar_Parser_AST.level)
in (

let t' = (FStar_Parser_AST.mk_term (FStar_Parser_AST.App (((let_v), ((FStar_Parser_AST.mk_term (FStar_Parser_AST.Abs ((((x)::[]), (t)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)), (FStar_Parser_AST.Nothing)))) top.FStar_Parser_AST.range top.FStar_Parser_AST.level)
in (desugar_typ env t')))
end
| (FStar_Parser_AST.If (_)) | (FStar_Parser_AST.Labeled (_)) -> begin
(desugar_formula env top)
end
| _63_1855 when (top.FStar_Parser_AST.level = FStar_Parser_AST.Formula) -> begin
(desugar_formula env top)
end
| _63_1857 -> begin
(FStar_Parser_AST.error "Expected a type" top top.FStar_Parser_AST.range)
end))))))
and desugar_comp : FStar_Range.range  ->  Prims.bool  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.comp = (fun r default_ok env t -> (

let fail = (fun msg -> (Prims.raise (FStar_Absyn_Syntax.Error (((msg), (r))))))
in (

let pre_process_comp_typ = (fun t -> (

let _63_1868 = (head_and_args t)
in (match (_63_1868) with
| (head, args) -> begin
(match (head.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Name (lemma) when (lemma.FStar_Ident.ident.FStar_Ident.idText = "Lemma") -> begin
(

let unit = (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Absyn_Const.unit_lid)) t.FStar_Parser_AST.range FStar_Parser_AST.Type)), (FStar_Parser_AST.Nothing))
in (

let nil_pat = (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Absyn_Const.nil_lid)) t.FStar_Parser_AST.range FStar_Parser_AST.Expr)), (FStar_Parser_AST.Nothing))
in (

let _63_1894 = (FStar_All.pipe_right args (FStar_List.partition (fun _63_1876 -> (match (_63_1876) with
| (arg, _63_1875) -> begin
(match ((let _160_667 = (unparen arg)
in _160_667.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.App ({FStar_Parser_AST.tm = FStar_Parser_AST.Var (d); FStar_Parser_AST.range = _63_1880; FStar_Parser_AST.level = _63_1878}, _63_1885, _63_1887) -> begin
(d.FStar_Ident.ident.FStar_Ident.idText = "decreases")
end
| _63_1891 -> begin
false
end)
end))))
in (match (_63_1894) with
| (decreases_clause, args) -> begin
(

let args = (match (args) with
| [] -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Not enough arguments to \'Lemma\'"), (t.FStar_Parser_AST.range)))))
end
| (ens)::[] -> begin
(

let req_true = (((FStar_Parser_AST.mk_term (FStar_Parser_AST.Requires ((((FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Absyn_Const.true_lid)) t.FStar_Parser_AST.range FStar_Parser_AST.Formula)), (None)))) t.FStar_Parser_AST.range FStar_Parser_AST.Type)), (FStar_Parser_AST.Nothing))
in (unit)::(req_true)::(ens)::(nil_pat)::[])
end
| (req)::(ens)::[] -> begin
(unit)::(req)::(ens)::(nil_pat)::[]
end
| more -> begin
(unit)::more
end)
in (

let t = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Construct (((lemma), ((FStar_List.append args decreases_clause))))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
in (desugar_typ env t)))
end))))
end
| FStar_Parser_AST.Name (tot) when (((tot.FStar_Ident.ident.FStar_Ident.idText = "Tot") && (not ((FStar_Parser_DesugarEnv.is_effect_name env FStar_Absyn_Const.effect_Tot_lid)))) && (let _160_668 = (FStar_Parser_DesugarEnv.current_module env)
in (FStar_Ident.lid_equals _160_668 FStar_Absyn_Const.prims_lid))) -> begin
(

let args = (FStar_List.map (fun _63_1909 -> (match (_63_1909) with
| (t, imp) -> begin
(let _160_670 = (desugar_typ_or_exp env t)
in (FStar_All.pipe_left (arg_withimp_t imp) _160_670))
end)) args)
in (let _160_671 = (FStar_Absyn_Util.ftv FStar_Absyn_Const.effect_Tot_lid FStar_Absyn_Syntax.kun)
in (FStar_Absyn_Util.mk_typ_app _160_671 args)))
end
| _63_1912 -> begin
(desugar_typ env t)
end)
end)))
in (

let t = (pre_process_comp_typ t)
in (

let _63_1916 = (FStar_Absyn_Util.head_and_args t)
in (match (_63_1916) with
| (head, args) -> begin
(match ((let _160_673 = (let _160_672 = (FStar_Absyn_Util.compress_typ head)
in _160_672.FStar_Absyn_Syntax.n)
in ((_160_673), (args)))) with
| (FStar_Absyn_Syntax.Typ_const (eff), ((FStar_Util.Inl (result_typ), _63_1923))::rest) -> begin
(

let _63_1963 = (FStar_All.pipe_right rest (FStar_List.partition (fun _63_11 -> (match (_63_11) with
| (FStar_Util.Inr (_63_1929), _63_1932) -> begin
false
end
| (FStar_Util.Inl (t), _63_1937) -> begin
(match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (fv); FStar_Absyn_Syntax.tk = _63_1946; FStar_Absyn_Syntax.pos = _63_1944; FStar_Absyn_Syntax.fvs = _63_1942; FStar_Absyn_Syntax.uvs = _63_1940}, ((FStar_Util.Inr (_63_1951), _63_1954))::[]) -> begin
(FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.decreases_lid)
end
| _63_1960 -> begin
false
end)
end))))
in (match (_63_1963) with
| (dec, rest) -> begin
(

let decreases_clause = (FStar_All.pipe_right dec (FStar_List.map (fun _63_12 -> (match (_63_12) with
| (FStar_Util.Inl (t), _63_1968) -> begin
(match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_app (_63_1971, ((FStar_Util.Inr (arg), _63_1975))::[]) -> begin
FStar_Absyn_Syntax.DECREASES (arg)
end
| _63_1981 -> begin
(FStar_All.failwith "impos")
end)
end
| _63_1983 -> begin
(FStar_All.failwith "impos")
end))))
in if ((FStar_Parser_DesugarEnv.is_effect_name env eff.FStar_Absyn_Syntax.v) || (FStar_Ident.lid_equals eff.FStar_Absyn_Syntax.v FStar_Absyn_Const.effect_Tot_lid)) then begin
if ((FStar_Ident.lid_equals eff.FStar_Absyn_Syntax.v FStar_Absyn_Const.effect_Tot_lid) && ((FStar_List.length decreases_clause) = (Prims.parse_int "0"))) then begin
(FStar_Absyn_Syntax.mk_Total result_typ)
end else begin
(

let flags = if (FStar_Ident.lid_equals eff.FStar_Absyn_Syntax.v FStar_Absyn_Const.effect_Lemma_lid) then begin
(FStar_Absyn_Syntax.LEMMA)::[]
end else begin
if (FStar_Ident.lid_equals eff.FStar_Absyn_Syntax.v FStar_Absyn_Const.effect_Tot_lid) then begin
(FStar_Absyn_Syntax.TOTAL)::[]
end else begin
if (FStar_Ident.lid_equals eff.FStar_Absyn_Syntax.v FStar_Absyn_Const.effect_ML_lid) then begin
(FStar_Absyn_Syntax.MLEFFECT)::[]
end else begin
[]
end
end
end
in (

let rest = if (FStar_Ident.lid_equals eff.FStar_Absyn_Syntax.v FStar_Absyn_Const.effect_Lemma_lid) then begin
(match (rest) with
| (req)::(ens)::((FStar_Util.Inr (pat), aq))::[] -> begin
(let _160_680 = (let _160_679 = (let _160_678 = (let _160_677 = (let _160_676 = (FStar_Absyn_Syntax.mk_Exp_meta (FStar_Absyn_Syntax.Meta_desugared (((pat), (FStar_Absyn_Syntax.Meta_smt_pat)))))
in FStar_Util.Inr (_160_676))
in ((_160_677), (aq)))
in (_160_678)::[])
in (ens)::_160_679)
in (req)::_160_680)
end
| _63_1994 -> begin
rest
end)
end else begin
rest
end
in (FStar_Absyn_Syntax.mk_Comp {FStar_Absyn_Syntax.effect_name = eff.FStar_Absyn_Syntax.v; FStar_Absyn_Syntax.result_typ = result_typ; FStar_Absyn_Syntax.effect_args = rest; FStar_Absyn_Syntax.flags = (FStar_List.append flags decreases_clause)})))
end
end else begin
if default_ok then begin
(env.FStar_Parser_DesugarEnv.default_result_effect t r)
end else begin
(let _160_682 = (let _160_681 = (FStar_Absyn_Print.typ_to_string t)
in (FStar_Util.format1 "%s is not an effect" _160_681))
in (fail _160_682))
end
end)
end))
end
| _63_1997 -> begin
if default_ok then begin
(env.FStar_Parser_DesugarEnv.default_result_effect t r)
end else begin
(let _160_684 = (let _160_683 = (FStar_Absyn_Print.typ_to_string t)
in (FStar_Util.format1 "%s is not an effect" _160_683))
in (fail _160_684))
end
end)
end))))))
and desugar_kind : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.knd = (fun env k -> (

let pos = (fun f -> (f k.FStar_Parser_AST.range))
in (

let setpos = (fun kk -> (

let _63_2004 = kk
in {FStar_Absyn_Syntax.n = _63_2004.FStar_Absyn_Syntax.n; FStar_Absyn_Syntax.tk = _63_2004.FStar_Absyn_Syntax.tk; FStar_Absyn_Syntax.pos = k.FStar_Parser_AST.range; FStar_Absyn_Syntax.fvs = _63_2004.FStar_Absyn_Syntax.fvs; FStar_Absyn_Syntax.uvs = _63_2004.FStar_Absyn_Syntax.uvs}))
in (

let k = (unparen k)
in (match (k.FStar_Parser_AST.tm) with
| FStar_Parser_AST.Name ({FStar_Ident.ns = _63_2013; FStar_Ident.ident = _63_2011; FStar_Ident.nsstr = _63_2009; FStar_Ident.str = "Type"}) -> begin
(setpos FStar_Absyn_Syntax.mk_Kind_type)
end
| FStar_Parser_AST.Name ({FStar_Ident.ns = _63_2022; FStar_Ident.ident = _63_2020; FStar_Ident.nsstr = _63_2018; FStar_Ident.str = "Effect"}) -> begin
(setpos FStar_Absyn_Syntax.mk_Kind_effect)
end
| FStar_Parser_AST.Name (l) -> begin
(match ((let _160_696 = (FStar_Parser_DesugarEnv.qualify_lid env l)
in (FStar_Parser_DesugarEnv.find_kind_abbrev env _160_696))) with
| Some (l) -> begin
(FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Kind_abbrev ((((l), ([]))), (FStar_Absyn_Syntax.mk_Kind_unknown))))
end
| _63_2030 -> begin
(FStar_Parser_AST.error "Unexpected term where kind was expected" k k.FStar_Parser_AST.range)
end)
end
| FStar_Parser_AST.Wild -> begin
(setpos FStar_Absyn_Syntax.kun)
end
| FStar_Parser_AST.Product (bs, k) -> begin
(

let _63_2038 = (uncurry bs k)
in (match (_63_2038) with
| (bs, k) -> begin
(

let rec aux = (fun env bs _63_13 -> (match (_63_13) with
| [] -> begin
(let _160_707 = (let _160_706 = (let _160_705 = (desugar_kind env k)
in (((FStar_List.rev bs)), (_160_705)))
in (FStar_Absyn_Syntax.mk_Kind_arrow _160_706))
in (FStar_All.pipe_left pos _160_707))
end
| (hd)::tl -> begin
(

let _63_2049 = (let _160_709 = (let _160_708 = (FStar_Parser_DesugarEnv.default_ml env)
in (desugar_binder _160_708 hd))
in (FStar_All.pipe_right _160_709 (as_binder env hd.FStar_Parser_AST.aqual)))
in (match (_63_2049) with
| (b, env) -> begin
(aux env ((b)::bs) tl)
end))
end))
in (aux env [] bs))
end))
end
| FStar_Parser_AST.Construct (l, args) -> begin
(match ((FStar_Parser_DesugarEnv.find_kind_abbrev env l)) with
| None -> begin
(FStar_Parser_AST.error "Unexpected term where kind was expected" k k.FStar_Parser_AST.range)
end
| Some (l) -> begin
(

let args = (FStar_List.map (fun _63_2059 -> (match (_63_2059) with
| (t, b) -> begin
(

let qual = if (b = FStar_Parser_AST.Hash) then begin
Some (imp_tag)
end else begin
None
end
in (let _160_711 = (desugar_typ_or_exp env t)
in ((_160_711), (qual))))
end)) args)
in (FStar_All.pipe_left pos (FStar_Absyn_Syntax.mk_Kind_abbrev ((((l), (args))), (FStar_Absyn_Syntax.mk_Kind_unknown)))))
end)
end
| _63_2063 -> begin
(FStar_Parser_AST.error "Unexpected term where kind was expected" k k.FStar_Parser_AST.range)
end)))))
and desugar_formula' : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.typ = (fun env f -> (

let connective = (fun s -> (match (s) with
| "/\\" -> begin
Some (FStar_Absyn_Const.and_lid)
end
| "\\/" -> begin
Some (FStar_Absyn_Const.or_lid)
end
| "==>" -> begin
Some (FStar_Absyn_Const.imp_lid)
end
| "<==>" -> begin
Some (FStar_Absyn_Const.iff_lid)
end
| "~" -> begin
Some (FStar_Absyn_Const.not_lid)
end
| _63_2074 -> begin
None
end))
in (

let pos = (fun t -> (t None f.FStar_Parser_AST.range))
in (

let setpos = (fun t -> (

let _63_2079 = t
in {FStar_Absyn_Syntax.n = _63_2079.FStar_Absyn_Syntax.n; FStar_Absyn_Syntax.tk = _63_2079.FStar_Absyn_Syntax.tk; FStar_Absyn_Syntax.pos = f.FStar_Parser_AST.range; FStar_Absyn_Syntax.fvs = _63_2079.FStar_Absyn_Syntax.fvs; FStar_Absyn_Syntax.uvs = _63_2079.FStar_Absyn_Syntax.uvs}))
in (

let desugar_quant = (fun q qt b pats body -> (

let tk = (desugar_binder env (

let _63_2087 = b
in {FStar_Parser_AST.b = _63_2087.FStar_Parser_AST.b; FStar_Parser_AST.brange = _63_2087.FStar_Parser_AST.brange; FStar_Parser_AST.blevel = FStar_Parser_AST.Formula; FStar_Parser_AST.aqual = _63_2087.FStar_Parser_AST.aqual}))
in (

let desugar_pats = (fun env pats -> (FStar_List.map (fun es -> (FStar_All.pipe_right es (FStar_List.map (fun e -> (let _160_747 = (desugar_typ_or_exp env e)
in (FStar_All.pipe_left (arg_withimp_t FStar_Parser_AST.Nothing) _160_747)))))) pats))
in (match (tk) with
| FStar_Util.Inl (Some (a), k) -> begin
(

let _63_2102 = (FStar_Parser_DesugarEnv.push_local_tbinding env a)
in (match (_63_2102) with
| (env, a) -> begin
(

let pats = (desugar_pats env pats)
in (

let body = (desugar_formula env body)
in (

let body = (match (pats) with
| [] -> begin
body
end
| _63_2107 -> begin
(let _160_748 = (FStar_Absyn_Syntax.mk_Typ_meta (FStar_Absyn_Syntax.Meta_pattern (((body), (pats)))))
in (FStar_All.pipe_left setpos _160_748))
end)
in (

let body = (let _160_754 = (let _160_753 = (let _160_752 = (let _160_751 = (FStar_Absyn_Syntax.t_binder (FStar_Absyn_Util.bvd_to_bvar_s a k))
in (_160_751)::[])
in ((_160_752), (body)))
in (FStar_Absyn_Syntax.mk_Typ_lam _160_753))
in (FStar_All.pipe_left pos _160_754))
in (let _160_758 = (let _160_757 = (FStar_Absyn_Util.ftv (FStar_Ident.set_lid_range qt b.FStar_Parser_AST.brange) FStar_Absyn_Syntax.kun)
in (let _160_756 = (let _160_755 = (FStar_Absyn_Syntax.targ body)
in (_160_755)::[])
in (FStar_Absyn_Util.mk_typ_app _160_757 _160_756)))
in (FStar_All.pipe_left setpos _160_758))))))
end))
end
| FStar_Util.Inr (Some (x), t) -> begin
(

let _63_2117 = (FStar_Parser_DesugarEnv.push_local_vbinding env x)
in (match (_63_2117) with
| (env, x) -> begin
(

let pats = (desugar_pats env pats)
in (

let body = (desugar_formula env body)
in (

let body = (match (pats) with
| [] -> begin
body
end
| _63_2122 -> begin
(FStar_Absyn_Syntax.mk_Typ_meta (FStar_Absyn_Syntax.Meta_pattern (((body), (pats)))))
end)
in (

let body = (let _160_764 = (let _160_763 = (let _160_762 = (let _160_761 = (FStar_Absyn_Syntax.v_binder (FStar_Absyn_Util.bvd_to_bvar_s x t))
in (_160_761)::[])
in ((_160_762), (body)))
in (FStar_Absyn_Syntax.mk_Typ_lam _160_763))
in (FStar_All.pipe_left pos _160_764))
in (let _160_768 = (let _160_767 = (FStar_Absyn_Util.ftv (FStar_Ident.set_lid_range q b.FStar_Parser_AST.brange) FStar_Absyn_Syntax.kun)
in (let _160_766 = (let _160_765 = (FStar_Absyn_Syntax.targ body)
in (_160_765)::[])
in (FStar_Absyn_Util.mk_typ_app _160_767 _160_766)))
in (FStar_All.pipe_left setpos _160_768))))))
end))
end
| _63_2126 -> begin
(FStar_All.failwith "impossible")
end))))
in (

let push_quant = (fun q binders pats body -> (match (binders) with
| (b)::(b')::_rest -> begin
(

let rest = (b')::_rest
in (

let body = (let _160_783 = (q ((rest), (pats), (body)))
in (let _160_782 = (FStar_Range.union_ranges b'.FStar_Parser_AST.brange body.FStar_Parser_AST.range)
in (FStar_Parser_AST.mk_term _160_783 _160_782 FStar_Parser_AST.Formula)))
in (let _160_784 = (q (((b)::[]), ([]), (body)))
in (FStar_Parser_AST.mk_term _160_784 f.FStar_Parser_AST.range FStar_Parser_AST.Formula))))
end
| _63_2140 -> begin
(FStar_All.failwith "impossible")
end))
in (match ((let _160_785 = (unparen f)
in _160_785.FStar_Parser_AST.tm)) with
| FStar_Parser_AST.Labeled (f, l, p) -> begin
(

let f = (desugar_formula env f)
in (FStar_Absyn_Syntax.mk_Typ_meta (FStar_Absyn_Syntax.Meta_labeled (((f), (l), (FStar_Absyn_Syntax.dummyRange), (p))))))
end
| FStar_Parser_AST.Op ("==", (hd)::_args) -> begin
(

let args = (hd)::_args
in (

let args = (FStar_List.map (fun t -> (let _160_787 = (desugar_typ_or_exp env t)
in (FStar_All.pipe_left (arg_withimp_t FStar_Parser_AST.Nothing) _160_787))) args)
in (

let eq = if (is_type env hd) then begin
(FStar_Absyn_Util.ftv (FStar_Ident.set_lid_range FStar_Absyn_Const.eqT_lid f.FStar_Parser_AST.range) FStar_Absyn_Syntax.kun)
end else begin
(FStar_Absyn_Util.ftv (FStar_Ident.set_lid_range FStar_Absyn_Const.eq2_lid f.FStar_Parser_AST.range) FStar_Absyn_Syntax.kun)
end
in (FStar_Absyn_Util.mk_typ_app eq args))))
end
| FStar_Parser_AST.Op (s, args) -> begin
(match ((((connective s)), (args))) with
| (Some (conn), (_63_2166)::(_63_2164)::[]) -> begin
(let _160_791 = (FStar_Absyn_Util.ftv (FStar_Ident.set_lid_range conn f.FStar_Parser_AST.range) FStar_Absyn_Syntax.kun)
in (let _160_790 = (FStar_List.map (fun x -> (let _160_789 = (desugar_formula env x)
in (FStar_All.pipe_left FStar_Absyn_Syntax.targ _160_789))) args)
in (FStar_Absyn_Util.mk_typ_app _160_791 _160_790)))
end
| _63_2171 -> begin
if (is_type env f) then begin
(desugar_typ env f)
end else begin
(let _160_792 = (desugar_exp env f)
in (FStar_All.pipe_right _160_792 FStar_Absyn_Util.b2t))
end
end)
end
| FStar_Parser_AST.If (f1, f2, f3) -> begin
(let _160_796 = (FStar_Absyn_Util.ftv (FStar_Ident.set_lid_range FStar_Absyn_Const.ite_lid f.FStar_Parser_AST.range) FStar_Absyn_Syntax.kun)
in (let _160_795 = (FStar_List.map (fun x -> (match ((desugar_typ_or_exp env x)) with
| FStar_Util.Inl (t) -> begin
(FStar_Absyn_Syntax.targ t)
end
| FStar_Util.Inr (v) -> begin
(let _160_794 = (FStar_Absyn_Util.b2t v)
in (FStar_All.pipe_left FStar_Absyn_Syntax.targ _160_794))
end)) ((f1)::(f2)::(f3)::[]))
in (FStar_Absyn_Util.mk_typ_app _160_796 _160_795)))
end
| (FStar_Parser_AST.QForall ([], _, _)) | (FStar_Parser_AST.QExists ([], _, _)) -> begin
(FStar_All.failwith "Impossible: Quantifier without binders")
end
| FStar_Parser_AST.QForall ((_1)::(_2)::_3, pats, body) -> begin
(

let binders = (_1)::(_2)::_3
in (let _160_798 = (push_quant (fun x -> FStar_Parser_AST.QForall (x)) binders pats body)
in (desugar_formula env _160_798)))
end
| FStar_Parser_AST.QExists ((_1)::(_2)::_3, pats, body) -> begin
(

let binders = (_1)::(_2)::_3
in (let _160_800 = (push_quant (fun x -> FStar_Parser_AST.QExists (x)) binders pats body)
in (desugar_formula env _160_800)))
end
| FStar_Parser_AST.QForall ((b)::[], pats, body) -> begin
(desugar_quant FStar_Absyn_Const.forall_lid FStar_Absyn_Const.allTyp_lid b pats body)
end
| FStar_Parser_AST.QExists ((b)::[], pats, body) -> begin
(desugar_quant FStar_Absyn_Const.exists_lid FStar_Absyn_Const.allTyp_lid b pats body)
end
| FStar_Parser_AST.Paren (f) -> begin
(desugar_formula env f)
end
| _63_2233 -> begin
if (is_type env f) then begin
(desugar_typ env f)
end else begin
(let _160_801 = (desugar_exp env f)
in (FStar_All.pipe_left FStar_Absyn_Util.b2t _160_801))
end
end)))))))
and desugar_formula : env_t  ->  FStar_Parser_AST.term  ->  FStar_Absyn_Syntax.typ = (fun env t -> (desugar_formula' (

let _63_2236 = env
in {FStar_Parser_DesugarEnv.curmodule = _63_2236.FStar_Parser_DesugarEnv.curmodule; FStar_Parser_DesugarEnv.modules = _63_2236.FStar_Parser_DesugarEnv.modules; FStar_Parser_DesugarEnv.open_namespaces = _63_2236.FStar_Parser_DesugarEnv.open_namespaces; FStar_Parser_DesugarEnv.modul_abbrevs = _63_2236.FStar_Parser_DesugarEnv.modul_abbrevs; FStar_Parser_DesugarEnv.sigaccum = _63_2236.FStar_Parser_DesugarEnv.sigaccum; FStar_Parser_DesugarEnv.localbindings = _63_2236.FStar_Parser_DesugarEnv.localbindings; FStar_Parser_DesugarEnv.recbindings = _63_2236.FStar_Parser_DesugarEnv.recbindings; FStar_Parser_DesugarEnv.phase = FStar_Parser_AST.Formula; FStar_Parser_DesugarEnv.sigmap = _63_2236.FStar_Parser_DesugarEnv.sigmap; FStar_Parser_DesugarEnv.default_result_effect = _63_2236.FStar_Parser_DesugarEnv.default_result_effect; FStar_Parser_DesugarEnv.iface = _63_2236.FStar_Parser_DesugarEnv.iface; FStar_Parser_DesugarEnv.admitted_iface = _63_2236.FStar_Parser_DesugarEnv.admitted_iface}) t))
and desugar_binder : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder  ->  ((FStar_Ident.ident Prims.option * FStar_Absyn_Syntax.knd), (FStar_Ident.ident Prims.option * FStar_Absyn_Syntax.typ)) FStar_Util.either = (fun env b -> if (is_type_binder env b) then begin
(let _160_806 = (desugar_type_binder env b)
in FStar_Util.Inl (_160_806))
end else begin
(let _160_807 = (desugar_exp_binder env b)
in FStar_Util.Inr (_160_807))
end)
and typars_of_binders : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder Prims.list  ->  (FStar_Parser_DesugarEnv.env * ((((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, FStar_Absyn_Syntax.knd) FStar_Absyn_Syntax.withinfo_t, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, FStar_Absyn_Syntax.typ) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list) = (fun env bs -> (

let _63_2269 = (FStar_List.fold_left (fun _63_2244 b -> (match (_63_2244) with
| (env, out) -> begin
(

let tk = (desugar_binder env (

let _63_2246 = b
in {FStar_Parser_AST.b = _63_2246.FStar_Parser_AST.b; FStar_Parser_AST.brange = _63_2246.FStar_Parser_AST.brange; FStar_Parser_AST.blevel = FStar_Parser_AST.Formula; FStar_Parser_AST.aqual = _63_2246.FStar_Parser_AST.aqual}))
in (match (tk) with
| FStar_Util.Inl (Some (a), k) -> begin
(

let _63_2256 = (FStar_Parser_DesugarEnv.push_local_tbinding env a)
in (match (_63_2256) with
| (env, a) -> begin
((env), ((((FStar_Util.Inl ((FStar_Absyn_Util.bvd_to_bvar_s a k))), ((trans_aqual b.FStar_Parser_AST.aqual))))::out))
end))
end
| FStar_Util.Inr (Some (x), t) -> begin
(

let _63_2264 = (FStar_Parser_DesugarEnv.push_local_vbinding env x)
in (match (_63_2264) with
| (env, x) -> begin
((env), ((((FStar_Util.Inr ((FStar_Absyn_Util.bvd_to_bvar_s x t))), ((trans_aqual b.FStar_Parser_AST.aqual))))::out))
end))
end
| _63_2266 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected binder"), (b.FStar_Parser_AST.brange)))))
end))
end)) ((env), ([])) bs)
in (match (_63_2269) with
| (env, tpars) -> begin
((env), ((FStar_List.rev tpars)))
end)))
and desugar_exp_binder : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder  ->  (FStar_Ident.ident Prims.option * FStar_Absyn_Syntax.typ) = (fun env b -> (match (b.FStar_Parser_AST.b) with
| FStar_Parser_AST.Annotated (x, t) -> begin
(let _160_814 = (desugar_typ env t)
in ((Some (x)), (_160_814)))
end
| FStar_Parser_AST.TVariable (t) -> begin
(let _160_815 = (FStar_Parser_DesugarEnv.fail_or2 (FStar_Parser_DesugarEnv.try_lookup_typ_var env) t)
in ((None), (_160_815)))
end
| FStar_Parser_AST.NoName (t) -> begin
(let _160_816 = (desugar_typ env t)
in ((None), (_160_816)))
end
| FStar_Parser_AST.Variable (x) -> begin
((Some (x)), (FStar_Absyn_Syntax.tun))
end
| _63_2283 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected domain of an arrow or sum (expected a type)"), (b.FStar_Parser_AST.brange)))))
end))
and desugar_type_binder : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder  ->  (FStar_Ident.ident Prims.option * FStar_Absyn_Syntax.knd) = (fun env b -> (

let fail = (fun _63_2287 -> (match (()) with
| () -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected domain of an arrow or sum (expected a kind)"), (b.FStar_Parser_AST.brange)))))
end))
in (match (b.FStar_Parser_AST.b) with
| (FStar_Parser_AST.Annotated (x, t)) | (FStar_Parser_AST.TAnnotated (x, t)) -> begin
(let _160_821 = (desugar_kind env t)
in ((Some (x)), (_160_821)))
end
| FStar_Parser_AST.NoName (t) -> begin
(let _160_822 = (desugar_kind env t)
in ((None), (_160_822)))
end
| FStar_Parser_AST.TVariable (x) -> begin
((Some (x)), ((

let _63_2298 = FStar_Absyn_Syntax.mk_Kind_type
in {FStar_Absyn_Syntax.n = _63_2298.FStar_Absyn_Syntax.n; FStar_Absyn_Syntax.tk = _63_2298.FStar_Absyn_Syntax.tk; FStar_Absyn_Syntax.pos = b.FStar_Parser_AST.brange; FStar_Absyn_Syntax.fvs = _63_2298.FStar_Absyn_Syntax.fvs; FStar_Absyn_Syntax.uvs = _63_2298.FStar_Absyn_Syntax.uvs})))
end
| _63_2301 -> begin
(fail ())
end)))


let gather_tc_binders : ((((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax  ->  ((((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list = (fun tps k -> (

let rec aux = (fun bs k -> (match (k.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Kind_arrow (binders, k) -> begin
(aux (FStar_List.append bs binders) k)
end
| FStar_Absyn_Syntax.Kind_abbrev (_63_2312, k) -> begin
(aux bs k)
end
| _63_2317 -> begin
bs
end))
in (let _160_831 = (aux tps k)
in (FStar_All.pipe_right _160_831 FStar_Absyn_Util.name_binders))))


let mk_data_discriminators : FStar_Absyn_Syntax.qualifier Prims.list  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Ident.lid  ->  ((((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax  ->  FStar_Ident.lident Prims.list  ->  FStar_Absyn_Syntax.sigelt Prims.list = (fun quals env t tps k datas -> (

let quals = (fun q -> if ((FStar_All.pipe_left Prims.op_Negation env.FStar_Parser_DesugarEnv.iface) || env.FStar_Parser_DesugarEnv.admitted_iface) then begin
(FStar_List.append ((FStar_Absyn_Syntax.Assumption)::q) quals)
end else begin
(FStar_List.append q quals)
end)
in (

let binders = (gather_tc_binders tps k)
in (

let p = (FStar_Ident.range_of_lid t)
in (

let imp_binders = (FStar_All.pipe_right binders (FStar_List.map (fun _63_2331 -> (match (_63_2331) with
| (x, _63_2330) -> begin
((x), (Some (imp_tag)))
end))))
in (

let binders = (let _160_852 = (let _160_851 = (let _160_850 = (let _160_849 = (let _160_848 = (FStar_Absyn_Util.ftv t FStar_Absyn_Syntax.kun)
in (let _160_847 = (FStar_Absyn_Util.args_of_non_null_binders binders)
in ((_160_848), (_160_847))))
in (FStar_Absyn_Syntax.mk_Typ_app' _160_849 None p))
in (FStar_All.pipe_left FStar_Absyn_Syntax.null_v_binder _160_850))
in (_160_851)::[])
in (FStar_List.append imp_binders _160_852))
in (

let disc_type = (let _160_855 = (let _160_854 = (let _160_853 = (FStar_Absyn_Util.ftv FStar_Absyn_Const.bool_lid FStar_Absyn_Syntax.ktype)
in (FStar_Absyn_Util.total_comp _160_853 p))
in ((binders), (_160_854)))
in (FStar_Absyn_Syntax.mk_Typ_fun _160_855 None p))
in (FStar_All.pipe_right datas (FStar_List.map (fun d -> (

let disc_name = (FStar_Absyn_Util.mk_discriminator d)
in (let _160_858 = (let _160_857 = (quals ((FStar_Absyn_Syntax.Logic)::(FStar_Absyn_Syntax.Discriminator (d))::[]))
in ((disc_name), (disc_type), (_160_857), ((FStar_Ident.range_of_lid disc_name))))
in FStar_Absyn_Syntax.Sig_val_decl (_160_858)))))))))))))


let mk_indexed_projectors = (fun fvq refine_domain env _63_2343 lid formals t -> (match (_63_2343) with
| (tc, tps, k) -> begin
(

let binders = (gather_tc_binders tps k)
in (

let p = (FStar_Ident.range_of_lid lid)
in (

let pos = (fun q -> (FStar_Absyn_Syntax.withinfo q None p))
in (

let projectee = (let _160_869 = (FStar_Absyn_Syntax.mk_ident (("projectee"), (p)))
in (let _160_868 = (FStar_Absyn_Util.genident (Some (p)))
in {FStar_Absyn_Syntax.ppname = _160_869; FStar_Absyn_Syntax.realname = _160_868}))
in (

let arg_exp = (FStar_Absyn_Util.bvd_to_exp projectee FStar_Absyn_Syntax.tun)
in (

let arg_binder = (

let arg_typ = (let _160_872 = (let _160_871 = (FStar_Absyn_Util.ftv tc FStar_Absyn_Syntax.kun)
in (let _160_870 = (FStar_Absyn_Util.args_of_non_null_binders binders)
in ((_160_871), (_160_870))))
in (FStar_Absyn_Syntax.mk_Typ_app' _160_872 None p))
in if (not (refine_domain)) then begin
(FStar_Absyn_Syntax.v_binder (FStar_Absyn_Util.bvd_to_bvar_s projectee arg_typ))
end else begin
(

let disc_name = (FStar_Absyn_Util.mk_discriminator lid)
in (

let x = (FStar_Absyn_Util.gen_bvar arg_typ)
in (let _160_882 = (let _160_881 = (let _160_880 = (let _160_879 = (let _160_878 = (let _160_877 = (let _160_876 = (FStar_Absyn_Util.fvar None disc_name p)
in (let _160_875 = (let _160_874 = (let _160_873 = (FStar_Absyn_Util.bvar_to_exp x)
in (FStar_All.pipe_left FStar_Absyn_Syntax.varg _160_873))
in (_160_874)::[])
in ((_160_876), (_160_875))))
in (FStar_Absyn_Syntax.mk_Exp_app _160_877 None p))
in (FStar_Absyn_Util.b2t _160_878))
in ((x), (_160_879)))
in (FStar_Absyn_Syntax.mk_Typ_refine _160_880 None p))
in (FStar_All.pipe_left (FStar_Absyn_Util.bvd_to_bvar_s projectee) _160_881))
in (FStar_All.pipe_left FStar_Absyn_Syntax.v_binder _160_882))))
end)
in (

let imp_binders = (FStar_All.pipe_right binders (FStar_List.map (fun _63_2360 -> (match (_63_2360) with
| (x, _63_2359) -> begin
((x), (Some (imp_tag)))
end))))
in (

let binders = (FStar_List.append imp_binders ((arg_binder)::[]))
in (

let arg = (FStar_Absyn_Util.arg_of_non_null_binder arg_binder)
in (

let subst = (let _160_890 = (FStar_All.pipe_right formals (FStar_List.mapi (fun i f -> (match ((Prims.fst f)) with
| FStar_Util.Inl (a) -> begin
(

let _63_2371 = (FStar_Absyn_Util.mk_field_projector_name lid a i)
in (match (_63_2371) with
| (field_name, _63_2370) -> begin
(

let proj = (let _160_887 = (let _160_886 = (FStar_Absyn_Util.ftv field_name FStar_Absyn_Syntax.kun)
in ((_160_886), ((arg)::[])))
in (FStar_Absyn_Syntax.mk_Typ_app _160_887 None p))
in (FStar_Util.Inl (((a.FStar_Absyn_Syntax.v), (proj))))::[])
end))
end
| FStar_Util.Inr (x) -> begin
(

let _63_2378 = (FStar_Absyn_Util.mk_field_projector_name lid x i)
in (match (_63_2378) with
| (field_name, _63_2377) -> begin
(

let proj = (let _160_889 = (let _160_888 = (FStar_Absyn_Util.fvar None field_name p)
in ((_160_888), ((arg)::[])))
in (FStar_Absyn_Syntax.mk_Exp_app _160_889 None p))
in (FStar_Util.Inr (((x.FStar_Absyn_Syntax.v), (proj))))::[])
end))
end))))
in (FStar_All.pipe_right _160_890 FStar_List.flatten))
in (

let ntps = (FStar_List.length tps)
in (

let all_params = (let _160_892 = (FStar_All.pipe_right tps (FStar_List.map (fun _63_2385 -> (match (_63_2385) with
| (b, _63_2384) -> begin
((b), (Some (imp_tag)))
end))))
in (FStar_List.append _160_892 formals))
in (let _160_922 = (FStar_All.pipe_right formals (FStar_List.mapi (fun i ax -> (match ((Prims.fst ax)) with
| FStar_Util.Inl (a) -> begin
(

let _63_2394 = (FStar_Absyn_Util.mk_field_projector_name lid a i)
in (match (_63_2394) with
| (field_name, _63_2393) -> begin
(

let kk = (let _160_896 = (let _160_895 = (FStar_Absyn_Util.subst_kind subst a.FStar_Absyn_Syntax.sort)
in ((binders), (_160_895)))
in (FStar_Absyn_Syntax.mk_Kind_arrow _160_896 p))
in (FStar_Absyn_Syntax.Sig_tycon (((field_name), ([]), (kk), ([]), ([]), ((FStar_Absyn_Syntax.Logic)::(FStar_Absyn_Syntax.Projector (((lid), (FStar_Util.Inl (a.FStar_Absyn_Syntax.v)))))::[]), ((FStar_Ident.range_of_lid field_name)))))::[])
end))
end
| FStar_Util.Inr (x) -> begin
(

let _63_2401 = (FStar_Absyn_Util.mk_field_projector_name lid x i)
in (match (_63_2401) with
| (field_name, _63_2400) -> begin
(

let t = (let _160_899 = (let _160_898 = (let _160_897 = (FStar_Absyn_Util.subst_typ subst x.FStar_Absyn_Syntax.sort)
in (FStar_Absyn_Util.total_comp _160_897 p))
in ((binders), (_160_898)))
in (FStar_Absyn_Syntax.mk_Typ_fun _160_899 None p))
in (

let quals = (fun q -> if ((not (env.FStar_Parser_DesugarEnv.iface)) || env.FStar_Parser_DesugarEnv.admitted_iface) then begin
(FStar_Absyn_Syntax.Assumption)::q
end else begin
q
end)
in (

let quals = (quals ((FStar_Absyn_Syntax.Logic)::(FStar_Absyn_Syntax.Projector (((lid), (FStar_Util.Inr (x.FStar_Absyn_Syntax.v)))))::[]))
in (

let impl = if (((let _160_902 = (FStar_Parser_DesugarEnv.current_module env)
in (FStar_Ident.lid_equals FStar_Absyn_Const.prims_lid _160_902)) || (fvq <> FStar_Absyn_Syntax.Data_ctor)) || (let _160_904 = (let _160_903 = (FStar_Parser_DesugarEnv.current_module env)
in _160_903.FStar_Ident.str)
in (FStar_Options.dont_gen_projectors _160_904))) then begin
[]
end else begin
(

let projection = (FStar_Absyn_Util.gen_bvar FStar_Absyn_Syntax.tun)
in (

let as_imp = (fun _63_14 -> (match (_63_14) with
| Some (FStar_Absyn_Syntax.Implicit (_63_2409)) -> begin
true
end
| _63_2413 -> begin
false
end))
in (

let arg_pats = (let _160_919 = (FStar_All.pipe_right all_params (FStar_List.mapi (fun j by -> (match (by) with
| (FStar_Util.Inl (_63_2418), imp) -> begin
if (j < ntps) then begin
[]
end else begin
(let _160_912 = (let _160_911 = (let _160_910 = (let _160_909 = (FStar_Absyn_Util.gen_bvar FStar_Absyn_Syntax.kun)
in FStar_Absyn_Syntax.Pat_tvar (_160_909))
in (pos _160_910))
in ((_160_911), ((as_imp imp))))
in (_160_912)::[])
end
end
| (FStar_Util.Inr (_63_2423), imp) -> begin
if ((i + ntps) = j) then begin
(let _160_914 = (let _160_913 = (pos (FStar_Absyn_Syntax.Pat_var (projection)))
in ((_160_913), ((as_imp imp))))
in (_160_914)::[])
end else begin
if (j < ntps) then begin
[]
end else begin
(let _160_918 = (let _160_917 = (let _160_916 = (let _160_915 = (FStar_Absyn_Util.gen_bvar FStar_Absyn_Syntax.tun)
in FStar_Absyn_Syntax.Pat_wild (_160_915))
in (pos _160_916))
in ((_160_917), ((as_imp imp))))
in (_160_918)::[])
end
end
end))))
in (FStar_All.pipe_right _160_919 FStar_List.flatten))
in (

let pat = (let _160_921 = (FStar_All.pipe_right (FStar_Absyn_Syntax.Pat_cons ((((FStar_Absyn_Util.fv lid)), (Some (fvq)), (arg_pats)))) pos)
in (let _160_920 = (FStar_Absyn_Util.bvar_to_exp projection)
in ((_160_921), (None), (_160_920))))
in (

let body = (FStar_Absyn_Syntax.mk_Exp_match ((arg_exp), ((pat)::[])) None p)
in (

let imp = (FStar_Absyn_Syntax.mk_Exp_abs ((binders), (body)) None (FStar_Ident.range_of_lid field_name))
in (

let lb = {FStar_Absyn_Syntax.lbname = FStar_Util.Inr (field_name); FStar_Absyn_Syntax.lbtyp = FStar_Absyn_Syntax.tun; FStar_Absyn_Syntax.lbeff = FStar_Absyn_Const.effect_Tot_lid; FStar_Absyn_Syntax.lbdef = imp}
in (FStar_Absyn_Syntax.Sig_let (((((false), ((lb)::[]))), (p), ([]), (quals))))::[])))))))
end
in (FStar_Absyn_Syntax.Sig_val_decl (((field_name), (t), (quals), ((FStar_Ident.range_of_lid field_name)))))::impl))))
end))
end))))
in (FStar_All.pipe_right _160_922 FStar_List.flatten))))))))))))))
end))


let mk_data_projectors : FStar_Parser_DesugarEnv.env  ->  FStar_Absyn_Syntax.sigelt  ->  FStar_Absyn_Syntax.sigelt Prims.list = (fun env _63_17 -> (match (_63_17) with
| FStar_Absyn_Syntax.Sig_datacon (lid, t, tycon, quals, _63_2440, _63_2442) when (not ((FStar_Ident.lid_equals lid FStar_Absyn_Const.lexcons_lid))) -> begin
(

let refine_domain = if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _63_15 -> (match (_63_15) with
| FStar_Absyn_Syntax.RecordConstructor (_63_2447) -> begin
true
end
| _63_2450 -> begin
false
end)))) then begin
false
end else begin
(

let _63_2456 = tycon
in (match (_63_2456) with
| (l, _63_2453, _63_2455) -> begin
(match ((FStar_Parser_DesugarEnv.find_all_datacons env l)) with
| Some (l) -> begin
((FStar_List.length l) > (Prims.parse_int "1"))
end
| _63_2460 -> begin
true
end)
end))
end
in (match ((FStar_Absyn_Util.function_formals t)) with
| Some (formals, cod) -> begin
(

let cod = (FStar_Absyn_Util.comp_result cod)
in (

let qual = (match ((FStar_Util.find_map quals (fun _63_16 -> (match (_63_16) with
| FStar_Absyn_Syntax.RecordConstructor (fns) -> begin
Some (FStar_Absyn_Syntax.Record_ctor (((lid), (fns))))
end
| _63_2471 -> begin
None
end)))) with
| None -> begin
FStar_Absyn_Syntax.Data_ctor
end
| Some (q) -> begin
q
end)
in (mk_indexed_projectors qual refine_domain env tycon lid formals cod)))
end
| _63_2477 -> begin
[]
end))
end
| _63_2479 -> begin
[]
end))


let rec desugar_tycon : FStar_Parser_DesugarEnv.env  ->  FStar_Range.range  ->  FStar_Absyn_Syntax.qualifier Prims.list  ->  FStar_Parser_AST.tycon Prims.list  ->  (env_t * FStar_Absyn_Syntax.sigelts) = (fun env rng quals tcs -> (

let tycon_id = (fun _63_18 -> (match (_63_18) with
| (FStar_Parser_AST.TyconAbstract (id, _, _)) | (FStar_Parser_AST.TyconAbbrev (id, _, _, _)) | (FStar_Parser_AST.TyconRecord (id, _, _, _)) | (FStar_Parser_AST.TyconVariant (id, _, _, _)) -> begin
id
end))
in (

let binder_to_term = (fun b -> (match (b.FStar_Parser_AST.b) with
| (FStar_Parser_AST.Annotated (x, _)) | (FStar_Parser_AST.Variable (x)) -> begin
(let _160_942 = (let _160_941 = (FStar_Ident.lid_of_ids ((x)::[]))
in FStar_Parser_AST.Var (_160_941))
in (FStar_Parser_AST.mk_term _160_942 x.FStar_Ident.idRange FStar_Parser_AST.Expr))
end
| (FStar_Parser_AST.TAnnotated (a, _)) | (FStar_Parser_AST.TVariable (a)) -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.Tvar (a)) a.FStar_Ident.idRange FStar_Parser_AST.Type)
end
| FStar_Parser_AST.NoName (t) -> begin
t
end))
in (

let tot = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Name (FStar_Absyn_Const.effect_Tot_lid)) rng FStar_Parser_AST.Expr)
in (

let with_constructor_effect = (fun t -> (FStar_Parser_AST.mk_term (FStar_Parser_AST.App (((tot), (t), (FStar_Parser_AST.Nothing)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level))
in (

let apply_binders = (fun t binders -> (

let imp_of_aqual = (fun b -> (match (b.FStar_Parser_AST.aqual) with
| Some (FStar_Parser_AST.Implicit) -> begin
FStar_Parser_AST.Hash
end
| _63_2544 -> begin
FStar_Parser_AST.Nothing
end))
in (FStar_List.fold_left (fun out b -> (let _160_955 = (let _160_954 = (let _160_953 = (binder_to_term b)
in ((out), (_160_953), ((imp_of_aqual b))))
in FStar_Parser_AST.App (_160_954))
in (FStar_Parser_AST.mk_term _160_955 out.FStar_Parser_AST.range out.FStar_Parser_AST.level))) t binders)))
in (

let tycon_record_as_variant = (fun _63_19 -> (match (_63_19) with
| FStar_Parser_AST.TyconRecord (id, parms, kopt, fields) -> begin
(

let constrName = (FStar_Ident.mk_ident (((Prims.strcat "Mk" id.FStar_Ident.idText)), (id.FStar_Ident.idRange)))
in (

let mfields = (FStar_List.map (fun _63_2559 -> (match (_63_2559) with
| (x, t, _63_2558) -> begin
(FStar_Parser_AST.mk_binder (FStar_Parser_AST.Annotated ((((FStar_Absyn_Util.mangle_field_name x)), (t)))) x.FStar_Ident.idRange FStar_Parser_AST.Expr None)
end)) fields)
in (

let result = (let _160_961 = (let _160_960 = (let _160_959 = (FStar_Ident.lid_of_ids ((id)::[]))
in FStar_Parser_AST.Var (_160_959))
in (FStar_Parser_AST.mk_term _160_960 id.FStar_Ident.idRange FStar_Parser_AST.Type))
in (apply_binders _160_961 parms))
in (

let constrTyp = (FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((mfields), ((with_constructor_effect result))))) id.FStar_Ident.idRange FStar_Parser_AST.Type)
in (let _160_963 = (FStar_All.pipe_right fields (FStar_List.map (fun _63_2568 -> (match (_63_2568) with
| (x, _63_2565, _63_2567) -> begin
(FStar_Parser_DesugarEnv.qualify env x)
end))))
in ((FStar_Parser_AST.TyconVariant (((id), (parms), (kopt), ((((constrName), (Some (constrTyp)), (None), (false)))::[])))), (_160_963)))))))
end
| _63_2570 -> begin
(FStar_All.failwith "impossible")
end))
in (

let desugar_abstract_tc = (fun quals _env mutuals _63_20 -> (match (_63_20) with
| FStar_Parser_AST.TyconAbstract (id, binders, kopt) -> begin
(

let _63_2584 = (typars_of_binders _env binders)
in (match (_63_2584) with
| (_env', typars) -> begin
(

let k = (match (kopt) with
| None -> begin
FStar_Absyn_Syntax.kun
end
| Some (k) -> begin
(desugar_kind _env' k)
end)
in (

let tconstr = (let _160_974 = (let _160_973 = (let _160_972 = (FStar_Ident.lid_of_ids ((id)::[]))
in FStar_Parser_AST.Var (_160_972))
in (FStar_Parser_AST.mk_term _160_973 id.FStar_Ident.idRange FStar_Parser_AST.Type))
in (apply_binders _160_974 binders))
in (

let qlid = (FStar_Parser_DesugarEnv.qualify _env id)
in (

let se = FStar_Absyn_Syntax.Sig_tycon (((qlid), (typars), (k), (mutuals), ([]), (quals), (rng)))
in (

let _env = (FStar_Parser_DesugarEnv.push_rec_binding _env (FStar_Parser_DesugarEnv.Binding_tycon (qlid)))
in (

let _env2 = (FStar_Parser_DesugarEnv.push_rec_binding _env' (FStar_Parser_DesugarEnv.Binding_tycon (qlid)))
in ((_env), (_env2), (se), (tconstr))))))))
end))
end
| _63_2595 -> begin
(FStar_All.failwith "Unexpected tycon")
end))
in (

let push_tparam = (fun env _63_21 -> (match (_63_21) with
| (FStar_Util.Inr (x), _63_2602) -> begin
(FStar_Parser_DesugarEnv.push_bvvdef env x.FStar_Absyn_Syntax.v)
end
| (FStar_Util.Inl (a), _63_2607) -> begin
(FStar_Parser_DesugarEnv.push_btvdef env a.FStar_Absyn_Syntax.v)
end))
in (

let push_tparams = (FStar_List.fold_left push_tparam)
in (match (tcs) with
| (FStar_Parser_AST.TyconAbstract (_63_2611))::[] -> begin
(

let tc = (FStar_List.hd tcs)
in (

let _63_2622 = (desugar_abstract_tc quals env [] tc)
in (match (_63_2622) with
| (_63_2616, _63_2618, se, _63_2621) -> begin
(

let quals = if ((FStar_All.pipe_right quals (FStar_List.contains FStar_Absyn_Syntax.Assumption)) || (FStar_All.pipe_right quals (FStar_List.contains FStar_Absyn_Syntax.New))) then begin
quals
end else begin
(

let _63_2623 = (let _160_984 = (FStar_Range.string_of_range rng)
in (let _160_983 = (let _160_982 = (let _160_981 = (FStar_Absyn_Util.lids_of_sigelt se)
in (FStar_All.pipe_right _160_981 (FStar_List.map FStar_Absyn_Print.sli)))
in (FStar_All.pipe_right _160_982 (FStar_String.concat ", ")))
in (FStar_Util.print2 "%s (Warning): Adding an implicit \'new\' qualifier on %s\n" _160_984 _160_983)))
in (FStar_Absyn_Syntax.New)::quals)
end
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env se)
in ((env), ((se)::[]))))
end)))
end
| (FStar_Parser_AST.TyconAbbrev (id, binders, kopt, t))::[] -> begin
(

let _63_2636 = (typars_of_binders env binders)
in (match (_63_2636) with
| (env', typars) -> begin
(

let k = (match (kopt) with
| None -> begin
if (FStar_Util.for_some (fun _63_22 -> (match (_63_22) with
| FStar_Absyn_Syntax.Effect -> begin
true
end
| _63_2641 -> begin
false
end)) quals) then begin
FStar_Absyn_Syntax.mk_Kind_effect
end else begin
FStar_Absyn_Syntax.kun
end
end
| Some (k) -> begin
(desugar_kind env' k)
end)
in (

let t0 = t
in (

let quals = if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _63_23 -> (match (_63_23) with
| FStar_Absyn_Syntax.Logic -> begin
true
end
| _63_2649 -> begin
false
end)))) then begin
quals
end else begin
if (t0.FStar_Parser_AST.level = FStar_Parser_AST.Formula) then begin
(FStar_Absyn_Syntax.Logic)::quals
end else begin
quals
end
end
in (

let se = if (FStar_All.pipe_right quals (FStar_List.contains FStar_Absyn_Syntax.Effect)) then begin
(

let c = (desugar_comp t.FStar_Parser_AST.range false env' t)
in (let _160_990 = (let _160_989 = (FStar_Parser_DesugarEnv.qualify env id)
in (let _160_988 = (FStar_All.pipe_right quals (FStar_List.filter (fun _63_24 -> (match (_63_24) with
| FStar_Absyn_Syntax.Effect -> begin
false
end
| _63_2655 -> begin
true
end))))
in ((_160_989), (typars), (c), (_160_988), (rng))))
in FStar_Absyn_Syntax.Sig_effect_abbrev (_160_990)))
end else begin
(

let t = (desugar_typ env' t)
in (let _160_992 = (let _160_991 = (FStar_Parser_DesugarEnv.qualify env id)
in ((_160_991), (typars), (k), (t), (quals), (rng)))
in FStar_Absyn_Syntax.Sig_typ_abbrev (_160_992)))
end
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env se)
in ((env), ((se)::[])))))))
end))
end
| (FStar_Parser_AST.TyconRecord (_63_2660))::[] -> begin
(

let trec = (FStar_List.hd tcs)
in (

let _63_2666 = (tycon_record_as_variant trec)
in (match (_63_2666) with
| (t, fs) -> begin
(desugar_tycon env rng ((FStar_Absyn_Syntax.RecordType (fs))::quals) ((t)::[]))
end)))
end
| (_63_2670)::_63_2668 -> begin
(

let env0 = env
in (

let mutuals = (FStar_List.map (fun x -> (FStar_All.pipe_left (FStar_Parser_DesugarEnv.qualify env) (tycon_id x))) tcs)
in (

let rec collect_tcs = (fun quals et tc -> (

let _63_2681 = et
in (match (_63_2681) with
| (env, tcs) -> begin
(match (tc) with
| FStar_Parser_AST.TyconRecord (_63_2683) -> begin
(

let trec = tc
in (

let _63_2688 = (tycon_record_as_variant trec)
in (match (_63_2688) with
| (t, fs) -> begin
(collect_tcs ((FStar_Absyn_Syntax.RecordType (fs))::quals) ((env), (tcs)) t)
end)))
end
| FStar_Parser_AST.TyconVariant (id, binders, kopt, constructors) -> begin
(

let _63_2700 = (desugar_abstract_tc quals env mutuals (FStar_Parser_AST.TyconAbstract (((id), (binders), (kopt)))))
in (match (_63_2700) with
| (env, _63_2697, se, tconstr) -> begin
((env), ((FStar_Util.Inl (((se), (constructors), (tconstr), (quals))))::tcs))
end))
end
| FStar_Parser_AST.TyconAbbrev (id, binders, kopt, t) -> begin
(

let _63_2712 = (desugar_abstract_tc quals env mutuals (FStar_Parser_AST.TyconAbstract (((id), (binders), (kopt)))))
in (match (_63_2712) with
| (env, _63_2709, se, tconstr) -> begin
((env), ((FStar_Util.Inr (((se), (t), (quals))))::tcs))
end))
end
| _63_2714 -> begin
(FStar_All.failwith "Unrecognized mutual type definition")
end)
end)))
in (

let _63_2717 = (FStar_List.fold_left (collect_tcs quals) ((env), ([])) tcs)
in (match (_63_2717) with
| (env, tcs) -> begin
(

let tcs = (FStar_List.rev tcs)
in (

let sigelts = (FStar_All.pipe_right tcs (FStar_List.collect (fun _63_26 -> (match (_63_26) with
| FStar_Util.Inr (FStar_Absyn_Syntax.Sig_tycon (id, tpars, k, _63_2724, _63_2726, _63_2728, _63_2730), t, quals) -> begin
(

let env_tps = (push_tparams env tpars)
in (

let t = (desugar_typ env_tps t)
in (FStar_Absyn_Syntax.Sig_typ_abbrev (((id), (tpars), (k), (t), ([]), (rng))))::[]))
end
| FStar_Util.Inl (FStar_Absyn_Syntax.Sig_tycon (tname, tpars, k, mutuals, _63_2744, tags, _63_2747), constrs, tconstr, quals) -> begin
(

let tycon = ((tname), (tpars), (k))
in (

let env_tps = (push_tparams env tpars)
in (

let _63_2780 = (let _160_1008 = (FStar_All.pipe_right constrs (FStar_List.map (fun _63_2762 -> (match (_63_2762) with
| (id, topt, _63_2760, of_notation) -> begin
(

let t = if of_notation then begin
(match (topt) with
| Some (t) -> begin
(FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (((((FStar_Parser_AST.mk_binder (FStar_Parser_AST.NoName (t)) t.FStar_Parser_AST.range t.FStar_Parser_AST.level None))::[]), (tconstr)))) t.FStar_Parser_AST.range t.FStar_Parser_AST.level)
end
| None -> begin
tconstr
end)
end else begin
(match (topt) with
| None -> begin
(FStar_All.failwith "Impossible")
end
| Some (t) -> begin
t
end)
end
in (

let t = (let _160_1003 = (FStar_Parser_DesugarEnv.default_total env_tps)
in (let _160_1002 = (close env_tps t)
in (desugar_typ _160_1003 _160_1002)))
in (

let name = (FStar_Parser_DesugarEnv.qualify env id)
in (

let quals = (FStar_All.pipe_right tags (FStar_List.collect (fun _63_25 -> (match (_63_25) with
| FStar_Absyn_Syntax.RecordType (fns) -> begin
(FStar_Absyn_Syntax.RecordConstructor (fns))::[]
end
| _63_2776 -> begin
[]
end))))
in (let _160_1007 = (let _160_1006 = (let _160_1005 = (FStar_All.pipe_right t FStar_Absyn_Util.name_function_binders)
in ((name), (_160_1005), (tycon), (quals), (mutuals), (rng)))
in FStar_Absyn_Syntax.Sig_datacon (_160_1006))
in ((name), (_160_1007)))))))
end))))
in (FStar_All.pipe_left FStar_List.split _160_1008))
in (match (_63_2780) with
| (constrNames, constrs) -> begin
(FStar_Absyn_Syntax.Sig_tycon (((tname), (tpars), (k), (mutuals), (constrNames), (tags), (rng))))::constrs
end))))
end
| _63_2782 -> begin
(FStar_All.failwith "impossible")
end))))
in (

let bundle = (let _160_1010 = (let _160_1009 = (FStar_List.collect FStar_Absyn_Util.lids_of_sigelt sigelts)
in ((sigelts), (quals), (_160_1009), (rng)))
in FStar_Absyn_Syntax.Sig_bundle (_160_1010))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env0 bundle)
in (

let data_ops = (FStar_All.pipe_right sigelts (FStar_List.collect (mk_data_projectors env)))
in (

let discs = (FStar_All.pipe_right sigelts (FStar_List.collect (fun _63_27 -> (match (_63_27) with
| FStar_Absyn_Syntax.Sig_tycon (tname, tps, k, _63_2792, constrs, quals, _63_2796) -> begin
(mk_data_discriminators quals env tname tps k constrs)
end
| _63_2800 -> begin
[]
end))))
in (

let ops = (FStar_List.append discs data_ops)
in (

let env = (FStar_List.fold_left FStar_Parser_DesugarEnv.push_sigelt env ops)
in ((env), ((FStar_List.append ((bundle)::[]) ops)))))))))))
end)))))
end
| [] -> begin
(FStar_All.failwith "impossible")
end)))))))))))


let desugar_binders : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.binder Prims.list  ->  (FStar_Parser_DesugarEnv.env * FStar_Absyn_Syntax.binder Prims.list) = (fun env binders -> (

let _63_2831 = (FStar_List.fold_left (fun _63_2809 b -> (match (_63_2809) with
| (env, binders) -> begin
(match ((desugar_binder env b)) with
| FStar_Util.Inl (Some (a), k) -> begin
(

let _63_2818 = (FStar_Parser_DesugarEnv.push_local_tbinding env a)
in (match (_63_2818) with
| (env, a) -> begin
(let _160_1019 = (let _160_1018 = (FStar_Absyn_Syntax.t_binder (FStar_Absyn_Util.bvd_to_bvar_s a k))
in (_160_1018)::binders)
in ((env), (_160_1019)))
end))
end
| FStar_Util.Inr (Some (x), t) -> begin
(

let _63_2826 = (FStar_Parser_DesugarEnv.push_local_vbinding env x)
in (match (_63_2826) with
| (env, x) -> begin
(let _160_1021 = (let _160_1020 = (FStar_Absyn_Syntax.v_binder (FStar_Absyn_Util.bvd_to_bvar_s x t))
in (_160_1020)::binders)
in ((env), (_160_1021)))
end))
end
| _63_2828 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Missing name in binder"), (b.FStar_Parser_AST.brange)))))
end)
end)) ((env), ([])) binders)
in (match (_63_2831) with
| (env, binders) -> begin
((env), ((FStar_List.rev binders)))
end)))


let trans_qual : FStar_Range.range  ->  FStar_Parser_AST.qualifier  ->  FStar_Absyn_Syntax.qualifier = (fun r _63_28 -> (match (_63_28) with
| FStar_Parser_AST.Private -> begin
FStar_Absyn_Syntax.Private
end
| FStar_Parser_AST.Assumption -> begin
FStar_Absyn_Syntax.Assumption
end
| FStar_Parser_AST.Opaque -> begin
FStar_Absyn_Syntax.Opaque
end
| FStar_Parser_AST.Logic -> begin
FStar_Absyn_Syntax.Logic
end
| FStar_Parser_AST.Abstract -> begin
FStar_Absyn_Syntax.Abstract
end
| FStar_Parser_AST.New -> begin
FStar_Absyn_Syntax.New
end
| FStar_Parser_AST.TotalEffect -> begin
FStar_Absyn_Syntax.TotalEffect
end
| FStar_Parser_AST.DefaultEffect -> begin
FStar_Absyn_Syntax.DefaultEffect (None)
end
| FStar_Parser_AST.Effect -> begin
FStar_Absyn_Syntax.Effect
end
| (FStar_Parser_AST.Reflectable) | (FStar_Parser_AST.Reifiable) | (FStar_Parser_AST.Inline) | (FStar_Parser_AST.Irreducible) | (FStar_Parser_AST.Noeq) | (FStar_Parser_AST.Unopteq) | (FStar_Parser_AST.Visible) | (FStar_Parser_AST.Unfold_for_unification_and_vcgen) | (FStar_Parser_AST.NoExtract) -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("The noextract qualifier is supported only with the --universes option"), (r)))))
end
| FStar_Parser_AST.Inline_for_extraction -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("This qualifier is supported only with the --universes option"), (r)))))
end))


let trans_pragma : FStar_Parser_AST.pragma  ->  FStar_Absyn_Syntax.pragma = (fun _63_29 -> (match (_63_29) with
| FStar_Parser_AST.SetOptions (s) -> begin
FStar_Absyn_Syntax.SetOptions (s)
end
| FStar_Parser_AST.ResetOptions (s) -> begin
FStar_Absyn_Syntax.ResetOptions (s)
end))


let trans_quals : FStar_Range.range  ->  FStar_Parser_AST.qualifier Prims.list  ->  FStar_Absyn_Syntax.qualifier Prims.list = (fun r -> (FStar_List.map (trans_qual r)))


let rec desugar_decl : env_t  ->  FStar_Parser_AST.decl  ->  (env_t * FStar_Absyn_Syntax.sigelts) = (fun env d -> (

let trans_quals = (trans_quals d.FStar_Parser_AST.drange)
in (match (d.FStar_Parser_AST.d) with
| FStar_Parser_AST.Fsdoc (_63_2863) -> begin
((env), ([]))
end
| FStar_Parser_AST.Pragma (p) -> begin
(

let se = FStar_Absyn_Syntax.Sig_pragma ((((trans_pragma p)), (d.FStar_Parser_AST.drange)))
in ((env), ((se)::[])))
end
| FStar_Parser_AST.TopLevelModule (id) -> begin
((env), ([]))
end
| FStar_Parser_AST.Open (lid) -> begin
(

let env = (FStar_Parser_DesugarEnv.push_namespace env lid)
in ((env), ([])))
end
| FStar_Parser_AST.Include (_63_2874) -> begin
(FStar_All.failwith "include not supported by legacy desugaring")
end
| FStar_Parser_AST.ModuleAbbrev (x, l) -> begin
(let _160_1039 = (FStar_Parser_DesugarEnv.push_module_abbrev env x l)
in ((_160_1039), ([])))
end
| FStar_Parser_AST.Tycon (qual, tcs) -> begin
(

let tcs = (FStar_List.map (fun _63_2887 -> (match (_63_2887) with
| (x, _63_2886) -> begin
x
end)) tcs)
in (let _160_1041 = (trans_quals qual)
in (desugar_tycon env d.FStar_Parser_AST.drange _160_1041 tcs)))
end
| FStar_Parser_AST.TopLevelLet (quals, isrec, lets) -> begin
(match ((let _160_1043 = (let _160_1042 = (desugar_exp_maybe_top true env (FStar_Parser_AST.mk_term (FStar_Parser_AST.Let (((isrec), (lets), ((FStar_Parser_AST.mk_term (FStar_Parser_AST.Const (FStar_Const.Const_unit)) d.FStar_Parser_AST.drange FStar_Parser_AST.Expr))))) d.FStar_Parser_AST.drange FStar_Parser_AST.Expr))
in (FStar_All.pipe_left FStar_Absyn_Util.compress_exp _160_1042))
in _160_1043.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_let (lbs, _63_2896) -> begin
(

let lids = (FStar_All.pipe_right (Prims.snd lbs) (FStar_List.map (fun lb -> (match (lb.FStar_Absyn_Syntax.lbname) with
| FStar_Util.Inr (l) -> begin
l
end
| _63_2903 -> begin
(FStar_All.failwith "impossible")
end))))
in (

let quals = (match (quals) with
| (_63_2908)::_63_2906 -> begin
(trans_quals quals)
end
| _63_2911 -> begin
(FStar_All.pipe_right (Prims.snd lbs) (FStar_List.collect (fun _63_30 -> (match (_63_30) with
| {FStar_Absyn_Syntax.lbname = FStar_Util.Inl (_63_2920); FStar_Absyn_Syntax.lbtyp = _63_2918; FStar_Absyn_Syntax.lbeff = _63_2916; FStar_Absyn_Syntax.lbdef = _63_2914} -> begin
[]
end
| {FStar_Absyn_Syntax.lbname = FStar_Util.Inr (l); FStar_Absyn_Syntax.lbtyp = _63_2928; FStar_Absyn_Syntax.lbeff = _63_2926; FStar_Absyn_Syntax.lbdef = _63_2924} -> begin
(FStar_Parser_DesugarEnv.lookup_letbinding_quals env l)
end))))
end)
in (

let s = FStar_Absyn_Syntax.Sig_let (((lbs), (d.FStar_Parser_AST.drange), (lids), (quals)))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env s)
in ((env), ((s)::[]))))))
end
| _63_2936 -> begin
(FStar_All.failwith "Desugaring a let did not produce a let")
end)
end
| FStar_Parser_AST.Main (t) -> begin
(

let e = (desugar_exp env t)
in (

let se = FStar_Absyn_Syntax.Sig_main (((e), (d.FStar_Parser_AST.drange)))
in ((env), ((se)::[]))))
end
| FStar_Parser_AST.Assume (atag, id, t) -> begin
(

let f = (desugar_formula env t)
in (let _160_1049 = (let _160_1048 = (let _160_1047 = (let _160_1046 = (FStar_Parser_DesugarEnv.qualify env id)
in ((_160_1046), (f), ((FStar_Absyn_Syntax.Assumption)::[]), (d.FStar_Parser_AST.drange)))
in FStar_Absyn_Syntax.Sig_assume (_160_1047))
in (_160_1048)::[])
in ((env), (_160_1049))))
end
| FStar_Parser_AST.Val (quals, id, t) -> begin
(

let t = (let _160_1050 = (close_fun env t)
in (desugar_typ env _160_1050))
in (

let quals = if (env.FStar_Parser_DesugarEnv.iface && env.FStar_Parser_DesugarEnv.admitted_iface) then begin
(let _160_1051 = (trans_quals quals)
in (FStar_Absyn_Syntax.Assumption)::_160_1051)
end else begin
(trans_quals quals)
end
in (

let se = (let _160_1053 = (let _160_1052 = (FStar_Parser_DesugarEnv.qualify env id)
in ((_160_1052), (t), (quals), (d.FStar_Parser_AST.drange)))
in FStar_Absyn_Syntax.Sig_val_decl (_160_1053))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env se)
in ((env), ((se)::[]))))))
end
| FStar_Parser_AST.Exception (id, None) -> begin
(

let t = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) FStar_Absyn_Const.exn_lid)
in (

let l = (FStar_Parser_DesugarEnv.qualify env id)
in (

let se = FStar_Absyn_Syntax.Sig_datacon (((l), (t), (((FStar_Absyn_Const.exn_lid), ([]), (FStar_Absyn_Syntax.ktype))), ((FStar_Absyn_Syntax.ExceptionConstructor)::[]), ((FStar_Absyn_Const.exn_lid)::[]), (d.FStar_Parser_AST.drange)))
in (

let se' = FStar_Absyn_Syntax.Sig_bundle ((((se)::[]), ((FStar_Absyn_Syntax.ExceptionConstructor)::[]), ((l)::[]), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env se')
in (

let data_ops = (mk_data_projectors env se)
in (

let discs = (mk_data_discriminators [] env FStar_Absyn_Const.exn_lid [] FStar_Absyn_Syntax.ktype ((l)::[]))
in (

let env = (FStar_List.fold_left FStar_Parser_DesugarEnv.push_sigelt env (FStar_List.append discs data_ops))
in ((env), ((FStar_List.append ((se')::discs) data_ops)))))))))))
end
| FStar_Parser_AST.Exception (id, Some (term)) -> begin
(

let t = (desugar_typ env term)
in (

let t = (let _160_1058 = (let _160_1057 = (let _160_1054 = (FStar_Absyn_Syntax.null_v_binder t)
in (_160_1054)::[])
in (let _160_1056 = (let _160_1055 = (FStar_Parser_DesugarEnv.fail_or env (FStar_Parser_DesugarEnv.try_lookup_typ_name env) FStar_Absyn_Const.exn_lid)
in (FStar_Absyn_Syntax.mk_Total _160_1055))
in ((_160_1057), (_160_1056))))
in (FStar_Absyn_Syntax.mk_Typ_fun _160_1058 None d.FStar_Parser_AST.drange))
in (

let l = (FStar_Parser_DesugarEnv.qualify env id)
in (

let se = FStar_Absyn_Syntax.Sig_datacon (((l), (t), (((FStar_Absyn_Const.exn_lid), ([]), (FStar_Absyn_Syntax.ktype))), ((FStar_Absyn_Syntax.ExceptionConstructor)::[]), ((FStar_Absyn_Const.exn_lid)::[]), (d.FStar_Parser_AST.drange)))
in (

let se' = FStar_Absyn_Syntax.Sig_bundle ((((se)::[]), ((FStar_Absyn_Syntax.ExceptionConstructor)::[]), ((l)::[]), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env se')
in (

let data_ops = (mk_data_projectors env se)
in (

let discs = (mk_data_discriminators [] env FStar_Absyn_Const.exn_lid [] FStar_Absyn_Syntax.ktype ((l)::[]))
in (

let env = (FStar_List.fold_left FStar_Parser_DesugarEnv.push_sigelt env (FStar_List.append discs data_ops))
in ((env), ((FStar_List.append ((se')::discs) data_ops))))))))))))
end
| FStar_Parser_AST.KindAbbrev (id, binders, k) -> begin
(

let _63_2989 = (desugar_binders env binders)
in (match (_63_2989) with
| (env_k, binders) -> begin
(

let k = (desugar_kind env_k k)
in (

let name = (FStar_Parser_DesugarEnv.qualify env id)
in (

let se = FStar_Absyn_Syntax.Sig_kind_abbrev (((name), (binders), (k), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env se)
in ((env), ((se)::[]))))))
end))
end
| FStar_Parser_AST.NewEffectForFree (_63_2995) -> begin
(FStar_All.failwith "effects for free only supported in conjunction with --universes")
end
| FStar_Parser_AST.NewEffect (quals, FStar_Parser_AST.RedefineEffect (eff_name, eff_binders, defn)) -> begin
(

let env0 = env
in (

let _63_3008 = (desugar_binders env eff_binders)
in (match (_63_3008) with
| (env, binders) -> begin
(

let defn = (desugar_typ env defn)
in (

let _63_3012 = (FStar_Absyn_Util.head_and_args defn)
in (match (_63_3012) with
| (head, args) -> begin
(match (head.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_const (eff) -> begin
(match ((FStar_Parser_DesugarEnv.try_lookup_effect_defn env eff.FStar_Absyn_Syntax.v)) with
| None -> begin
(let _160_1063 = (let _160_1062 = (let _160_1061 = (let _160_1060 = (let _160_1059 = (FStar_Absyn_Print.sli eff.FStar_Absyn_Syntax.v)
in (Prims.strcat _160_1059 " not found"))
in (Prims.strcat "Effect " _160_1060))
in ((_160_1061), (d.FStar_Parser_AST.drange)))
in FStar_Absyn_Syntax.Error (_160_1062))
in (Prims.raise _160_1063))
end
| Some (ed) -> begin
(

let subst = (FStar_Absyn_Util.subst_of_list ed.FStar_Absyn_Syntax.binders args)
in (

let sub = (FStar_Absyn_Util.subst_typ subst)
in (

let ed = (let _160_1081 = (FStar_Parser_DesugarEnv.qualify env0 eff_name)
in (let _160_1080 = (trans_quals quals)
in (let _160_1079 = (FStar_Absyn_Util.subst_kind subst ed.FStar_Absyn_Syntax.signature)
in (let _160_1078 = (sub ed.FStar_Absyn_Syntax.ret)
in (let _160_1077 = (sub ed.FStar_Absyn_Syntax.bind_wp)
in (let _160_1076 = (sub ed.FStar_Absyn_Syntax.bind_wlp)
in (let _160_1075 = (sub ed.FStar_Absyn_Syntax.if_then_else)
in (let _160_1074 = (sub ed.FStar_Absyn_Syntax.ite_wp)
in (let _160_1073 = (sub ed.FStar_Absyn_Syntax.ite_wlp)
in (let _160_1072 = (sub ed.FStar_Absyn_Syntax.wp_binop)
in (let _160_1071 = (sub ed.FStar_Absyn_Syntax.wp_as_type)
in (let _160_1070 = (sub ed.FStar_Absyn_Syntax.close_wp)
in (let _160_1069 = (sub ed.FStar_Absyn_Syntax.close_wp_t)
in (let _160_1068 = (sub ed.FStar_Absyn_Syntax.assert_p)
in (let _160_1067 = (sub ed.FStar_Absyn_Syntax.assume_p)
in (let _160_1066 = (sub ed.FStar_Absyn_Syntax.null_wp)
in (let _160_1065 = (sub ed.FStar_Absyn_Syntax.trivial)
in {FStar_Absyn_Syntax.mname = _160_1081; FStar_Absyn_Syntax.binders = binders; FStar_Absyn_Syntax.qualifiers = _160_1080; FStar_Absyn_Syntax.signature = _160_1079; FStar_Absyn_Syntax.ret = _160_1078; FStar_Absyn_Syntax.bind_wp = _160_1077; FStar_Absyn_Syntax.bind_wlp = _160_1076; FStar_Absyn_Syntax.if_then_else = _160_1075; FStar_Absyn_Syntax.ite_wp = _160_1074; FStar_Absyn_Syntax.ite_wlp = _160_1073; FStar_Absyn_Syntax.wp_binop = _160_1072; FStar_Absyn_Syntax.wp_as_type = _160_1071; FStar_Absyn_Syntax.close_wp = _160_1070; FStar_Absyn_Syntax.close_wp_t = _160_1069; FStar_Absyn_Syntax.assert_p = _160_1068; FStar_Absyn_Syntax.assume_p = _160_1067; FStar_Absyn_Syntax.null_wp = _160_1066; FStar_Absyn_Syntax.trivial = _160_1065})))))))))))))))))
in (

let se = FStar_Absyn_Syntax.Sig_new_effect (((ed), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env0 se)
in ((env), ((se)::[])))))))
end)
end
| _63_3024 -> begin
(let _160_1085 = (let _160_1084 = (let _160_1083 = (let _160_1082 = (FStar_Absyn_Print.typ_to_string head)
in (Prims.strcat _160_1082 " is not an effect"))
in ((_160_1083), (d.FStar_Parser_AST.drange)))
in FStar_Absyn_Syntax.Error (_160_1084))
in (Prims.raise _160_1085))
end)
end)))
end)))
end
| FStar_Parser_AST.NewEffect (quals, FStar_Parser_AST.DefineEffect (eff_name, eff_binders, eff_kind, eff_decls, _actions)) -> begin
(

let env0 = env
in (

let env = (FStar_Parser_DesugarEnv.enter_monad_scope env eff_name)
in (

let _63_3039 = (desugar_binders env eff_binders)
in (match (_63_3039) with
| (env, binders) -> begin
(

let eff_k = (desugar_kind env eff_kind)
in (

let _63_3050 = (FStar_All.pipe_right eff_decls (FStar_List.fold_left (fun _63_3043 decl -> (match (_63_3043) with
| (env, out) -> begin
(

let _63_3047 = (desugar_decl env decl)
in (match (_63_3047) with
| (env, ses) -> begin
(let _160_1089 = (let _160_1088 = (FStar_List.hd ses)
in (_160_1088)::out)
in ((env), (_160_1089)))
end))
end)) ((env), ([]))))
in (match (_63_3050) with
| (env, decls) -> begin
(

let decls = (FStar_List.rev decls)
in (

let lookup = (fun s -> (match ((let _160_1093 = (let _160_1092 = (FStar_Absyn_Syntax.mk_ident ((s), (d.FStar_Parser_AST.drange)))
in (FStar_Parser_DesugarEnv.qualify env _160_1092))
in (FStar_Parser_DesugarEnv.try_resolve_typ_abbrev env _160_1093))) with
| None -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((((Prims.strcat "Monad " (Prims.strcat eff_name.FStar_Ident.idText (Prims.strcat " expects definition of " s)))), (d.FStar_Parser_AST.drange)))))
end
| Some (t) -> begin
t
end))
in (

let ed = (let _160_1109 = (FStar_Parser_DesugarEnv.qualify env0 eff_name)
in (let _160_1108 = (trans_quals quals)
in (let _160_1107 = (lookup "return")
in (let _160_1106 = (lookup "bind_wp")
in (let _160_1105 = (lookup "bind_wlp")
in (let _160_1104 = (lookup "if_then_else")
in (let _160_1103 = (lookup "ite_wp")
in (let _160_1102 = (lookup "ite_wlp")
in (let _160_1101 = (lookup "wp_binop")
in (let _160_1100 = (lookup "wp_as_type")
in (let _160_1099 = (lookup "close_wp")
in (let _160_1098 = (lookup "close_wp_t")
in (let _160_1097 = (lookup "assert_p")
in (let _160_1096 = (lookup "assume_p")
in (let _160_1095 = (lookup "null_wp")
in (let _160_1094 = (lookup "trivial")
in {FStar_Absyn_Syntax.mname = _160_1109; FStar_Absyn_Syntax.binders = binders; FStar_Absyn_Syntax.qualifiers = _160_1108; FStar_Absyn_Syntax.signature = eff_k; FStar_Absyn_Syntax.ret = _160_1107; FStar_Absyn_Syntax.bind_wp = _160_1106; FStar_Absyn_Syntax.bind_wlp = _160_1105; FStar_Absyn_Syntax.if_then_else = _160_1104; FStar_Absyn_Syntax.ite_wp = _160_1103; FStar_Absyn_Syntax.ite_wlp = _160_1102; FStar_Absyn_Syntax.wp_binop = _160_1101; FStar_Absyn_Syntax.wp_as_type = _160_1100; FStar_Absyn_Syntax.close_wp = _160_1099; FStar_Absyn_Syntax.close_wp_t = _160_1098; FStar_Absyn_Syntax.assert_p = _160_1097; FStar_Absyn_Syntax.assume_p = _160_1096; FStar_Absyn_Syntax.null_wp = _160_1095; FStar_Absyn_Syntax.trivial = _160_1094}))))))))))))))))
in (

let se = FStar_Absyn_Syntax.Sig_new_effect (((ed), (d.FStar_Parser_AST.drange)))
in (

let env = (FStar_Parser_DesugarEnv.push_sigelt env0 se)
in ((env), ((se)::[])))))))
end)))
end))))
end
| FStar_Parser_AST.SubEffect (l) -> begin
(

let lookup = (fun l -> (match ((FStar_Parser_DesugarEnv.try_lookup_effect_name env l)) with
| None -> begin
(let _160_1116 = (let _160_1115 = (let _160_1114 = (let _160_1113 = (let _160_1112 = (FStar_Absyn_Print.sli l)
in (Prims.strcat _160_1112 " not found"))
in (Prims.strcat "Effect name " _160_1113))
in ((_160_1114), (d.FStar_Parser_AST.drange)))
in FStar_Absyn_Syntax.Error (_160_1115))
in (Prims.raise _160_1116))
end
| Some (l) -> begin
l
end))
in (

let src = (lookup l.FStar_Parser_AST.msource)
in (

let dst = (lookup l.FStar_Parser_AST.mdest)
in (

let non_reifiable = (fun _63_31 -> (match (_63_31) with
| FStar_Parser_AST.NonReifiableLift (f) -> begin
f
end
| _63_3073 -> begin
(Prims.raise (FStar_Absyn_Syntax.Error ((("Unexpected reifiable sub-effect"), (d.FStar_Parser_AST.drange)))))
end))
in (

let lift = (let _160_1119 = (non_reifiable l.FStar_Parser_AST.lift_op)
in (desugar_typ env _160_1119))
in (

let se = FStar_Absyn_Syntax.Sig_sub_effect ((({FStar_Absyn_Syntax.source = src; FStar_Absyn_Syntax.target = dst; FStar_Absyn_Syntax.lift = lift}), (d.FStar_Parser_AST.drange)))
in ((env), ((se)::[]))))))))
end)))


let desugar_decls : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.decl Prims.list  ->  (FStar_Parser_DesugarEnv.env * FStar_Absyn_Syntax.sigelts) = (fun env decls -> (FStar_List.fold_left (fun _63_3081 d -> (match (_63_3081) with
| (env, sigelts) -> begin
(

let _63_3085 = (desugar_decl env d)
in (match (_63_3085) with
| (env, se) -> begin
((env), ((FStar_List.append sigelts se)))
end))
end)) ((env), ([])) decls))


let open_prims_all : (FStar_Parser_AST.fsdoc Prims.option  ->  FStar_Parser_AST.decl) Prims.list = ((FStar_Parser_AST.mk_decl (FStar_Parser_AST.Open (FStar_Absyn_Const.prims_lid)) FStar_Absyn_Syntax.dummyRange))::((FStar_Parser_AST.mk_decl (FStar_Parser_AST.Open (FStar_Absyn_Const.all_lid)) FStar_Absyn_Syntax.dummyRange))::[]


let desugar_modul_common : FStar_Absyn_Syntax.modul Prims.option  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.modul  ->  (env_t * FStar_Absyn_Syntax.modul * Prims.bool) = (fun curmod env m -> (

let open_ns = (fun mname d -> (

let d = if ((FStar_List.length mname.FStar_Ident.ns) <> (Prims.parse_int "0")) then begin
(let _160_1144 = (let _160_1143 = (let _160_1141 = (FStar_Absyn_Syntax.lid_of_ids mname.FStar_Ident.ns)
in FStar_Parser_AST.Open (_160_1141))
in (let _160_1142 = (FStar_Absyn_Syntax.range_of_lid mname)
in (FStar_Parser_AST.mk_decl _160_1143 _160_1142 None)))
in (_160_1144)::d)
end else begin
d
end
in d))
in (

let env = (match (curmod) with
| None -> begin
env
end
| Some (prev_mod) -> begin
(FStar_Parser_DesugarEnv.finish_module_or_interface env prev_mod)
end)
in (

let _63_3112 = (match (m) with
| FStar_Parser_AST.Interface (mname, decls, admitted) -> begin
(let _160_1146 = (FStar_Parser_DesugarEnv.prepare_module_or_interface true admitted env mname)
in (let _160_1145 = (open_ns mname decls)
in ((_160_1146), (mname), (_160_1145), (true))))
end
| FStar_Parser_AST.Module (mname, decls) -> begin
(let _160_1148 = (FStar_Parser_DesugarEnv.prepare_module_or_interface false false env mname)
in (let _160_1147 = (open_ns mname decls)
in ((_160_1148), (mname), (_160_1147), (false))))
end)
in (match (_63_3112) with
| ((env, pop_when_done), mname, decls, intf) -> begin
(

let _63_3115 = (desugar_decls env decls)
in (match (_63_3115) with
| (env, sigelts) -> begin
(

let modul = {FStar_Absyn_Syntax.name = mname; FStar_Absyn_Syntax.declarations = sigelts; FStar_Absyn_Syntax.exports = []; FStar_Absyn_Syntax.is_interface = intf; FStar_Absyn_Syntax.is_deserialized = false}
in ((env), (modul), (pop_when_done)))
end))
end)))))


let desugar_partial_modul : FStar_Absyn_Syntax.modul Prims.option  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.modul  ->  (FStar_Parser_DesugarEnv.env * FStar_Absyn_Syntax.modul) = (fun curmod env m -> (

let m = if (FStar_Options.interactive_fsi ()) then begin
(match (m) with
| FStar_Parser_AST.Module (mname, decls) -> begin
FStar_Parser_AST.Interface (((mname), (decls), (true)))
end
| FStar_Parser_AST.Interface (mname, _63_3126, _63_3128) -> begin
(FStar_All.failwith (Prims.strcat "Impossible: " mname.FStar_Ident.ident.FStar_Ident.idText))
end)
end else begin
m
end
in (

let _63_3136 = (desugar_modul_common curmod env m)
in (match (_63_3136) with
| (x, y, _63_3135) -> begin
((x), (y))
end))))


let desugar_modul : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.modul  ->  (env_t * FStar_Absyn_Syntax.modul) = (fun env m -> (

let _63_3142 = (desugar_modul_common None env m)
in (match (_63_3142) with
| (env, modul, pop_when_done) -> begin
(

let env = (FStar_Parser_DesugarEnv.finish_module_or_interface env modul)
in (

let _63_3144 = if (FStar_Options.dump_module modul.FStar_Absyn_Syntax.name.FStar_Ident.str) then begin
(let _160_1159 = (FStar_Absyn_Print.modul_to_string modul)
in (FStar_Util.print1 "%s\n" _160_1159))
end else begin
()
end
in (let _160_1160 = if pop_when_done then begin
(FStar_Parser_DesugarEnv.export_interface modul.FStar_Absyn_Syntax.name env)
end else begin
env
end
in ((_160_1160), (modul)))))
end)))


let desugar_file : FStar_Parser_DesugarEnv.env  ->  FStar_Parser_AST.file  ->  (FStar_Parser_DesugarEnv.env * FStar_Absyn_Syntax.modul Prims.list) = (fun env f -> (

let _63_3157 = (FStar_List.fold_left (fun _63_3150 m -> (match (_63_3150) with
| (env, mods) -> begin
(

let _63_3154 = (desugar_modul env m)
in (match (_63_3154) with
| (env, m) -> begin
((env), ((m)::mods))
end))
end)) ((env), ([])) f)
in (match (_63_3157) with
| (env, mods) -> begin
((env), ((FStar_List.rev mods)))
end)))


let add_modul_to_env : FStar_Absyn_Syntax.modul  ->  FStar_Parser_DesugarEnv.env  ->  FStar_Parser_DesugarEnv.env = (fun m en -> (

let _63_3162 = (FStar_Parser_DesugarEnv.prepare_module_or_interface false false en m.FStar_Absyn_Syntax.name)
in (match (_63_3162) with
| (en, pop_when_done) -> begin
(

let en = (FStar_List.fold_left FStar_Parser_DesugarEnv.push_sigelt (

let _63_3163 = en
in {FStar_Parser_DesugarEnv.curmodule = Some (m.FStar_Absyn_Syntax.name); FStar_Parser_DesugarEnv.modules = _63_3163.FStar_Parser_DesugarEnv.modules; FStar_Parser_DesugarEnv.open_namespaces = _63_3163.FStar_Parser_DesugarEnv.open_namespaces; FStar_Parser_DesugarEnv.modul_abbrevs = _63_3163.FStar_Parser_DesugarEnv.modul_abbrevs; FStar_Parser_DesugarEnv.sigaccum = _63_3163.FStar_Parser_DesugarEnv.sigaccum; FStar_Parser_DesugarEnv.localbindings = _63_3163.FStar_Parser_DesugarEnv.localbindings; FStar_Parser_DesugarEnv.recbindings = _63_3163.FStar_Parser_DesugarEnv.recbindings; FStar_Parser_DesugarEnv.phase = _63_3163.FStar_Parser_DesugarEnv.phase; FStar_Parser_DesugarEnv.sigmap = _63_3163.FStar_Parser_DesugarEnv.sigmap; FStar_Parser_DesugarEnv.default_result_effect = _63_3163.FStar_Parser_DesugarEnv.default_result_effect; FStar_Parser_DesugarEnv.iface = _63_3163.FStar_Parser_DesugarEnv.iface; FStar_Parser_DesugarEnv.admitted_iface = _63_3163.FStar_Parser_DesugarEnv.admitted_iface}) m.FStar_Absyn_Syntax.exports)
in (

let env = (FStar_Parser_DesugarEnv.finish_module_or_interface en m)
in if pop_when_done then begin
(FStar_Parser_DesugarEnv.export_interface m.FStar_Absyn_Syntax.name env)
end else begin
env
end))
end)))




