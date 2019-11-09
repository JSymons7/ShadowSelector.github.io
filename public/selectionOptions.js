function insertOptions(listName, possibleOptions) {
    var list = document.getElementById(listName);

    var option;

    for (i = 0; i < possibleOptions.length; i++) {
        option = document.createElement("option");
        option.text = possibleOptions[i];
        option.value = possibleOptions[i];
        list.add(option);
    }
}

var possibleOptions = [
    "Ben Schurr",
    "Brendan Ryan",
    "Bruce Turner",
    "Chris Greenough",
    "Chris Rowe",
    "Eric Hansen",
    "Jo Martell",
    "Mark Kennerley",
    "Paul Campbell",
    "Simon Till"];

var pillarOptions = [
    "Control",
    "Efficiency",
    "People",
    "Value"
];