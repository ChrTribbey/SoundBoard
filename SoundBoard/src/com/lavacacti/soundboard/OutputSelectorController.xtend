package com.lavacacti.soundboard

import javafx.fxml.Initializable
import java.net.URL
import java.util.ResourceBundle
import javafx.fxml.FXML
import javafx.scene.control.Button
import javafx.scene.control.ComboBox

class OutputSelectorController implements Initializable {
	
	var SoundManager sManager
	
	@FXML
	var ComboBox displayBox
	@FXML
	var Button okButton
	
	override initialize(URL location, ResourceBundle resources) {
	}
	
	def init(SoundManager sm) {
		sManager = sm
		sManager.supportedMixers.forEach[mixer | displayBox.items.add(mixer.name)]
		displayBox.selectionModel.select(0)
	}
	
	def onOk() {
		sManager.supportedMixers.forEach[mixer | 
			var String name = displayBox.selectionModel.selectedItem.toString
			if (name.contains(mixer.name)) {
				sManager.changeMixer(mixer)
				displayBox.scene.window.hide()
			}
		]
	}
	
}