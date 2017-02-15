
open Prims
type debug_level_t =
| Low
| Medium
| High
| Extreme
| Other of Prims.string


let uu___is_Low : debug_level_t  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Low -> begin
true
end
| uu____7 -> begin
false
end))


let uu___is_Medium : debug_level_t  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Medium -> begin
true
end
| uu____11 -> begin
false
end))


let uu___is_High : debug_level_t  ->  Prims.bool = (fun projectee -> (match (projectee) with
| High -> begin
true
end
| uu____15 -> begin
false
end))


let uu___is_Extreme : debug_level_t  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Extreme -> begin
true
end
| uu____19 -> begin
false
end))


let uu___is_Other : debug_level_t  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Other (_0) -> begin
true
end
| uu____24 -> begin
false
end))


let __proj__Other__item___0 : debug_level_t  ->  Prims.string = (fun projectee -> (match (projectee) with
| Other (_0) -> begin
_0
end))

type option_val =
| Bool of Prims.bool
| String of Prims.string
| Int of Prims.int
| List of option_val Prims.list
| Unset


let uu___is_Bool : option_val  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Bool (_0) -> begin
true
end
| uu____49 -> begin
false
end))


let __proj__Bool__item___0 : option_val  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Bool (_0) -> begin
_0
end))


let uu___is_String : option_val  ->  Prims.bool = (fun projectee -> (match (projectee) with
| String (_0) -> begin
true
end
| uu____61 -> begin
false
end))


let __proj__String__item___0 : option_val  ->  Prims.string = (fun projectee -> (match (projectee) with
| String (_0) -> begin
_0
end))


let uu___is_Int : option_val  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Int (_0) -> begin
true
end
| uu____73 -> begin
false
end))


let __proj__Int__item___0 : option_val  ->  Prims.int = (fun projectee -> (match (projectee) with
| Int (_0) -> begin
_0
end))


let uu___is_List : option_val  ->  Prims.bool = (fun projectee -> (match (projectee) with
| List (_0) -> begin
true
end
| uu____86 -> begin
false
end))


let __proj__List__item___0 : option_val  ->  option_val Prims.list = (fun projectee -> (match (projectee) with
| List (_0) -> begin
_0
end))


let uu___is_Unset : option_val  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Unset -> begin
true
end
| uu____100 -> begin
false
end))

type options =
| Set
| Reset
| Restore


let uu___is_Set : options  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Set -> begin
true
end
| uu____104 -> begin
false
end))


let uu___is_Reset : options  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Reset -> begin
true
end
| uu____108 -> begin
false
end))


let uu___is_Restore : options  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Restore -> begin
true
end
| uu____112 -> begin
false
end))


let __unit_tests__ : Prims.bool FStar_ST.ref = (FStar_Util.mk_ref false)


let __unit_tests : Prims.unit  ->  Prims.bool = (fun uu____118 -> (FStar_ST.read __unit_tests__))


let __set_unit_tests : Prims.unit  ->  Prims.unit = (fun uu____123 -> (FStar_ST.write __unit_tests__ true))


let __clear_unit_tests : Prims.unit  ->  Prims.unit = (fun uu____128 -> (FStar_ST.write __unit_tests__ false))


let as_bool : option_val  ->  Prims.bool = (fun uu___43_133 -> (match (uu___43_133) with
| Bool (b) -> begin
b
end
| uu____135 -> begin
(failwith "Impos: expected Bool")
end))


let as_int : option_val  ->  Prims.int = (fun uu___44_138 -> (match (uu___44_138) with
| Int (b) -> begin
b
end
| uu____140 -> begin
(failwith "Impos: expected Int")
end))


let as_string : option_val  ->  Prims.string = (fun uu___45_143 -> (match (uu___45_143) with
| String (b) -> begin
b
end
| uu____145 -> begin
(failwith "Impos: expected String")
end))


let as_list = (fun as_t uu___46_161 -> (match (uu___46_161) with
| List (ts) -> begin
(FStar_All.pipe_right ts (FStar_List.map as_t))
end
| uu____168 -> begin
(failwith "Impos: expected List")
end))


let as_option = (fun as_t uu___47_185 -> (match (uu___47_185) with
| Unset -> begin
None
end
| v -> begin
Some ((as_t v))
end))


let fstar_options : option_val FStar_Util.smap Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let peek : Prims.unit  ->  option_val FStar_Util.smap = (fun uu____200 -> (FStar_List.hd (FStar_ST.read fstar_options)))


let pop : Prims.unit  ->  Prims.unit = (fun uu____208 -> (

let uu____209 = (FStar_ST.read fstar_options)
in (match (uu____209) with
| ([]) | ((_)::[]) -> begin
(failwith "TOO MANY POPS!")
end
| (uu____220)::tl -> begin
(FStar_ST.write fstar_options tl)
end)))


let push : Prims.unit  ->  Prims.unit = (fun uu____232 -> (let _0_27 = (let _0_26 = (FStar_Util.smap_copy (peek ()))
in (let _0_25 = (FStar_ST.read fstar_options)
in (_0_26)::_0_25))
in (FStar_ST.write fstar_options _0_27)))


let set_option : Prims.string  ->  option_val  ->  Prims.unit = (fun k v -> (let _0_28 = (peek ())
in (FStar_Util.smap_add _0_28 k v)))


let set_option' : (Prims.string * option_val)  ->  Prims.unit = (fun uu____252 -> (match (uu____252) with
| (k, v) -> begin
(set_option k v)
end))


let light_off_files : Prims.string Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let add_light_off_file : Prims.string  ->  Prims.unit = (fun filename -> (let _0_30 = (let _0_29 = (FStar_ST.read light_off_files)
in (filename)::_0_29)
in (FStar_ST.write light_off_files _0_30)))


