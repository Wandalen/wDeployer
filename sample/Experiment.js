if( typeof module !== 'undefined' )
{
  require( 'wTools' )
  require( '../../wFiles/staging/amid/file/Files.ss' )
  require( '../../wDeployer/staging/amid/deployer/Deployer.ss' )



}

var _ = wTools;

var deployer = new wDeployer();
deployer.read( __dirname );
