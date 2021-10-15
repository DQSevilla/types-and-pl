
type term =
  | True | False | Zero
  | If of term * term * term
  | Succ of term
  | Pred of term
  | IsZero of term

let rec consts t =
  match t with
  | Succ t | Pred t | IsZero t -> consts t (* notice t is shadowed here *)
  | If (t1, t2, t3) -> (consts t1) @ (consts t2) @ (consts t3) (* list appends *)
  | t -> [t] (* singleton list of the constant terms (only type constructors left) *)

(* You can replace the last match rule above with the more explicit:

  | True -> True
  | False -> False
  | Zero -> Zero


  Also notice that if you remove any line above, the compiler will complain that you are not
  exhausing all of th etype constructors of term in your match. This is the power of static types
  that we will explore later in this book.
*)

let rec size t =
  (* the indictuve definition from the book will directly inform this code *)
  failwith "Implement me!"

let rec depth t =
  (* same deal. note OCaml has a polymorphic max builtin. You can also easily implement it yourself
     though, I recommend it. *)
  failwith "Implement me!"

let rec isnumericalval t =
  match t with
  | Zero -> true (* notice this is Ocaml's true, not the constructor True for our language *)
  | Succ t -> isnumericalval t
  | _ -> false (* notice the wildcard pattern, use with caution *)

let rec isval t  =
  match t with
  | True | False -> true
  | t when isnumericalval t -> true
  | _ -> false


exception NoRuleApplies

(* notice the optional explicit term-wise type annotation *)
let rec eval1 (t : term) : term =
  match t with
  | If (True, t2, _) -> t2
  | If (False, _, t3) -> t3
  | If (cond, t2, t3) ->
      (* notice the let binding, very different from traditional variable assignment *)
      let cond' = eval1 cond in
      If (cond', t2, t3)
  | Succ t ->
      let t' = eval1 t in
      Succ t'
  | Pred Zero -> Zero
  | Pred (Succ n) when isnumericalval n -> n
  | Pred t ->
      let t' = eval1 t in Pred t'
  | IsZero Zero -> True
  | IsZero (Succ n) when isnumericalval n -> False
  | IsZero t ->
      let t' = eval1 t in IsZero t'
  | _ -> raise NoRuleApplies

let rec eval t =
  try
    let t' = eval1 t in eval t'
  with NoRuleApplies -> t