let init : Prims.unit  ->  Prims.unit = (fun uu____273 -> (

let vals = ((("__temp_no_proj"), (List ([]))))::((("_fstar_home"), (String (""))))::((("_include_path"), (List ([]))))::((("admit_smt_queries"), (Bool (false))))::((("cardinality"), (String ("off"))))::((("codegen"), (Unset)))::((("codegen-lib"), (List ([]))))::((("debug"), (List ([]))))::((("debug_level"), (List ([]))))::((("dep"), (Unset)))::((("detail_errors"), (Bool (false))))::((("doc"), (Bool (false))))::((("dump_module"), (List ([]))))::((("eager_inference"), (Bool (false))))::((("explicit_deps"), (Bool (false))))::((("extract_all"), (Bool (false))))::((("extract_module"), (List ([]))))::((("extract_namespace"), (List ([]))))::((("fs_typ_app"), (Bool (false))))::((("fsi"), (Bool (false))))::((("fstar_home"), (Unset)))::((("full_context_dependency"), (Bool (true))))::((("hide_genident_nums"), (Bool (false))))::((("hide_uvar_nums"), (Bool (false))))::((("hint_info"), (Bool (false))))::((("in"), (Bool (false))))::((("include"), (List ([]))))::((("indent"), (Bool (false))))::((("initial_fuel"), (Int ((Prims.parse_int "2")))))::((("initial_ifuel"), (Int ((Prims.parse_int "1")))))::((("inline_arith"), (Bool (false))))::((("lax"), (Bool (false))))::((("log_queries"), (Bool (false))))::((("log_types"), (Bool (false))))::((("max_fuel"), (Int ((Prims.parse_int "8")))))::((("max_ifuel"), (Int ((Prims.parse_int "2")))))::((("min_fuel"), (Int ((Prims.parse_int "1")))))::((("MLish"), (Bool (false))))::((("n_cores"), (Int ((Prims.parse_int "1")))))::((("no_default_includes"), (Bool (false))))::((("no_extract"), (List ([]))))::((("no_location_info"), (Bool (false))))::((("no_warn_top_level_effects"), (Bool (true))))::((("odir"), (Unset)))::((("prims"), (Unset)))::((("pretype"), (Bool (true))))::((("prims_ref"), (Unset)))::((("print_before_norm"), (Bool (false))))::((("print_bound_var_types"), (Bool (false))))::((("print_effect_args"), (Bool (false))))::((("print_fuels"), (Bool (false))))::((("print_implicits"), (Bool (false))))::((("print_universes"), (Bool (false))))::((("print_z3_statistics"), (Bool (false))))::((("prn"), (Bool (false))))::((("record_hints"), (Bool (false))))::((("reuse_hint_for"), (Unset)))::((("show_signatures"), (List ([]))))::((("silent"), (Bool (false))))::((("smt"), (Unset)))::((("split_cases"), (Int ((Prims.parse_int "0")))))::((("timing"), (Bool (false))))::((("trace_error"), (Bool (false))))::((("unthrottle_inductives"), (Bool (false))))::((("use_eq_at_higher_order"), (Bool (false))))::((("use_hints"), (Bool (false))))::((("verify"), (Bool (true))))::((("verify_all"), (Bool (false))))::((("verify_module"), (List ([]))))::((("warn_default_effects"), (Bool (false))))::((("z3refresh"), (Bool (false))))::((("z3rlimit"), (Int ((Prims.parse_int "5")))))::((("z3seed"), (Int ((Prims.parse_int "0")))))::((("z3timeout"), (Int ((Prims.parse_int "5")))))::((("z3cliopt"), (List ([]))))::((("__no_positivity"), (Bool (false))))::[]
in (

let o = (peek ())
in ((FStar_Util.smap_clear o);
(FStar_All.pipe_right vals (FStar_List.iter set_option'));
))))


let clear : Prims.unit  ->  Prims.unit = (fun uu____442 -> (

let o = (FStar_Util.smap_create (Prims.parse_int "50"))
in ((FStar_ST.write fstar_options ((o)::[]));
(FStar_ST.write light_off_files []);
(init ());
)))


let _run : Prims.unit = (clear ())


let lookup_opt = (fun s c -> (

let uu____473 = (let _0_31 = (peek ())
in (FStar_Util.smap_try_find _0_31 s))
in (match (uu____473) with
| None -> begin
(failwith (Prims.strcat "Impossible: option " (Prims.strcat s " not found")))
end
| Some (s) -> begin
(c s)
end)))


let get_admit_smt_queries : Prims.unit  ->  Prims.bool = (fun uu____478 -> (lookup_opt "admit_smt_queries" as_bool))


let get_cardinality : Prims.unit  ->  Prims.string = (fun uu____481 -> (lookup_opt "cardinality" as_string))


let get_codegen : Prims.unit  ->  Prims.string Prims.option = (fun uu____485 -> (lookup_opt "codegen" (as_option as_string)))


let get_codegen_lib : Prims.unit  ->  Prims.string Prims.list = (fun uu____490 -> (lookup_opt "codegen-lib" (as_list as_string)))


let get_debug : Prims.unit  ->  Prims.string Prims.list = (fun uu____495 -> (lookup_opt "debug" (as_list as_string)))


let get_debug_level : Prims.unit  ->  Prims.string Prims.list = (fun uu____500 -> (lookup_opt "debug_level" (as_list as_string)))


let get_dep : Prims.unit  ->  Prims.string Prims.option = (fun uu____505 -> (lookup_opt "dep" (as_option as_string)))


let get_detail_errors : Prims.unit  ->  Prims.bool = (fun uu____509 -> (lookup_opt "detail_errors" as_bool))


let get_doc : Prims.unit  ->  Prims.bool = (fun uu____512 -> (lookup_opt "doc" as_bool))


let get_dump_module : Prims.unit  ->  Prims.string Prims.list = (fun uu____516 -> (lookup_opt "dump_module" (as_list as_string)))


let get_eager_inference : Prims.unit  ->  Prims.bool = (fun uu____520 -> (lookup_opt "eager_inference" as_bool))


let get_explicit_deps : Prims.unit  ->  Prims.bool = (fun uu____523 -> (lookup_opt "explicit_deps" as_bool))


let get_extract_all : Prims.unit  ->  Prims.bool = (fun uu____526 -> (lookup_opt "extract_all" as_bool))


let get_extract_module : Prims.unit  ->  Prims.string Prims.list = (fun uu____530 -> (lookup_opt "extract_module" (as_list as_string)))


let get_extract_namespace : Prims.unit  ->  Prims.string Prims.list = (fun uu____535 -> (lookup_opt "extract_namespace" (as_list as_string)))


let get_fs_typ_app : Prims.unit  ->  Prims.bool = (fun uu____539 -> (lookup_opt "fs_typ_app" as_bool))


let get_fstar_home : Prims.unit  ->  Prims.string Prims.option = (fun uu____543 -> (lookup_opt "fstar_home" (as_option as_string)))


let get_hide_genident_nums : Prims.unit  ->  Prims.bool = (fun uu____547 -> (lookup_opt "hide_genident_nums" as_bool))


let get_hide_uvar_nums : Prims.unit  ->  Prims.bool = (fun uu____550 -> (lookup_opt "hide_uvar_nums" as_bool))


let get_hint_info : Prims.unit  ->  Prims.bool = (fun uu____553 -> (lookup_opt "hint_info" as_bool))


let get_in : Prims.unit  ->  Prims.bool = (fun uu____556 -> (lookup_opt "in" as_bool))


let get_include : Prims.unit  ->  Prims.string Prims.list = (fun uu____560 -> (lookup_opt "include" (as_list as_string)))


let get_indent : Prims.unit  ->  Prims.bool = (fun uu____564 -> (lookup_opt "indent" as_bool))


let get_initial_fuel : Prims.unit  ->  Prims.int = (fun uu____567 -> (lookup_opt "initial_fuel" as_int))


let get_initial_ifuel : Prims.unit  ->  Prims.int = (fun uu____570 -> (lookup_opt "initial_ifuel" as_int))


let get_inline_arith : Prims.unit  ->  Prims.bool = (fun uu____573 -> (lookup_opt "inline_arith" as_bool))


let get_lax : Prims.unit  ->  Prims.bool = (fun uu____576 -> (lookup_opt "lax" as_bool))


let get_log_queries : Prims.unit  ->  Prims.bool = (fun uu____579 -> (lookup_opt "log_queries" as_bool))


let get_log_types : Prims.unit  ->  Prims.bool = (fun uu____582 -> (lookup_opt "log_types" as_bool))


let get_max_fuel : Prims.unit  ->  Prims.int = (fun uu____585 -> (lookup_opt "max_fuel" as_int))


let get_max_ifuel : Prims.unit  ->  Prims.int = (fun uu____588 -> (lookup_opt "max_ifuel" as_int))


let get_min_fuel : Prims.unit  ->  Prims.int = (fun uu____591 -> (lookup_opt "min_fuel" as_int))


let get_MLish : Prims.unit  ->  Prims.bool = (fun uu____594 -> (lookup_opt "MLish" as_bool))


let get_n_cores : Prims.unit  ->  Prims.int = (fun uu____597 -> (lookup_opt "n_cores" as_int))


let get_no_default_includes : Prims.unit  ->  Prims.bool = (fun uu____600 -> (lookup_opt "no_default_includes" as_bool))


let get_no_extract : Prims.unit  ->  Prims.string Prims.list = (fun uu____604 -> (lookup_opt "no_extract" (as_list as_string)))


let get_no_location_info : Prims.unit  ->  Prims.bool = (fun uu____608 -> (lookup_opt "no_location_info" as_bool))


let get_warn_top_level_effects : Prims.unit  ->  Prims.bool = (fun uu____611 -> (lookup_opt "no_warn_top_level_effects" as_bool))


let get_odir : Prims.unit  ->  Prims.string Prims.option = (fun uu____615 -> (lookup_opt "odir" (as_option as_string)))


let get_prims : Prims.unit  ->  Prims.string Prims.option = (fun uu____620 -> (lookup_opt "prims" (as_option as_string)))


let get_print_before_norm : Prims.unit  ->  Prims.bool = (fun uu____624 -> (lookup_opt "print_before_norm" as_bool))


let get_print_bound_var_types : Prims.unit  ->  Prims.bool = (fun uu____627 -> (lookup_opt "print_bound_var_types" as_bool))


let get_print_effect_args : Prims.unit  ->  Prims.bool = (fun uu____630 -> (lookup_opt "print_effect_args" as_bool))


let get_print_fuels : Prims.unit  ->  Prims.bool = (fun uu____633 -> (lookup_opt "print_fuels" as_bool))


let get_print_implicits : Prims.unit  ->  Prims.bool = (fun uu____636 -> (lookup_opt "print_implicits" as_bool))


let get_print_universes : Prims.unit  ->  Prims.bool = (fun uu____639 -> (lookup_opt "print_universes" as_bool))


let get_print_z3_statistics : Prims.unit  ->  Prims.bool = (fun uu____642 -> (lookup_opt "print_z3_statistics" as_bool))


let get_prn : Prims.unit  ->  Prims.bool = (fun uu____645 -> (lookup_opt "prn" as_bool))


let get_record_hints : Prims.unit  ->  Prims.bool = (fun uu____648 -> (lookup_opt "record_hints" as_bool))


let get_reuse_hint_for : Prims.unit  ->  Prims.string Prims.option = (fun uu____652 -> (lookup_opt "reuse_hint_for" (as_option as_string)))


let get_show_signatures : Prims.unit  ->  Prims.string Prims.list = (fun uu____657 -> (lookup_opt "show_signatures" (as_list as_string)))


let get_silent : Prims.unit  ->  Prims.bool = (fun uu____661 -> (lookup_opt "silent" as_bool))


let get_smt : Prims.unit  ->  Prims.string Prims.option = (fun uu____665 -> (lookup_opt "smt" (as_option as_string)))


let get_split_cases : Prims.unit  ->  Prims.int = (fun uu____669 -> (lookup_opt "split_cases" as_int))


let get_timing : Prims.unit  ->  Prims.bool = (fun uu____672 -> (lookup_opt "timing" as_bool))


let get_trace_error : Prims.unit  ->  Prims.bool = (fun uu____675 -> (lookup_opt "trace_error" as_bool))


let get_unthrottle_inductives : Prims.unit  ->  Prims.bool = (fun uu____678 -> (lookup_opt "unthrottle_inductives" as_bool))


let get_use_eq_at_higher_order : Prims.unit  ->  Prims.bool = (fun uu____681 -> (lookup_opt "use_eq_at_higher_order" as_bool))


let get_use_hints : Prims.unit  ->  Prims.bool = (fun uu____684 -> (lookup_opt "use_hints" as_bool))


let get_verify_all : Prims.unit  ->  Prims.bool = (fun uu____687 -> (lookup_opt "verify_all" as_bool))


let get_verify_module : Prims.unit  ->  Prims.string Prims.list = (fun uu____691 -> (lookup_opt "verify_module" (as_list as_string)))


let get___temp_no_proj : Prims.unit  ->  Prims.string Prims.list = (fun uu____696 -> (lookup_opt "__temp_no_proj" (as_list as_string)))


let get_version : Prims.unit  ->  Prims.bool = (fun uu____700 -> (lookup_opt "version" as_bool))


let get_warn_default_effects : Prims.unit  ->  Prims.bool = (fun uu____703 -> (lookup_opt "warn_default_effects" as_bool))


let get_z3cliopt : Prims.unit  ->  Prims.string Prims.list = (fun uu____707 -> (lookup_opt "z3cliopt" (as_list as_string)))


let get_z3refresh : Prims.unit  ->  Prims.bool = (fun uu____711 -> (lookup_opt "z3refresh" as_bool))


let get_z3rlimit : Prims.unit  ->  Prims.int = (fun uu____714 -> (lookup_opt "z3rlimit" as_int))


let get_z3seed : Prims.unit  ->  Prims.int = (fun uu____717 -> (lookup_opt "z3seed" as_int))


let get_z3timeout : Prims.unit  ->  Prims.int = (fun uu____720 -> (lookup_opt "z3timeout" as_int))


let get_no_positivity : Prims.unit  ->  Prims.bool = (fun uu____723 -> (lookup_opt "__no_positivity" as_bool))


let dlevel : Prims.string  ->  debug_level_t = (fun uu___48_726 -> (match (uu___48_726) with
| "Low" -> begin
Low
end
| "Medium" -> begin
Medium
end
| "High" -> begin
High
end
| "Extreme" -> begin
Extreme
end
| s -> begin
Other (s)
end))


let one_debug_level_geq : debug_level_t  ->  debug_level_t  ->  Prims.bool = (fun l1 l2 -> (match (l1) with
| (Other (_)) | (Low) -> begin
(l1 = l2)
end
| Medium -> begin
((l2 = Low) || (l2 = Medium))
end
| High -> begin
(((l2 = Low) || (l2 = Medium)) || (l2 = High))
end
| Extreme -> begin
((((l2 = Low) || (l2 = Medium)) || (l2 = High)) || (l2 = Extreme))
end))


let debug_level_geq : debug_level_t  ->  Prims.bool = (fun l2 -> (let _0_32 = (get_debug_level ())
in (FStar_All.pipe_right _0_32 (FStar_Util.for_some (fun l1 -> (one_debug_level_geq (dlevel l1) l2))))))


let include_path_base_dirs : Prims.string Prims.list = ("/lib")::("/lib/fstar")::[]


let universe_include_path_base_dirs : Prims.string Prims.list = ("/ulib")::("/lib/fstar")::[]


let display_version : Prims.unit  ->  Prims.unit = (fun uu____744 -> (FStar_Util.print_string (FStar_Util.format5 "F* %s\nplatform=%s\ncompiler=%s\ndate=%s\ncommit=%s\n" FStar_Version.version FStar_Version.platform FStar_Version.compiler FStar_Version.date FStar_Version.commit)))


let display_usage_aux = (fun specs -> ((FStar_Util.print_string "fstar.exe [options] file[s]\n");
(FStar_List.iter (fun uu____772 -> (match (uu____772) with
| (uu____778, flag, p, doc) -> begin
(match (p) with
| FStar_Getopt.ZeroArgs (ig) -> begin
(match ((doc = "")) with
| true -> begin
(FStar_Util.print_string (let _0_33 = (FStar_Util.colorize_bold flag)
in (FStar_Util.format1 "  --%s\n" _0_33)))
end
| uu____787 -> begin
(FStar_Util.print_string (let _0_34 = (FStar_Util.colorize_bold flag)
in (FStar_Util.format2 "  --%s  %s\n" _0_34 doc)))
end)
end
| FStar_Getopt.OneArg (uu____788, argname) -> begin
(match ((doc = "")) with
| true -> begin
(FStar_Util.print_string (let _0_36 = (FStar_Util.colorize_bold flag)
in (let _0_35 = (FStar_Util.colorize_bold argname)
in (FStar_Util.format2 "  --%s %s\n" _0_36 _0_35))))
end
| uu____794 -> begin
(FStar_Util.print_string (let _0_38 = (FStar_Util.colorize_bold flag)
in (let _0_37 = (FStar_Util.colorize_bold argname)
in (FStar_Util.format3 "  --%s %s  %s\n" _0_38 _0_37 doc))))
end)
end)
end)) specs);
))


let mk_spec : (FStar_BaseTypes.char * Prims.string * option_val FStar_Getopt.opt_variant * Prims.string)  ->  FStar_Getopt.opt = (fun o -> (

let uu____808 = o
in (match (uu____808) with
| (ns, name, arg, desc) -> begin
(

let arg = (match (arg) with
| FStar_Getopt.ZeroArgs (f) -> begin
(

let g = (fun uu____829 -> (set_option' (let _0_39 = (f ())
in ((name), (_0_39)))))
in FStar_Getopt.ZeroArgs (g))
end
| FStar_Getopt.OneArg (f, d) -> begin
(

let g = (fun x -> (set_option' (let _0_40 = (f x)
in ((name), (_0_40)))))
in FStar_Getopt.OneArg (((g), (d))))
end)
in ((ns), (name), (arg), (desc)))
end)))


