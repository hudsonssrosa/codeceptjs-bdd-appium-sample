const { I, loginPage } = inject();
const TestHelper = require('../helpers/test_helper');


Given('that app is open', () => {
    console.log("pass");
});

When('I provide wrong credentials', () => {
    loginPage.typeInputUsername("wrong_user_name");
    loginPage.typeInputPassword("wrong_pass_123");
});

Then(/^I see "(.*)"/, (message) => {
    loginPage.clickOnLogin(message);
});

