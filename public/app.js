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
        const textToSave = inputTextField.value;
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
            console.log("Status saved!");
        }).catch(function(error) {
            console.log("Got an error: ", error);
        });
    })
//})