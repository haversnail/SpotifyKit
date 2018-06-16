//
//  app.js
//  SpotifyKit
//
//  Created by Alexander Havermale on 6/10/18.
//  Copyright © 2018 Alex Havermale.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

/************************ Global Constants ************************/

const constants = {
    keys: {
        accessToken: "access_token",
        tokenType: "token_type",
        expiresIn: "expires_in",
        state: "state"
    },
    buttonText: {
        successLabel: "Copied!",
        failureLabel: "Something Went Wrong :("
    }
};

/************************ Function Declarations ************************/

/**
 * @name getHashParameters
 * @description Retrieves the hash parameters from the window's URL and removes them.
 * @param query - The query string to parse.
 * @returns An object containing the hash parameters in the initial URL.
 */
function getHashParameters(query = "") {

    // Create an empty parameters dictionary object to store the final values:
    let parameters = {};

    // Create an array of strings separated by the URL-encoded "&" separator:
    let queryItems = query.split(/&/);

    // For each query item,
    for (let item in queryItems) {
        // split the item by its key and value:
        let parameter = queryItems[item].split(/=/);
        // Finally, add that key-value pair to our `parameters` dictionary:
        parameters[parameter[0]] = parameter[1];
    }

    return parameters;
}

/**
 * @name copyText
 * @description Copies the text in the given element to the user's clipboard.
 * @param element - The element containing the text.
 * @param success - An optional callback handler for when the text is successfully copied.
 * @param failure - An optional callback handler for if the copy command failed.
 */
function copyText({inElement: element, onSuccess: success = function(){}, onFailure: failure = function(){}}) {
    //console.log("Called the `copyText` method.");

    if (element === undefined) {
        console.log("No element from which to copy text has specified in the `copyText` function.");
        failure();
        return;
    }

    // First create an empty range within the document:
    let textRange = document.createRange();

    // Then set the range equal to the contents of our token display:
    textRange.selectNodeContents(element);

    // Next get the selection object, and make sure nothing else is selected before continuing:
    let currentSelection = window.getSelection();
    currentSelection.removeAllRanges();

    // Then add our text range to the current selection:
    currentSelection.addRange(textRange);

    try {
        // With our text currently selected, copy it and immediately clear the selection:
        document.execCommand("copy");
        currentSelection.removeAllRanges();

        // Call the `success` completion handler:
        success();

    } catch(error) {
        console.log("The `document.execCommand(\"copy\")` command failed.");

        // Call the `failure` completion handler:
        failure();
    }
}

/**
 * @deprecated
 * @name updateTimer
 * @description Updates the timer display when called.
 * @param expirationTime - The point in time at which the timer should stop updating.
 * @param element - The HTML element representing the timer.
 * @param completion - A callback handler for when the timer is complete.
 */
function updateTimer({until: expirationTime, forElement: element, onCompletion: completion = function(){}}) {
    //console.log("Called the `updateTimer` method.");

    let now = new Date().getTime();
    let interval = expirationTime - now;

    let minutes = Math.floor((interval % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((interval % (1000 * 60)) / 1000);

    element.innerText = minutes.padded() + ":" + seconds.padded();

    if (interval < 0) {
        completion();
    }
}

/**
 * @name padded
 * @description Returns the given number as a string, padded with zeros to match the specified number of digits.
 * @param length - The desired length of the resulting string. The default value is 2.
 * @returns {string}
 */
Number.prototype.padded = function(length = 2) {
    // Create a string of the absolute value of the given number:
    let string = String(Math.abs(this));

    // Until the string reaches the specified padding character length,
    while (string.length < length) {
        // Prepend a zero:
        string = "0" + string;
    }

    // And, if the value WAS negative, then prepend the sign as well:
    if (this < 0) { string = "-" + string; }

    return string;
};

/**
 * @name show
 * @description Changes the display of the given element to `block`.
 */
Element.prototype.show = function() {
    this.style.display = "block";
};

/**
 * @name hide
 * @description Changes the display of the given element to `none`.
 */
Element.prototype.hide = function() {
    this.style.display = "none";
};

/************************ Global Script ************************/

/** Capture Query Parameters **/

// First, capture the query string after the hash:
let query = document.location.hash.substring(1);
// Then immediately remove the hash from the URL:
document.location.hash = "";
// Call the `getHashParameters` function to parse the query string:
let parameters = getHashParameters(query);

/** Get DOM Elements **/

// let templateElement = document.getElementById("template");
let mainDisplayElement = document.getElementById("main-display");
let errorDisplayElement = document.getElementById("error-display");
let tokenDisplayElement = document.getElementById("token-display");
let timerDisplayElement = document.getElementById("timer-display");
let copyButtonElement = document.getElementById("copy-btn");

/** Compile Template **/

// // Get the template's markup and compile it:
// let templateHTML = Handlebars.compile(templateElement.innerHTML);
// // Now populate the template display with the compiled markup, passing it the hash parameters:
// templateDisplayElement.innerHTML = templateHTML(parameters);

/** Handle Missing Parameters **/

let tokenIsMissing = parameters[constants.keys.accessToken] === undefined;

// If there was no access token in the hash,
if (tokenIsMissing) {
    // Remove the main display container:
    mainDisplayElement.remove(); // .hide();

    // And show the error display container:
    errorDisplayElement.show();
} else {
    // First, remove the error display container:
    errorDisplayElement.remove();

    // And show the main display container:
    mainDisplayElement.show();

    /** Set Access Token **/

    tokenDisplayElement.innerHTML = "<code>" + parameters[constants.keys.accessToken] + "</code>";

    /** Add Copy Button Behavior **/

    // Add the `onclick` event listener to the copy button:
    copyButtonElement.addEventListener("click", function(/*event*/) {
        // Copy the token to the clipboard on click:
        copyText({
            inElement: tokenDisplayElement,
            onSuccess: function() {
                // and update the text inside the button for confirmation:
                copyButtonElement.innerText = constants.buttonText.successLabel;
            },
            onFailure: function () {
                // or, update the text inside the button to show an error:
                copyButtonElement.innerText = constants.buttonText.failureLabel;
                // TODO: Maybe present a modal instead.
            }
        });
    }, false);

    /** Start the Timer **/

    // If an expiration time interval was provided in the hash parameters, get it; otherwise, default to an hour:
    let expirationTime = parameters[constants.keys.expiresIn] ? parameters[constants.keys.expiresIn] : 3600;

    // Start the timer, updating it once every second:
    let timerID = window.setInterval(function() {

        let minutes = Math.floor(expirationTime / 60);
        let seconds = expirationTime - (minutes * 60);

        timerDisplayElement.innerText = minutes.padded() + ":" + seconds.padded();

        expirationTime--;

        if (expirationTime < 0) {
            window.clearInterval(timerID);
        }
    }, 1000);
}
