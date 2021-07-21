using HydraulicModels
using ModelingToolkit
using DifferentialEquations
using Test

@testset "StaticPipe" begin
    @parameters t
    pipe1 = StaticPipe(t; name=:pipe1)
    @test !isnothing(pipe1.a)
    @test !isnothing(pipe1.b)
    @test isequal(string.(parameters(pipe1)), ["C"])
end

@testset "Pipe Connected to Ideal Sources" begin
    @parameters t
    @named pipe1 = StaticPipe(t; L=100.0, C=90, d=.4)
    @named pipe2 = StaticPipe(t; L=200.0, C=150, d=.4)
    @named source_left = IdealPressureSource(t; P=517107)
    @named source_right = IdealPressureSource(t;)

    connections = [
        connect(source_left.a, pipe1.a)
        connect(pipe1.b, pipe2.a)
        connect(pipe2.b, source_right.a)
    ]

    @parameters t
    @named pipe_model = ODESystem(connections, t, systems=[source_left, pipe1, pipe2, source_right])
    simplified = structural_simplify(pipe_model)
    tspan = (0.0, 0.0)
    prob = ODEProblem(simplified, [], tspan)
    sol = solve(prob, Rodas4())
    @test isequal(sol[pipe1.Δp][1], 234039.78851047347)
    @test isequal(sol[pipe1.a.p][1], 517107.0)
    @test isequal(sol[pipe1.b.p][1], 517107.0 - sol[pipe1.Δp][1])
    @test isequal(sol[pipe2.a.p][1], sol[pipe1.b.p][1])
    @test isequal(sol[pipe2.b.p][1], sol[source_right.a.p][1])
end
