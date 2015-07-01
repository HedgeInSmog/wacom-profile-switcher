wacom-profile-switcher
======================

Forked from HedgeInSmog/wacom-profile-switcher

Switches the functions of the buttons of Wacom Intuos Pro for different applications

What's new
----------
Changes switch algorythm.

Added settings for Inkscape, Blender & GIMP.

Added initial settings for ring switch and permissions files needed to allow led toggle functions.

Install
-------

1. Copy 99-wacom-intuos.rules & wacom-permissions.sh into /etc/udev/rules.d and reload udev rules.
2. Assign system custom shortcuts:
	* Alt+Ctrl+Super+1	for firefox-ring.sh
	* Alt+Ctrl+Super+2	for gimp-ring.sh
	* Alt+Ctrl+Super+3	for krita-ring.sh
	* Alt+Ctrl+Super+4	for inkscape-ring.sh
	* Alt+Ctrl+Super+5	for blender-ring.sh
3. Edit wacom-profile-switcher.desktop and copy it to ~/.local/share/applications
4. Run it from unity dash.
5. 'GIMP' can be symlinked to 'GNU Image' file.
