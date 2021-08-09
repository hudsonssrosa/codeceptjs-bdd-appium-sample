// const { setHeadlessWhen } = require('@codeceptjs/configure');
// setHeadlessWhen(process.env.HEADLESS);

exports.config = {
  tests: './tests/*test.js',
  output: './output',
  timeout: 10000,
  name: 'codeceptjs-bdd-appium-sample',
  hooks: [],
  bootstrap: null,

  helpers: {
    // Playwright: {
    //   url: 'http://localhost',
    //   show: true, // Set as true to show the tests in browser (without headless)
    //   browser: 'firefox', // chromium is presenting flaky tests when interacting with video streaming pages
    //   waitForNavigation: "networkidle0"
    // },
    // Appium: {
    //   app: "./app_distribution/Sample.apk",
    //   platform: "Android",
    //   smartWait: 20000,
    //   desiredCapabilities: {
    //     platformName: "Android",
    //     platformVersion: "11.0",
    //     deviceName: "R58N52FV01T",
    //     waitForTimeout: 20000,
    //     automationName: "UIAutomator2",
    //     autoGrantPermissions: true,
    //     noReset: false,
    //     adbExecTimeout: 120000,
    //     noSign: true
    //   }
    // },
    Appium: {
      host: "hub-cloud.browserstack.com",
      port: 4444,
      user: process.env.BROWSERSTACK_USER,
      key: process.env.BROWSERSTACK_KEY,
      platform: "Android",
      desiredCapabilities: {
        app: process.env.BS_APP,
        // app: "bs://ae486edbbccf9e3f21ef2ba37577f68e6f629e80",
        appName: "com.dgotlieb.automationsample",
        realMobile: "true",
        device: "Samsung Galaxy A51",
        os_version: "10.0"
      }
    },
    SetupBlocks: {
      require: './tests/helpers/setupblocks_helper.js'
    },
    TestHelper: {
      require: './tests/helpers/test_helper.js'
    },
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