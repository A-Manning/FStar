
open Prims
type z3version =
| Z3V_Unknown of Prims.string
| Z3V of (Prims.int * Prims.int * Prims.int)


let uu___is_Z3V_Unknown : z3version  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Z3V_Unknown (_0) -> begin
true
end
| uu____14 -> begin
false
end))


let __proj__Z3V_Unknown__item___0 : z3version  ->  Prims.string = (fun projectee -> (match (projectee) with
| Z3V_Unknown (_0) -> begin
_0
end))


let uu___is_Z3V : z3version  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Z3V (_0) -> begin
true
end
| uu____29 -> begin
false
end))


let __proj__Z3V__item___0 : z3version  ->  (Prims.int * Prims.int * Prims.int) = (fun projectee -> (match (projectee) with
| Z3V (_0) -> begin
_0
end))


let z3version_as_string : z3version  ->  Prims.string = (fun uu___91_48 -> (match (uu___91_48) with
| Z3V_Unknown (s) -> begin
(FStar_Util.format1 "unknown version: %s" s)
end
| Z3V (i, j, k) -> begin
(let _0_363 = (FStar_Util.string_of_int i)
in (let _0_362 = (FStar_Util.string_of_int j)
in (let _0_361 = (FStar_Util.string_of_int k)
in (FStar_Util.format3 "%s.%s.%s" _0_363 _0_362 _0_361))))
end))


let z3v_compare : z3version  ->  (Prims.int * Prims.int * Prims.int)  ->  Prims.int Prims.option = (fun known uu____62 -> (match (uu____62) with
| (w1, w2, w3) -> begin
(match (known) with
| Z3V_Unknown (uu____71) -> begin
None
end
| Z3V (k1, k2, k3) -> begin
Some ((match ((k1 <> w1)) with
| true -> begin
(w1 - k1)
end
| uu____75 -> begin
(match ((k2 <> w2)) with
| true -> begin
(w2 - k2)
end
| uu____76 -> begin
(w3 - k3)
end)
end))
end)
end))


let z3v_le : z3version  ->  (Prims.int * Prims.int * Prims.int)  ->  Prims.bool = (fun known wanted -> (match ((z3v_compare known wanted)) with
| None -> begin
false
end
| Some (i) -> begin
(i >= (Prims.parse_int "0"))
end))


let _z3version : z3version Prims.option FStar_ST.ref = (FStar_Util.mk_ref None)


let get_z3version : Prims.unit  ->  z3version = (fun uu____97 -> (

let prefix = "Z3 version "
in (

let uu____99 = (FStar_ST.read _z3version)
in (match (uu____99) with
| Some (version) -> begin
version
end
| None -> begin
(

let uu____105 = (let _0_364 = (FStar_Options.z3_exe ())
in (FStar_Util.run_proc _0_364 "-version" ""))
in (match (uu____105) with
| (uu____109, out, uu____111) -> begin
(

let out = (match ((FStar_Util.splitlines out)) with
| (x)::uu____114 when (FStar_Util.starts_with x prefix) -> begin
(

let x = (FStar_Util.trim_string (FStar_Util.substring_from x (FStar_String.length prefix)))
in (

let x = try
(match (()) with
| () -> begin
(FStar_List.map FStar_Util.int_of_string (FStar_Util.split x "."))
end)
with
| uu____126 -> begin
[]
end
in (match (x) with
| (i1)::(i2)::(i3)::[] -> begin
Z3V (((i1), (i2), (i3)))
end
| uu____130 -> begin
Z3V_Unknown (out)
end)))
end
| uu____132 -> begin
Z3V_Unknown (out)
end)
in ((FStar_ST.write _z3version (Some (out)));
out;
))
end))
end))))


let ini_params : Prims.unit  ->  Prims.string = (fun uu____140 -> (

let z3_v = (get_z3version ())
in ((

let uu____143 = (let _0_365 = (get_z3version ())
in (z3v_le _0_365 (((Prims.parse_int "4")), ((Prims.parse_int "4")), ((Prims.parse_int "0")))))
in (match (uu____143) with
| true -> begin
(let _0_367 = FStar_Util.Failure ((let _0_366 = (z3version_as_string z3_v)
in (FStar_Util.format1 "Z3 4.5.0 recommended; at least Z3 v4.4.1 required; got %s\n" _0_366)))
in (FStar_All.pipe_left Prims.raise _0_367))
end
| uu____144 -> begin
()
end));
(let _0_373 = (let _0_372 = (let _0_370 = (let _0_369 = (let _0_368 = (FStar_Util.string_of_int (FStar_Options.z3_seed ()))
in (FStar_Util.format1 "smt.random_seed=%s" _0_368))
in (_0_369)::[])
in ("-smt2 -in auto_config=false model=true smt.relevancy=2")::_0_370)
in (let _0_371 = (FStar_Options.z3_cliopt ())
in (FStar_List.append _0_372 _0_371)))
in (FStar_String.concat " " _0_373));
)))


