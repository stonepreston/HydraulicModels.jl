function IdealPressureSource(iv::Num; name, P=101325)
    @named a = Pin(iv)
    eqs = [
        a.p ~ P
    ]
    compose(ODESystem(eqs, iv, [], []; name=name), a)
end

