<?php

/**
 * @file ViethrpThemePlugin.inc.php
 *
 * @class ViethrpThemePlugin
 * @ingroup plugins_themes_viethrp
 *
 * @brief "Viethrp" theme plugin
 */

// $Id$


import('classes.plugins.ThemePlugin');

class ViethrpThemePlugin extends ThemePlugin {
	/**
	 * Get the name of this plugin. The name must be unique within
	 * its category.
	 * @return String name of plugin
	 */
	function getName() {
		return 'ViethrpThemePlugin';
	}

	function getDisplayName() {
		return 'Viethrp Theme';
	}

	function getDescription() {
		return 'Vietnam Health Research Portal';
	}

	function getStylesheetFilename() {
		return 'viethrp.css';
	}
	function getLocaleFilename($locale) {
		return null; // No locale data
	}
}

?>
