function IdealPressureSource(;name, P=101325)
    @named a = Pin()
    eqs = [
        a.p ~ P
    ]
    compose(ODESystem(eqs, t, [], []; name=name), a)
end

source = IdealPressureSource(;name=:source)
string.(equations(source))
string.(states(source))
source.a.p
ModelingToolkit.get_eqs(source)