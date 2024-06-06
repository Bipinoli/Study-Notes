
Definition doit3times {T: Type} (f: T -> T) (n: T): T :=
 f (f (f n)).

Check @doit3times.


Definition minustwo (n: nat): nat :=
 match n with 
 | O => O
 | S O => O
 | S (S x) => x
 end.

Compute minustwo 5.

Example test_doitetimes: doit3times minustwo 8 = 2.
Proof. reflexivity. Qed.


Inductive list {T: Type}: Type :=
 | nil
 | cons (x: T) (l: list).


Fixpoint filter {T: Type} (cond: T -> bool) (lst: list): list :=
 match lst with
 | nil => nil
 | cons a lst => if cond a then (cons a (filter cond lst)) 
                  else (filter cond lst)
 end.


Definition notb (b: bool): bool :=
 match b with
 | true => false 
 | false => true
end.

Fixpoint iseven (n: nat): bool :=
 match n with
 | O => true
 | S O => false
 | S x => notb (iseven x)
end.

Definition isodd (n: nat): bool := notb (iseven n).


Compute filter iseven (cons 1 (cons 2 (cons 3 nil))).
Compute filter isodd (cons 1 (cons 2 (cons 3 nil))).
 
Example test_filter1: filter iseven (cons 1 (cons 2 (cons 3 nil))) = (cons 2 nil).
Proof. reflexivity. Qed.
Example test_filter2: filter isodd (cons 1 (cons 2 (cons 3 nil))) = (cons 1 (cons 3 nil)).
Proof. reflexivity. Qed.


Example test_anonymous_func: 
 doit3times (fun n => n + n) 3 = 24.
Proof. reflexivity. Qed.


Notation "[ x , .. , y ]" := (cons x .. (cons y nil) .. ).

Fixpoint map {X Y: Type} (func: X -> Y) (lst: list): list :=
 match lst with 
 | nil => nil
 | cons a lst' => cons (func a) (map func lst')
 end.


Compute map (fun x => x + 3) [1,2,3].

Example test_map: map (fun x => x * 2) [1,2,3] = [2,4,6].
Proof. reflexivity. Qed.


Example test_map2: map isodd [1,2,3,4,5,6] = [true, false, true, false, true, false].
Proof. reflexivity. Qed.


Fixpoint fold {X: Type} (func: X -> X -> X) (lst: list) (default: X): X :=
 match lst with
 | nil => default
 | cons a lst' => func a (fold func lst' default)
 end.


Example test_fold1: fold (fun x y => x + y) [1,2,3,4,5,6,7,8,9,10] 0 = 55.
Proof. reflexivity. Qed.


Definition xorb (b1 b2: bool): bool :=
 match b1, b2 with
 | true, true => false
 | true, false => true
 | false, true => true
 | false, false => false
end.

Example test_fold2: fold xorb [true, true, false, true] false = true.
Proof. reflexivity. Qed. 









