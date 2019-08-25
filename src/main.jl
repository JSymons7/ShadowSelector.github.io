using DocOpt

include("toolkit.jl")
include("load_data.jl")
include("solve.jl")
include("save_output.jl")

doc =
"""Shadow Selector - Choosing your destiny

Usage:
  main.jl [options]

Options:
  -h --help                      Show this screen
  -l=<level> --loglevel=<level>  Log level: [default: info]
  -v --version                   Show version
"""


function main()
    args = docopt(doc)
    initialise_logger(args["--loglevel"])

    env = load_data(args)

    solution = solve(env)

    save_output(env, solution)

    exit(0)
end


Base.exit(main())
