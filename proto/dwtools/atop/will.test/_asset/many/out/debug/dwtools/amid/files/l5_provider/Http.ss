( function _Http_ss_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../Tools.s' );
  if( !_.FileProvider )
  require( '../UseMid.s' );
}

//

/**
 @classdesc Class to transfer data over http protocol using GET/POST methods. Implementation for a server side.
 @class wFileProviderHttp
 @memberof module:Tools/mid/Files.wTools.FileProvider
*/

let _global = _global_;
let _ = _global_.wTools;
let Parent = _.FileProvider.Partial;
let Self = function wFileProviderHttp( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Http';

_.assert( !_.FileProvider.Http );

// --
// inter
// --

function init( o )
{
  let self = this;
  Parent.prototype.init.call( self,o );
}

//

function streamReadAct( o )
{
  let self = this;

  // if( _.strIs( o ) )
  // {
  //   o = { filePath : o };
  // }

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.filePath ),'streamReadAct :','Expects {-o.filePath-}' );

  let con = new _.Consequence( );
  let Request = null;

  function get( url )
  {
    let info = _.uri.parse( url );
    Request = info.protocol ? require( info.protocol ) : require( 'http' );

    Request.get( url, function( response )
    {
      if( response.statusCode > 300 && response.statusCode < 400 )
      {
        get( response.headers.location );
      }
      else if( response.statusCode !== 200 )
      {
        con.error( _.err( "Network error. StatusCode: ", response.statusCode ) );
      }
      else
      {
        con.take( response );
      }
    });
  }

  get( o.filePath );

  return con;
}

streamReadAct.defaults = Object.create( Parent.prototype.streamReadAct.defaults );
streamReadAct.having = Object.create( Parent.prototype.streamReadAct.having );


//

/**
 * @summary Reads content of a remote resourse performing GET request.
 * @description Accepts single argument - map with options. Expects that map `o` contains all necessary options and don't have redundant fields.
 * If `o.sync` is false, return instance of wConsequence, that gives a message with concent of a file when reading is finished.
 *
 * @param {Object} o Options map.
 * @param {String} o.filePath Remote url.
 * @param {String} o.encoding Desired encoding of a file concent.
 * @param {Boolean} o.resolvingSoftLink Enable resolving of soft links.
 * @param {String} o.sync Determines how to read a file, synchronously or asynchronously.
 * @param {Object} o.advanced Advanced options for http method
 * @param {} o.advanced.send Data to send.
 * @param {String} o.advanced.method Which http method to use: 'GET' or 'POST'.
 * @param {String} o.advanced.user Username, is used in authorization
 * @param {String} o.advanced.password Password, is used in authorization
 *
 * @function fileReadAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderHttp#
*/


function fileReadAct( o )
{
  let self = this;
  let con = new _.Consequence( );

  // if( _.strIs( o ) )
  // {
  //   o = { filePath : o };
  // }

  _.assertRoutineOptions( fileReadAct,arguments );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.filePath ),'fileReadAct :','Expects {-o.filePath-}' );
  _.assert( _.strIs( o.encoding ),'fileReadAct :','Expects {-o.encoding-}' );
  _.assert( !o.sync,'sync version is not implemented' );

  o.encoding = o.encoding.toLowerCase();
  let encoder = fileReadAct.encoders[ o.encoding ];

  logger.log( 'fileReadAct',o );

  /* on encoding : arraybuffer or encoding : buffer should return buffer( in consequence ) */

  function handleError( err )
  {

    if( encoder && encoder.onError )
    try
    {
      err = _._err
      ({
        args : [ stack,'\nfileReadAct( ',o.filePath,' )\n',err ],
        usingSourceCode : 0,
        level : 0,
      });
      err = encoder.onError.call( self,{ error : err, operation : o, encoder : encoder })
    }
    catch( err2 )
    {
      console.error( err2 );
      console.error( err.toString() + '\n' + err.stack );
    }

    if( o.sync )
    {
      throw err;
    }
    else
    {
      con.error( err );
    }
  }

  /* */

  function onData( data )
  {

    if( o.encoding === null )
    {
      _.bufferMove
      ({
        dst : result,
        src : data,
        dstOffset : dstOffset
      });

      dstOffset += data.length;
    }
    else
    {
      result += data;
    }

  }

  /* */

  let result = null;;
  let totalSize = null;
  let dstOffset = 0;

  if( encoder && encoder.onBegin )
  _.sure( encoder.onBegin.call( self, { operation : o, encoder : encoder }) === undefined );

  self.streamReadAct({ filePath :  o.filePath })
  .give( function( err, response )
  {
    debugger;

    if( err )
    return handleError( err );

    _.assert( _.strIs( o.encoding ) || o.encoding === null );

    if( o.encoding === null )
    {
      totalSize = response.headers[ 'content-length' ];
      result = new BufferRaw( totalSize );
    }
    else
    {
      response.setEncoding( o.encoding );
      result = '';
    }

    response.on( 'data', onData );
    response.on( 'end', onEnd );
    response.on( 'error', handleError );
    debugger;

  });

 return con;

  /* */

  function onEnd()
  {
    if( o.encoding === null )
    _.assert( _.bufferRawIs( result ) );
    else
    _.assert( _.strIs( result ) );

    let context = { data : result, operation : o, encoder : encoder };
    if( encoder && encoder.onEnd )
    _.sure( encoder.onEnd.call( self,context ) === undefined );
    result = context.data

    con.take( result );
  }

}

