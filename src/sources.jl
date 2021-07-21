function IdealPressureSource(iv::Num; name, p=101325)
    @named a = Pin(iv)
    ps = @parameters p=p
    eqs = [
        a.p ~ p
    ]
    compose(ODESystem(eqs, iv, [], ps; name=name), a)
end
