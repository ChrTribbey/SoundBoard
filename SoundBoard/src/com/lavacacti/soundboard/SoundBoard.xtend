package com.lavacacti.soundboard

import javafx.application.Application
import javafx.fxml.FXML
import javafx.fxml.FXMLLoader
import javafx.scene.Scene
import javafx.scene.layout.Pane
import javafx.stage.Stage
import javafx.event.EventHandler
import javafx.stage.WindowEvent
import kuusisto.tinysound.TinySound
import org.jnativehook.GlobalScreen
import javafx.application.Platform

class SoundBoard extends Application {
	
	def static void main(String[] args) {
		launch(args)
	}
	
    override start(Stage primaryStage) {
        primaryStage.setTitle("Hello World!");
        var loader = new FXMLLoader(
        	getClass().getResource("SoundBoard.fxml")
        )
        primaryStage.setScene = new Scene(loader.load())
        primaryStage.show();
        primaryStage.resizable = false;
        primaryStage.onCloseRequest = new EventHandler<WindowEvent> {
			override handle(WindowEvent arg0) {
				TinySound.shutdown()
				GlobalScreen.unregisterNativeHook()
				Platform.exit()
			}	
		}
    }
}