fileReadAct.defaults = Object.create( Parent.prototype.fileReadAct.defaults );
fileReadAct.having = Object.create( Parent.prototype.fileReadAct.having );

fileReadAct.advanced =
{
  send : null,
  method : 'GET',
  user : null,
  password : null,
}

//

function filesReflectSingle_body( o )
{
  let self = this;
  let path = self.path;

  o.extra = o.extra || Object.create( null );
  _.routineOptions( filesReflectSingle_body, o.extra, filesReflectSingle_body.extra );

  _.assertRoutineOptions( filesReflectSingle_body, o );
  // _.assert( o.mandatory === undefined )
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.routineIs( o.onUp ) && o.onUp.composed && o.onUp.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onDown ) && o.onDown.composed && o.onDown.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteDstUp ) && o.onWriteDstUp.composed && o.onWriteDstUp.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteDstDown ) && o.onWriteDstDown.composed && o.onWriteDstDown.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteSrcUp ) && o.onWriteSrcUp.composed && o.onWriteSrcUp.composed.elements.length === 0, 'Not supported options' );
  _.assert( _.routineIs( o.onWriteSrcDown ) && o.onWriteSrcDown.composed && o.onWriteSrcDown.composed.elements.length === 0, 'Not supported options' );
  // _.assert( o.outputFormat === 'record' || o.outputFormat === 'nothing', 'Not supported options' );
  _.assert( o.outputFormat === undefined );
  _.assert( o.linking === 'fileCopy' || o.linking === 'hardLinkMaybe' || o.linking === 'softLinkMaybe', 'Not supported options' );
  _.assert( !o.src.hasFiltering(), 'Not supported options' );
  _.assert( !o.dst.hasFiltering(), 'Not supported options' );
  _.assert( o.src.formed === 3 );
  _.assert( o.dst.formed === 3 );
  _.assert( o.srcPath === undefined );
  // _.assert( o.filter === null || !o.filter.hasFiltering(), 'Not supported options' );
  _.assert( o.filter === undefined );

  /* */

  let con = new _.Consequence();
  let dstFileProvider = o.dst.providerForPath();
  let srcPath = o.src.filePathSimplest();
  let dstPath = o.dst.filePathSimplest();
  // let srcPath = o.srcPath;
  // let dstPath = o.dstPath;
  let srcCurrentPath;

  // if( _.mapIs( srcPath ) )
  // {
  //   _.assert( _.mapVals( srcPath ).length === 1 );
  //   _.assert( _.mapVals( srcPath )[ 0 ] === true || _.mapVals( srcPath )[ 0 ] === dstPath );
  //   srcPath = _.mapKeys( srcPath )[ 0 ];
  // }

  srcPath = srcPath.replace( '///', '//' );

  /* */

  _.sure( _.strIs( srcPath ) );
  _.sure( _.strIs( dstPath ) );
  _.assert( dstFileProvider instanceof _.FileProvider.HardDrive || dstFileProvider.originalFileProvider instanceof _.FileProvider.HardDrive, 'Support only downloading on hard drive' );
  _.sure( !o.src || !o.src.hasFiltering(), 'Does not support filtering, but {o.src} is not empty' );
  _.sure( !o.dst || !o.dst.hasFiltering(), 'Does not support filtering, but {o.dst} is not empty' );
  // _.sure( !o.filter || !o.filter.hasFiltering(), 'Does not support filtering, but {o.filter} is not empty' );

  /* log */

  // logger.log( '' );
  // logger.log( 'srcPath', srcPath );
  // logger.log( 'dstPath', dstPath );
  // logger.log( '' );
  // debugger;

  /* */

  dstFileProvider.dirMake( dstFileProvider.path.dir( dstPath ) );

  let writeStream = null;
  writeStream = dstFileProvider.streamWrite({ filePath : dstPath });
  writeStream.on( 'error', onError );
  writeStream.on( 'finish', function( )
  {
    writeStream.close( function( )
    {
      con.take( null );
    })
  });

  self.streamRead({ filePath : srcPath })
  .give( function( err, response )
  {
    response.pipe( writeStream );
    response.on( 'error', onError );
  });

  /* handle error if any */

  con
  .finally( function( err, arg )
  {
    debugger;
    if( err )
    throw _.err( err );
    return recordsMake();
  });

  return con;

  /* */

  function recordsMake()
  {
    /* xxx : fast solution to return records instead of empty arrray */
    debugger;
    o.result = dstFileProvider.filesReflectEvaluate
    ({
      src : { filePath : dstPath },
      dst : { filePath : dstPath },
    });
    debugger;
    return o.result;
  }

  /* begin */

  function onError( err )
  {
    debugger;
    try
    {
      HardDrive.fileDelete( o.filePath );
    }
    catch( err )
    {
    }
    con.error( _.err( err ) );
  }

}

