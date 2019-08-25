"""
Julia ain't quite perfect, so here are some tools to help make the ride a bit
smoother.
"""

using Logging


#-------------------------------------------------------------------------------

"""
As far as I can tell, the Julia logging library doesn't let us set the
logging level with a string, so let's fix that up.
"""
logLevels = Dict{String, Int32}(
    "debug" => Logging.Debug.level,
    "info"  => Logging.Info.level,
    "warn"  => Logging.Warn.level,
    "error" => Logging.Error.level,
    )


function initialise_logger(level::AbstractString)
    initialise_logger(logLevels[lowercase(level)])
end


function initialise_logger(level::Int32)
    global_logger(SimpleLogger(stdout, level))
    @debug "Set log level to $level"
end
