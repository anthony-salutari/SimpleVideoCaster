// constants
var CAST_API_INITIALIZATION_DELAY = 1000;
var PROGRESS_BAR_UPDATE_DELAY = 1000;
var SESSION_IDLE_TIMEOUT = 300000;

// global variables
var currentMediaSession = null;
var currentVolume = 0.5;
var progressFlag = 1;
var mediaCurrentTime = 0;
var session = null;
var storedSession = null;
var timer = null;

// cast initialization
if (!chrome.cast || !chrome.cast.isAvailable) {
    setTimeout(initializeCastApi, CAST_API_INITIALIZATION_DELAY);
}

function initializeCastApi() {
    // set the application id to the default
    var applicationId = chrome.cast.media.DEFAULT_MEDIA_RECEIVER_APP_ID;

    // set the auto join policy to page scoped for now
    var autoJoinPolicy = chrome.cast.AutoJoinPolicy.PAGE_SCOPED;

    // set up the session
    var sessionRequest = new chrome.cast.SessionRequest(applicationId);
    var apiConfig = new chrome.cast.ApiConfig(sessionRequest,
        sessionListener,
        receiverListener,
        autoJoinPolicy);

    chrome.cast.initialize(apiConfig, onInitSuccess, onError);
}

function onInitSuccess() {
    console.log("Cast init success");
}

function onError(e) {
    console.log('Error: ' + e);
}

function onSuccess(message) {
    console.log('Success: ' + message);
}