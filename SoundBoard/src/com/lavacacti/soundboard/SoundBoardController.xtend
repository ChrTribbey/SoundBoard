package com.lavacacti.soundboard

import javafx.fxml.Initializable
import java.net.URL
import java.util.ResourceBundle
import javafx.fxml.FXML
import javafx.scene.control.Button
import javafx.scene.control.TableView

class SoundBoardController implements Initializable {
	
	@FXML 
	var Button addSongButton
	@FXML 
	var Button deleteSongButton
	@FXML 
	var Button editOutputButton
	@FXML 
	var Button saveButton
	@FXML 
	var Button loadButton
	@FXML
	var TableView songTable
	
	override initialize(URL location, ResourceBundle resources) {
	}
	
}