_.routineExtend( filesReflectSingle_body, _.FileProvider.Find.prototype.filesReflectSingle );

var extra = filesReflectSingle_body.extra = Object.create( null );
extra.fetching = 1;

var defaults = filesReflectSingle_body.defaults;
let filesReflectSingle = _.routineFromPreAndBody( _.FileProvider.Find.prototype.filesReflectSingle.pre, filesReflectSingle_body );

//

/**
 * @summary Saves content of a remote resourse to the hard drive. Actual implementation.
 * @description Accepts single argument - map with options. Expects that map `o` contains all necessary options and don't have redundant fields.
 *
 * @param {Object} o Options map.
 * @param {String} o.url Remote url.
 * @param {String} o.filePath Destination path.
 * @param {String} o.encoding Desired encoding of a file concent.
 * @param {Boolean} o.resolvingSoftLink Enable resolving of soft links.
 * @param {String} o.sync Determines how to read a file, synchronously or asynchronously.
 * @param {Object} o.advanced Advanced options for http method
 * @param {} o.advanced.send Data to send.
 * @param {String} o.advanced.method Which http method to use: 'GET' or 'POST'.
 * @param {String} o.advanced.user Username, is used in authorization
 * @param {String} o.advanced.password Password, is used in authorization
 *
 * @function fileCopyToHardDriveAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderHttp#
*/

function fileCopyToHardDriveAct( o )
{
  let self = this;
  let con = new _.Consequence( );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.url ),'fileCopyToHardDriveAct :','Expects {-o.filePath-}' );
  _.assert( _.strIs( o.filePath ),'fileCopyToHardDriveAct :','Expects {-o.filePath-}' );

 //

  let dstFileProvider = _.FileProvider.HardDrive( );
  let writeStream = null;
  let dstPath = dstFileProvider.path.nativize( o.filePath );

  console.log( 'dstPath', dstPath );

  writeStream = dstFileProvider.streamWrite({ filePath : dstPath });
  writeStream.on( 'error', onError );
  writeStream.on( 'finish', function( )
  {
    writeStream.close( function( )
    {
      con.take( o.filePath );
    })
  });

  self.streamReadAct({ filePath : o.url })
  .give( function( err, response )
  {
    response.pipe( writeStream );
    response.on( 'error', onError );
  });

  return con;

  /* begin */

  function onError( err )
  {
    try
    {
      HardDrive.fileDelete( o.filePath );
    }
    catch( err )
    {
    }
    con.error( _.err( err ) );
  }

}

var defaults = fileCopyToHardDriveAct.defaults = Object.create( Parent.prototype.fileReadAct.defaults );

defaults.url = null;

fileCopyToHardDriveAct.advanced =
{
  send : null,
  method : 'GET',
  user : null,
  password : null,

}

//

