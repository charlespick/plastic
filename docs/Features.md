# Features
This document lays out the intent for Plastic's functionality as a referance to 
be used during initial development and as new features are added to moonraker
or app independant features are added. 

## Navigation overview
Throughout normal use the app will open first to the Dashboard page and connect
to the last used printer. The user can switch printers using the Printers page.
The Jobs page allows you to browse the availible gcode files on the printer.
Selecting one to print returns you to the Dashboard. 

### First use
On first launch or after a reset, the app should open a sheet that configures
the first printer and drops the user on the Dashboard. 

## Dashboard
Common functions appropriate to a mobile controller that include: 
* General system status
* Ongoing print information if one is in progress
* Webcam (swipe between multiple)
* Exclude objects (opens sheet)
* Basic tempurture (more information and controls availible with a tap)
* Basic jogging, QGL, Bed Screws Calibrate, Bed Mesh Calibrate, Motors off, Macros, etc.
* Extruder PA, Retraction, and filament loading controls
* Lights and maybe some other accesories

It is important to note, the dashboard should be 1 screen that doesn't scroll.
Scrolling introduces complexity into the app where it shouldn't be. The
purpose of Plastic is to be a monitoring app first, with basic controls 
availible as it warents. The goal is not to incorperate all functions of
moonraker. 

## Jobs
The jobs screen allows you to view uploaded jobs, launch jobs, queue jobs, view 
the queue, modify the queue, and start the queue

## Printers Page
The Printers page supports the rest of the app by providing functionality for the following:
* Adding new/editing printers in the app by configureing the following information:
    * Name - the display name used in the app can be configured. It is not stored in the 
    Moonraker database like with other web guis since we have local storage availible to 
    persist this information. 
    * Connection information - location and port
    * Theme - selecting a color in the app will allow you to easily distinguish which
    printer is actively selected
    * Notifications settings
* Removing printers
* Selecting printers
* Previewing printer information - basic state information will be displayed for all printers
to provide an overview of your printer environment
* Shareing printers - the ability to share printers' app configuration with others
* Open printer in safari - if another web ui is detected
* SSH into printer in Termius or another SSH app

## App Settings
App settings will be availible in the system settings app and provide essential
functionality including:
* Removing all printers and resetting the app
* Other options as nessesary

## Other features to note
* Notifications - filament runout, print finished, etc
