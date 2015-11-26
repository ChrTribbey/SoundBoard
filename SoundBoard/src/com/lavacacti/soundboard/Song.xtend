package com.lavacacti.soundboard

import java.util.UUID
import org.eclipse.xtend.lib.annotations.Data
import java.io.Serializable

@Data class Song implements Serializable {
	UUID id
	String name
	String path
	String keyCode
	int volume
	boolean repeat
	boolean memory
}