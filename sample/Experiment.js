if( typeof module !== 'undefined' )
{
  require( 'wTools' )
  require( '../../wFiles/staging/dwtools/amid/file/Files.ss' )
  require( '../../wDeployer/staging/dwtools/amid/deployer/Deployer.ss' )



}

var _ = wTools;

var deployer = new wDeployer();
deployer.read( __dirname );