let cons_extract_module : Prims.string  ->  option_val = (fun s -> List ((let _0_43 = (let _0_41 = (get_extract_module ())
in ((FStar_String.lowercase s))::_0_41)
in (FStar_All.pipe_right _0_43 (FStar_List.map (fun _0_42 -> String (_0_42)))))))


let cons_extract_namespace : Prims.string  ->  option_val = (fun s -> List ((let _0_46 = (let _0_44 = (get_extract_namespace ())
in ((FStar_String.lowercase s))::_0_44)
in (FStar_All.pipe_right _0_46 (FStar_List.map (fun _0_45 -> String (_0_45)))))))


let add_extract_module : Prims.string  ->  Prims.unit = (fun s -> (let _0_47 = (cons_extract_module s)
in (set_option "extract_module" _0_47)))


let add_extract_namespace : Prims.string  ->  Prims.unit = (fun s -> (let _0_48 = (cons_extract_namespace s)
in (set_option "extract_namespace" _0_48)))


let cons_verify_module : Prims.string  ->  option_val = (fun s -> List ((let _0_51 = (let _0_49 = (get_verify_module ())
in ((FStar_String.lowercase s))::_0_49)
in (FStar_All.pipe_right _0_51 (FStar_List.map (fun _0_50 -> String (_0_50)))))))


