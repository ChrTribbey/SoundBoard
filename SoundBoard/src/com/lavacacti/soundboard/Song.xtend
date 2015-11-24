package com.lavacacti.soundboard

import java.util.UUID
import org.eclipse.xtend.lib.annotations.Data

@Data class Song {
	UUID id
	String name
	String path
	String keyCode
}