function StaticPipe(;name, L=1.0, C=90, d=.4, γ=9810)
    @named a = Pin()
    @named b = Pin()
    sts = @variables Δp(t)=1.0 Q(t)=1.0
    ps= @parameters C=C 

    eqs = [
        Δp ~ a.p - b.p
        0 ~ a.Q + b.Q
        # Hazen-Williams
        # https://en.wikipedia.org/wiki/Hazen%E2%80%93Williams_equation
        b.Q ~ -1 * (Δp/(γ * L* 10.67)) * ((C^1.852 * d^4.8704))
        Q ~ a.Q
    ]
    compose(ODESystem(eqs, t, sts, ps; name=name), a, b)
end