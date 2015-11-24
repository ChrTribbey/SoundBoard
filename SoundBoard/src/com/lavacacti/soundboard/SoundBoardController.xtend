package com.lavacacti.soundboard

import java.net.URL
import java.util.ResourceBundle
import javafx.collections.FXCollections
import javafx.collections.ObservableList
import javafx.fxml.FXML
import javafx.fxml.Initializable
import javafx.scene.control.Button
import javafx.scene.control.TableColumn
import javafx.scene.control.TableView
import javafx.scene.control.cell.PropertyValueFactory
import javafx.stage.Stage
import javafx.fxml.FXMLLoader
import javafx.scene.Scene

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
	@FXML
	var TableColumn songNameColumn
	@FXML
	var TableColumn songBindingColumn
	
	var ObservableList<Song> songList
	var FXMLLoader loader
	var Stage addSongDialog
	
	override initialize(URL location, ResourceBundle resources) {
		songNameColumn.cellValueFactory = new PropertyValueFactory("name")
		songBindingColumn.cellValueFactory = new PropertyValueFactory("keyCode")
		songList = FXCollections.observableArrayList
		songTable.items = songList
		loader = new FXMLLoader(
			getClass().getResource("SongDialog.fxml")
		)
		addSongDialog = new Stage()
		addSongDialog.scene = new Scene(loader.load())
		val SongDialogController ctrl = loader.controller;
		ctrl.songList = songList
	}
	
	@FXML def addSongHandle() {
		addSongDialog.show()
	}
	
}