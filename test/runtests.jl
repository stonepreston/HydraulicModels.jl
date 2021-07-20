using ModelingToolkit: get_defaults
using SafeTestsets

@safetestset "Pin Tests" begin include("pin_tests.jl") end
@safetestset "Sources Tests" begin include("sources_test.jl") end
@safetestset "Pipes Tests" begin include("pipes_test.jl") end
