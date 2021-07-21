@parameters t

@connector function Pin(iv::Num; name)
    sts = @variables p(iv)=1.0 Q(iv)=1.0
    ODESystem(Equation[], iv, sts, []; name=name)
end

function ModelingToolkit.connect(::Type{Pin}, pins...)
    eqs = [
           0 ~ sum(pin->pin.Q, pins) # KCL
          ]
    # KVL
    for i in 1:length(pins)-1
        push!(eqs, pins[i].p ~ pins[i+1].p)
    end

    return eqs
end

