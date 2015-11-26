package com.lavacacti.soundboard

import kuusisto.tinysound.Music;
import kuusisto.tinysound.TinySound;
import javax.sound.sampled.Mixer
import javax.sound.sampled.AudioSystem
import java.util.List
import java.util.ArrayList
import java.util.concurrent.Semaphore
import javafx.animation.Timeline
import javafx.util.Duration
import javafx.animation.KeyFrame
import javafx.animation.Animation
import java.nio.file.Paths
import javafx.scene.control.Alert
import javafx.scene.control.Alert.AlertType
import javafx.application.Platform

class SoundManager {
	var Mixer.Info mixer
	var List<Music> playList
	var Timeline timeLine

	new() {
		supportedMixers.forEach [ mix |
			if (mix.name.contains("Virtual Audio Cable"))
				mixer = mix
		]
		if (mixer != null) {
			println("Virtual Audio Cable has been selected as the default mixer.")
			TinySound.init(mixer)
		}
		playList = new ArrayList()
		timeLine = new Timeline(new KeyFrame(Duration.millis(2000), [watchList()]))
		timeLine.cycleCount = Animation.INDEFINITE
		timeLine.play()
	}

	def getSupportedMixers() {
		val list = new ArrayList<Mixer.Info>()
		for (mInfo : AudioSystem.mixerInfo) {
			if (mInfo.description.contains("Playback"))
				list.add(mInfo)
		}
		return list
	}

	def changeMixer(Mixer.Info mixer) {
		TinySound.shutdown()
		TinySound.init(mixer)
	}

	def playSound(String path) {
		if (Paths.get(path).toFile.exists) {
			val music = TinySound.loadMusic(Paths.get(path).toFile)
			if (music != null) {
				playList.add(music)
				music.play(false)
			} else {
				Platform.runLater([new Alert(AlertType.ERROR, "Unsupported song " + path).show()]) // Make sure its called on the FX thread
			}
		} else {
			Platform.runLater([new Alert(AlertType.ERROR, "File does not exist: " + path).show()]) // Make sure its called on the FX thread
		}
	}

	def watchList() {
		val removalList = new ArrayList()
		for (music : playList) {
			if (!music.playing) {
				removalList.add(music)
				music.unload()
			}
		}
		removalList.forEach[music|playList.remove(music)]
		System.gc()
	}

	def stopAllSounds() {
		playList.forEach [ music |
			if (music.playing) {
				music.stop()
				music.unload()
			}
		]
		playList.clear()
	}
}