type label =
Prims.string


type unsat_core =
Prims.string Prims.list Prims.option

type z3status =
| UNSAT of unsat_core
| SAT of label Prims.list
| UNKNOWN of label Prims.list
| TIMEOUT of label Prims.list
| KILLED


let uu___is_UNSAT : z3status  ->  Prims.bool = (fun projectee -> (match (projectee) with
| UNSAT (_0) -> begin
true
end
| uu____166 -> begin
false
end))


let __proj__UNSAT__item___0 : z3status  ->  unsat_core = (fun projectee -> (match (projectee) with
| UNSAT (_0) -> begin
_0
end))


let uu___is_SAT : z3status  ->  Prims.bool = (fun projectee -> (match (projectee) with
| SAT (_0) -> begin
true
end
| uu____179 -> begin
false
end))


let __proj__SAT__item___0 : z3status  ->  label Prims.list = (fun projectee -> (match (projectee) with
| SAT (_0) -> begin
_0
end))


let uu___is_UNKNOWN : z3status  ->  Prims.bool = (fun projectee -> (match (projectee) with
| UNKNOWN (_0) -> begin
true
end
| uu____195 -> begin
false
end))


let __proj__UNKNOWN__item___0 : z3status  ->  label Prims.list = (fun projectee -> (match (projectee) with
| UNKNOWN (_0) -> begin
_0
end))


let uu___is_TIMEOUT : z3status  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TIMEOUT (_0) -> begin
true
end
| uu____211 -> begin
false
end))


let __proj__TIMEOUT__item___0 : z3status  ->  label Prims.list = (fun projectee -> (match (projectee) with
| TIMEOUT (_0) -> begin
_0
end))


let uu___is_KILLED : z3status  ->  Prims.bool = (fun projectee -> (match (projectee) with
| KILLED -> begin
true
end
| uu____225 -> begin
false
end))


let status_to_string : z3status  ->  Prims.string = (fun uu___92_228 -> (match (uu___92_228) with
| SAT (uu____229) -> begin
"sat"
end
| UNSAT (uu____231) -> begin
"unsat"
end
| UNKNOWN (uu____232) -> begin
"unknown"
end
| TIMEOUT (uu____234) -> begin
"timeout"
end
| KILLED -> begin
"killed"
end))


let tid : Prims.unit  ->  Prims.string = (fun uu____238 -> (let _0_374 = (FStar_Util.current_tid ())
in (FStar_All.pipe_right _0_374 FStar_Util.string_of_int)))


let new_z3proc : Prims.string  ->  FStar_Util.proc = (fun id -> (

let cond = (fun pid s -> (

let x = ((FStar_Util.trim_string s) = "Done!")
in x))
in (let _0_376 = (FStar_Options.z3_exe ())
in (let _0_375 = (ini_params ())
in (FStar_Util.start_process id _0_376 _0_375 cond)))))

type bgproc =
{grab : Prims.unit  ->  FStar_Util.proc; release : Prims.unit  ->  Prims.unit; refresh : Prims.unit  ->  Prims.unit; restart : Prims.unit  ->  Prims.unit}

type query_log =
{get_module_name : Prims.unit  ->  Prims.string; set_module_name : Prims.string  ->  Prims.unit; append_to_log : Prims.string  ->  Prims.unit; close_log : Prims.unit  ->  Prims.unit; log_file_name : Prims.unit  ->  Prims.string}


