( function _Deployer_ss_() {

'use strict';

/*

try :
node staging/amid/fileDeployer/FileDeployer.ss ./staging

*/

if( typeof module !== 'undefined' )
{

  // require( '../../../../wTools/staging/abase/wTools.s' );
  // require( '../../../../wFiles/staging/amid/file/Files.ss' );

  if( typeof wBase === 'undefined' )
  try
  {
    require( '../../abase/wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  if( typeof wCopyable === 'undefined' )
  try
  {
    require( '../../mixin/Copyable.s' );
  }
  catch( err )
  {
    require( 'wCopyable' );
  }

  if( !wTools.files )
  try
  {
    require( '../../amid/Files.ss' );
  }
  catch( err )
  {
    require( 'wFiles' );
  }

  var Path = require( 'path' );
  var File = require( 'fs-extra' );

}

//

var _ = wTools;
var Parent = null;
var Self = function wFileDeployer( o )
{
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

//

var init = function( o )
{
  var self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.protoComplementInstance( self );

  if( self.Self === Self )
  Object.preventExtensions( self );

  if( o )
  self.copy( o );

}

//

/* exec if launched as stand-alone application */

var exec = function()
{
  var self = this;
  var argv = process.argv;

  debugger;

  console.log( 'argv :',argv );

  self.read( _.pathJoin( _.pathCurrent() , argv[ 2 ] ) );

  return self;
}

//

var read = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  _.routineOptions( read, o );

  self._tree = _.filesTreeRead( o );

  // logger.log( 'tree :\n' + _.toStr( self._tree,{ levels : 3 } ) );
  debugger;

}

read.defaults =
{
  pathFile : null,
}

//

var write = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  _.routineOptions( write, o );

  var data = _.toStr( self._tree,{ json : 1 } );
  File.writeFileSync( o.pathFile , data );

  debugger;

}

write.defaults =
{
  pathFile : null,
}

//

var publish = function( o )
{
  var self = this;

  debugger;

}

publish.defaults =
{
}

//

var toStr = function( o )
{
  var self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  debugger;

}

//

var fileProviderMake = function( o )
{
  var self = this;

  debugger;

}

fileProviderMake.defaults =
{
}

//

var _writeTreeIntoFile = function( o )
{
  var self = this;

  _.assert( arguments.length === 1 );

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  o.tree = self._tree;

  x



}

//

var readFromJson = function ( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  _.routineOptions( readFromJson, o )

  self._tree =  _.fileReadJson( o.pathFile );
}

readFromJson.defaults =
{
  pathFile : null,
}

// --
//
// --

var Composes =
{
}

var Aggregates =
{
}

var Associates =
{
  _tree : null,
}

var Restricts =
{
}

var Static =
{
}

// --
// prototype
// --

var Proto =
{

  init : init,
  exec : exec,

  read : read,
  write : write,
  publish : publish,

  toStr : toStr,

  fileProviderMake : fileProviderMake,

  _writeTreeIntoFile : _writeTreeIntoFile,
  readFromJson : readFromJson,

  /**/

  constructor : Self,
  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Static : Static,

};

//

_.protoMake
({
  constructor : Self,
  parent : Parent,
  extend : Proto,
});

//

if( _global_.wCopyable )
wCopyable.mixin( Self );

//

_.accessorForbid( Self.prototype,
{
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

_global_[ Self.name ] = wTools.Deployer = Self;

if( typeof module !== 'undefined' )
if( !module.parent )
{
  _global_.deployer = new Self();
  _global_.deployer.exec();
}

return Self;

})();
