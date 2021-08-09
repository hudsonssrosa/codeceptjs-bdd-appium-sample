#!/bin/bash

# Android toolkit
brew install android-sdk
export ANDROID_HOME=/usr/local/Caskroom/android-sdk >> ~/.bashrc
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools >> ~/.bashrc
source ~/.bash_profile

# Install CodeceptJs - Dev dependencies (including Allure)
npm install -g npm
npm init -y
npm install -g shelljs
npm install -g appium-doctor
npm i -g appium

npm install codeceptjs webdriverio --save
npm install -g allure-commandline --save-dev
# npm i @codeceptjs/ui --save

# Run a single scenario to check if everything works:
# npx codeceptjs run --features --steps --grep '@login-sample'

