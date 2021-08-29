#!/bin/bash

# Install Android toolkit
# brew install cask
# brew tap caskroom/cask
brew install --cask adoptopenjdk8
# brew install android-sdk
# brew install --cask android-sdk
brew install android-studio --cask
brew install --cask android-platform-tools

# Install NPM
npm install -g npm
npm init -y

# Install Appium and Resources
npm install -g appium-doctor
npm install -g appium --unsafe-perm=true --allow-root
npm install -g wd
npm i -g webpack

# Using Appium 2.0
# npm install -g appium@next
# appium driver install uiautomator2
# appium plugin install images
# appium --plugins=images

# ENVIRONMENT VARIABLES
export JAVA_HOME=`echo $(/usr/libexec/java_home)` >> ~/.bashrc
export ANDROID_HOME=$HOME/Library/Android/sdk >> ~/.bashrc
export PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:/usr/local/bin/adb >> ~/.bashrc
source ~/.bashrc

adb kill-server && adb devices

# Install & Run Selenium Standalone
# npm install -g selenium-standalone
# selenium-standalone install
# bash -c "\
#     lsof -t -i :4444 | xargs kill &
#     sleep 2
#     selenium-standalone start &
# "

# Install CodeceptJs - Dev dependencies (including Allure)
npm install codeceptjs webdriverio --save
npx codeceptjs init

npm install -g allure-commandline --save-dev
npm i @codeceptjs/ui --save

# FINAL CHECKS
npm audit fix
appium-doctor

# Run a single scenario to check if everything works:
# npx codeceptjs run --features --steps --grep '@login-sample'

