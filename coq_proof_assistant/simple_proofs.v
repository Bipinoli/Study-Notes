Theorem plus_zero :
 forall n: nat, 0 + n = n.
Proof.
 intros n. simpl. reflexivity. Qed.


Theorem mult_zero:
 forall n: nat, 0 * n = 0.
Proof.
 intros x. simpl. reflexivity. Qed.


Theorem plus_id:
 forall n m: nat, n = m -> n + n = m + m.
Proof.
 intros n m.
 intros hypothesis.
 rewrite -> hypothesis.
 reflexivity. Qed.


Theorem mult_n_0_m:
 forall n m : nat, (0 * n) + (0 * m) = 0.
Proof.
 intros a b.
 rewrite -> mult_zero.
 rewrite -> mult_zero.
 reflexivity. Qed.
 