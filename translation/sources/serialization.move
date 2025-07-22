module deploy_address::moduleA {
    struct A {
        r: u64,
        s: bool
    }
}

module deploy_address::moduleB {
    use deploy_address::moduleA;

    struct B {
        t: u64,
        u: moduleA::A
    }
}

module deploy_address::moduleC {
    use deploy_address::moduleA;
    use deploy_address::moduleB;

    struct C {
        v: moduleB::B,
        x: moduleA::A
    }

    /*
    * C structure:
    * C {
    *     v: B {
    *         t: u64,
    *         u: A {
    *             r: u64,
    *             s: bool
    *         }
    *     },
    *     x: A {
    *         r: u64,
    *         s: bool
    *     }
    * }
    *
    * C serialization:
    * { v: { t: 1, u: { r: 2, s: true } }, x: { r: 3, s: false } }
    */

}