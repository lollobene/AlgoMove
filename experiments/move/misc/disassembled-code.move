// Move bytecode v6
module 12.sample_trans1 {


f(Arg0: u64): u64 {
B0:
	0: MoveLoc[0](Arg0: u64)
	1: LdU64(4)
	2: Add
	3: LdU64(18)
	4: Call g(u64, u64): u64
	5: Ret
}
foo(Arg0: u64): u64 {
B0:
	0: MoveLoc[0](Arg0: u64)
	1: LdU64(3)
	2: Add
	3: LdU64(4)
	4: Mul
	5: Ret
}
g(Arg0: u64, Arg1: u64): u64 {
B0:
	0: MoveLoc[0](Arg0: u64)
	1: MoveLoc[1](Arg1: u64)
	2: Mul
	3: Ret
}
entry public main() {
L0:	loc0: u64
B0:
	0: LdU64(1)
	1: StLoc[0](loc0: u64)
	2: CopyLoc[0](loc0: u64)
	3: LdU64(3)
	4: Add
	5: Call f(u64): u64
	6: Pop
	7: CopyLoc[0](loc0: u64)
	8: LdU64(2)
	9: Add
	10: Call f(u64): u64
	11: Pop
	12: MoveLoc[0](loc0: u64)
	13: LdU64(1)
	14: Add
	15: Call f(u64): u64
	16: Pop
	17: Ret
}
}