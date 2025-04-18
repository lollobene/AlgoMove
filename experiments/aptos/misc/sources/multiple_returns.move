module deploy_address::multiple_returns {

    struct Simple has key {
        a: u64,
        b: bool
    }
  
    // public fun f(acc: signer, n: u64) {
    //     let s = Simple { 
    //         a: n+7,
    //         b: true 
    //     };
    //     move_to(&acc, s);
    // }

    public fun g(acc: signer): (u64, bool) {
        let s = 58;   
        let t = false;
        return (s, t)
    }

    public fun h(n: u64): u64 {
        return n + 18
    }
}