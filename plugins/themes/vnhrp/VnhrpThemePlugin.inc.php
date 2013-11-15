<?php

/**
 * @file VnhrpThemePlugin.inc.php
 *
 * @class VnhrpThemePlugin
 * @ingroup plugins_themes_vnhrp
 *
 * @brief "Vnhrp" theme plugin
 */

// $Id$


import('classes.plugins.ThemePlugin');

class VnhrpThemePlugin extends ThemePlugin {
	/**
	 * Get the name of this plugin. The name must be unique within
	 * its category.
	 * @return String name of plugin
	 */
	function getName() {
		return 'VnhrpThemePlugin';
	}

	function getDisplayName() {
		return 'Vnhrp Theme';
	}

	function getDescription() {
		return 'Vietnam Health Research Portal';
	}

	function getStylesheetFilename() {
		return 'vnhrp.css';
	}
	function getLocaleFilename($locale) {
		return null; // No locale data
	}
}

?>
