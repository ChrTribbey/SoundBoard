package com.lavacacti.soundboard

import javafx.fxml.Initializable
import java.net.URL
import java.util.ResourceBundle
import org.eclipse.xtend.lib.annotations.Accessors
import javafx.collections.ObservableList
import java.util.UUID
import javafx.fxml.FXML
import javafx.scene.control.TextField

class SongDialogController implements Initializable {
	@Accessors ObservableList songList
	@FXML
	var TextField songPath
	@FXML
	var TextField songName
	var String keyCode
	
	override initialize(URL location, ResourceBundle resources) {
	}
	
	@FXML def save() {
		songList.add(new Song(UUID.randomUUID(), songName.getText(), songPath.getText(), "Shift"))
		songPath.text = "Empty"
		songName.text = "Empty"
		keyCode = "None"
		songPath.scene.window.hide()
	}
	
}