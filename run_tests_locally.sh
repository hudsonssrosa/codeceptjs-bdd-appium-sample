#!/bin/bash

echo "-----> ARG 1: ${1}"
echo "-----> ARG 2: ${2}"

function set_env_path_for_android(){
    echo "" > ~/.bash_profile
    echo export PATH="$HOME/.rbenv/bin:$PATH" >> ~/.bash_profile
    echo export PATH="$PATH:$HOME/.rvm/bin" >> ~/.bash_profile
    export JAVA_HOME=`echo $(/usr/libexec/java_home)`
    export ANDROID_HOME=$HOME/Library/Android/sdk
    echo export PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/platform-tools/adb >> ~/.bash_profile
    source ~/.bash_profile
}

function upload_and_generate_app_id_for_bs_execution(){
    echo "Generating Browserstack APP_ID..."
    BS_UPLOAD_URL=https://api-cloud.browserstack.com/app-automate/upload
    BS_APP_FILE=`echo "${HOME}/git_projects/codeceptjs-bdd-appium-sample/app_distribution/Sample.apk"`
    source .env
    BS_USER=`echo ${BROWSERSTACK_USER}`
    source .env
    BS_KEY=`echo ${BROWSERSTACK_KEY}`
    export BS_APP_GEN=`curl -u "${BS_USER}:${BS_KEY}" -X POST "${BS_UPLOAD_URL}" -F "file=@${BS_APP_FILE}"`
    export BS_APP=$(awk  'BEGIN{FS="\""}{print $4}' <<< "${BS_APP_GEN}")

    # CLEANUP AND SETTLING IN THE .ENV
    echo "Cleaning up and settling the .ENV file..."
    bs_cred=`sed '/^BS_APP/d' .env`
    echo $bs_cred > .env
    echo "BS_APP=$BS_APP" >> .env
    echo "-----> ${BS_APP}"
}

function run_appium(){
    bash -c "\
        kill -9 `lsof -i TCP:\"4723\" | awk '/LISTEN/{print $2}'` &
        appium &
    "
}

set_env_path_for_android
run_appium
tag_res=""

# Running the tag selected
if [[ ${2} && "@${2}" == *"@"* ]] ; then
    tag=`echo --grep @${2}`
    tag_res=`echo ${tag} | sed 's/@//g'`
    echo "(command: npx codeceptjs run --features --steps ${tag_res})"
fi

# No external arguments informed
if [ $# -eq 0 ] ; then
    echo "RUNNING APPIUM LOCALLY..."
    npx codeceptjs run --features --steps
echo $tag_res

# First external argument with "local" and a second optional argument with a "tag" of your test
#       i.e.:    sh run_tests_locally.sh local @login-sample
elif [[ ${1} == "local" ]] ; then
    echo "RUNNING APPIUM LOCALLY WITH A REAL DEVICE..."
    npx codeceptjs run --features --steps ${tag_res}

# First external argument with "bs" and a second optional argument with a "tag" of your test
#       i.e.:    sh run_tests_locally.sh bs @login-sample
elif [[ ${1} == "bs" ]] ; then
    upload_and_generate_app_id_for_bs_execution
    sleep 2
    echo "RUNNING WITH BROWSERSTACK..."
    npx codeceptjs run --features --steps ${tag_res}
fi


## RUN TESTS USING TERMINAL IN YOUR WAY - SEE ALL OPTIONS AND EXAMPLES

    ## Run all tests
    # npx codeceptjs run --features --steps --grep '@login-sample'

    ## Run the tests considering DEBUG logs. Example:
    # DEBUG=pw:api npx codeceptjs run --features --steps --grep '@login-sample'

    ## Run tests with Codecept UI. Example:
    # npx codecept-ui --app --features

    ## Run in parallel with workers (choose the number of workers). Example:
    # npx codeceptjs run-workers --features 2
    # npx codeceptjs run-workers --features 2 --grep '@login-sample'

    ## Run in multiple browsers (default: chromium, firefox, webkit). Example:
    # npx codeceptjs run-multiple --features chromium firefox
    # npx codeceptjs run-multiple parallel --features --grep '@login-sample'
