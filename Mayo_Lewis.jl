using Catalyst, Catlab, DiffEqBase, OrdinaryDiffEq, Plots

rn = @reaction_network begin
    k11, M1′+ M1 --> M1′
    k12, M1′+ M2 --> M2′
    k21, M2′+ M1 --> M1′
    k22, M2′+ M2 --> M2′
end k11 k12 k21 k22

p = (.1, .01, .2, .01) # k11, k12, k21, k22
tspan = (0., 30.)
u0 = [1., 3., 5., 1.]  #M1′, M1, M2, M2′
osys  = convert(ODESystem, rn)
u0map = map((x,y) -> Pair(x,y), species(rn), u0)
pmap  = map((x,y) -> Pair(x,y), params(rn), p)
oprob = ODEProblem(osys, u0map, tspan, pmap)
sol   = solve(oprob, Tsit5())

plot(sol, lw=2)