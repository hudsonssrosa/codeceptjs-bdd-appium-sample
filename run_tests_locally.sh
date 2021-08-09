#!/bin/bash

echo "-----> ARG 1: ${1}"
echo "-----> ARG 2: ${2}"

# GENERATING BROWSERSTACK APP_ID
bash -c "\
export BS_APP_GEN=`curl -u "${BROWSERSTACK_USER}:${BROWSERSTACK_KEY}" \
-X POST "https://api-cloud.browserstack.com/app-automate/upload" \
-F "file=@./app_distribution/Sample.apk"` &
export BS_APP=$(awk  'BEGIN{FS="\""}{print $4}' <<< "${BS_APP_GEN}")
"

# CLEANUP AND SETTLING IN THE .ENV
bs_cred=`sed '/^BS_APP/d' .env`
echo $bs_cred > .env
bs_app_id=`echo "BS_APP=$BS_APP" >> .env`


# SETTING ANDROID ENVIRONMENT VARIABLES TO PATH
launchctl setenv ANDROID_HOME /usr/local/Caskroom/android-sdk
export ANDROID_HOME=/usr/local/Caskroom/android-sdk >> ~/.bashrc
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools >> ~/.bashrc
source ~/.bash_profile

bash -c "\
    appium &
"

# No external arguments informed
if [ $# -eq 0 ] ; then
    echo "Running all the tests..."
    npx codeceptjs run --features --steps

# One external argument with 'ccui' to run in Codecept UI
elif [ ${1} == "ccui" ] ; then
    echo "Opening Codecept UI..."
    npx codecept-ui --app --features

# Single or multiple browsers with or withot Feature / Scenario tags
else
    with_parallel=""
    crossbrowser="multi"
    tag=`echo --grep @${1}`
    tag_norm=`echo ${tag} | sed 's/@//g'`
    
    if [[ ${1} && ${1} == ${crossbrowser} ]] ; then 
        with_parallel="-multiple parallel"
        tag_norm=""
    
    elif [[ ${2} && ${2} == ${crossbrowser} ]] ; then
        with_parallel="-multiple parallel"
        echo "-----> MULTIPLE BROWSERS IN PARALLEL: Webkit, Chromium, Firefox --- '${tag_norm}'"
        
    else
        with_parallel=""
        echo "-----> Running single browser the Feature / Scenario with '${tag_norm}'. Command:"
    fi
        
    echo "(command: npx codeceptjs run${with_parallel} --features --steps ${tag_norm})"
    npx codeceptjs run${with_parallel} --features --steps ${tag_norm}
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
