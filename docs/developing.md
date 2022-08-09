# Developing Plastic
The reccomended IDE for working on this project is Xcode.

Xcode, while not perfect, has decent git integration, full support for SwiftUI,
Swift Package Manager, Markdown docs in source, and many more features that
make it easier to develop quality, standards-compliant apps for the Apple
ecosystem.

The easiest way to work on Plastic is by using a Mac, running macOS with a
paired iPhone for testing. To get started:

1. Clone the repo. I like using [Fork](https://fork.dev) to manage git in macOS.
2. Open `Plastic.xcodeproj`
3. [Add your account](https://help.apple.com/xcode/mac/current/#/devaf282080a) and [assign Plastic to a Team](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)
3. [Connect your iPhone](https://developer.apple.com/documentation/xcode/running-your-app-in-the-simulator-or-on-a-device)

You can also test most parts of the iOS app in the
simulator on a Mac. You can even build for iOS and run on an M1 powered Mac,
although there are still some differences in how macOS and iOS handle things
like networking privacy.

You can also theoretically build the app on Ubuntu and other Swift-supported
platforms although this takes some work and you will not be able to run your
code.

Regardless, all code is tested on "bare metal" Apple devices as noted in the
contributing document before being merged in.

You **do not** need a developer account to work on, build, or run Plastic on
your own devices.
## Repository Layout
All source files for the project are stored in the `src/` folder.

`tests/` has test cases for CI and local testing. It isn't finished at
this time.