let query_logging : query_log = (

let log_file_opt = (FStar_Util.mk_ref None)
in (

let used_file_names = (FStar_Util.mk_ref [])
in (

let current_module_name = (FStar_Util.mk_ref None)
in (

let current_file_name = (FStar_Util.mk_ref None)
in (

let set_module_name = (fun n -> (FStar_ST.write current_module_name (Some (n))))
in (

let get_module_name = (fun uu____412 -> (

let uu____413 = (FStar_ST.read current_module_name)
in (match (uu____413) with
| None -> begin
(failwith "Module name not set")
end
| Some (n) -> begin
n
end)))
in (

let new_log_file = (fun uu____422 -> (

let uu____423 = (FStar_ST.read current_module_name)
in (match (uu____423) with
| None -> begin
(failwith "current module not set")
end
| Some (n) -> begin
(

let file_name = (

let uu____430 = (let _0_377 = (FStar_ST.read used_file_names)
in (FStar_List.tryFind (fun uu____436 -> (match (uu____436) with
| (m, uu____440) -> begin
(n = m)
end)) _0_377))
in (match (uu____430) with
| None -> begin
((let _0_379 = (let _0_378 = (FStar_ST.read used_file_names)
in (((n), ((Prims.parse_int "0"))))::_0_378)
in (FStar_ST.write used_file_names _0_379));
n;
)
end
| Some (uu____461, k) -> begin
((let _0_381 = (let _0_380 = (FStar_ST.read used_file_names)
in (((n), ((k + (Prims.parse_int "1")))))::_0_380)
in (FStar_ST.write used_file_names _0_381));
(let _0_382 = (FStar_Util.string_of_int (k + (Prims.parse_int "1")))
in (FStar_Util.format2 "%s-%s" n _0_382));
)
end))
in (

let file_name = (FStar_Util.format1 "queries-%s.smt2" file_name)
in ((FStar_ST.write current_file_name (Some (file_name)));
(

let fh = (FStar_Util.open_file_for_writing file_name)
in ((FStar_ST.write log_file_opt (Some (fh)));
fh;
));
)))
end)))
in (

let get_log_file = (fun uu____491 -> (

let uu____492 = (FStar_ST.read log_file_opt)
in (match (uu____492) with
| None -> begin
(new_log_file ())
end
| Some (fh) -> begin
fh
end)))
in (

let append_to_log = (fun str -> (let _0_383 = (get_log_file ())
in (FStar_Util.append_to_file _0_383 str)))
in (

let close_log = (fun uu____505 -> (

let uu____506 = (FStar_ST.read log_file_opt)
in (match (uu____506) with
| None -> begin
()
end
| Some (fh) -> begin
((FStar_Util.close_file fh);
(FStar_ST.write log_file_opt None);
)
end)))
in (

let log_file_name = (fun uu____519 -> (

let uu____520 = (FStar_ST.read current_file_name)
in (match (uu____520) with
| None -> begin
(failwith "no log file")
end
| Some (n) -> begin
n
end)))
in {get_module_name = get_module_name; set_module_name = set_module_name; append_to_log = append_to_log; close_log = close_log; log_file_name = log_file_name})))))))))))


let bg_z3_proc : bgproc = (

let the_z3proc = (FStar_Util.mk_ref None)
in (

let new_proc = (

let ctr = (FStar_Util.mk_ref (~- ((Prims.parse_int "1"))))
in (fun uu____537 -> (new_z3proc (let _0_385 = ((FStar_Util.incr ctr);
(let _0_384 = (FStar_ST.read ctr)
in (FStar_All.pipe_right _0_384 FStar_Util.string_of_int));
)
in (FStar_Util.format1 "bg-%s" _0_385)))))
in (

let z3proc = (fun uu____547 -> ((

let uu____549 = (let _0_386 = (FStar_ST.read the_z3proc)
in (_0_386 = None))
in (match (uu____549) with
| true -> begin
(let _0_387 = Some ((new_proc ()))
in (FStar_ST.write the_z3proc _0_387))
end
| uu____557 -> begin
()
end));
(FStar_Util.must (FStar_ST.read the_z3proc));
))
in (

let x = []
in (

let grab = (fun uu____566 -> ((FStar_Util.monitor_enter x);
(z3proc ());
))
in (

let release = (fun uu____572 -> (FStar_Util.monitor_exit x))
in (

let refresh = (fun uu____577 -> (

let proc = (grab ())
in ((FStar_Util.kill_process proc);
(let _0_388 = Some ((new_proc ()))
in (FStar_ST.write the_z3proc _0_388));
(query_logging.close_log ());
(release ());
)))
in (

let restart = (fun uu____588 -> ((FStar_Util.monitor_enter ());
(query_logging.close_log ());
(FStar_ST.write the_z3proc None);
(let _0_389 = Some ((new_proc ()))
in (FStar_ST.write the_z3proc _0_389));
(FStar_Util.monitor_exit ());
))
in {grab = grab; release = release; refresh = refresh; restart = restart}))))))))


let at_log_file : Prims.unit  ->  Prims.string = (fun uu____601 -> (

let uu____602 = (FStar_Options.log_queries ())
in (match (uu____602) with
| true -> begin
(let _0_390 = (query_logging.log_file_name ())
in (Prims.strcat "@" _0_390))
end
| uu____603 -> begin
""
end)))


