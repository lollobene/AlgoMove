/// Standard math utilities missing in the Move Language.
module prover::math {

    public fun max(a: u64, b: u64): u64 {
        if (a >= b) a else b
    }
	spec max(a: u64, b: u64): u64 {
        ensures a >= b ==> result == a && a < b ==> result == b;
    }

    public fun average(a: u64, b: u64): u64 {
        if (a < b) {
            a + (b - a) / 2
        } else {
            b + (a - b) / 2
        }
    }
	spec average(a: u64, b: u64): u64 {
        ensures a > b ==> result < a && result >= b;
		ensures b > a ==> result < b && result >= a;
        ensures a == b ==> result == a;
	}

    public fun aborts_if_zero(x: u64) {
        if (x == 0) abort 0x1;
    }
    spec aborts_if_zero(x: u64) {
        aborts_if x == 0;
    }

}