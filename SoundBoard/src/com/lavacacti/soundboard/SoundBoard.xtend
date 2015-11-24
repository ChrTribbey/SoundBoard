package com.lavacacti.soundboard

import javafx.application.Application
import javafx.fxml.FXML
import javafx.fxml.FXMLLoader
import javafx.scene.Scene
import javafx.scene.layout.Pane
import javafx.stage.Stage

class SoundBoard extends Application {
	def static void main(String[] args) {
		launch(args)
	}
	
    override start(Stage primaryStage) {
        primaryStage.setTitle("Hello World!");
        var Pane root = FXMLLoader.load(getClass().getResource("SoundBoard.fxml"))
        primaryStage.setScene(new Scene(root))
        primaryStage.show();
        primaryStage.resizable = false;
    }
    
    @FXML def handle(){
    	
    }
	
}