package com.lavacacti.soundboard

import javafx.fxml.Initializable
import java.net.URL
import java.util.ResourceBundle
import org.eclipse.xtend.lib.annotations.Accessors
import javafx.collections.ObservableList
import java.util.UUID
import javafx.fxml.FXML
import javafx.scene.control.TextField
import javafx.stage.Stage
import javafx.collections.FXCollections

class SongDialogController implements Initializable {
	@Accessors ObservableList songList
	@FXML
	var TextField songPath
	@FXML
	var TextField songName
	var String keyCode
	var Song song
	var UUID id
	
	override initialize(URL location, ResourceBundle resources) {
	}
	
	@FXML def save() {
		if (song != null) {
			val index = songList.indexOf(song);
			songList.set(index, new Song(id, songName.getText(), songPath.getText(), "Shift"))
		} else {
			songList.add(new Song(UUID.randomUUID(), songName.getText(), songPath.getText(), "Shift"))
		}
		songPath.text = "Empty"
		songName.text = "Empty"
		keyCode = "None"
		songPath.scene.window.hide()
	}
	
	def edit(Song song) {
		this.song = song
		songPath.text = song.path
		songName.text = song.name
		keyCode = song.keyCode
		id = song.id
	}
	
	
}