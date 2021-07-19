@parameters t

@connector function Pin(;name)
    sts = @variables p(t)=1.0 Q(t)=1.0
    ODESystem(Equation[], t, sts, []; name=name)
end