let add_verify_module : Prims.string  ->  Prims.unit = (fun s -> (let _0_52 = (cons_verify_module s)
in (set_option "verify_module" _0_52)))


let rec specs : Prims.unit  ->  FStar_Getopt.opt Prims.list = (fun uu____874 -> (

let specs = (((FStar_Getopt.noshort), ("admit_smt_queries"), (FStar_Getopt.OneArg ((((fun s -> (match ((s = "true")) with
| true -> begin
Bool (true)
end
| uu____892 -> begin
(match ((s = "false")) with
| true -> begin
Bool (false)
end
| uu____893 -> begin
(failwith "Invalid argument to --admit_smt_queries")
end)
end))), ("[true|false]")))), ("Admit SMT queries, unsafe! (default \'false\')")))::(((FStar_Getopt.noshort), ("cardinality"), (FStar_Getopt.OneArg ((((fun x -> String ((validate_cardinality x)))), ("[off|warn|check]")))), ("Check cardinality constraints on inductive data types (default \'off\')")))::(((FStar_Getopt.noshort), ("codegen"), (FStar_Getopt.OneArg ((((fun s -> String ((parse_codegen s)))), ("[OCaml|FSharp|Kremlin]")))), ("Generate code for execution")))::(((FStar_Getopt.noshort), ("codegen-lib"), (FStar_Getopt.OneArg ((((fun s -> List ((let _0_55 = (let _0_53 = (get_codegen_lib ())
in (s)::_0_53)
in (FStar_All.pipe_right _0_55 (FStar_List.map (fun _0_54 -> String (_0_54)))))))), ("[namespace]")))), ("External runtime library (i.e. M.N.x extracts to M.N.X instead of M_N.x)")))::(((FStar_Getopt.noshort), ("debug"), (FStar_Getopt.OneArg ((((fun x -> List ((let _0_58 = (let _0_56 = (get_debug ())
in (x)::_0_56)
in (FStar_All.pipe_right _0_58 (FStar_List.map (fun _0_57 -> String (_0_57)))))))), ("[module name]")))), ("Print lots of debugging information while checking module")))::(((FStar_Getopt.noshort), ("debug_level"), (FStar_Getopt.OneArg ((((fun x -> List ((let _0_61 = (let _0_59 = (get_debug_level ())
in (x)::_0_59)
in (FStar_All.pipe_right _0_61 (FStar_List.map (fun _0_60 -> String (_0_60)))))))), ("[Low|Medium|High|Extreme|...]")))), ("Control the verbosity of debugging info")))::(((FStar_Getopt.noshort), ("dep"), (FStar_Getopt.OneArg ((((fun x -> (match (((x = "make") || (x = "graph"))) with
| true -> begin
String (x)
end
| uu____954 -> begin
(failwith "invalid argument to \'dep\'")
end))), ("[make|graph]")))), ("Output the transitive closure of the dependency graph in a format suitable for the given tool")))::(((FStar_Getopt.noshort), ("detail_errors"), (FStar_Getopt.ZeroArgs ((fun uu____961 -> Bool (true)))), ("Emit a detailed error report by asking the SMT solver many queries; will take longer;\n         implies n_cores=1")))::(((FStar_Getopt.noshort), ("doc"), (FStar_Getopt.ZeroArgs ((fun uu____968 -> Bool (true)))), ("Extract Markdown documentation files for the input modules, as well as an index. Output is written to --odir directory.")))::(((FStar_Getopt.noshort), ("dump_module"), (FStar_Getopt.OneArg ((((fun x -> (let _0_66 = (let _0_64 = (let _0_62 = (get_dump_module ())
in (x)::_0_62)
in (FStar_All.pipe_right _0_64 (FStar_List.map (fun _0_63 -> String (_0_63)))))
in (FStar_All.pipe_right _0_66 (fun _0_65 -> List (_0_65)))))), ("[module name]")))), ("")))::(((FStar_Getopt.noshort), ("eager_inference"), (FStar_Getopt.ZeroArgs ((fun uu____987 -> Bool (true)))), ("Solve all type-inference constraints eagerly; more efficient but at the cost of generality")))::(((FStar_Getopt.noshort), ("explicit_deps"), (FStar_Getopt.ZeroArgs ((fun uu____994 -> Bool (true)))), ("Do not find dependencies automatically, the user provides them on the command-line")))::(((FStar_Getopt.noshort), ("extract_all"), (FStar_Getopt.ZeroArgs ((fun uu____1001 -> Bool (true)))), ("Discover the complete dependency graph and do not stop at interface boundaries")))::(((FStar_Getopt.noshort), ("extract_module"), (FStar_Getopt.OneArg (((cons_extract_module), ("[module name]")))), ("Only extract the specified modules (instead of the possibly-partial dependency graph)")))::(((FStar_Getopt.noshort), ("extract_namespace"), (FStar_Getopt.OneArg (((cons_extract_namespace), ("[namespace name]")))), ("Only extract modules in the specified namespace")))::(((FStar_Getopt.noshort), ("fstar_home"), (FStar_Getopt.OneArg ((((fun _0_67 -> String (_0_67))), ("[dir]")))), ("Set the FSTAR_HOME variable to [dir]")))::(((FStar_Getopt.noshort), ("hide_genident_nums"), (FStar_Getopt.ZeroArgs ((fun uu____1032 -> Bool (true)))), ("Don\'t print generated identifier numbers")))::(((FStar_Getopt.noshort), ("hide_uvar_nums"), (FStar_Getopt.ZeroArgs ((fun uu____1039 -> Bool (true)))), ("Don\'t print unification variable numbers")))::(((FStar_Getopt.noshort), ("hint_info"), (FStar_Getopt.ZeroArgs ((fun uu____1046 -> Bool (true)))), ("Print information regarding hints")))::(((FStar_Getopt.noshort), ("in"), (FStar_Getopt.ZeroArgs ((fun uu____1053 -> Bool (true)))), ("Interactive mode; reads input from stdin")))::(((FStar_Getopt.noshort), ("include"), (FStar_Getopt.OneArg ((((fun s -> List ((let _0_70 = (let _0_68 = (get_include ())
in (FStar_List.append _0_68 ((s)::[])))
in (FStar_All.pipe_right _0_70 (FStar_List.map (fun _0_69 -> String (_0_69)))))))), ("[path]")))), ("A directory in which to search for files included on the command line")))::(((FStar_Getopt.noshort), ("indent"), (FStar_Getopt.ZeroArgs ((fun uu____1071 -> Bool (true)))), ("Parses and outputs the files on the command line")))::(((FStar_Getopt.noshort), ("initial_fuel"), (FStar_Getopt.OneArg ((((fun x -> Int ((FStar_Util.int_of_string x)))), ("[non-negative integer]")))), ("Number of unrolling of recursive functions to try initially (default 2)")))::(((FStar_Getopt.noshort), ("initial_ifuel"), (FStar_Getopt.OneArg ((((fun x -> Int ((FStar_Util.int_of_string x)))), ("[non-negative integer]")))), ("Number of unrolling of inductive datatypes to try at first (default 1)")))::(((FStar_Getopt.noshort), ("inline_arith"), (FStar_Getopt.ZeroArgs ((fun uu____1096 -> Bool (true)))), ("Inline definitions of arithmetic functions in the SMT encoding")))::(((FStar_Getopt.noshort), ("lax"), (FStar_Getopt.ZeroArgs ((fun uu____1103 -> Bool (true)))), ("Run the lax-type checker only (admit all verification conditions)")))::(((FStar_Getopt.noshort), ("log_types"), (FStar_Getopt.ZeroArgs ((fun uu____1110 -> Bool (true)))), ("Print types computed for data/val/let-bindings")))::(((FStar_Getopt.noshort), ("log_queries"), (FStar_Getopt.ZeroArgs ((fun uu____1117 -> Bool (true)))), ("Log the Z3 queries in several queries-*.smt2 files, as we go")))::(((FStar_Getopt.noshort), ("max_fuel"), (FStar_Getopt.OneArg ((((fun x -> Int ((FStar_Util.int_of_string x)))), ("[non-negative integer]")))), ("Number of unrolling of recursive functions to try at most (default 8)")))::(((FStar_Getopt.noshort), ("max_ifuel"), (FStar_Getopt.OneArg ((((fun x -> Int ((FStar_Util.int_of_string x)))), ("[non-negative integer]")))), ("Number of unrolling of inductive datatypes to try at most (default 2)")))::(((FStar_Getopt.noshort), ("min_fuel"), (FStar_Getopt.OneArg ((((fun x -> Int ((FStar_Util.int_of_string x)))), ("[non-negative integer]")))), ("Minimum number of unrolling of recursive functions to try (default 1)")))::(((FStar_Getopt.noshort), ("MLish"), (FStar_Getopt.ZeroArgs ((fun uu____1151 -> Bool (true)))), ("Trigger various specializations for compiling the F* compiler itself (not meant for user code)")))::(((FStar_Getopt.noshort), ("n_cores"), (FStar_Getopt.OneArg ((((fun x -> Int ((FStar_Util.int_of_string x)))), ("[positive integer]")))), ("Maximum number of cores to use for the solver (implies detail_errors = false) (default 1)")))::(((FStar_Getopt.noshort), ("no_default_includes"), (FStar_Getopt.ZeroArgs ((fun uu____1167 -> Bool (true)))), ("Ignore the default module search paths")))::(((FStar_Getopt.noshort), ("no_extract"), (FStar_Getopt.OneArg ((((fun x -> List ((let _0_73 = (let _0_71 = (get_no_extract ())
in (x)::_0_71)
in (FStar_All.pipe_right _0_73 (FStar_List.map (fun _0_72 -> String (_0_72)))))))), ("[module name]")))), ("Do not extract code from this module")))::(((FStar_Getopt.noshort), ("no_location_info"), (FStar_Getopt.ZeroArgs ((fun uu____1185 -> Bool (true)))), ("Suppress location information in the generated OCaml output (only relevant with --codegen OCaml)")))::(((FStar_Getopt.noshort), ("odir"), (FStar_Getopt.OneArg ((((fun _0_74 -> String (_0_74))), ("[dir]")))), ("Place output in directory [dir]")))::(((FStar_Getopt.noshort), ("prims"), (FStar_Getopt.OneArg ((((fun _0_75 -> String (_0_75))), ("file")))), ("")))::(((FStar_Getopt.noshort), ("print_before_norm"), (FStar_Getopt.ZeroArgs ((fun uu____1208 -> Bool (true)))), ("Do not normalize types before printing (for debugging)")))::(((FStar_Getopt.noshort), ("print_bound_var_types"), (FStar_Getopt.ZeroArgs ((fun uu____1215 -> Bool (true)))), ("Print the types of bound variables")))::(((FStar_Getopt.noshort), ("print_effect_args"), (FStar_Getopt.ZeroArgs ((fun uu____1222 -> Bool (true)))), ("Print inferred predicate transformers for all computation types")))::(((FStar_Getopt.noshort), ("print_fuels"), (FStar_Getopt.ZeroArgs ((fun uu____1229 -> Bool (true)))), ("Print the fuel amounts used for each successful query")))::(((FStar_Getopt.noshort), ("print_implicits"), (FStar_Getopt.ZeroArgs ((fun uu____1236 -> Bool (true)))), ("Print implicit arguments")))::(((FStar_Getopt.noshort), ("print_universes"), (FStar_Getopt.ZeroArgs ((fun uu____1243 -> Bool (true)))), ("Print universes")))::(((FStar_Getopt.noshort), ("print_z3_statistics"), (FStar_Getopt.ZeroArgs ((fun uu____1250 -> Bool (true)))), ("Print Z3 statistics for each SMT query")))::(((FStar_Getopt.noshort), ("prn"), (FStar_Getopt.ZeroArgs ((fun uu____1257 -> Bool (true)))), ("Print real names (you may want to use this in conjunction with log_queries)")))::(((FStar_Getopt.noshort), ("record_hints"), (FStar_Getopt.ZeroArgs ((fun uu____1264 -> Bool (true)))), ("Record a database of hints for efficient proof replay")))::(((FStar_Getopt.noshort), ("reuse_hint_for"), (FStar_Getopt.OneArg ((((fun _0_76 -> String (_0_76))), ("top-level name in the current module")))), ("Optimistically, attempt using the recorded hint for \'f\' when trying to verify some other term \'g\'")))::(((FStar_Getopt.noshort), ("show_signatures"), (FStar_Getopt.OneArg ((((fun x -> List ((let _0_79 = (let _0_77 = (get_show_signatures ())
in (x)::_0_77)
in (FStar_All.pipe_right _0_79 (FStar_List.map (fun _0_78 -> String (_0_78)))))))), ("[module name]")))), ("Show the checked signatures for all top-level symbols in the module")))::(((FStar_Getopt.noshort), ("silent"), (FStar_Getopt.ZeroArgs ((fun uu____1290 -> Bool (true)))), (" ")))::(((FStar_Getopt.noshort), ("smt"), (FStar_Getopt.OneArg ((((fun _0_80 -> String (_0_80))), ("[path]")))), ("Path to the SMT solver (usually Z3, but could be any SMT2-compatible solver)")))::(((FStar_Getopt.noshort), ("split_cases"), (FStar_Getopt.OneArg ((((fun n -> Int ((FStar_Util.int_of_string n)))), ("[positive integer]")))), ("Partition VC of a match into groups of [n] cases")))::(((FStar_Getopt.noshort), ("timing"), (FStar_Getopt.ZeroArgs ((fun uu____1314 -> Bool (true)))), ("Print the time it takes to verify each top-level definition")))::(((FStar_Getopt.noshort), ("trace_error"), (FStar_Getopt.ZeroArgs ((fun uu____1321 -> Bool (true)))), ("Don\'t print an error message; show an exception trace instead")))::(((FStar_Getopt.noshort), ("unthrottle_inductives"), (FStar_Getopt.ZeroArgs ((fun uu____1328 -> Bool (true)))), ("Let the SMT solver unfold inductive types to arbitrary depths (may affect verifier performance)")))::(((FStar_Getopt.noshort), ("use_eq_at_higher_order"), (FStar_Getopt.ZeroArgs ((fun uu____1335 -> Bool (true)))), ("Use equality constraints when comparing higher-order types (Temporary)")))::(((FStar_Getopt.noshort), ("use_hints"), (FStar_Getopt.ZeroArgs ((fun uu____1342 -> Bool (true)))), ("Use a previously recorded hints database for proof replay")))::(((FStar_Getopt.noshort), ("verify_all"), (FStar_Getopt.ZeroArgs ((fun uu____1349 -> Bool (true)))), ("With automatic dependencies, verify all the dependencies, not just the files passed on the command-line.")))::(((FStar_Getopt.noshort), ("verify_module"), (FStar_Getopt.OneArg (((cons_verify_module), ("[module name]")))), ("Name of the module to verify")))::(((FStar_Getopt.noshort), ("__temp_no_proj"), (FStar_Getopt.OneArg ((((fun x -> List ((let _0_83 = (let _0_81 = (get___temp_no_proj ())
in (x)::_0_81)
in (FStar_All.pipe_right _0_83 (FStar_List.map (fun _0_82 -> String (_0_82)))))))), ("[module name]")))), ("Don\'t generate projectors for this module")))::((('v'), ("version"), (FStar_Getopt.ZeroArgs ((fun uu____1375 -> ((display_version ());
(FStar_All.exit (Prims.parse_int "0"));
)))), ("Display version number")))::(((FStar_Getopt.noshort), ("warn_default_effects"), (FStar_Getopt.ZeroArgs ((fun uu____1383 -> Bool (true)))), ("Warn when (a -> b) is desugared to (a -> Tot b)")))::(((FStar_Getopt.noshort), ("z3cliopt"), (FStar_Getopt.OneArg ((((fun s -> List ((let _0_86 = (let _0_84 = (get_z3cliopt ())
in (FStar_List.append _0_84 ((s)::[])))
in (FStar_All.pipe_right _0_86 (FStar_List.map (fun _0_85 -> String (_0_85)))))))), ("[option]")))), ("Z3 command line options")))::(((FStar_Getopt.noshort), ("z3refresh"), (FStar_Getopt.ZeroArgs ((fun uu____1401 -> Bool (false)))), ("Restart Z3 after each query; useful for ensuring proof robustness")))::(((FStar_Getopt.noshort), ("z3rlimit"), (FStar_Getopt.OneArg ((((fun s -> Int ((FStar_Util.int_of_string s)))), ("[positive integer]")))), ("Set the Z3 per-query resource limit (default 5 units, taking roughtly 5s)")))::(((FStar_Getopt.noshort), ("z3seed"), (FStar_Getopt.OneArg ((((fun s -> Int ((FStar_Util.int_of_string s)))), ("[positive integer]")))), ("Set the Z3 random seed (default 0)")))::(((FStar_Getopt.noshort), ("z3timeout"), (FStar_Getopt.OneArg ((((fun s -> ((FStar_Util.print_string "Warning: z3timeout ignored; use z3rlimit instead\n");
Int ((FStar_Util.int_of_string s));
))), ("[positive integer]")))), ("Set the Z3 per-query (soft) timeout to [t] seconds (default 5)")))::(((FStar_Getopt.noshort), ("__no_positivity"), (FStar_Getopt.ZeroArgs ((fun uu____1436 -> Bool (true)))), ("Don\'t check positivity of inductive types")))::[]
in (let _0_87 = (FStar_List.map mk_spec specs)
in ((('h'), ("help"), (FStar_Getopt.ZeroArgs ((fun x -> ((display_usage_aux specs);
(FStar_All.exit (Prims.parse_int "0"));
)))), ("Display this information")))::_0_87)))
and parse_codegen : Prims.string  ->  Prims.string = (fun s -> (match (s) with
| ("Kremlin") | ("OCaml") | ("FSharp") -> begin
s
end
| uu____1456 -> begin
((FStar_Util.print_string "Wrong argument to codegen flag\n");
(display_usage_aux (specs ()));
(FStar_All.exit (Prims.parse_int "1"));
)
end))
and validate_cardinality : Prims.string  ->  Prims.string = (fun x -> (match (x) with
| ("warn") | ("check") | ("off") -> begin
x
end
| uu____1460 -> begin
((FStar_Util.print_string "Wrong argument to cardinality flag\n");
(display_usage_aux (specs ()));
(FStar_All.exit (Prims.parse_int "1"));
)
end))


