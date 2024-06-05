Inductive animal: Type := 
 | fish
 | reptile
 | bird.

Definition evolve_to (a: animal): animal :=
 match a with
  | fish => reptile
  | reptile => bird 
  | bird => bird
 end.

Compute (evolve_to fish).

Example test_evolve:
 (evolve_to reptile) = bird.
 Proof. simpl. reflexivity. Qed.

