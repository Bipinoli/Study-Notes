
Inductive list (T: Type): Type :=
 | nil
 | cons (x: T) (l: list T).

Check (nil nat).

Check (cons nat 3 (cons nat 4 (nil nat))).

Check nil.
Check cons.