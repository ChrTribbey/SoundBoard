package com.lavacacti.soundboard

import org.eclipse.xtend.lib.annotations.Data
import javafx.beans.property.StringProperty
import java.util.UUID

@Data class Song {
	UUID id
	StringProperty name
	StringProperty path
	String keyCode
}