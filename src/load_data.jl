using CSV, HTTP, JSON


mutable struct Preference
    name                            ::String
    preferences                     ::Dict{String, Int}
    currentLT                       ::String
    alreadyAssigned                 ::String
    enableAssignmentToCurrentLT     ::Bool
end

Preference(name) = Preference(
    name,
    Dict{String, Int}(),
    "",
    "",
    0
)


function load_data(args)
    env = Dict{String, Any}()

    data = JSON.parse(open("..\\data\\preferences.json", "r"))
    # data = HTTP.get("https://firestore.googleapis.com/v1/projects/shadow-5f1c5123/databases/(default)/documents/preferences")
    # println(data)

    MC = Dict{String, Any}()
    for fields in data["documents"]
        name = fields["fields"]["name"]["stringValue"]
        MC[name] = Preference(name)

        MC[name].preferences[fields["fields"]["preference1"]["stringValue"]] = 1
        MC[name].preferences[fields["fields"]["preference2"]["stringValue"]] = 2
        MC[name].preferences[fields["fields"]["preference3"]["stringValue"]] = 3
        MC[name].preferences[fields["fields"]["preference4"]["stringValue"]] = 4
        MC[name].preferences[fields["fields"]["preference5"]["stringValue"]] = 5
        MC[name].preferences[fields["fields"]["preference6"]["stringValue"]] = 6
        MC[name].preferences[fields["fields"]["preference7"]["stringValue"]] = 7
        MC[name].preferences[fields["fields"]["preference8"]["stringValue"]] = 8
        MC[name].preferences[fields["fields"]["preference9"]["stringValue"]] = 9
        MC[name].preferences[fields["fields"]["preference10"]["stringValue"]] = 10
        MC[name].preferences[fields["fields"]["preference11"]["stringValue"]] = 11
        MC[name].preferences[fields["fields"]["preference12"]["stringValue"]] = 12
        

        MC[name].currentLT = fields["fields"]["currentLT"]["stringValue"]

        MC[name].alreadyAssigned = fields["fields"]["alreadyAssigned"]["stringValue"]
        MC[name].preferences[MC[name].alreadyAssigned] = 1000

        MC[name].enableAssignmentToCurrentLT = fields["fields"]["enableAssignmentToCurrentLT"]["booleanValue"]
    end

    println(MC)

    #data = HTTP.get("https://firestore.googleapis.com/v1/projects/shadow-5f1c5123/databases/(default)/documents/preferences")
    
    env["data"] = MC

    env["LT"] = [
        "Ben Schurr",
        "Brendan Ryan",
        "Brent Mealings",
        "Chris Greenough",
        "Chris Rowe",
        "Eric Hansen",
        "Gordon Rettkowicz",
        "Jo Martell",
        "Mark Kennerley",
        "Paul Campbell",
        "Piers Shore",
        "Priya Singh",
        "Simon Till"]
    return env
end