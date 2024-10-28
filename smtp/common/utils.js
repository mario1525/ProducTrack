class Utils {
    static getLogger() {
      return {
        log: console.log,
        verbose: console.log,
      };
    }
  }
  
  module.exports = Utils;
  