let settable : Prims.string  ->  Prims.bool = (fun uu___49_1465 -> (match (uu___49_1465) with
| ("admit_smt_queries") | ("cardinality") | ("debug") | ("debug_level") | ("detail_errors") | ("eager_inference") | ("hide_genident_nums") | ("hide_uvar_nums") | ("hint_info") | ("initial_fuel") | ("initial_ifuel") | ("inline_arith") | ("lax") | ("log_types") | ("log_queries") | ("max_fuel") | ("max_ifuel") | ("min_fuel") | ("print_before_norm") | ("print_bound_var_types") | ("print_effect_args") | ("print_fuels") | ("print_implicits") | ("print_universes") | ("print_z3_statistics") | ("prn") | ("show_signatures") | ("silent") | ("split_cases") | ("timing") | ("trace_error") | ("unthrottle_inductives") | ("use_eq_at_higher_order") | ("__temp_no_proj") | ("no_warn_top_level_effects") | ("reuse_hint_for") | ("z3refresh") -> begin
true
end
| uu____1466 -> begin
false
end))


let resettable : Prims.string  ->  Prims.bool = (fun s -> ((((settable s) || (s = "z3timeout")) || (s = "z3rlimit")) || (s = "z3seed")))


let all_specs : FStar_Getopt.opt Prims.list = (specs ())


