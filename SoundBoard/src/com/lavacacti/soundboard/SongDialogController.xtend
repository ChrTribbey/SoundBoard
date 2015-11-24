package com.lavacacti.soundboard

import javafx.fxml.Initializable
import java.net.URL
import java.util.ResourceBundle
import org.eclipse.xtend.lib.annotations.Accessors
import javafx.collections.ObservableList
import java.util.UUID
import javafx.fxml.FXML

class SongDialogController implements Initializable {
	@Accessors ObservableList songList
	
	override initialize(URL location, ResourceBundle resources) {
	}
	
	@FXML def save() {
	}
	
}