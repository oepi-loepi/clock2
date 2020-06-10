// Modified Clock for dryer and washing machine by Oepi-Loepi

import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: clock2Tile
        property bool dimState: screenStateController.dimmedColors


	/// Will be called when widget instantiated
	function init() {}

	onClicked: {
		stage.openFullscreen(app.fullScreenUrl);
	}

	Text {
		id: txtTimeBig
		text: app.timeStr
		color: dimmableColors.clockTileColor
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: dimState ? qfont.clockFaceText : qfont.timeAndTemperatureText
		font.family: qfont.regular.name
	}

	Text {
		id: txtDate
		text: app.dateStr
		color: dimmableColors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			baseline: parent.bottom
			baselineOffset: designElements.vMarginNeg16
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: qfont.tileTitle
		font.family: qfont.regular.name
		visible: !dimState
	}

	NewTextLabel {
		id: wasButton
		width: isNxt ? 284 : 220;  
		height: isNxt ? 35 : 30
		buttonActiveColor: app.actWas? app.actDroog?  "yellow" :  "orange"    :  app.actDroog? "cyan" : "transparent"
		textColor : "black"
		//buttonText: app.actWas? app.actDroog? "Wasmachine en droger bezig" :  "Wasmachine is bezig"    :  app.actDroog? "Droger is bezig" : ""
		buttonText: animationscreen.animationRunning
		anchors {
			top: parent.top
			topMargin: 1
			horizontalCenter: parent.horizontalCenter 
			}
		visible: app.actWas || app.actDroog
	}
		
	NewTextLabel {
		id: setupButton
		width: 30 
		height: 30
		buttonActiveColor: "transparent"
		buttonHoverColor: "blue"
		enabled : true
		textColor : "black"
		buttonText:  "s"
		anchors {
			right:parent.right
			rightMargin: 2

			bottom: parent.bottom
			bottomMargin: 2
		}
		onClicked: {app.clock2ConfigScreen.show();}
		visible: !dimState
	}



}
