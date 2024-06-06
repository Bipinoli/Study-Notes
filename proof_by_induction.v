Fixpoint plus (a: nat) (b: nat): nat :=
 match a with
 | O => b
 | S a' => S (plus a' b)
 end.

Notation "x + y" := (plus x y): nat_scope.

Compute (3 + 4).


(** proof by cases **)
Theorem add_0:
 forall n: nat, n + 0 = n.
Proof.
 intros n. destruct n as [ | n'] eqn:Eq.
 (** case n = 0. with definition of plus from above reflexivy can prove it **)
 - reflexivity.
 (** case n = S n' **)
 (** Hmm.. we need induction to prove this **)
Abort.


(** proof by induction **)
Theorem add_0_induction:
 forall n: nat, n + 0 = n.
Proof.
 intros n. induction n as [ | n' inductive_hypo].
 - (* case 1. n = O *) reflexivity. 
 - (* case 2. n = n' = S k *)
   simpl.
   rewrite -> inductive_hypo.
   reflexivity.
Qed.



Fixpoint minus (a b: nat): nat :=
 match a, b with
 | O , _ => O
 | S _ , O => a
 | S a', S b' => minus a' b'
 end.

Compute (minus 5 2).


Theorem minus_n_n:
 forall n:nat, n - n = 0.
Proof.
 intros n. induction n as [ | n' induc_hypo].
 - (* base case *) reflexivity.
 - (* inductive case *) 
    simpl. rewrite -> induc_hypo. reflexivity.
Qed.