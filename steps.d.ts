/// <reference types='codeceptjs' />
type steps_file = typeof import('./steps_file.js');
type loginPage = typeof import('./tests/pages/login_page.js');

declare namespace CodeceptJS {
  interface SupportObject { I: I, current: any, loginPage: loginPage }
  interface Methods extends Appium {}
  interface I extends ReturnType<steps_file> {}

  namespace Translation {
    interface Actions {}
  }
}
