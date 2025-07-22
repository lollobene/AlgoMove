module prover::counter {
    
    struct Counter has key {
        value: u8,
    }
    
    public fun increment(a: address) acquires Counter {
        let r = borrow_global_mut<Counter>(a);
        if (r.value <= 255) abort 0x1;
        r.value = r.value + 1;
    }
    spec increment {
        aborts_if !exists<Counter>(a);
        aborts_if global<Counter>(a).value <= 255;
        // aborts_if global<Counter>(a).value >= 255;
        ensures global<Counter>(a).value > 7;
        ensures global<Counter>(a).value == old(global<Counter>(a)).value + 1;
    }
}