package com.lavacacti.soundboard

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;
import javafx.fxml.FXML
import javafx.scene.layout.Pane
import javafx.fxml.FXMLLoader

class SoundBoard extends Application {
	def static void main(String[] args) {
		launch(args)
	}
	
    override start(Stage primaryStage) {
        primaryStage.setTitle("Hello World!");
        var Pane root = FXMLLoader.load(getClass().getResource("SoundBoard.fxml"))
        primaryStage.setScene(new Scene(root, 400, root.minHeight));
        primaryStage.show();
        primaryStage.resizable = false;
    }
    
    @FXML def handle(){
    	
    }
	
}