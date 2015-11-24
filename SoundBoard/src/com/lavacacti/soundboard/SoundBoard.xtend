package com.lavacacti.soundboard

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

class SoundBoard extends Application {
	def static void main(String[] args) {
		launch(args)
	}
	
    override start(Stage primaryStage) {
        primaryStage.setTitle("Hello World!");
        var root = new StackPane();
        primaryStage.setScene(new Scene(root, 300, 250));
        primaryStage.show();
    }
	
}