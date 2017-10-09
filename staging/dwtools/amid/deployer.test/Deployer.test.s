( function _Deployer_test_s_( ) {

'use strict';

/*

to run this test
from the project directory run

npm install
node ./amid/z.test/Deployer.test.s

*/

if( typeof module !== 'undefined' )
{

  require( 'wTools' );

  try
  {
    require( '../../amid/diagnostic/Testing.debug.s' );
  }
  catch( err )
  {
    require( 'wTesting' );
  }

}

var deployer = require( '../deployer/Deployer.s' )(  );
var fs = require('fs');

var _ = wTools;
var Self = {};

var path = _.dirTempMake( _.pathDir( __dirname ) );
var fileTestDir = _.pathResolve( _.pathRealMainDir(), '../file.test' );

//

function cleanTestDir()
{
  _.fileProvider.fileDelete( path );
}

//

var DeployerTest = function( test )
{
  var pathSrc = _.pathJoin( fileTestDir, 'file.s' );
  var pathDst = _.pathJoin( path, 'file.json' )

  test.description = 'single file path as string ';
  debugger
  deployer.read( pathSrc );
  deployer.writeToJson(  pathDst );
  var got = deployer._tree;
  deployer.readFromJson( pathDst );
  var expected = deployer._tree;
  test.identical( got,expected );

  test.description = 'single file, path like map property ';
  deployer.read( { pathFile : pathSrc } );
  deployer.writeToJson(  { pathFile : pathDst} );
  var got = deployer._tree;
  deployer.readFromJson( { pathFile : pathDst} );
  var expected = deployer._tree;
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.description = 'read : incorrect argument type';
    test.shouldThrowError( function()
    {
      deployer.read( 1 )
    });

    test.description = 'writeToJson : incorrect argument type';
    test.shouldThrowError( function()
    {
      deployer.writeToJson( 0 )
    });



  }
}

//

var Proto =
{

  name : 'Deployer test',
  silencing : 1,

  onSuiteEnd : cleanTestDir,

  tests :
  {
    DeployerTest : DeployerTest,
  }

}

_.mapExtend( Self,Proto );
Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
