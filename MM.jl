using Catalyst, Catlab, DiffEqBase, OrdinaryDiffEq, Plots

rn = @reaction_network begin
    k1, S + E --> ES
    k2, ES --> S + E
    k3, ES --> E + P
end k1 k2 k3

p = (.2, .05, 10.)
tspan = (0., 1.)
u0 = [301., 100., 0., 0.]  
osys  = convert(ODESystem, rn)
u0map = map((x,y) -> Pair(x,y), species(rn), u0)
pmap  = map((x,y) -> Pair(x,y), params(rn), p)
oprob = ODEProblem(osys, u0map, tspan, pmap)
sol   = solve(oprob, Tsit5())

plot(sol, lw=2)
savefig("Michaelis-Menten.png")