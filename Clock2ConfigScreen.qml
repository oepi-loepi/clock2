import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0;

Screen {
	id: clock2ConfigScreen
	screenTitle: "Clock-2 app Setup"

	function saveDomoticzURL1(text) {
		if (text) {
			app.domoticzURL1 = text;
		}
	}

	function saveidxWas(text) {
		if (text) {
			app.idxWas = text;
		}
	}

	function saveidxDryer(text) {
		if (text) {
			app.idxDryer = text;
		}
	}


	onShown: {
		domoticzURL1.inputText = app.domoticzURL1;
		idxWas.inputText = app.idxWas;
		idxDryer.inputText = app.idxDryer;
		addCustomTopRightButton("Save");
	}

	onCustomButtonClicked: {
		app.saveSettings();
		hide();
	}

	Text {
		id: myLabel
		text: "URL to Domoticz (example: http://192.168.10.185:8080)"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name

		anchors {
			left: parent.left
			top: parent.top			
			leftMargin: 20
			topMargin: 10
		}
	}

	EditTextLabel4421 {
		id: domoticzURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 300
		leftText: "Domoticz URL"

		anchors {
			left: myLabel.left
			top: myLabel.bottom
			topMargin: 10
		}

		onClicked: {
			qkeyboard.open("URL to Domoticz incl. Port", domoticzURL1.inputText, saveDomoticzURL1)
		}
	}


	Text {
		id: myLabel2
		text: "IDX from Domoticz (Devices Tab) :"
		font.pixelSize:  isNxt ? 20 : 16
		font.family: qfont.regular.name

		anchors {
			left: myLabel.left
			top: domoticzURL1.bottom
			topMargin: 30
		}
	}

	EditTextLabel4421 {
		id: idxWas
		width: (parent.width*0.5) - 40		
		height: 35		
		leftTextAvailableWidth: 300
		leftText: "Washingmachine"

		anchors {
			left: myLabel.left
			top: myLabel2.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Washingmachine", idxWas.inputText, saveidxWas)
		}
	}


	EditTextLabel4421 {
		id: idxDryer
		width: (parent.width*0.5) - 40		
		height: 35		
		leftTextAvailableWidth: 300
		leftText: "Dryer"

		anchors {
			left: myLabel.left
			top: idxWas.bottom
			topMargin: 6
		}

		onClicked: {
			qkeyboard.open("Dryer", idxDryer.inputText, saveidxDryer)
		}
	}


}

