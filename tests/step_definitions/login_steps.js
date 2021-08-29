const { I, loginPage } = inject();
const TestHelper = require('../helpers/test_helper');


Given('that app is open', () => {
    // loginPage.openApp("com.dgotlieb.automationsample");
    console.log("pass")
});

When('I provide wrong credentials', async () => {
    await loginPage.typeInputUsername("wrong_user_name");
    await loginPage.typeInputPassword("wrong_pass_123");
});

Then(/^I see "(.*)"/, async (message) => {
    await loginPage.clickOnLogin(message);
});

