const Helper = require('@codeceptjs/helper');
const { exec } = require("child_process")

class TestHelper extends Helper{

  static extractFromBash(cmdLine) {
    let stored = exec(cmdLine, (error, stdout, stderr) => {
      if (error) {
          console.log(`error: ${error.message}`);
          return;
      }
      if (stderr) {
          console.log(`stderr: ${stderr}`);
          return;
      }
      console.log(`stdout: ${stdout}`);
    });
    return stored;
  }

}

module.exports = TestHelper;