/**
 * @summary Saves content of a remote resourse to the hard drive.
 * @description Accepts single argument - map with options. Expects that map `o` contains all necessary options and don't have redundant fields.
 *
 * @param {Object} o Options map.
 * @param {String} o.url Remote url.
 * @param {String} o.filePath Destination path.
 * @param {String} o.encoding Desired encoding of a file concent.
 * @param {Boolean} o.resolvingSoftLink Enable resolving of soft links.
 * @param {String} o.sync Determines how to read a file, synchronously or asynchronously.
 * @param {Object} o.advanced Advanced options for http method
 * @param {} o.advanced.send Data to send.
 * @param {String} o.advanced.method Which http method to use: 'GET' or 'POST'.
 * @param {String} o.advanced.user Username, is used in authorization
 * @param {String} o.advanced.password Password, is used in authorization
 *
 * @function fileCopyToHardDriveAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderHttp#
*/

function fileCopyToHardDrive( o )
{
  let self = this;

  if( _.strIs( o ) )
  {
    let filePath = self.path.join( self.path.realMainDir( ), self.path.name({ path : o, full : 1 }) );
    o = { url : o, filePath : filePath };
  }
  else
  {
    _.assert( arguments.length === 1, 'Expects single argument' );
    _.assert( _.strIs( o.url ),'fileCopyToHardDrive :','Expects {-o.filePath-}' );
    _.assert( _.strIs( o.filePath ),'fileCopyToHardDrive :','Expects {-o.filePath-}' );

    let HardDrive = _.FileProvider.HardDrive();
    let dirPath = self.path.dir( o.filePath );
    let stat = HardDrive.statResolvedRead({ filePath : dirPath, throwing : 0 });
    if( !stat )
    {
      try
      {
        HardDrive.dirMake({ filePath : dirPath, recursive : 1})
      }
      catch ( err )
      {
      }
    }

  }

  return self.fileCopyToHardDriveAct( o );
}

var defaults = fileCopyToHardDrive.defaults = Object.create( Parent.prototype.fileReadAct.defaults );

defaults.url = null;

fileCopyToHardDrive.advanced =
{
  send : null,
  method : 'GET',
  user : null,
  password : null,

}

// --
// encoders
// --

let WriteEncoders = {};

WriteEncoders[ 'buffer.raw' ] =
{

  onBegin : function( e )
  {
    e.operation.encoding = null;
  },

}

WriteEncoders[ 'buffer.node' ] =
{

  onBegin : function( e )
  {
    e.operation.encoding = null;
  },

}

WriteEncoders[ 'blob' ] =
{

  onBegin : function( e )
  {
    debugger;
    throw _.err( 'not tested' );
    e.operation.encoding = 'blob';
  },

}

WriteEncoders[ 'document' ] =
{

  onBegin : function( e )
  {
    debugger;
    throw _.err( 'not tested' );
    e.operation.encoding = 'document';
  },

}

WriteEncoders[ 'buffer.bytes' ] =
{

  responseType : 'arraybuffer',

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'buffer.bytes' );
  },

  onEnd : function( e )
  {
    let result = _.bufferBytesFrom( e.data );
    return result;
  },

}

fileReadAct.encoders = WriteEncoders;

// --
// relationship
// --

/**
 * @typedef {Object} Fields
 * @param {Boolean} safe=0
 * @param {Boolean} stating=0
 * @param {String[]} protocols=[ 'http', 'https' ]
 * @param {Boolean} resolvingSoftLink=0
 * @param {Boolean} resolvingTextLink=0
 * @param {Boolean} usingSoftLink=0
 * @param {Boolean} usingTextLink=0
 * @param {Boolean} usingGlobalPath=1
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderHttp
*/

let Composes =
{

  safe : 0,
  protocols : _.define.own([ 'http', 'https' ]),

  resolvingSoftLink : 0,
  resolvingTextLink : 0,
  usingSoftLink : 0,
  usingTextLink : 0,
  usingGlobalPath : 1,

}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  Path : _.weburi.CloneExtending({ fileProvider : Self }),
}

// --
// declare
// --

let Proto =
{

  init,

  // read

  streamReadAct,
  fileReadAct,

  // write

  filesReflectSingle,

  // special

  fileCopyToHardDriveAct,
  fileCopyToHardDrive,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module === 'undefined' )
if( !_.FileProvider.Default )
_.FileProvider.Default = Self;

_.FileProvider[ Self.shortName ] = Self;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})( );
