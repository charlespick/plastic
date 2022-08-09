# Contributing to Plastic
Plastic is an iOS app built using Swift and SwiftUI. It uses
Moonraker to interface with your Klipper-based 3d-printer. As such,
coding standards are similar to other projects in the Klipper universe

This documents reviews the requirements for all new code entering the repository so the codebase stays consistant
and managable. For assistance with development, see the [developing document](developing.md)
## Committing rules
* Commits should follow the [conventional commmits](https://www.conventionalcommits.org/en/v1.0.0/)
standard to allow easy understanding of what is what.
* Commits should each have a Signed-off-by line with your legal
name and a functioning email address, which indicates you
have read and agree to the [developer certificate of origin]()
* At this time, make PRs against the `master` branch
* Because often times a pull request brings in new features along with
documentation, assets, and other diffs, it does not make sense to
specifiy the module or relm a squashed commit would refer to.
Instead, title your commit in a way that conveys what effect your
changes have made to the software with a ticket # if applicable

For example, adding a feature might look like:
```
feat: Gesture-based toolhead jogging #000

The direction keys have been replaced with a area that simply reads
"swipe here to control printer"
The user manual in /docs has been updated to reflect this functionality

Signed-off-by: Your Name <your email address>
```
Or a bugfix might look like:
```
fix: previous console content remains after dropped connection reestablised #000

The data structure behind the console has been updated to allow
multiple printer connections to be displayed at once
This means that a dead connection can persist in the console while a
new connection is open

Signed-off-by: Your Name <your email address>
```
## Testing
All PRs are tested on a real Mac, iPhone, and iPad before being merged. The simulators **do behave differently.**

## Files and source
* All source files should begin with
```
//
//  File.ext
//  File description
//
//  Copyright notice - most will follow the format shown below however
//  in sone cases, such as when a file is borrowed without alterations
//  from another source under it's own copyright an appropriate notice
//  may be included instead, as well as attribution
//
```
For example the primary source file for the project begins with:
```
//
//  Source.swift
//  Master of the universe
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//
```
* Do not wrap code on the source files. Xcode does this for you in a much nicer way.
* Use the [one true brace style](https://en.wikipedia.org/wiki/Indentation_style#Variant:_1TBS_(OTBS))
* Document your work using the documentation specs [built into Swift](https://developer.apple.com/documentation/xcode/writing-symbol-documentation-in-your-source-files)
* Don't do the trailing whitespace thing
* Leave a new line at the end of every file that is diffed on by git
* When a simple app element is only to be included on one platform, it
is prefered to use compiler directives or runtime directives. When a
feature (that includes at least 1 `func`, `class`, `struct`, etc) is
only applicable to one platform, add it to the specific platform folder.
## Packages and Libraries
Plastic uses the Swift Package Manager to manage dependancies. If possible,
configure your new dependancy in XCode using the SPM and add the modified
`Package.resolved` file and other related files to your commit

If you cannot use SPM, (because you are not able to add a `Package.swift` file
to the source you need to use) commit the source to the /lib directory.
