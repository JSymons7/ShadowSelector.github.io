using JuMP, CSV
import Cbc


function solve(env)
    data = env["data"]

    println(env)

    LT = names(data)[2:end]

    MC = data[:MC]

    m = Model(with_optimizer(Cbc.Optimizer))

    @variables m begin
        assignment[ lt = LT, mc = [m for m in MC], periods = 1:3] >= 0, Bin
    end

    @objective(m, Max, sum(assignment))
    for t in 1:3
        for mc in MC  
            @constraint(m, sum(assignment[:, mc, t]) == 1)
        end

        for lt in LT
            @constraint(m, sum(assignment[lt, :, t]) == 1)
        end
    end

    optimize!(m)
    f = open("FileName.csv", "w")
    for t in 1:3
        println(value.(assignment[:,:,t]))

        CSV.write(f,  value.(assignment[:,:,t]))
    end
    close(f)

    return m
end