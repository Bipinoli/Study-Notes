Inductive bool : Type :=
 | true 
 | false.

Definition negb (b: bool): bool :=
 match b with 
  | true => false 
  | false => true
 end.

Definition andb (b1: bool) (b2: bool): bool :=
 match b1 with 
 | true => b2
 | false => false
 end.

Definition orb (b1: bool) (b2: bool): bool :=
 match b1 with 
 | true => true
 | false => b2 
 end.

Example test_orb1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb2: (orb false false) = false.
Proof. simpl. reflexivity. Qed.
Example test_and1: (andb false true) = false.
Proof. simpl. reflexivity. Qed.
Example test_and2: (andb true true) = true.
Proof. simpl. reflexivity. Qed.

Check orb.



Inductive rgb: Type :=
 | red 
 | green
 | blue.

Inductive color: Type :=
 | black
 | white 
 | primary (p: rgb).

Definition monochrome (c: color): bool :=
 match c with 
 | black => true
 | white => true
 | primary p => false 
 end.

Definition isred (c: color): bool := 
 match c with 
 | black => false 
 | white => false 
 | primary red => true
 | primary _ => false
 end.


Module Playground.
 Definition b: rgb := blue.
End Playground.

Definition b: bool := true.

Check Playground.b : rgb.
Check b : bool.


Module NatPlayground.
 Inductive nat: Type :=
 | O
 | S (n: nat).

 Definition pred (n: nat): nat := 
 match n with 
 | O => O
 | S n' => n'
 end.

 Check (S (S O)).

 Definition minusTwo (n: nat): nat :=
 match n with
 | O => O
 | S O => O
 | S (S n') => n'
 end.

 (** Recursive functions are defined with 'Fixpoint' **)
 Fixpoint even (n: nat) : bool :=
 match n with 
 | O => true
 | S O => false
 | S (S n') => even n'
 end.

End NatPlayground.


Module Playground2.

Fixpoint plus (a: nat) (b: nat) : nat := 
 match a with 
 | O => b 
 | S n' => S (plus n' b)
 end.

Compute (plus 10 3).


Fixpoint mult (a: nat) (b: nat) : nat := 
 match a with 
 | O => O
 | S n' => plus b (mult n' b)
 end.

Compute (mult 4 3).


Fixpoint minus (a: nat) (b: nat) : nat :=
 match a, b with 
 | O , _ => O
 | S _ , O => a
 | S a', S b' => minus a' b'
 end.

Compute (minus 5 3).


Fixpoint equal (a: nat) (b: nat): bool :=
 match a with 
 | O => match b with 
        | O => true 
        | S _ => false 
        end
 | S a' => match b with 
          | O => false 
          | S b' => equal a' b'
          end
 end.

Compute (equal 12 12).
Compute (equal 10 11).


End Playground2.