let doZ3Exe' : Prims.bool  ->  Prims.string  ->  z3status = (fun fresh input -> (

let parse = (fun z3out -> (

let lines = (FStar_All.pipe_right (FStar_String.split (('\n')::[]) z3out) (FStar_List.map FStar_Util.trim_string))
in (

let print_stats = (fun lines -> (

let starts_with = (fun c s -> (((FStar_String.length s) >= (Prims.parse_int "1")) && (let _0_391 = (FStar_String.get s (Prims.parse_int "0"))
in (_0_391 = c))))
in (

let ends_with = (fun c s -> (((FStar_String.length s) >= (Prims.parse_int "1")) && (let _0_392 = (FStar_String.get s ((FStar_String.length s) - (Prims.parse_int "1")))
in (_0_392 = c))))
in (

let last = (fun l -> (FStar_List.nth l ((FStar_List.length l) - (Prims.parse_int "1"))))
in (

let uu____656 = (FStar_Options.print_z3_statistics ())
in (match (uu____656) with
| true -> begin
(

let uu____657 = ((((FStar_List.length lines) >= (Prims.parse_int "2")) && (let _0_393 = (FStar_List.hd lines)
in (starts_with '(' _0_393))) && (let _0_394 = (last lines)
in (ends_with ')' _0_394)))
in (match (uu____657) with
| true -> begin
((FStar_Util.print_string (let _0_397 = (let _0_395 = (query_logging.get_module_name ())
in (FStar_Util.format1 "BEGIN-STATS %s\n" _0_395))
in (let _0_396 = (at_log_file ())
in (Prims.strcat _0_397 _0_396))));
(FStar_List.iter (fun s -> (FStar_Util.print_string (FStar_Util.format1 "%s\n" s))) lines);
(FStar_Util.print_string "END-STATS\n");
)
end
| uu____664 -> begin
(failwith "Unexpected output from Z3: could not find statistics\n")
end))
end
| uu____665 -> begin
()
end))))))
in (

let unsat_core = (fun lines -> (

let parse_core = (fun s -> (

let s = (FStar_Util.trim_string s)
in (

let s = (FStar_Util.substring s (Prims.parse_int "1") ((FStar_String.length s) - (Prims.parse_int "2")))
in (match ((FStar_Util.starts_with s "error")) with
| true -> begin
None
end
| uu____691 -> begin
(let _0_399 = (FStar_All.pipe_right (FStar_Util.split s " ") (FStar_Util.sort_with FStar_String.compare))
in (FStar_All.pipe_right _0_399 (fun _0_398 -> Some (_0_398))))
end))))
in (match (lines) with
| ("<unsat-core>")::(core)::("</unsat-core>")::rest -> begin
(let _0_400 = (parse_core core)
in ((_0_400), (lines)))
end
| uu____709 -> begin
((None), (lines))
end)))
in (

let rec lblnegs = (fun lines succeeded -> (match (lines) with
| (lname)::("false")::rest when (FStar_Util.starts_with lname "label_") -> begin
(let _0_401 = (lblnegs rest succeeded)
in (lname)::_0_401)
end
| (lname)::(uu____730)::rest when (FStar_Util.starts_with lname "label_") -> begin
(lblnegs rest succeeded)
end
| uu____733 -> begin
((match (succeeded) with
| true -> begin
(print_stats lines)
end
| uu____736 -> begin
()
end);
[];
)
end))
in (

let unsat_core_and_lblnegs = (fun lines succeeded -> (

let uu____751 = (unsat_core lines)
in (match (uu____751) with
| (core_opt, rest) -> begin
(let _0_402 = (lblnegs rest succeeded)
in ((core_opt), (_0_402)))
end)))
in (

let rec result = (fun x -> (match (x) with
| ("timeout")::tl -> begin
TIMEOUT ([])
end
| ("unknown")::tl -> begin
UNKNOWN ((Prims.snd (unsat_core_and_lblnegs tl false)))
end
| ("sat")::tl -> begin
SAT ((Prims.snd (unsat_core_and_lblnegs tl false)))
end
| ("unsat")::tl -> begin
UNSAT ((Prims.fst (unsat_core_and_lblnegs tl true)))
end
| ("killed")::tl -> begin
((bg_z3_proc.restart ());
KILLED;
)
end
| (hd)::tl -> begin
((let _0_404 = (let _0_403 = (query_logging.get_module_name ())
in (FStar_Util.format2 "%s: Unexpected output from Z3: %s\n" _0_403 hd))
in (FStar_Errors.warn FStar_Range.dummyRange _0_404));
(result tl);
)
end
| uu____803 -> begin
(let _0_407 = (let _0_406 = (let _0_405 = (FStar_List.map (fun l -> (FStar_Util.format1 "<%s>" (FStar_Util.trim_string l))) lines)
in (FStar_String.concat "\n" _0_405))
in (FStar_Util.format1 "Unexpected output from Z3: got output lines: %s\n" _0_406))
in (FStar_All.pipe_left failwith _0_407))
end))
in (result lines))))))))
in (

let cond = (fun pid s -> (

let x = ((FStar_Util.trim_string s) = "Done!")
in x))
in (

let stdout = (match (fresh) with
| true -> begin
(let _0_410 = (tid ())
in (let _0_409 = (FStar_Options.z3_exe ())
in (let _0_408 = (ini_params ())
in (FStar_Util.launch_process _0_410 _0_409 _0_408 input cond))))
end
| uu____815 -> begin
(

let proc = (bg_z3_proc.grab ())
in (

let stdout = (FStar_Util.ask_process proc input)
in ((bg_z3_proc.release ());
stdout;
)))
end)
in (parse (FStar_Util.trim_string stdout))))))


