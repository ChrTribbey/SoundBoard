package com.lavacacti.soundboard

import org.jnativehook.keyboard.NativeKeyListener
import org.jnativehook.keyboard.NativeKeyEvent
import javafx.collections.ObservableList
import javafx.scene.input.KeyCode

class KeyHandler implements NativeKeyListener {

	var ObservableList<Song> songList
	var SoundManager sManager

	new(ObservableList<Song> songList, SoundManager sManager) {
		this.songList = songList
		this.sManager = sManager
	}

	override nativeKeyReleased(NativeKeyEvent ke) {
		songList.forEach [ song |
			if (song.keyCode != null) {
				val cKey = KeyCode.getKeyCode(song.keyCode).impl_getCode
				if (ke.rawCode == cKey) {
					sManager.playSound(song.path)
				}
			}
		]
		if (ke.keyCode == NativeKeyEvent.VC_ESCAPE) {
			sManager.stopAllSounds
		}
	}

	override nativeKeyPressed(NativeKeyEvent arg0) {
	}

	override nativeKeyTyped(NativeKeyEvent arg0) {
	}

}