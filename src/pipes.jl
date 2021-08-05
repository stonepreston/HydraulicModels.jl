function StaticPipe(iv::Num; name, L=1.0, C=90.0, d=.4, γ=9810.0)
    @named a = Pin(iv)
    @named b = Pin(iv)
    sts = @variables Δp(iv)=1.0 Q(iv)=1.0
    ps = @parameters L=L d=d C=C γ=γ 

    eqs = [
        Δp ~ a.p - b.p
        0 ~ a.Q + b.Q
        # Hazen-Williams
        # https://en.wikipedia.org/wiki/Hazen%E2%80%93Williams_equation
        # b.Q ~ -1 * (Δp/(γ * L* 10.67)) * ((C^1.852 * d^4.8704))
        Δp ~ (γ * L * 10.67 * Q^1.852) / (C^1.852 * d^4.8704)
        Q ~ a.Q
    ]
    compose(ODESystem(eqs, iv, sts, ps; name=name), a, b)
end
