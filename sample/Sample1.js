

if( typeof module !== 'undefined' )
require( 'wDeployer' );

var _ = wTools;
var deployer = new wDeployer();

deployer.read( __dirname );

logger.log( 'tree :\n' + _.toStr( deployer._tree,{ levels : 3 } ) );

deployer.writeToJson( _.pathJoin( __dirname, 'tree.json' ) );

/**/
