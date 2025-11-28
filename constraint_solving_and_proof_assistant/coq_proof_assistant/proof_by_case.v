Fixpoint eqb (n m: nat) : bool :=
 match n with 
 | O => match m with 
      | O => true
      | S _ => false
      end
 | S n' => match m with 
        | O => false
        | S m' => eqb n' m'
        end
 end.

Definition negb (n: bool): bool :=
 match n with 
 | true => false 
 | false => true
 end.


Notation "x =? y" := (eqb x y) (at level 70): nat_scope.


Theorem plus_1_neg_0 :
 forall n : nat,
 (n + 1) =? 0 = false.
Proof.
 intros n. destruct n as [ | n'] eqn:equation.
 - reflexivity.
 - reflexivity. Qed.


Theorem negb_involutive:
 forall b: bool, negb (negb b) = b.
Proof.
 intros b. destruct b eqn:equation.
 - reflexivity.
 - reflexivity. Qed.



Definition andb (a b: bool) : bool := 
 match a with 
 | true => b
 | false => false
 end.


Theorem andb_commutative:
 forall a b: bool, andb a b = andb b a.
Proof.
 intros x y. destruct x eqn:Ea.
 - destruct y eqn:Eb.
  -- reflexivity.
  -- reflexivity.
 - destruct y eqn:Eb.
  -- reflexivity.
  -- reflexivity.
Qed.


(** more handy way to check the truth table **)
Theorem andb_commutative_again:
 forall a b: bool, andb a b = andb b a.
Proof.
 intros [] [].
 - reflexivity.
 - reflexivity.
 - reflexivity.
 - reflexivity.
Qed.