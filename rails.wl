(* ::Package:: *)

(* Mathematica Package *)

(* Created by the Wolfram Workbench Sep 5, 2010 *)

BeginPackage["rails`"]
(* Exported symbols added here with SymbolName::usage *) 
(* Copyright 2015 Ficonab Pte Ltd *)
(* Author Scott Sproule *)
(* Package used for connecting to rails applications from mathematica*)
(* Exported symbols added here with SymbolName::usage *) 
railsPrintDebug::usage="print debug statement flag: eg monitorPosition  //railsPrintDebug";
railsPostJsonDataRails::usage="post json data railsPostJsonData[url_String,token_String,email_String,data_List] ";
railsGetJsonDataRails::usage="get json data railsGetJsonData[url_String,token_String,email_String,data_List] ";
railsGetActiveRecordModel::usage=" get ar model railsGetActiveRecordModel[modelName_String,id_Integer,host_String ]";
railsGetActiveRecordModels::usage=" get ar model railsGetActiveRecordModels[modelName_String,,host_String ]";
railsGetRawJsonDataRails::usage="get Raw Json Data from rails application";
railsPostActiveRecordModel::usage="create a model in active record from mathematica railsPostActiveRecordModel[modelName_String,body_Association,host_String ]";
(* logging utilities for logging results *)
railsOpenLog::usage="open logging railsOpenLog[fname_String, directory_String:]";
railsLogStream::usage="log stream variable railsLogStream ";
railsLog::usage="log values railsLog[out_OutputStream,string_String,expression_:{}]";
railsSystemStatus::usage="return key system status railsSystemStatus";

Begin["`Private`"]
Attributes[railsPrintDebug]={HoldAll};
railsPrintDebug[expr_] := Block[{railsDebugPrint = Print}, expr];

railsGetRawJsonDataRails[url_String,rules_Rule]:=Module[{res,body},
railsDebugPrint["url: ",url];
body=ExportString[{Normal[rules]},"JSON"];
If[body==$Failed,Print["Export failed for :",rules]];
res=URLFetch[url,  "Body"-> body,
  "Method"->"GET","Headers"->{"Content-type" -> "application/json"}];
railsDebugPrint["url ",url," res is: ",res, " rules were: ", rules];
res
];

(* post a model/create *)

railsPostActiveRecordModel[modelName_String,body_Association,host_String ]:=Module[{res,url},
url=StringJoin[host,"/",modelName,"s.json"];
railsDebugPrint["Posting railsPostActiveRecordModel: --->",body, " to url: ",url];
res=railsPostJsonDataRails[url,modelName-> body] ;
res ];

(* get one record from AR *)

railsGetActiveRecordModel[modelName_String,id_Integer,host_String ]:=Module[{res,url},
url=StringJoin[host,"/",modelName,"s/",ToString[id],".json"];
railsDebugPrint["Getting: ",modelName, " to url: ",url, " id: ",id];
res=railsGetJsonDataRails[url,modelName-> modelName] ;
res ];

(* get many instances of model *)
railsGetActiveRecordModels[modelName_String,host_String ]:=Module[{res,url},
url=StringJoin[host,"/",modelName,"s.json"];
res=railsGetRawJsonDataRails[url,modelName-> modelName] ;
railsDebugPrint["Getting: ",modelName, " from url: ",url, " res: ",res];
ImportString[res,"JSON"] ];

railsPostJsonDataRails[url_String,rules_Rule]:=Module[{res,body},
railsDebugPrint["url: ",url];
body=ExportString[{Normal[rules]},"JSON"];
If[body==$Failed,Print["Export failed for :",rules]];
res=URLFetch[url,  "Body"-> body,
  "Method"->"POST","Headers"->{"Content-type" -> "application/json"}];
railsDebugPrint["url ",url," res is: ",res, " rules were: ", rules];
Association[ImportString[res,"JSON"]]
];

railsGetJsonDataRails[url_String,rules_Rule]:=Module[{res},
res=railsGetRawJsonDataRails[url,rules];
Association[ImportString[res,"JSON"]]
];

(* logging *)
railsOpenLog[fname_String, directory_String: "~/dreamLog/" ]:=Module[{filename,outs},
If[Length[FileNames[directory]]==0,CreateDirectory[directory]];
filename=StringJoin[directory,fname,DateString["ISODate"]];
Print["creating log file: ",filename];
outs=OpenWrite[filename];
If[Head[outs]==OutputStream,railsLogStream=outs];
outs
  ];

railsLog[out_OutputStream,string_String,expression_:{}]:=Module[{}, 
Write[out,{{DateList[],$TimeZone},string,expression}]
];

railsSystemStatus[]:=Module[{assoc},
assoc=<|"memoryinuse" -> MemoryInUse[],"maxmemory"-> MaxMemoryUsed[] |>;
assoc ];

End[];
EndPackage[];







