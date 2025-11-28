Inductive natprod : Type :=
 | pair (n1 n1: nat).

Check (pair 2 3) : natprod.


Definition first (p: natprod) : nat :=
 match p with 
 | pair x y => x
 end.

Compute (first (pair 2 3)).

Notation "( x , y )" := (pair x y).

Compute (first (3 , 5)).


Definition second (p: natprod) : nat :=
 match p with 
 | ( x , y ) => y
 end.


Theorem surjective_pairing:
 forall (p: natprod), p = (first p, second p).
Proof.
 intros p. destruct p as [n m]. simpl.
 reflexivity.
Qed.

