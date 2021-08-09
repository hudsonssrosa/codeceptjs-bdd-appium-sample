const { I } = inject();

class LoginPage {

  locs = {
    txtUsername: '#com.dgotlieb.automationsample:id/userName',
    txtPassword: '#com.dgotlieb.automationsample:id/userPassword',
    btnLogin: '#com.dgotlieb.automationsample:id/loginButton',
    lblErrorMessage: '#com.dgotlieb.automationsample:id/errorTV'
  }

  async openApp() {
    // I.seeAppIsInstalled()
    // I.runOnAndroid()
  }

  async typeInputUsername(input) {
    I.fillField(this.locs.txtUsername, input);
  }

  async typeInputPassword(input) {
    I.fillField(this.locs.txtPassword, input);
  }

  async clickOnLogin(expectedTitle) {
    I.tap(this.locs.btnLogin);
    I.waitForText(expectedTitle, 5)
    I.see(expectedTitle);
  }

}
module.exports = new LoginPage();