let settable_specs : (FStar_BaseTypes.char * Prims.string * Prims.unit FStar_Getopt.opt_variant * Prims.string) Prims.list = (FStar_All.pipe_right all_specs (FStar_List.filter (fun uu____1489 -> (match (uu____1489) with
| (uu____1495, x, uu____1497, uu____1498) -> begin
(settable x)
end))))


let resettable_specs : (FStar_BaseTypes.char * Prims.string * Prims.unit FStar_Getopt.opt_variant * Prims.string) Prims.list = (FStar_All.pipe_right all_specs (FStar_List.filter (fun uu____1519 -> (match (uu____1519) with
| (uu____1525, x, uu____1527, uu____1528) -> begin
(resettable x)
end))))


let display_usage : Prims.unit  ->  Prims.unit = (fun uu____1533 -> (display_usage_aux (specs ())))


let fstar_home : Prims.unit  ->  Prims.string = (fun uu____1536 -> (

let uu____1537 = (get_fstar_home ())
in (match (uu____1537) with
| None -> begin
(

let x = (FStar_Util.get_exec_dir ())
in (

let x = (Prims.strcat x "/..")
in ((set_option' (("fstar_home"), (String (x))));
x;
)))
end
| Some (x) -> begin
x
end)))


let set_options : options  ->  Prims.string  ->  FStar_Getopt.parse_cmdline_res = (fun o s -> (

let specs = (match (o) with
| Set -> begin
resettable_specs
end
| Reset -> begin
resettable_specs
end
| Restore -> begin
all_specs
end)
in (FStar_Getopt.parse_string specs (fun uu____1562 -> ()) s)))


let file_list_ : Prims.string Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let parse_cmd_line : Prims.unit  ->  (FStar_Getopt.parse_cmdline_res * Prims.string Prims.list) = (fun uu____1573 -> (

let res = (let _0_90 = (specs ())
in (FStar_Getopt.parse_cmdline _0_90 (fun i -> (let _0_89 = (let _0_88 = (FStar_ST.read file_list_)
in (FStar_List.append _0_88 ((i)::[])))
in (FStar_ST.write file_list_ _0_89)))))
in (let _0_91 = (FStar_ST.read file_list_)
in ((res), (_0_91)))))


let file_list : Prims.unit  ->  Prims.string Prims.list = (fun uu____1589 -> (FStar_ST.read file_list_))


let restore_cmd_line_options : Prims.bool  ->  FStar_Getopt.parse_cmdline_res = (fun should_clear -> (

let old_verify_module = (get_verify_module ())
in ((match (should_clear) with
| true -> begin
(clear ())
end
| uu____1599 -> begin
(init ())
end);
(

let r = (let _0_92 = (specs ())
in (FStar_Getopt.parse_cmdline _0_92 (fun x -> ())))
in ((set_option' (let _0_94 = List ((FStar_List.map (fun _0_93 -> String (_0_93)) old_verify_module))
in (("verify_module"), (_0_94))));
r;
));
)))


