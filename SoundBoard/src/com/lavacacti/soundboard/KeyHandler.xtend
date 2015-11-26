package com.lavacacti.soundboard

import org.jnativehook.keyboard.NativeKeyListener
import org.jnativehook.keyboard.NativeKeyEvent
import javafx.collections.ObservableList

class KeyHandler implements NativeKeyListener {

	var ObservableList<Song> songList
	var SoundManager sManager

	new(ObservableList<Song> songList, SoundManager sManager) {
		this.songList = songList
		this.sManager = sManager
	}

	override nativeKeyReleased(NativeKeyEvent ke) {
		val key = NativeKeyEvent.getKeyText(ke.getKeyCode()).toLowerCase()
		songList.forEach [ song |
			if (song.keyCode != null) {
				val cKey = song.keyCode.toLowerCase()
				if (key.contains(cKey)) {
					sManager.playSound(song.path)
				}
			}
		]
		if (key.contains("escape")) {
			sManager.stopAllSounds
		}
	}

	override nativeKeyPressed(NativeKeyEvent arg0) {
	}

	override nativeKeyTyped(NativeKeyEvent arg0) {
	}

}