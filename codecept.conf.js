const { setHeadlessWhen } = require('@codeceptjs/configure');

// setHeadlessWhen(process.env.HEADLESS);

exports.config = {
  name: 'codeceptjs-bdd-appium-sample',
  tests: './tests/*test.js',
  output: './output',
  bootstrap: null,
  timeout: 10000,
  helpers: {
    // Appium: {
    //   app: '/Users/hudsonssrosa/git_projects/codeceptjs-bdd-appium-sample/app_distribution/Sample.apk',
    //   platform: 'Android',
    //   platformName: 'Android',
    //   platformVersion: "11.0", 
    //   browserName: 'Android',
    //   appPackage: "com.dgotlieb.automationsample",
    //   appActivity: "com.dgotlieb.automationsample.MainActivity",
    //   deviceName: 'Samsung Galaxy A51',
    //   automationName: 'UiAutomator2',
    //   newCommandTimeout: "3000",
    //   autoGrantPermissions: true,
    //   capabilities:{
    //     automationName: 'UiAutomator2'
    //   }
    // },

    Appium: {
      app: process.env.BS_APP,
      user: process.env.BROWSERSTACK_USER,
      key: process.env.BROWSERSTACK_KEY,
      host: "hub-cloud.browserstack.com",
      port: 4444,
      platform: "android",
      device: "samsung galaxy a51"
    },
    
    SetupBlocks: {
      require: './tests/helpers/setupblocks_helper.js'
    },
    TestHelper: {
      require: './tests/helpers/test_helper.js'
    }
  },

  include: {
    I: './steps_file.js',
    loginPage: './tests/pages/login_page.js'
  },

  gherkin: {
    features: './tests/features/*.feature',
    steps: './tests/step_definitions/*_steps.js'
  },

  mocha: {
    reporterOptions: {
      mochaFile: 'output/result.xml',
      reportDir: 'output'
    }
  },

  plugins: {
    allure: {
      enabled: true,
      outputDir: "./output"
    },
    screenshotOnFail: {
      enabled: true
    },
    pauseOnFail: {
      enabled: false
    },
    retryFailedStep: {
      enabled: true
    },
    tryTo: {
      enabled: true
    },
    stepByStepReport: {
      enabled: false,
      screenshotsForAllureReport: true,
      output: "./output",
      deleteSuccessful: false
    }
  }
}