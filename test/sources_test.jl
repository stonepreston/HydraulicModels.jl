using HydraulicModels
using ModelingToolkit
using Test

@testset "IdealPressureSource" begin
    source1 = IdealPressureSource(;name=:source1)
    @test !isnothing(source1.a)
    @test isequal(string.(equations(source1)), ["a₊p(t) ~ 101325"])

    source2 = IdealPressureSource(;name=:source1, P=50)
    @test isequal(string.(equations(source2)), ["a₊p(t) ~ 50"])
end