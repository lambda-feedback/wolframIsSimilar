(* A function to test whether a response is equal to an answer, \
including to within a given tolerance; input and output as
Associations *)

equalQAssociation = 
  Function[input,
    Module[{data, tolerance, correctQ, error, answer, response, params, feedback},
      (*Get the evaluation parameters from the incoming request*)
      data = input["params"];
      answer = data["answer"];
      response = data["response"];
      params = data["params"];
      Print["Loaded Data"];
      Print[data];

      Print["Processing Response and Answer"];
      If[NumericQ[answer],
        tolerance = 
          If[TrueQ[params["tolerance_is_absolute"]],
            params["tolerance"],
            params["tolerance"] * answer
          ];
        error = Abs[answer - response];
        correctQ = TrueQ[error <= tolerance],
        error = "not applicable";
        correctQ = TrueQ[answer == response]
      ];

      Print["Deciding Feedback"];
      feedback =
        If[correctQ,
            params["correct_response_feedback"],
            params["incorrect_response_feedback"]
        ];
      Print["Outputting Response"];
      <|
        "command" -> "eval",
        "result" -> <|
          "is_correct" -> correctQ,
          "feedback" -> feedback
        |>
      |>
    ]
  ];


(* A function to test whether a response is equal to an answer, \
including to within a given tolerance; input and output as
JSON strings

Calls equalQAssociation  *)

equalQJSON = Function[ExportString[equalQAssociation[ImportString[#, 
    "JSON"] //. List :> Association], "JSON", "Compact" -> True]];

(* A function to test whether a response is equal to an answer, \
including to within a given tolerance; input and output read in from \
external JSON files

Calls equalQAssociation  *)

equalQIO = Function[Export[#2, equalQAssociation[Import[#1, "JSON"] //.
     List :> Association], "JSON", "Compact" -> True]];

argv = Rest[$ScriptCommandLine];

Print["Running Evaluation"];
equalQIO[argv[[1]], argv[[2]]]
