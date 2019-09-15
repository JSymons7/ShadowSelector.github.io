//(function(){

    //Initialize Firebase
    var config = {
        apiKey: "AIzaSyCXl8Ojm8lby1Z7tlhk3b3lbKZxLf2RVOQ",
        authDomain: "shadow-5f1c5123.firebaseapp.com",
        databaseURL: "https://shadow-5f1c5123.firebaseio.com",
        projectId: "shadow-5f1c5123",
        storageBucket: "",
        messagingSenderId: "29061061157",
        appId: "1:29061061157:web:d97c1d7990bb9c2d31bdcc"
    };

    firebase.initializeApp(config);
    var firestore = firebase.firestore();

    const outputHeader = document.querySelector("#preferencesOutput")
    const inputTextField = document.querySelector("#username")
    const docRef = firestore.collection("preferences");
    const option1 = document.querySelector("#option1")
    const option2 = document.querySelector("#option2")
    const option3 = document.querySelector("#option3")
    const option4 = document.querySelector("#option4")
    const option5 = document.querySelector("#option5")
    const option6 = document.querySelector("#option6")
    const option7 = document.querySelector("#option7")
    const option8 = document.querySelector("#option8")
    const firstAssignment = document.querySelector("#firstAssignment")
    const notAssignable = document.querySelector("#notAssignable")
    const saveButton = document.querySelector("#saveButton")    

    saveButton.addEventListener("click", function() {
        var fieldEntries = [ option1.value,
                            option2.value,
                            option3.value,
                            option4.value,
                            option5.value,
                            option6.value,
                            option7.value,
                            option8.value,
                            firstAssignment.value,
                            notAssignable.value];
        console.log(emptyEntries(fieldEntries))
        if(emptyEntries(fieldEntries)) {
            document.querySelector("#Status").innerHTML = "Please fill in all fields"
            console.log("Duplicate entries")
        } else if (hasDuplicates(fieldEntries)) {
            document.querySelector("#Status").innerHTML = "Duplicate Entries"
            console.log("Not all entries filled in")
        } else {
            console.log("I m going to save " + option1.value + " to Firestore");
            docRef.add({
                name: inputTextField.value,
                preference1: option1.value,
                preference2: option2.value,
                preference3: option3.value,
                preference4: option4.value,
                preference5: option5.value,
                preference6: option6.value,
                preference7: option7.value,
                preference8: option8.value,
                alreadyAssigned: firstAssignment.value,
                currentLT: notAssignable.value,
                timestamp: firebase.firestore.FieldValue.serverTimestamp()
            }).then(function() {
                document.querySelector('#Status').innerHTML = "Successfully saved results";
                console.log("Status saved!");
            }).catch(function(error) {
                document.querySelector("#status").innerHTML = "Was not able to save"
                console.log("Got an error: ", error);
            });
        }
    })

    
    function hasDuplicates(array) {
        return (new Set(array)).size !== array.length;
    }


    function emptyEntries(array){
        for(var i=0; i<array.length; i++) {
            if (array[i] == "") {
                console.log("Empty")
                return true;
            }
        }
        return false; 
    }
//})