# Versal Application iOS

## Project Setup

```
brew install cocoapods
pod install
open Versal.xcworkspace
```

## Running Tests

```
brew install xcbeautify
xcode-select --install
sudo xcode-select --switch /Library/Developer/CommandLineTools
xcodebuild -workspace Versal.xcworkspace -scheme Development -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 13,OS=15.4' test | xcbeautify
```

## Using Fastlane

```
brew install xcbeautify fastlane
fastlane install_plugins
fastlane tests
fastlane increment_major
fastlane increment_minor
fastlane increment_patch
fastlane increment_build
```

## Links

 * https://github.com/realm/SwiftLint#rules