function IdealPressureSource(iv::Num; name, p=101325.0)
    @named a = Pin(iv)
    eqs = [
        a.p ~ p
    ]
    compose(ODESystem(eqs, iv, [], []; name=name), a)
end
