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
Theorem add_0_right_induction:
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


Lemma plus_a_Sb_lemma: 
 forall a b: nat, S (a + b) = a + S b.
(** let's just assume the lemma to be true **)
Proof. Admitted.


Theorem plus_commutative_unproven_lemma:
 forall a b: nat, a + b = b + a.
Proof.
 intros a b. induction a as [ | n' hypothesis].
 - (* base case: 0 + b = b + 0 *)
   simpl. rewrite -> add_0_right_induction. reflexivity. 
 - (* inductive case: n' + b = b + n' => S n' + b = b + S n' *)
   simpl. rewrite -> hypothesis. rewrite -> plus_a_Sb_lemma.
   reflexivity.
Qed.



Lemma plus_n_Sm_lemma: 
 forall n m: nat, S (n + m) = n + S m.
Proof.
 intros n m. induction n as [ | n' hypothesis].
 - (* base case: S ( 0 + m ) = 0 + S m *)
   simpl. reflexivity.
 - (* inductive case: S (n' + m) = n' + Sm => S (S n' + m) = S n' + S m *)
   simpl. rewrite -> hypothesis. reflexivity.
Qed.


Theorem plus_commutative_proven_lemma:
 forall a b: nat, a + b = b + a.
Proof.
 intros a b. induction a as [ | n' hypothesis].
 - (* base case: 0 + b = b + 0 *)
   simpl. rewrite -> add_0_right_induction. reflexivity. 
 - (* inductive case: n' + b = b + n' => S n' + b = b + S n' *)
   simpl. rewrite -> hypothesis. rewrite -> plus_n_Sm_lemma.
   reflexivity.
Qed.


Theorem mult_0_plus: 
 forall a b: nat, (a + 0 + 0) * b = a * b.
Proof.
 intros a b.
 assert (hypothesis: a + 0 + 0 = a).
 {
  (* prove the asserted hypothesis *)
  Set Printing Parentheses. (* for better visibility *)
  rewrite plus_commutative_proven_lemma.
  simpl.
  rewrite plus_commutative_proven_lemma.
  simpl.
  reflexivity.
 }
 rewrite hypothesis.
 reflexivity.
Qed.



Theorem plus_rearrange: 
 forall a b c d: nat, (a + b) + (c + d) = (b + a) + (c + d).
Proof.
 intros a b c d.
 Set Printing Parentheses. (* show all parens *)
 assert (H: a + b = b + a).
 { rewrite plus_commutative_proven_lemma. reflexivity. }
 rewrite H. reflexivity. 
Qed.






