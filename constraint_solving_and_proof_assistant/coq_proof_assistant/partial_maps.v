
Inductive partial_map: Type :=
 | Empty
 | Binding (key: nat) (val: nat) (others: partial_map).


Definition add (key: nat) (val: nat) (m: partial_map) : partial_map :=
 Binding key val m.



Inductive natoption: Type :=
 | None
 | Some (n: nat).


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


Notation "x =? y" := (eqb x y) (at level 70): nat_scope.


Fixpoint find (key: nat) (m: partial_map): natoption :=
 match m with
 | Empty => None
 | Binding k v others => 
    if k =? key then Some v else find key others
 end.



Lemma eqb_lemma: 
 forall n : nat, eqb n n = true.
Proof. Admitted.


Theorem find_update: 
 forall (m: partial_map) (k v: nat), 
 find k (add k v m) = Some v.
Proof.
 intros m k v.
 simpl. rewrite eqb_lemma. reflexivity. 
Qed.
