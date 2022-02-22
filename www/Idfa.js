var exec = require("cordova/exec");

var PLUGIN_NAME = "Idfa";

exports.getInfoAndrequestPermission = function (resolve, reject) {
  exec(resolve, reject, PLUGIN_NAME, "getInfo", []);
};

exports.requestPermission = function (resolve, reject) {
  exec(resolve, reject, PLUGIN_NAME, "requestPermission", []);
};
