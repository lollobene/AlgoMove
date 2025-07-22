module algomove::borrow_test {

    struct S<T : store> has key {
		x: u64,
		y: T
	}
    
	struct A has store {}

	struct B has store {}

    // called by participants willing to bid. Must know the address of the auctioneer
    public fun f<T: store>(a: address) acquires S {
        let _ = borrow_global<S<B>>(a);
        let _ = borrow_global<S<A>>(a);
        let _ = borrow_global<S<A>>(a);
        let _ = borrow_global<S<u64>>(a);
        let _ = borrow_global<S<u64>>(a);
        let _ = borrow_global<S<T>>(a);
    }
}