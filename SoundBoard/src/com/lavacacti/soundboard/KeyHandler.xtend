package com.lavacacti.soundboard

import org.jnativehook.keyboard.NativeKeyListener
import org.jnativehook.keyboard.NativeKeyEvent
import javafx.collections.ObservableList
import javafx.scene.input.KeyCode
import java.util.HashMap

class KeyHandler implements NativeKeyListener {

	var ObservableList<Song> songList
	var SoundManager sManager
	var HashMap<Integer, Integer> keyHelper

	new(ObservableList<Song> songList, SoundManager sManager) {
		this.songList = songList
		this.sManager = sManager
		keyHelper = new HashMap()
		// For some reason not all the keymappings are using the same code so this is just to convert them to the proper one.
		// More will be added as found.
		keyHelper.put(127, 46)
		keyHelper.put(155, 45)
		keyHelper.put(10, 13)
	}

	override nativeKeyReleased(NativeKeyEvent ke) {
		songList.forEach [ song |
			if (song.keyCode != null) {
				val cKey = KeyCode.getKeyCode(song.keyCode).impl_getCode
				if (keyHelper.containsKey(cKey)) {
					if (ke.rawCode == keyHelper.get(cKey)) {
						sManager.playSound(song.path)
					}
				} else {
					if (ke.rawCode == cKey) {
						sManager.playSound(song.path)
					}
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