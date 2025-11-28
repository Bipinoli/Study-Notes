Inductive natlist: Type :=
 | nil
 | cons (n: nat) (l: natlist).


Definition mylist := cons 1 (cons 2 (cons 3 nil)).

Check mylist.

Notation "[ ]" := nil.
Notation "[ x , .. , y ]" := (cons x .. (cons y nil) .. ).
Notation "x :: l" := (cons x l) (at level 60, right associativity).

Check [ 1 , 2 , 3].


Fixpoint repeat (n count: nat): natlist :=
 match count with 
 | O => nil
 | S x' => n :: (repeat n x')
 end.


Compute (repeat 5 6).


Fixpoint length (l: natlist): nat :=
 match l with
 | nil => O
 | cons a lst => S (length lst)
 end.


Compute length (repeat 10 20).


Fixpoint append (lst1 lst2: natlist): natlist :=
 match lst1 with 
 | nil => lst2
 | cons a lst => cons a (append lst lst2)
 end.


Compute append (repeat 2 3) (repeat 1 2).

Notation "x ++ y" := (append x y)
                      (right associativity, at level 60).


Example test_append: [1 , 2 , 3] ++ [4 , 5] = [1 , 2 , 3 , 4 , 5].
Proof. reflexivity. Qed.


Definition head (default: nat) (lst: natlist): nat :=
 match lst with 
 | nil => default 
 | cons a lst => a
 end.

Definition tail (lst: natlist): natlist :=
 match lst with
 | nil => nil
 | cons a lst => lst
 end.

Example test_head: head 0 [1 , 2 , 3 ] = 1.
Proof. reflexivity. Qed.

Example test_tail: tail [1 , 2 , 3] = [2 , 3].
Proof. reflexivity. Qed.



Theorem nil_append:
 forall lst : natlist, [] ++ lst = lst.
Proof. reflexivity. Qed.


Theorem list_associativity: 
 forall lst1 lst2 lst3: natlist,
 (lst1 ++ lst2) ++ lst3 = lst1 ++ (lst2 ++ lst3).
Proof.
 intros lst1 lst2 lst3.
 induction lst1 as [ | head1 tail1 hypothesis].
 - simpl. reflexivity. (* base case: lst1 = nil *)
 - (* inductive case *)
   Set Printing Parentheses.
   simpl. rewrite -> hypothesis. reflexivity.
Qed.



Fixpoint reverse (lst: natlist): natlist := 
 match lst with
 | nil => nil
 | cons a lst' => reverse lst' ++ [a]
 end.


Example test_reverse: reverse [1,2,3,4] = [4,3,2,1].
Proof. reflexivity. Qed.



Inductive natoption: Type :=
 | None
 | Some (n: nat).


Fixpoint nth_item (lst: natlist) (n: nat): natoption :=
 match lst with 
 | nil => None
 | cons a lst' => match n with
                  | O => Some a
                  | S k => nth_item lst' k
                  end
 end.


Example test_nth_item : nth_item [1,2,3,4,5] 4 = Some 5.
Proof. reflexivity. Qed.











