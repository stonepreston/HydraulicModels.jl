using HydraulicModels
using ModelingToolkit
using Test

@testset "Pin.jl" begin
    @parameters t
    pin = Pin(t; name=:pin1)
    @test pin.name == :pin1
    @test !isnothing(pin.p)
    @test !isnothing(pin.Q)
    @test string(pin.iv) == "t"
end

@testset "Connecting pins" begin
    @parameters t
    pin1 = Pin(t; name=:pin1)
    pin2 = Pin(t; name=:pin2)
    pin3 = Pin(t; name=:pin3)
    @test isequal(connect(pin1, pin2, pin3), [
                                              0 ~ pin1.Q + pin2.Q + pin3.Q, 
                                              pin1.p ~ pin2.p,
                                              pin2.p ~ pin3.p 
                                             ])
end