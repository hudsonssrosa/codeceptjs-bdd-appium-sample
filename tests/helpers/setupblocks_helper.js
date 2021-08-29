const Helper = require('@codeceptjs/helper');
const execSync = require('child_process').execSync;
const utf8 = { encoding: 'utf-8' };

class SetupBlocks extends Helper {


  /**
   * @protected
   */
  _init() {
    execSync('rm -rf output/*', utf8);
    execSync('rm -rf allure-results/*', utf8);
  }

  _before(test) {}

  /**
   * @protected
   */
  _finishTest() {
    execSync('allure serve output', utf8);
    execSync("kill -9 `lsof -i TCP:\"4723\" | awk '/LISTEN/{print $2}'`", utf8);
  }

  // use: this.helpers['helperName']

}

module.exports = SetupBlocks;
