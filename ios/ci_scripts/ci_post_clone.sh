#!/bin/sh

echo 'export GEM_HOME=$HOME/gems' >> ~/.bash_profile
echo 'export PATH=$HOME/gems/bin:$PATH' >> ~/.bash_profile
export GEM_HOME=$HOME/gems
export PATH=$GEM_HOME/gems/bin:$PATH

# Install CocoaPods using Homebrew.
brew install cocoapods

# Install Flutter
brew install --cask flutter

# Run Flutter doctor
flutter doctor

# Get packages
flutter packages get

# Update generated files
flutter pub run build_runner build

# Build ios app
flutter build ios
