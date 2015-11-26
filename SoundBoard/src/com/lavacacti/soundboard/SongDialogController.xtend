package com.lavacacti.soundboard

import javafx.fxml.Initializable
import java.net.URL
import java.util.ResourceBundle
import org.eclipse.xtend.lib.annotations.Accessors
import javafx.collections.ObservableList
import java.util.UUID
import javafx.fxml.FXML
import javafx.scene.control.TextField
import javafx.scene.input.KeyEvent
import javafx.scene.control.Label
import javafx.scene.input.MouseEvent
import javafx.event.Event
import javafx.event.EventHandler
import javafx.scene.input.DragEvent
import javafx.scene.input.TransferMode

class SongDialogController implements Initializable {
	@Accessors ObservableList songList
	@FXML
	var TextField songPath
	@FXML
	var TextField songName
	@FXML
	var Label bindLabel

	var String keyCode
	var Song song
	var UUID id
	var boolean isListen = false

	override initialize(URL location, ResourceBundle resources) {
	}

	@FXML def save() {
		if (song != null) {
			val index = songList.indexOf(song);
			songList.set(index, new Song(id, songName.getText(), songPath.getText(), keyCode, 100, false, false))
		} else {
			songList.add(new Song(UUID.randomUUID(), songName.getText(), songPath.getText(), keyCode, 100, false, false))
		}
		songPath.text = "Empty"
		songName.text = "Empty"
		keyCode = "None"
		updateBindingLabel()
		song = null
		isListen = false
		songPath.scene.window.hide()
	}

	def edit(Song song) {
		this.song = song
		songPath.text = song.path
		songName.text = song.name
		keyCode = song.keyCode
		id = song.id
		updateBindingLabel()
	}

	@FXML def onKeyPress(KeyEvent e) {
		if (isListen) {
			keyCode = e.code.toString
			updateBindingLabel()
			isListen = false
		}
	}

	@FXML def onBindListen() {
		bindLabel.text = "Please press the key you wish to use"
		isListen = true
	}
	
	def updateBindingLabel() {
		bindLabel.text = "Current bind: " + keyCode
	}
	
	@FXML def onDragOver(DragEvent e) {
		val db = e.dragboard
		if (db.hasFiles()) {
			e.acceptTransferModes(TransferMode.LINK)
			e.consume()
		} else {
			e.consume()
		}
	}
	
	@FXML def onDragDropped(DragEvent e) {
		val db = e.dragboard
		if (db.hasFiles()) {
			db.files.forEach[file |
				songPath.text = file.absolutePath
			]
		}
		e.dropCompleted = true
		e.consume()
	}
}