let should_verify : Prims.string  ->  Prims.bool = (fun m -> (

let uu____1606 = (get_lax ())
in (match (uu____1606) with
| true -> begin
false
end
| uu____1607 -> begin
(

let uu____1608 = (get_verify_all ())
in (match (uu____1608) with
| true -> begin
true
end
| uu____1609 -> begin
(

let uu____1610 = (get_verify_module ())
in (match (uu____1610) with
| [] -> begin
(let _0_98 = (file_list ())
in (FStar_List.existsML (fun f -> (

let f = (FStar_Util.basename f)
in (

let f = (let _0_97 = (let _0_96 = (let _0_95 = (FStar_String.length (FStar_Util.get_file_extension f))
in ((FStar_String.length f) - _0_95))
in (_0_96 - (Prims.parse_int "1")))
in (FStar_String.substring f (Prims.parse_int "0") _0_97))
in ((FStar_String.lowercase f) = m)))) _0_98))
end
| l -> begin
(FStar_List.contains (FStar_String.lowercase m) l)
end))
end))
end)))


let dont_gen_projectors : Prims.string  ->  Prims.bool = (fun m -> (let _0_99 = (get___temp_no_proj ())
in (FStar_List.contains m _0_99)))


let should_print_message : Prims.string  ->  Prims.bool = (fun m -> (

let uu____1628 = (should_verify m)
in (match (uu____1628) with
| true -> begin
(m <> "Prims")
end
| uu____1629 -> begin
false
end)))


let include_path : Prims.unit  ->  Prims.string Prims.list = (fun uu____1633 -> (

let uu____1634 = (get_no_default_includes ())
in (match (uu____1634) with
| true -> begin
(get_include ())
end
| uu____1636 -> begin
(

let h = (fstar_home ())
in (

let defs = universe_include_path_base_dirs
in (let _0_103 = (let _0_100 = (FStar_All.pipe_right defs (FStar_List.map (fun x -> (Prims.strcat h x))))
in (FStar_All.pipe_right _0_100 (FStar_List.filter FStar_Util.file_exists)))
in (let _0_102 = (let _0_101 = (get_include ())
in (FStar_List.append _0_101 ((".")::[])))
in (FStar_List.append _0_103 _0_102)))))
end)))


let find_file : Prims.string  ->  Prims.string Prims.option = (fun filename -> (

let uu____1649 = (FStar_Util.is_path_absolute filename)
in (match (uu____1649) with
| true -> begin
(match ((FStar_Util.file_exists filename)) with
| true -> begin
Some (filename)
end
| uu____1652 -> begin
None
end)
end
| uu____1653 -> begin
(let _0_104 = (FStar_List.rev (include_path ()))
in (FStar_Util.find_map _0_104 (fun p -> (

let path = (FStar_Util.join_paths p filename)
in (match ((FStar_Util.file_exists path)) with
| true -> begin
Some (path)
end
| uu____1657 -> begin
None
end)))))
end)))


let prims : Prims.unit  ->  Prims.string = (fun uu____1660 -> (

let uu____1661 = (get_prims ())
in (match (uu____1661) with
| None -> begin
(

let filename = "prims.fst"
in (

let uu____1664 = (find_file filename)
in (match (uu____1664) with
| Some (result) -> begin
result
end
| None -> begin
(Prims.raise (FStar_Util.Failure ((FStar_Util.format1 "unable to find required file \"%s\" in the module search path.\n" filename))))
end)))
end
| Some (x) -> begin
x
end)))


let prepend_output_dir : Prims.string  ->  Prims.string = (fun fname -> (

let uu____1671 = (get_odir ())
in (match (uu____1671) with
| None -> begin
fname
end
| Some (x) -> begin
(Prims.strcat x (Prims.strcat "/" fname))
end)))


let __temp_no_proj : Prims.string  ->  Prims.bool = (fun s -> (let _0_105 = (get___temp_no_proj ())
in (FStar_All.pipe_right _0_105 (FStar_List.contains s))))


let admit_smt_queries : Prims.unit  ->  Prims.bool = (fun uu____1680 -> (get_admit_smt_queries ()))


let check_cardinality : Prims.unit  ->  Prims.bool = (fun uu____1683 -> (let _0_106 = (get_cardinality ())
in (_0_106 = "check")))


let codegen : Prims.unit  ->  Prims.string Prims.option = (fun uu____1687 -> (get_codegen ()))


let codegen_libs : Prims.unit  ->  Prims.string Prims.list Prims.list = (fun uu____1692 -> (let _0_107 = (get_codegen_lib ())
in (FStar_All.pipe_right _0_107 (FStar_List.map (fun x -> (FStar_Util.split x "."))))))


let debug_any : Prims.unit  ->  Prims.bool = (fun uu____1700 -> (let _0_108 = (get_debug ())
in (_0_108 <> [])))


let debug_at_level : Prims.string  ->  debug_level_t  ->  Prims.bool = (fun modul level -> (((modul = "") || (let _0_109 = (get_debug ())
in (FStar_All.pipe_right _0_109 (FStar_List.contains modul)))) && (debug_level_geq level)))


let dep : Prims.unit  ->  Prims.string Prims.option = (fun uu____1712 -> (get_dep ()))


let detail_errors : Prims.unit  ->  Prims.bool = (fun uu____1715 -> (get_detail_errors ()))


let doc : Prims.unit  ->  Prims.bool = (fun uu____1718 -> (get_doc ()))


