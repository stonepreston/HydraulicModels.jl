using HydraulicModels
using ModelingToolkit
using Test

@testset "StaticPipe" begin
    pipe1 = StaticPipe(;name=:pipe1)
    @test !isnothing(pipe1.a)
    @test !isnothing(pipe1.b)
    @test isequal(string.(parameters(pipe1)), ["C"])
end

