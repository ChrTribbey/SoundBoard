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
import javafx.scene.input.MouseEvent
import javafx.event.EventHandler
import javafx.beans.value.ObservableValue
import javafx.beans.value.ChangeListener
import java.nio.file.Paths
import org.jnativehook.GlobalScreen
import java.util.logging.Logger
import java.util.logging.Level
import java.util.ArrayList
import java.io.FileOutputStream
import java.io.ObjectOutputStream
import java.io.FileInputStream
import java.io.ObjectInputStream
import java.io.FileNotFoundException
import javafx.scene.control.Alert
import javafx.scene.control.Alert.AlertType
import javafx.stage.WindowEvent
import kuusisto.tinysound.TinySound
import javafx.application.Platform
import javafx.scene.control.Slider

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
	@FXML
	var Slider slider

	var ObservableList<Song> songList
	var FXMLLoader loader
	var SongDialogController soundDialogController
	var Stage addSongDialog
	var Song currentSelectionSong
	var SoundManager sManager
	var Stage outputSelectorDialog
	var OutputSelectorController outputSelectorController
	var KeyHandler keyHandler

	override initialize(URL location, ResourceBundle resources) {
		sManager = new SoundManager()
		songNameColumn.cellValueFactory = new PropertyValueFactory("name")
		songBindingColumn.cellValueFactory = new PropertyValueFactory("keyCode")
		songList = FXCollections.observableArrayList
		songTable.items = songList
		songTable.onMouseClicked = new EventHandler<MouseEvent>() {
			override handle(MouseEvent arg0) {
				if (arg0.clickCount >= 2) {
					onTableDoubleClick()
				}
			}
		}
		songTable.selectionModel.selectedItemProperty.addListener(new ChangeListener {
			override changed(ObservableValue arg0, Object arg1, Object arg2) {
				currentSelectionSong = arg2 as Song
			}
		})

		loader = new FXMLLoader(
			getClass().getResource("SongDialog.fxml")
		)
		addSongDialog = new Stage()
		addSongDialog.resizable = false
		addSongDialog.scene = new Scene(loader.load())
		addSongDialog.sizeToScene()
		soundDialogController = loader.controller
		soundDialogController.songList = songList

		loader = new FXMLLoader(
			getClass().getResource("OutputSelector.fxml")
		)
		outputSelectorDialog = new Stage()
		outputSelectorDialog.resizable = false
		outputSelectorDialog.scene = new Scene(loader.load())
		outputSelectorDialog.sizeToScene()
		outputSelectorController = loader.controller
		outputSelectorController.init(sManager)

		var logger = Logger.getLogger(GlobalScreen.getPackage().getName());
		logger.setLevel(Level.OFF);
		keyHandler = new KeyHandler(songList, sManager)
		GlobalScreen.registerNativeHook()
		GlobalScreen.addNativeKeyListener(keyHandler)

		slider.valueProperty.addListener(new ChangeListener<Number> {
			override changed(ObservableValue<? extends Number> arg0, Number arg1, Number arg2) {
				TinySound.setGlobalVolume(arg2.doubleValue)
			}
		})
	}

	@FXML def addSongHandle() {
		addSongDialog.title = "Add new song"
		addSongDialog.sizeToScene()
		addSongDialog.show()
	}

	@FXML def editSongHandle() {
		if (currentSelectionSong != null) {
			addSongDialog.title = "Edit song"
			soundDialogController.edit(currentSelectionSong)
			addSongDialog.sizeToScene()
			addSongDialog.show()
		}
	}

	@FXML def deleteSongHandle() {
		if (currentSelectionSong != null) {
			songList.remove(currentSelectionSong)
		}
	}

	def onTableDoubleClick() {
		editSongHandle()
	}

	@FXML def editOutput() {
		outputSelectorDialog.sizeToScene()
		outputSelectorDialog.show()
	}

	@FXML def save() {
		val fos = new FileOutputStream("list.dat")
		val oos = new ObjectOutputStream(fos)
		oos.writeObject(songList.toArray())
		oos.close()
	}

	@FXML def load() {
		songList.clear()
		val FileInputStream fis = try {
			new FileInputStream("list.dat")
		} catch (FileNotFoundException e) {
			new Alert(AlertType.ERROR, "Save file does not exist").show()
			return
		}

		val ois = new ObjectInputStream(fis)
		val Object[] list = ois.readObject() as Object[]
		list.forEach [ obj |
			val s = obj as Song
			songList.add(s)
		]
		ois.close()
	}
}