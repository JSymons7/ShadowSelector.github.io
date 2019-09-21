using JuMP, CSV, DataFrames
import GLPK


function solve(env)
    data = env["data"]

    LT = env["LT"]

    MC = keys(env["data"])

    m = Model(with_optimizer(GLPK.Optimizer, tm_lim = 60000))

    @variables m begin
        assignment[ lt = LT, mc = [m for m in MC], periods = 1:3] >= 0, Bin
        z
    end

    T = 1:3

    for t in T
        for mc in MC  
            @constraint(m, sum(assignment[:, mc, t]) == 1)
        end

        for lt in LT
            @constraint(m, sum(assignment[lt, :, t]) <= 1)
        end
    end

    for lt in LT
        for mc in MC
            @constraint(m, sum(assignment[lt, mc, :]) <= 1)
        end
    end

    for mc in MC
        @constraint(m, sum(assignment[data[mc].alreadyAssigned, mc, :]) ==0)
    end

    for mc in MC
        if data[mc].enableAssignmentToCurrentLT != true
            @constraint(m, sum(assignment[data[mc].currentLT, mc, :]) == 0)
        end
    end

    for mc in MC
        @constraint(m, sum(data[mc].preferences[lt] * assignment[lt, mc, t] for lt in LT, t in T) <= z)
    end

    #Make worst person as good as possible
    @objective(m, Min, z)

    optimize!(m)
    println(value(z))

    @constraint(m, z <= objective_value(m))

    #Add constraint so they don't get any worse

    #Make everyone as good as possible
    @objective(m, Min, sum(data[mc].preferences[lt] * assignment[lt, mc, t] for lt in LT, mc in MC, t in T))
    optimize!(m)

    f = open("FileName.csv", "w")

    results = Dict{String, Any}()



    # output = DataFrame(index = [mc for mc in MC], columns = [t for t in T])
    # println(output)
    columns = [Symbol(col) => String[] for col in T]
    df = DataFrame(fill(String, length(MC)), Symbol.(MC), length(T))
    df[2, Symbol.("Jonathan Symons")] = "5"
    println("HERE")
    println(df)
    for mc in MC
        println(mc)
        # println(sum(data[mc].preferences[lt] * value(assignment[lt, mc, t]) for lt in LT, t in T))
        results[mc] = Dict{Int, String}()
        for lt in LT   

            for t in T
                if value.(assignment[lt, mc, t]) == 1
                    println(assignment[lt, mc, t])
                    # results[mc][t] = lt
                    # output[mc,t] = lt
                    df[t, Symbol.(mc)] = lt
                end
            end
        end
        # push!(df, results[mc])
        # println(results[mc])
        # df
    end
    println(df)
    # itr = (merge((; key = key), val) for (key, val) in results)
    # itr |> CSV.write("test.csv")


    println("Objective is ", objective_value(m))

    # CSV.write(f, DataFrame(results))
    CSV.write(f, df)
    close(f)

    # println(output)
    # output.to_csv(path_or_buf = "output.csv")

    return m
end