let doZ3Exe : Prims.bool  ->  Prims.string  ->  z3status = (fun fresh input -> (doZ3Exe' fresh input))


let z3_options : Prims.unit  ->  Prims.string = (fun uu____827 -> "(set-option :global-decls false)(set-option :smt.mbqi false)(set-option :auto_config false)(set-option :produce-unsat-cores true)")

type 'a job =
{job : Prims.unit  ->  'a; callback : 'a  ->  Prims.unit}

type error_kind =
| Timeout
| Kill
| Default


let uu___is_Timeout : error_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Timeout -> begin
true
end
| uu____878 -> begin
false
end))


let uu___is_Kill : error_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Kill -> begin
true
end
| uu____882 -> begin
false
end))


let uu___is_Default : error_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Default -> begin
true
end
| uu____886 -> begin
false
end))


type z3job =
((unsat_core, (FStar_SMTEncoding_Term.error_labels * error_kind)) FStar_Util.either * Prims.int) job


let job_queue : z3job Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let pending_jobs : Prims.int FStar_ST.ref = (FStar_Util.mk_ref (Prims.parse_int "0"))


let with_monitor = (fun m f -> ((FStar_Util.monitor_enter m);
(

let res = (f ())
in ((FStar_Util.monitor_exit m);
res;
));
))


let z3_job : Prims.bool  ->  ((label * FStar_SMTEncoding_Term.sort) * Prims.string * FStar_Range.range) Prims.list  ->  Prims.string  ->  Prims.unit  ->  ((unsat_core, (FStar_SMTEncoding_Term.error_labels * error_kind)) FStar_Util.either * Prims.int) = (fun fresh label_messages input uu____947 -> (

let ekind = (fun uu___93_963 -> (match (uu___93_963) with
| TIMEOUT (uu____964) -> begin
Timeout
end
| (SAT (_)) | (UNKNOWN (_)) -> begin
Default
end
| KILLED -> begin
Kill
end
| uu____968 -> begin
(failwith "Impossible")
end))
in (

let start = (FStar_Util.now ())
in (

let status = (doZ3Exe fresh input)
in (

let uu____971 = (let _0_411 = (FStar_Util.now ())
in (FStar_Util.time_diff start _0_411))
in (match (uu____971) with
| (uu____980, elapsed_time) -> begin
(

let result = (match (status) with
| UNSAT (core) -> begin
((FStar_Util.Inl (core)), (elapsed_time))
end
| KILLED -> begin
((FStar_Util.Inr ((([]), (Kill)))), (elapsed_time))
end
| (TIMEOUT (lblnegs)) | (SAT (lblnegs)) | (UNKNOWN (lblnegs)) -> begin
((

let uu____1060 = (FStar_Options.debug_any ())
in (match (uu____1060) with
| true -> begin
(let _0_412 = (FStar_Util.format1 "Z3 says: %s\n" (status_to_string status))
in (FStar_All.pipe_left FStar_Util.print_string _0_412))
end
| uu____1061 -> begin
()
end));
(

let failing_assertions = (FStar_All.pipe_right lblnegs (FStar_List.collect (fun l -> (

let uu____1082 = (FStar_All.pipe_right label_messages (FStar_List.tryFind (fun uu____1106 -> (match (uu____1106) with
| (m, uu____1113, uu____1114) -> begin
((Prims.fst m) = l)
end))))
in (match (uu____1082) with
| None -> begin
[]
end
| Some (lbl, msg, r) -> begin
(((lbl), (msg), (r)))::[]
end)))))
in (let _0_414 = FStar_Util.Inr ((let _0_413 = (ekind status)
in ((failing_assertions), (_0_413))))
in ((_0_414), (elapsed_time))));
)
end)
in result)
end))))))