let dump_module : Prims.string  ->  Prims.bool = (fun s -> (let _0_110 = (get_dump_module ())
in (FStar_All.pipe_right _0_110 (FStar_List.contains s))))


let eager_inference : Prims.unit  ->  Prims.bool = (fun uu____1725 -> (get_eager_inference ()))


let explicit_deps : Prims.unit  ->  Prims.bool = (fun uu____1728 -> (get_explicit_deps ()))


let extract_all : Prims.unit  ->  Prims.bool = (fun uu____1731 -> (get_extract_all ()))


let fs_typ_app : Prims.string  ->  Prims.bool = (fun filename -> (let _0_111 = (FStar_ST.read light_off_files)
in (FStar_List.contains filename _0_111)))


let full_context_dependency : Prims.unit  ->  Prims.bool = (fun uu____1740 -> true)


let hide_genident_nums : Prims.unit  ->  Prims.bool = (fun uu____1743 -> (get_hide_genident_nums ()))


let hide_uvar_nums : Prims.unit  ->  Prims.bool = (fun uu____1746 -> (get_hide_uvar_nums ()))


let hint_info : Prims.unit  ->  Prims.bool = (fun uu____1749 -> (get_hint_info ()))


let indent : Prims.unit  ->  Prims.bool = (fun uu____1752 -> (get_indent ()))


let initial_fuel : Prims.unit  ->  Prims.int = (fun uu____1755 -> (get_initial_fuel ()))


let initial_ifuel : Prims.unit  ->  Prims.int = (fun uu____1758 -> (get_initial_ifuel ()))


let inline_arith : Prims.unit  ->  Prims.bool = (fun uu____1761 -> (get_inline_arith ()))


let interactive : Prims.unit  ->  Prims.bool = (fun uu____1764 -> (get_in ()))


let lax : Prims.unit  ->  Prims.bool = (fun uu____1767 -> (get_lax ()))


let log_queries : Prims.unit  ->  Prims.bool = (fun uu____1770 -> (get_log_queries ()))


let log_types : Prims.unit  ->  Prims.bool = (fun uu____1773 -> (get_log_types ()))


let max_fuel : Prims.unit  ->  Prims.int = (fun uu____1776 -> (get_max_fuel ()))


let max_ifuel : Prims.unit  ->  Prims.int = (fun uu____1779 -> (get_max_ifuel ()))


let min_fuel : Prims.unit  ->  Prims.int = (fun uu____1782 -> (get_min_fuel ()))


let ml_ish : Prims.unit  ->  Prims.bool = (fun uu____1785 -> (get_MLish ()))


let set_ml_ish : Prims.unit  ->  Prims.unit = (fun uu____1788 -> (set_option "MLish" (Bool (true))))


let n_cores : Prims.unit  ->  Prims.int = (fun uu____1791 -> (get_n_cores ()))


let no_default_includes : Prims.unit  ->  Prims.bool = (fun uu____1794 -> (get_no_default_includes ()))


let no_extract : Prims.string  ->  Prims.bool = (fun s -> (let _0_112 = (get_no_extract ())
in (FStar_All.pipe_right _0_112 (FStar_List.contains s))))


let no_location_info : Prims.unit  ->  Prims.bool = (fun uu____1801 -> (get_no_location_info ()))


let norm_then_print : Prims.unit  ->  Prims.bool = (fun uu____1804 -> (let _0_113 = (get_print_before_norm ())
in (_0_113 = false)))


let output_dir : Prims.unit  ->  Prims.string Prims.option = (fun uu____1808 -> (get_odir ()))


let print_bound_var_types : Prims.unit  ->  Prims.bool = (fun uu____1811 -> (get_print_bound_var_types ()))


let print_effect_args : Prims.unit  ->  Prims.bool = (fun uu____1814 -> (get_print_effect_args ()))


let print_fuels : Prims.unit  ->  Prims.bool = (fun uu____1817 -> (get_print_fuels ()))


let print_implicits : Prims.unit  ->  Prims.bool = (fun uu____1820 -> (get_print_implicits ()))


let print_real_names : Prims.unit  ->  Prims.bool = (fun uu____1823 -> (get_prn ()))


let print_universes : Prims.unit  ->  Prims.bool = (fun uu____1826 -> (get_print_universes ()))


let print_z3_statistics : Prims.unit  ->  Prims.bool = (fun uu____1829 -> (get_print_z3_statistics ()))


let record_hints : Prims.unit  ->  Prims.bool = (fun uu____1832 -> (get_record_hints ()))


let reuse_hint_for : Prims.unit  ->  Prims.string Prims.option = (fun uu____1836 -> (get_reuse_hint_for ()))


let silent : Prims.unit  ->  Prims.bool = (fun uu____1839 -> (get_silent ()))


let split_cases : Prims.unit  ->  Prims.int = (fun uu____1842 -> (get_split_cases ()))


let timing : Prims.unit  ->  Prims.bool = (fun uu____1845 -> (get_timing ()))


let trace_error : Prims.unit  ->  Prims.bool = (fun uu____1848 -> (get_trace_error ()))


let unthrottle_inductives : Prims.unit  ->  Prims.bool = (fun uu____1851 -> (get_unthrottle_inductives ()))


let use_eq_at_higher_order : Prims.unit  ->  Prims.bool = (fun uu____1854 -> (get_use_eq_at_higher_order ()))


let use_hints : Prims.unit  ->  Prims.bool = (fun uu____1857 -> (get_use_hints ()))


let verify_all : Prims.unit  ->  Prims.bool = (fun uu____1860 -> (get_verify_all ()))


let verify_module : Prims.unit  ->  Prims.string Prims.list = (fun uu____1864 -> (get_verify_module ()))


let warn_cardinality : Prims.unit  ->  Prims.bool = (fun uu____1867 -> (let _0_114 = (get_cardinality ())
in (_0_114 = "warn")))


let warn_default_effects : Prims.unit  ->  Prims.bool = (fun uu____1870 -> (get_warn_default_effects ()))


let warn_top_level_effects : Prims.unit  ->  Prims.bool = (fun uu____1873 -> (get_warn_top_level_effects ()))


let z3_exe : Prims.unit  ->  Prims.string = (fun uu____1876 -> (

let uu____1877 = (get_smt ())
in (match (uu____1877) with
| None -> begin
(FStar_Platform.exe "z3")
end
| Some (s) -> begin
s
end)))


let z3_cliopt : Prims.unit  ->  Prims.string Prims.list = (fun uu____1883 -> (get_z3cliopt ()))


let z3_refresh : Prims.unit  ->  Prims.bool = (fun uu____1886 -> (get_z3refresh ()))


let z3_rlimit : Prims.unit  ->  Prims.int = (fun uu____1889 -> (get_z3rlimit ()))


let z3_seed : Prims.unit  ->  Prims.int = (fun uu____1892 -> (get_z3seed ()))


let z3_timeout : Prims.unit  ->  Prims.int = (fun uu____1895 -> (get_z3timeout ()))


let no_positivity : Prims.unit  ->  Prims.bool = (fun uu____1898 -> (get_no_positivity ()))


let should_extract : Prims.string  ->  Prims.bool = (fun m -> ((not ((no_extract m))) && ((extract_all ()) || (

let uu____1902 = (get_extract_module ())
in (match (uu____1902) with
| [] -> begin
(

let uu____1904 = (get_extract_namespace ())
in (match (uu____1904) with
| [] -> begin
true
end
| ns -> begin
(FStar_Util.for_some (FStar_Util.starts_with (FStar_String.lowercase m)) ns)
end))
end
| l -> begin
(FStar_List.contains (FStar_String.lowercase m) l)
end)))))




