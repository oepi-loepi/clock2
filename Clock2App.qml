//modified for washing machine and dryer by Oepi-loepi

import QtQuick 2.1
import qb.components 1.0
import FileIO 1.0
import qb.base 1.0;

App {
	id: clock2App

	// These are the URL's for the QML resources from which our widgets will be instantiated.
	// By making them a URL type property they will automatically be converted to full paths,
	// preventing problems when passing them around to code that comes from a different path.
	property url tileUrl : "Clock2Tile.qml"
	property url thumbnailIcon: "qrc:/tsc/a.png"

        property url clock2ConfigScreenUrl : "Clock2ConfigScreen.qml"
	property Clock2ConfigScreen clock2ConfigScreen


	property string timeStr
	property string dateStr

        property bool actWas : false
	property string wasmachine
	property bool actDroog : false
	property string droger
        property string idxWas : "32"
	property string idxDryer : "33"

	property string domoticzURL1 : "http://192.168.xx.xx:yyyy"


	// user settings from config file
	property variant clock2SettingsJson : {
		'domoticzURL1': "",
		'idxWas': "",
		'idxDryer': "",
	}


	FileIO {
		id: clock2SettingsFile
		source: "file:///mnt/data/tsc/clock2_userSettings.json"
 	}


	function init() {
		registry.registerWidget("tile", tileUrl, clock2App, null, {thumbLabel: qsTr("Klok-2"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", clock2ConfigScreenUrl, this, "clock2ConfigScreen");
	}

	function updateClockTiles() {
		var now = new Date().getTime();
		timeStr = i18n.dateTime(now, i18n.time_yes);
		dateStr = i18n.dateTime(now, i18n.mon_full);
	}

	Timer {
		id: datetimeTimer
		interval: 10000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: {updateClockTiles();readState()}
	}


	function readState() {
		var xmlhttp7 = new XMLHttpRequest();
        	xmlhttp7.onreadystatechange = function() {
            		if (xmlhttp7.readyState == XMLHttpRequest.DONE) {
				var JsonString7 = xmlhttp7.responseText;
        			var JsonObject7= JSON.parse(JsonString7);
        			wasmachine = JsonObject7.result[0].Value;
				if (wasmachine == "1"){
							actWas = true;
				}else{
							actWas = false;
				}
			}
		}
		xmlhttp7.open("GET", domoticzURL1 + "/json.htm?type=command&param=getuservariable&idx=" + idxWas);
		xmlhttp7.send();

        	var xmlhttp8 = new XMLHttpRequest();
        	xmlhttp8.onreadystatechange = function() {
            		if (xmlhttp8.readyState == XMLHttpRequest.DONE) {
				var JsonString8 = xmlhttp8.responseText;
        			var JsonObject8= JSON.parse(JsonString8);
        			droger = JsonObject8.result[0].Value;
				if (droger == "1"){
					actDroog = true;
				}else{
					actDroog = false;
				}
			}
		}
		xmlhttp8.open("GET", domoticzURL1 + "/json.htm?type=command&param=getuservariable&idx=" + idxDryer);
		xmlhttp8.send();
	}

	function simpleSynchronous(request) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("GET", request, true);
		xmlhttp.timeout = 1500;
		xmlhttp.send();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					if (typeof(functie) !== 'undefined') {
						functie(parameter);
					}
				}
			}
		}
	}



Component.onCompleted: {
		try {
			onkyowasSettingsJson = JSON.parse(clock2SettingsFile.read());
			domoticzURL1 = onkyowasSettingsJson['domoticzURL1'];
			idxWas = onkyowasSettingsJson['idxWas'];
			idxDryer = onkyowasSettingsJson['idxDryer'];
		} catch(e) {
		}
	}


	function saveSettings() {
 		var setJson = {
			"domoticzURL1" : domoticzURL1,
			"idxWas" : idxWas,
			"idxDryer" : idxDryer,
		}
  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/clock2_userSettings.json");
   		doc3.send(JSON.stringify(setJson));
	}


}
