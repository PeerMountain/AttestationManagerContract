var ClaimsRegistry = artifacts.require('ClaimsRegistry.sol');
var AttestationManager = artifacts.require('AttestationManager.sol');


module.exports = function(deployer) {
  // deployment steps
  const args = process.argv.slice();
   if (args.length > 4) {
     deployer.deploy(ClaimsRegistry, args[3]);
     deployer.deploy(AttestationManager, args[3], args[4]);
  }else {
    console.log('ERROR: Contract not deployed. Need to provide the owner as a parameter.');
  }
};
