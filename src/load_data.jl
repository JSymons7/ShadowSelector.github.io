using CSV


function load_data(args)
    env = Dict{String, Any}()

    data = CSV.read("..\\data\\data.csv")
    
    env["data"] = data
    return env
end