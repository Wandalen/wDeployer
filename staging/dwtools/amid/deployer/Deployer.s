( function _Deployer_s_() {

'use strict';

/*

try :
node staging/dwtools/amid/fileDeployer/FileDeployer.s ./staging

*/

if( typeof module !== 'undefined' )
{

  // require( '../../../../wTools/staging/dwtools/abase/wTools.s' );
  // require( '../../../../wFiles/staging/dwtools/amid/file/Files.ss' );

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

  //require( '../../../../wFiles/staging/dwtools/amid/file/Files.ss' );

  if( !wTools.files )
  try
  {
    require( '../../amid/file/Files.ss' );
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
var AdvancedMixin = _.FileProvider.AdvancedMixin;
var Self = function wDeployer( o )
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

  /* default file provider, it's HardDrive for backend */

  if( !self.files )
  self.files = _.FileProvider.def();

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

  logger.log( 'tree :\n' + _.toStr( self._tree,{ levels : 3 } ) );

  var pathDst = argv[ 3 ] || 'tree.json';

  self.writeToJson( _.pathJoin( _.pathCurrent(), pathDst ) );

  return self;
}

//

var read = function( o )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  self.pathTarget = o.pathFile;

  self._optionsSupplement( o );
  _.routineOptions( read, o )

  self._tree = self.files.filesTreeRead( o );

}

read.defaults =
{
  pathFile : null,
}

read.defaults.__proto__ = _.FileProvider.AdvancedMixin.filesTreeRead.defaults;

//

var write = function( o )
{
  var self = this;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  debugger;

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  o.tree = self._tree;
  self.pathTarget = o.pathFile;

  self._optionsSupplement( o );
  _.routineOptions( write, o )

  return self.files.filesTreeWrite( o );
}

write.defaults =
{
  pathFile : null,
}

write.defaults.__proto__ = _.FileProvider.AdvancedMixin.filesTreeWrite.defaults;

//

var readFromJson = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  self._optionsSupplement( o,0 );
  _.routineOptions( readFromJson, o );

  self._tree = self.files.fileReadJson( o.pathFile );

}

readFromJson.defaults =
{
  pathFile : null,
}

readFromJson.defaults.__proto__ = _.FileProvider.Abstract.prototype.fileReadJson.defaults;

console.log( _.toStr( readFromJson.defaults.__proto__ ) );

//

var writeToJson = function( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o ) || _.objectIs( o ) );

  var self = this;

  debugger;

  if( _.strIs( o ) )
  {
    o = { pathFile : o };
  }

  self._optionsSupplement( o,0 );
  _.routineOptions( writeToJson, o );

  var data = _.toStr( self._tree,{ json : 1 } );
  File.writeFileSync( o.pathFile , data );

}

writeToJson.defaults =
{
  pathFile : null,
  usingLogging : 0,
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

var _optionsSupplement = function( options,forTree )
{
  var self = this;

  if( options.usingLogging === undefined )
  options.usingLogging = self.usingLogging;

  if( forTree )
  if( options.pathFile === undefined )
  options.pathFile = self.pathTarget;

}

//

// var _writeTreeIntoFile = function( o )
// {
//   var self = this;
//
//   _.assert( arguments.length === 1 );
//
//   if( _.strIs( o ) )
//   {
//     o = { pathFile : o };
//   }
//
//   o.tree = self._tree;
//
//   x
//
// }

// --
//
// --

var Composes =
{
  pathTarget : null,
  usingLogging : 1,
  files : null,
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

  readFromJson : readFromJson,
  writeToJson : writeToJson,

  publish : publish,

  toStr : toStr,

  fileProviderMake : fileProviderMake,

  _optionsSupplement : _optionsSupplement,

  //_writeTreeIntoFile : _writeTreeIntoFile,

  /**/

  constructor : Self,
  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Static : Static,

};

//

_.classMake
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