let running : Prims.bool FStar_ST.ref = (FStar_Util.mk_ref false)


let rec dequeue' : Prims.unit  ->  Prims.unit = (fun uu____1192 -> (

let j = (

let uu____1194 = (FStar_ST.read job_queue)
in (match (uu____1194) with
| [] -> begin
(failwith "Impossible")
end
| (hd)::tl -> begin
((FStar_ST.write job_queue tl);
hd;
)
end))
in ((FStar_Util.incr pending_jobs);
(FStar_Util.monitor_exit job_queue);
(run_job j);
(with_monitor job_queue (fun uu____1221 -> (FStar_Util.decr pending_jobs)));
(dequeue ());
)))
and dequeue : Prims.unit  ->  Prims.unit = (fun uu____1226 -> (

let uu____1227 = (FStar_ST.read running)
in if uu____1227 then begin
(

let rec aux = (fun uu____1233 -> ((FStar_Util.monitor_enter job_queue);
(

let uu____1239 = (FStar_ST.read job_queue)
in (match (uu____1239) with
| [] -> begin
((FStar_Util.monitor_exit job_queue);
(FStar_Util.sleep (Prims.parse_int "50"));
(aux ());
)
end
| uu____1250 -> begin
(dequeue' ())
end));
))
in (aux ()))
end else begin
()
end))
and run_job : z3job  ->  Prims.unit = (fun j -> (let _0_415 = (j.job ())
in (FStar_All.pipe_left j.callback _0_415)))


let init : Prims.unit  ->  Prims.unit = (fun uu____1273 -> ((FStar_ST.write running true);
(

let n_cores = (FStar_Options.n_cores ())
in (match ((n_cores > (Prims.parse_int "1"))) with
| true -> begin
(

let rec aux = (fun n -> (match ((n = (Prims.parse_int "0"))) with
| true -> begin
()
end
| uu____1282 -> begin
((FStar_Util.spawn dequeue);
(aux (n - (Prims.parse_int "1")));
)
end))
in (aux n_cores))
end
| uu____1284 -> begin
()
end));
))


let enqueue : Prims.bool  ->  z3job  ->  Prims.unit = (fun fresh j -> (match ((not (fresh))) with
| true -> begin
(run_job j)
end
| uu____1291 -> begin
((FStar_Util.monitor_enter job_queue);
(let _0_417 = (let _0_416 = (FStar_ST.read job_queue)
in (FStar_List.append _0_416 ((j)::[])))
in (FStar_ST.write job_queue _0_417));
(FStar_Util.monitor_pulse job_queue);
(FStar_Util.monitor_exit job_queue);
)
end))


let finish : Prims.unit  ->  Prims.unit = (fun uu____1315 -> (

let rec aux = (fun uu____1319 -> (

let uu____1320 = (with_monitor job_queue (fun uu____1329 -> (let _0_419 = (FStar_ST.read pending_jobs)
in (let _0_418 = (FStar_List.length (FStar_ST.read job_queue))
in ((_0_419), (_0_418))))))
in (match (uu____1320) with
| (n, m) -> begin
(match (((n + m) = (Prims.parse_int "0"))) with
| true -> begin
((FStar_ST.write running false);
(let _0_420 = (FStar_Errors.report_all ())
in (FStar_All.pipe_right _0_420 Prims.ignore));
)
end
| uu____1346 -> begin
((FStar_Util.sleep (Prims.parse_int "500"));
(aux ());
)
end)
end)))
in (aux ())))


type scope_t =
FStar_SMTEncoding_Term.decl Prims.list Prims.list


let fresh_scope : FStar_SMTEncoding_Term.decl Prims.list Prims.list FStar_ST.ref = (FStar_Util.mk_ref (([])::[]))


let bg_scope : FStar_SMTEncoding_Term.decl Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let push : Prims.string  ->  Prims.unit = (fun msg -> ((let _0_422 = (let _0_421 = (FStar_ST.read fresh_scope)
in ((FStar_SMTEncoding_Term.Caption (msg))::(FStar_SMTEncoding_Term.Push)::[])::_0_421)
in (FStar_ST.write fresh_scope _0_422));
(let _0_424 = (let _0_423 = (FStar_ST.read bg_scope)
in (FStar_List.append ((FStar_SMTEncoding_Term.Caption (msg))::(FStar_SMTEncoding_Term.Push)::[]) _0_423))
in (FStar_ST.write bg_scope _0_424));
))


let pop : Prims.string  ->  Prims.unit = (fun msg -> ((let _0_425 = (FStar_List.tl (FStar_ST.read fresh_scope))
in (FStar_ST.write fresh_scope _0_425));
(let _0_427 = (let _0_426 = (FStar_ST.read bg_scope)
in (FStar_List.append ((FStar_SMTEncoding_Term.Pop)::(FStar_SMTEncoding_Term.Caption (msg))::[]) _0_426))
in (FStar_ST.write bg_scope _0_427));
))


let giveZ3 : FStar_SMTEncoding_Term.decl Prims.list  ->  Prims.unit = (fun decls -> ((FStar_All.pipe_right decls (FStar_List.iter (fun uu___94_1409 -> (match (uu___94_1409) with
| (FStar_SMTEncoding_Term.Push) | (FStar_SMTEncoding_Term.Pop) -> begin
(failwith "Unexpected push/pop")
end
| uu____1410 -> begin
()
end))));
(

let uu____1412 = (FStar_ST.read fresh_scope)
in (match (uu____1412) with
| (hd)::tl -> begin
(FStar_ST.write fresh_scope (((FStar_List.append hd decls))::tl))
end
| uu____1430 -> begin
(failwith "Impossible")
end));
(let _0_429 = (let _0_428 = (FStar_ST.read bg_scope)
in (FStar_List.append (FStar_List.rev decls) _0_428))
in (FStar_ST.write bg_scope _0_429));
))


let bgtheory : Prims.bool  ->  FStar_SMTEncoding_Term.decl Prims.list = (fun fresh -> (match (fresh) with
| true -> begin
((FStar_ST.write bg_scope []);
(let _0_430 = (FStar_List.rev (FStar_ST.read fresh_scope))
in (FStar_All.pipe_right _0_430 FStar_List.flatten));
)
end
| uu____1456 -> begin
(

let bg = (FStar_ST.read bg_scope)
in ((FStar_ST.write bg_scope []);
(FStar_List.rev bg);
))
end))


let refresh : Prims.unit  ->  Prims.unit = (fun uu____1468 -> ((

let uu____1470 = (let _0_431 = (FStar_Options.n_cores ())
in (_0_431 < (Prims.parse_int "2")))
in (match (uu____1470) with
| true -> begin
(bg_z3_proc.refresh ())
end
| uu____1471 -> begin
()
end));
(

let theory = (bgtheory true)
in (FStar_ST.write bg_scope (FStar_List.rev theory)));
))


let mark : Prims.string  ->  Prims.unit = (fun msg -> (push msg))


let reset_mark : Prims.string  ->  Prims.unit = (fun msg -> ((pop msg);
(refresh ());
))


let commit_mark = (fun msg -> (

let uu____1491 = (FStar_ST.read fresh_scope)
in (match (uu____1491) with
| (hd)::(s)::tl -> begin
(FStar_ST.write fresh_scope (((FStar_List.append hd s))::tl))
end
| uu____1512 -> begin
(failwith "Impossible")
end)))


let ask : unsat_core  ->  ((label * FStar_SMTEncoding_Term.sort) * Prims.string * FStar_Range.range) Prims.list  ->  FStar_SMTEncoding_Term.decl Prims.list  ->  (((unsat_core, (FStar_SMTEncoding_Term.error_labels * error_kind)) FStar_Util.either * Prims.int)  ->  Prims.unit)  ->  Prims.unit = (fun core label_messages qry cb -> (

let fresh = (let _0_432 = (FStar_Options.n_cores ())
in (_0_432 > (Prims.parse_int "1")))
in (

let filter_assertions = (fun theory -> (match (core) with
| None -> begin
((theory), (false))
end
| Some (core) -> begin
(

let uu____1576 = (FStar_List.fold_right (fun d uu____1586 -> (match (uu____1586) with
| (theory, n_retained, n_pruned) -> begin
(match (d) with
| FStar_SMTEncoding_Term.Assume (uu____1604, uu____1605, Some (name)) -> begin
(match ((FStar_List.contains name core)) with
| true -> begin
(((d)::theory), ((n_retained + (Prims.parse_int "1"))), (n_pruned))
end
| uu____1613 -> begin
(match ((FStar_Util.starts_with name "@")) with
| true -> begin
(((d)::theory), (n_retained), (n_pruned))
end
| uu____1619 -> begin
((theory), (n_retained), ((n_pruned + (Prims.parse_int "1"))))
end)
end)
end
| uu____1621 -> begin
(((d)::theory), (n_retained), (n_pruned))
end)
end)) theory (([]), ((Prims.parse_int "0")), ((Prims.parse_int "0"))))
in (match (uu____1576) with
| (theory', n_retained, n_pruned) -> begin
(

let missed_assertions = (fun th core -> (

let missed = (let _0_434 = (FStar_All.pipe_right core (FStar_List.filter (fun nm -> (let _0_433 = (FStar_All.pipe_right th (FStar_Util.for_some (fun uu___95_1649 -> (match (uu___95_1649) with
| FStar_SMTEncoding_Term.Assume (uu____1650, uu____1651, Some (nm')) -> begin
(nm = nm')
end
| uu____1654 -> begin
false
end))))
in (FStar_All.pipe_right _0_433 Prims.op_Negation)))))
in (FStar_All.pipe_right _0_434 (FStar_String.concat ", ")))
in (

let included = (let _0_435 = (FStar_All.pipe_right th (FStar_List.collect (fun uu___96_1659 -> (match (uu___96_1659) with
| FStar_SMTEncoding_Term.Assume (uu____1661, uu____1662, Some (nm)) -> begin
(nm)::[]
end
| uu____1665 -> begin
[]
end))))
in (FStar_All.pipe_right _0_435 (FStar_String.concat ", ")))
in (FStar_Util.format2 "missed={%s}; included={%s}" missed included))))
in ((

let uu____1667 = ((FStar_Options.hint_info ()) && (FStar_Options.debug_any ()))
in (match (uu____1667) with
| true -> begin
(

let n = (FStar_List.length core)
in (

let missed = (match ((n <> n_retained)) with
| true -> begin
(missed_assertions theory' core)
end
| uu____1673 -> begin
""
end)
in (let _0_439 = (FStar_Util.string_of_int n_retained)
in (let _0_438 = (match ((n <> n_retained)) with
| true -> begin
(let _0_436 = (FStar_Util.string_of_int n)
in (FStar_Util.format2 " (expected %s (%s); replay may be inaccurate)" _0_436 missed))
end
| uu____1679 -> begin
""
end)
in (let _0_437 = (FStar_Util.string_of_int n_pruned)
in (FStar_Util.print3 "Hint-info: Retained %s assertions%s and pruned %s assertions using recorded unsat core\n" _0_439 _0_438 _0_437))))))
end
| uu____1680 -> begin
()
end));
(let _0_443 = (let _0_442 = (let _0_441 = FStar_SMTEncoding_Term.Caption ((let _0_440 = (FStar_All.pipe_right core (FStar_String.concat ", "))
in (Prims.strcat "UNSAT CORE: " _0_440)))
in (_0_441)::[])
in (FStar_List.append theory' _0_442))
in ((_0_443), (true)));
))
end))
end))
in (

let theory = (bgtheory fresh)
in (

let theory = (FStar_List.append theory (FStar_List.append ((FStar_SMTEncoding_Term.Push)::[]) (FStar_List.append qry ((FStar_SMTEncoding_Term.Pop)::[]))))
in (

let uu____1687 = (filter_assertions theory)
in (match (uu____1687) with
| (theory, used_unsat_core) -> begin
(

let cb = (fun uu____1704 -> (match (uu____1704) with
| (uc_errs, time) -> begin
(match (used_unsat_core) with
| true -> begin
(match (uc_errs) with
| FStar_Util.Inl (uu____1721) -> begin
(cb ((uc_errs), (time)))
end
| FStar_Util.Inr (uu____1728, ek) -> begin
(cb ((FStar_Util.Inr ((([]), (ek)))), (time)))
end)
end
| uu____1741 -> begin
(cb ((uc_errs), (time)))
end)
end))
in (

let input = (let _0_444 = (FStar_List.map (FStar_SMTEncoding_Term.declToSmt (z3_options ())) theory)
in (FStar_All.pipe_right _0_444 (FStar_String.concat "\n")))
in ((

let uu____1749 = (FStar_Options.log_queries ())
in (match (uu____1749) with
| true -> begin
(query_logging.append_to_log input)
end
| uu____1750 -> begin
()
end));
(enqueue fresh {job = (z3_job fresh label_messages input); callback = cb});
)))
end)))))))




