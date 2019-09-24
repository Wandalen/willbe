( function _Extract_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );
  if( !_.FileProvider )
  require( '../UseMid.s' );

}

let _global = _global_;
let _ = _global_.wTools;
let Abstract = _.FileProvider.Abstract;
let Partial = _.FileProvider.Partial;
let FileRecord = _.FileRecord;
let Find = _.FileProvider.Find;

_.assert( _.routineIs( _.FileRecord ) );
_.assert( _.routineIs( Abstract ) );
_.assert( _.routineIs( Partial ) );
_.assert( !!Find );
_.assert( !_.FileProvider.Extract );

//

/**
 @classdesc Class that allows file manipulations on filesTree - object based on some folders/files tree,
 where folders are nested objects with same depth level as in real folder and contains some files that are properties
 with corresponding names and file content as a values.
 @class wFileProviderExtract
 @memberof module:Tools/mid/Files.wTools.FileProvider
*/

let Parent = Partial;
let Self = function wFileProviderExtract( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Extract';

// --
// inter
// --

function init( o )
{
  let self = this;
  Parent.prototype.init.call( self, o );

  if( self.filesTree === null )
  self.filesTree = Object.create( null );

}

// --
// path
// --

/**
 * @summary Return path to current working directory.
 * @description Changes current path to `path` if argument is provided.
 * @param {String} [path] New current path.
 * @function pathCurrentAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderExtract#
*/

function pathCurrentAct()
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( arguments.length === 1 && arguments[ 0 ] )
  {
    let path = arguments[ 0 ];
    _.assert( self.path.is( path ) );
    self._currentPath = path;
  }

  let result = self._currentPath;

  return result;
}

//

/**
 * @summary Resolves soft link `o.filePath`.
 * @description Accepts single argument - map with options. Expects that map `o` contains all necessary options and don't have redundant fields.
 * Returns input path `o.filePath` if source file is not a soft link.
 * @param {Object} o Options map.
 * @param {String} o.filePath Path to soft link.
 * @param {Boolean} o.resolvingMultiple=0 Resolves chain of terminal links.
 * @param {Boolean} o.resolvingIntermediateDirectories=0 Resolves intermediate soft links.
 * @function pathResolveSoftLinkAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderExtract#
*/

function pathResolveSoftLinkAct( o )
{
  let self = this;
  // let filePath = o.filePath;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( self.path.isAbsolute( o.filePath ) );

  // /* using self.resolvingSoftLink causes recursion problem in pathResolveLinkFull */
  // debugger;
  // if( !self.isSoftLink( o.filePath ) )
  // return o.filePath;

  let result;

  if( o.resolvingIntermediateDirectories )
  return resolveIntermediateDirectories();

  let descriptor = self._descriptorRead( o.filePath );

  if( !self._descriptorIsSoftLink( descriptor ) )
  return o.filePath;

  result = self._descriptorResolveSoftLinkPath( descriptor );

  _.assert( _.strIs( result ) )

  if( o.resolvingMultiple )
  return resolvingMultiple();

  return result;

  /*  */

  function resolveIntermediateDirectories()
  {
    let splits = self.path.split( o.filePath );
    let o2 = _.mapExtend( null, o );

    o2.resolvingIntermediateDirectories = 0;
    o2.filePath = '/';

    for( let i = 1 ; i < splits.length ; i++ )
    {
      o2.filePath = self.path.join( o2.filePath, splits[ i ] );

      let descriptor = self._descriptorRead( o2.filePath );

      if( self._descriptorIsSoftLink( descriptor ) )
      {
        result = self.pathResolveSoftLinkAct( o2 )
        o2.filePath = self.path.join( o2.filePath, result );
      }
    }
    return o2.filePath;
  }

  /**/

  function resolvingMultiple()
  {
    result = self.path.join( o.filePath, self.path.normalize( result ) );
    let descriptor = self._descriptorRead( result );
    if( !self._descriptorIsSoftLink( descriptor ) )
    return result;
    let o2 = _.mapExtend( null, o );
    o2.filePath = result;
    return self.pathResolveSoftLinkAct( o2 );
  }
}

_.routineExtend( pathResolveSoftLinkAct, Parent.prototype.pathResolveSoftLinkAct )

//

/**
 * @summary Resolves text link `o.filePath`.
 * @description Accepts single argument - map with options. Expects that map `o` contains all necessary options and don't have redundant fields.
 * Returns input path `o.filePath` if source file is not a text link.
 * @param {Object} o Options map.
 * @param {String} o.filePath Path to text link.
 * @param {Boolean} o.resolvingMultiple=0 Resolves chain of text links.
 * @param {Boolean} o.resolvingIntermediateDirectories=0 Resolves intermediate text links.
 * @function pathResolveTextLinkAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderExtract#
*/

function pathResolveTextLinkAct( o )
{
  let self = this;
  let filePath = o.filePath;
  let result;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( self.path.isAbsolute( o.filePath ) );

  if( o.resolvingIntermediateDirectories )
  return resolveIntermediateDirectories();

  let file = self._descriptorRead( o.filePath );

  if( self._descriptorIsSoftLink( file ) )
  return false;
  if( _.numberIs( file ) )
  return false;

  if( _.bufferRawIs( file ) || _.bufferTypedIs( file ) )
  file = _.bufferToStr( file );

  if( _.arrayIs( file ) )
  file = file[ 0 ].data;

  _.assert( _.strIs( file ) );

  let regexp = /link ([^\n]+)\n?$/;
  let m = file.match( regexp );

  if( !m )
  return false;

  result = m[ 1 ];

  if( o.resolvingMultiple )
  return resolvingMultiple();

  return result;

  /*  */

  function resolveIntermediateDirectories()
  {
    let splits = self.path.split( o.filePath );
    let o2 = _.mapExtend( null, o );

    o2.resolvingIntermediateDirectories = 0;
    o2.filePath = '/';

    for( let i = 1 ; i < splits.length ; i++ )
    {
      o2.filePath = self.path.join( o2.filePath, splits[ i ] );

      let descriptor = self._descriptorRead( o2.filePath );

      if( self._descriptorIsTextLink( descriptor ) )
      {
        result = self.pathResolveTextLinkAct( o2 )
        o2.filePath = self.path.join( o2.filePath, result );
      }
    }
    return o2.filePath;
  }

  /**/

  function resolvingMultiple()
  {
    result = self.path.join( o.filePath, self.path.normalize( result ) );
    let descriptor = self._descriptorRead( result );
    if( !self._descriptorIsTextLink( descriptor ) )
    return result;
    let o2 = _.mapExtend( null, o );
    o2.filePath = result;
    return self.pathResolveTextLinkAct( o2 );
  }
}

_.routineExtend( pathResolveTextLinkAct, Parent.prototype.pathResolveTextLinkAct )

// --
// read
// --

/**
 * @summary Reads content of a terminal file.
 * @description Accepts single argument - map with options. Expects that map `o` contains all necessary options and don't have redundant fields.
 * If `o.sync` is false, return instance of wConsequence, that gives a message with concent of a file when reading is finished.
 * @param {Object} o Options map.
 * @param {String} o.filePath Path to terminal file.
 * @param {String} o.encoding Desired encoding of a file concent.
 * @param {} o.advanced
 * @param {Boolean} o.resolvingSoftLink Enable resolving of soft links.
 * @param {String} o.sync Determines how to read a file, synchronously or asynchronously.
 * @function fileReadAct
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderExtract#
*/

function fileReadAct( o )
{
  let self = this;
  let con = new _.Consequence();
  let result = null;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( fileReadAct, o );
  _.assert( _.strIs( o.encoding ) );

  let encoder = fileReadAct.encoders[ o.encoding ];

  if( o.encoding )
  if( !encoder )
  return handleError( _.err( 'Encoding: ' + o.encoding + ' is not supported!' ) )

  /* exec */

  handleBegin();

  // if( _.strHas( o.filePath, 'icons.woff2' ) )
  // debugger;

  o.filePath = self.pathResolveLinkFull
  ({
    filePath : o.filePath,
    resolvingSoftLink : o.resolvingSoftLink,
    resolvingTextLink : o.resolvingTextLink,
  }).absolutePath;

  if( self.system && _.path.isGlobal( o.filePath ) )
  {
    _.assert( self.system !== self );
    return self.system.fileReadAct( o );
  }

  result = self._descriptorRead( o.filePath );

  // if( self._descriptorIsLink( result ) )
  // {
  //   result = self._descriptorResolve({ descriptor : result });
  //   if( result === undefined )
  //   return handleError( _.err( 'Cant resolve :', result ) );
  // }

  if( self._descriptorIsHardLink( result ) )
  {
    result = result[ 0 ].data;
    _.assert( result !== undefined );
    // debugger; xxx
    // let resolved = self._descriptorResolve({ descriptor : result });
    // if( resolved === undefined )
    // return handleError( _.err( 'Cant resolve :', result ) );
    // result = resolved;
  }

  if( result === undefined || result === null )
  {
    debugger;
    result = self._descriptorRead( o.filePath );
    return handleError( _.err( 'File at', _.strQuote( o.filePath ), 'doesn`t exist!' ) );
  }

  if( self._descriptorIsDir( result ) )
  return handleError( _.err( 'Can`t read from dir : ' + _.strQuote( o.filePath ) + ' method expects terminal file' ) );
  else if( self._descriptorIsLink( result ) )
  return handleError( _.err( 'Can`t read from link : ' + _.strQuote( o.filePath ) + ', without link resolving enabled' ) );
  else if( !self._descriptorIsTerminal( result ) )
  return handleError( _.err( 'Can`t read file : ' + _.strQuote( o.filePath ), result ) );

  if( self.usingExtraStat )
  self._fileTimeSetAct({ filePath : o.filePath, atime : _.timeNow() });

  return handleEnd( result );

  /* begin */

  function handleBegin()
  {

    if( encoder && encoder.onBegin )
    _.sure( encoder.onBegin.call( self, { operation : o, encoder : encoder }) === undefined );

  }

  /* end */

  function handleEnd( data )
  {

    let context = { data : data, operation : o, encoder : encoder };
    if( encoder && encoder.onEnd )
    _.sure( encoder.onEnd.call( self, context ) === undefined );
    data = context.data;

    if( o.sync )
    {
      return data;
    }
    else
    {
      return con.take( data );
    }

  }

  /* error */

  function handleError( err )
  {

    debugger;

    if( encoder && encoder.onError )
    try
    {
      err = _._err
      ({
        args : [ stack, '\nfileReadAct( ', o.filePath, ' )\n', err ],
        usingSourceCode : 0,
        level : 0,
      });
      err = encoder.onError.call( self, { error : err, operation : o, encoder : encoder })
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
      return con.error( err );
    }

  }

}

_.routineExtend( fileReadAct, Parent.prototype.fileReadAct );

//

function dirReadAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( dirReadAct, o );

  let result;

  if( o.sync )
  {
    readDir();
    return result;
  }
  else
  {
    return _.timeOut( 0, function()
    {
      readDir();
      return result;
    });
  }

  /* */

  function readDir()
  {
    o.filePath = self.pathResolveLinkFull({ filePath : o.filePath, resolvingSoftLink : 1 }).absolutePath;

    let file = self._descriptorRead( o.filePath );

    if( file !== undefined )
    {
      if( _.objectIs( file ) )
      {
        result = Object.keys( file );
      }
      else
      {
        result = self.path.name({ path : o.filePath, full : 1 });
      }
    }
    else
    {
      result = null;
      throw _.err( 'File ', _.strQuote( o.filePath ), 'doesn`t exist!' );;
    }
  }

}

_.routineExtend( dirReadAct, Parent.prototype.dirReadAct );

// --
// read stat
// -

function statReadAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( statReadAct, o );

  /* */

  if( o.sync )
  {
    return _statReadAct( o.filePath );
  }
  else
  {
    return _.timeOut( 0, function()
    {
      return _statReadAct( o.filePath );
    })
  }

  /* */

  function _statReadAct( filePath )
  {
    let result = null;

    if( o.resolvingSoftLink )
    {

      let o2 =
      {
        filePath : filePath,
        resolvingSoftLink : o.resolvingSoftLink,
        resolvingTextLink : 0,
      };

      filePath = self.pathResolveLinkFull( o2 ).absolutePath;
      _.assert( o2.stat !== undefined );

      if( !o2.stat && o.throwing )
      throw _.err( 'File', _.strQuote( filePath ), 'doesn`t exist!' );

      return o2.stat;
    }
    else
    {
      filePath = self._pathResolveIntermediateDirs( filePath );
    }

    let d = self._descriptorRead( filePath );

    if( !_.definedIs( d ) )
    {
      if( o.throwing )
      throw _.err( 'File', _.strQuote( filePath ), 'doesn`t exist!' );
      return result;
    }

    result = new _.FileStat();

    if( self.extraStats && self.extraStats[ filePath ] )
    {
      let extraStat = self.extraStats[ filePath ];
      result.atime = new Date( extraStat.atime );
      result.mtime = new Date( extraStat.mtime );
      result.ctime = new Date( extraStat.ctime );
      result.birthtime = new Date( extraStat.birthtime );
      result.ino = extraStat.ino || null;
      result.dev = extraStat.dev || null;
    }

    result.filePath = filePath;
    result.isTerminal = returnFalse;
    result.isDir = returnFalse;
    result.isTextLink = returnFalse; /* qqq : implement and add coverage, please */
    result.isSoftLink = returnFalse;
    result.isHardLink = returnFalse; /* qqq : implement and add coverage, please */
    result.isFile = returnFalse;
    result.isDirectory = returnFalse;
    result.isSymbolicLink = returnFalse;
    result.nlink = 1;
    // result.ino = d.ino || null;

    if( self._descriptorIsDir( d ) )
    {
      result.isDirectory = returnTrue;
      result.isDir = returnTrue;
    }
    else if( self._descriptorIsTerminal( d ) || self._descriptorIsHardLink( d ) )
    {
      if( self._descriptorIsHardLink( d ) )
      {
        if( _.arrayIs( d[ 0 ].hardLinks ) )
        result.nlink = d[ 0 ].hardLinks.length;

        d = d[ 0 ].data;
        result.isHardLink = returnTrue;
      }

      result.isTerminal = returnTrue;
      result.isFile = returnTrue;

      if( _.numberIs( d ) )
      result.size = String( d ).length;
      else if( _.strIs( d ) )
      result.size = d.length;
      else
      result.size = d.byteLength;

      _.assert( result.size >= 0 );

      result.isTextLink = function isTextLink()
      {
        if( !self.usingTextLink )
        return false;
        return self._descriptorIsTextLink( d );
      }
    }
    else if( self._descriptorIsSoftLink( d ) )
    {
      result.isSymbolicLink = returnTrue;
      result.isSoftLink = returnTrue;
    }
    else if( self._descriptorIsHardLink( d ) )
    {
      _.assert( 0 );
      // result.isHardLink = returnTrue;
    }
    else if( self._descriptorIsScript( d ) )
    {
      result.isTerminal = returnTrue;
      result.isFile = returnTrue;
    }

    return result;
  }

  /* */

  function returnFalse()
  {
    return false;
  }

  /* */

  function returnTrue()
  {
    return true;
  }

}

_.routineExtend( statReadAct, Parent.prototype.statReadAct );

//

function fileExistsAct( o )
{
  let self = this;

  _.assert( arguments.length === 1 );
  _.assert( self.path.isNormalized( o.filePath ) );

  let filePath = o.filePath;

  filePath = self._pathResolveIntermediateDirs( filePath );

  let file = self._descriptorRead( filePath );
  return !!file;
}

_.routineExtend( fileExistsAct, Parent.prototype.fileExistsAct );

// --
// write
// --

function fileWriteAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( fileWriteAct, o );
  _.assert( _.strIs( o.filePath ) );
  _.assert( self.WriteMode.indexOf( o.writeMode ) !== -1 );

  let encoder = fileWriteAct.encoders[ o.encoding ];

  _.assert( self._descriptorIsTerminal( o.data ), 'Expects string or BufferNode, but got', _.strType( o.data ) );

  /* */

  if( o.sync )
  {
    write();
  }
  else
  {
    return _.timeOut( 0, () => write() );
  }

  /* */

  function handleError( err )
  {
    err = _.err( err );
    if( o.sync )
    throw err;
    return new _.Consequence().error( err );
  }

  /* begin */

  function handleBegin( read )
  {
    if( !encoder )
    return o.data;

    _.assert( _.routineIs( encoder.onBegin ) )
    let context = { data : o.data, read : read, operation : o, encoder : encoder };
    _.sure( encoder.onBegin.call( self, context ) === undefined );

    return context.data;
  }

  /* */

  function write()
  {

    let filePath =  o.filePath;
    let descriptor = self._descriptorRead( filePath );
    let read;

    if( self._descriptorIsLink( descriptor ) )
    {
      let resolvedPath = self.pathResolveLinkFull
      ({
        filePath : filePath,
        allowingMissed : 1,
        allowingCycled : 0,
        resolvingSoftLink : 1,
        resolvingTextLink : 0,
        preservingRelative : 0,
        throwing : 1
      }).absolutePath;
      descriptor = self._descriptorRead( resolvedPath );
      filePath = resolvedPath;

      //descriptor should be missing/text/hard/terminal
      _.assert( descriptor === undefined || self._descriptorIsTerminal( descriptor ) || self._descriptorIsHardLink( descriptor )  );

      // if( !self._descriptorIsLink( descriptor ) )
      // {
      //   filePath = resolvedPath;
      //   if( descriptor === undefined )
      //   throw _.err( 'Link refers to file ->', filePath, 'that doesn`t exist' );
      // }

    }

    // let dstName = self.path.name({ path : filePath, full : 1 });
    let dstDir = self._descriptorRead( self.path.dir( filePath ) );
    if( !dstDir )
    throw _.err( 'Directory for', filePath, 'does not exist' );
    else if( !self._descriptorIsDir( dstDir ) )
    throw _.err( 'Parent of', filePath, 'is not a directory' );

    if( self._descriptorIsDir( descriptor ) )
    throw _.err( 'Incorrect path to file!\nCan`t rewrite dir :', filePath );

    let writeMode = o.writeMode;

    _.assert( _.arrayHas( self.WriteMode, writeMode ), 'Unknown write mode:' + writeMode );

    if( descriptor === undefined || self._descriptorIsLink( descriptor ) )
    {
      if( self._descriptorIsHardLink( descriptor ) )
      {
        read = descriptor[ 0 ].data;
      }
      else
      {
        read = '';
        writeMode = 'rewrite';
      }
    }
    else
    {
      read = descriptor;
    }

    let data = handleBegin( read );

    _.assert( self._descriptorIsTerminal( read ) );

    if( writeMode === 'append' || writeMode === 'prepend' )
    {
      if( !encoder )
      {
        //converts data from file to the type of o.data
        if( _.strIs( data ) )
        {
          if( !_.strIs( read ) )
          read = _.bufferToStr( read );
        }
        else
        {
          _.assert( 0, 'not tested' );

          if( _.bufferBytesIs( data ) )
          read = _.bufferBytesFrom( read )
          else if( _.bufferRawIs( data ) )
          read = _.bufferRawFrom( read )
          else
          _.assert( 0, 'not implemented for:', _.strType( data ) );
        }
      }

      if( _.strIs( read ) )
      {
        if( writeMode === 'append' )
        data = read + data;
        else
        data = data + read;
      }
      else
      {
        if( writeMode === 'append' )
        data = _.bufferJoin( read, data );
        else
        data = _.bufferJoin( data, read );
      }

    }
    else
    {
      _.assert( writeMode === 'rewrite', 'Not implemented write mode:', writeMode );
    }

    self._descriptorWrite( filePath, data );

    /* what for is that needed ??? */
    /*self._descriptorRead({ selector : dstDir, set : structure });*/

    return true;
  }

}

_.routineExtend( fileWriteAct, Parent.prototype.fileWriteAct );

//

function fileTimeSetAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertMapHasOnly( o, fileTimeSetAct.defaults );

  let file = self._descriptorRead( o.filePath );
  if( !file )
  throw _.err( 'File:', o.filePath, 'doesn\'t exist. Can\'t set time stats.' );

  self._fileTimeSetAct( o );

}

_.routineExtend( fileTimeSetAct, Parent.prototype.fileTimeSetAct );

//

function _fileTimeSetAct( o )
{
  let self = this;

/* qqq xxx : implement for hardlinks

*/

  if( !self.usingExtraStat )
  return;

  if( _.strIs( arguments[ 0 ] ) )
  o = { filePath : arguments[ 0 ] };

  _.assert( self.path.isAbsolute( o.filePath ), o.filePath );
  _.assert( o.atime === undefined || o.atime === null || _.numberIs( o.atime ) );
  _.assert( o.mtime === undefined || o.mtime === null || _.numberIs( o.mtime ) );
  _.assert( o.ctime === undefined || o.ctime === null || _.numberIs( o.ctime ) );
  _.assert( o.birthtime === undefined || o.birthtime === null || _.numberIs( o.birthtime ) );

  let extra = self.extraStats[ o.filePath ];

  if( !extra )
  {
    extra = self.extraStats[ o.filePath ] = Object.create( null );
    extra.atime = null;
    extra.mtime = null;
    extra.ctime = null;
    extra.birthtime = null;
    extra.ino = ++Self.InoCounter;
    Object.preventExtensions( extra );
  }

  if( o.atime )
  extra.atime = o.atime;

  if( o.mtime )
  extra.mtime = o.mtime;

  if( o.ctime )
  extra.ctime = o.ctime;

  if( o.birthtime )
  extra.birthtime = o.birthtime;

  if( o.updatingDir )
  {
    let dirPath = self.path.dir( o.filePath );
    if( dirPath === '/' )
    return;

    extra.birthtime = null;

    _.assert( o.atime && o.mtime && o.ctime );
    _.assert( o.atime === o.mtime && o.mtime === o.ctime );

    o.filePath = dirPath;

    self._fileTimeSetAct( o );
  }

  return extra;
}

_fileTimeSetAct.defaults =
{
  filePath : null,
  atime : null,
  mtime : null,
  ctime : null,
  birthtime : null,
  updatingDir : false
}

//

function fileDeleteAct( o )
{
  let self = this;

  _.assertRoutineOptions( fileDeleteAct, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( o.filePath ) );

  // logger.log( 'Extract.fileDeleteAct', o.filePath );
  // debugger;

  if( o.sync )
  {
    act();
  }
  else
  {
    return _.timeOut( 0, () => act() );
  }

  /* - */

  function act()
  {
    let filePath = o.filePath;

    let stat = self.statReadAct
    ({
      filePath : filePath,
      resolvingSoftLink : 0,
      sync : 1,
      throwing : 0,
    });

    if( !stat )
    {
      debugger;
      throw _.err( 'Path', _.strQuote( o.filePath ), 'doesn`t exist!' );
    }

    // Vova: intermediate dirs should be resolved, stat.filePath stores that resolved path
    filePath = stat.filePath;

    let file = self._descriptorRead( filePath );
    if( self._descriptorIsDir( file ) && Object.keys( file ).length )
    {
      debugger;
      throw _.err( 'Directory is not empty : ' + _.strQuote( o.filePath ) );
    }

    let dirPath = self.path.dir( filePath );
    let dir = self._descriptorRead( dirPath );

    _.sure( !!dir, () => 'Cant delete root directory ' + _.strQuote( o.filePath ) );

    let fileName = self.path.name({ path : filePath, full : 1 });
    delete dir[ fileName ];

    // for( let k in self.extraStats[ o.filePath ] )
    // self.extraStats[ o.filePath ][ k ] = null;
    delete self.extraStats[ o.filePath ];
    self._descriptorTimeUpdate( dirPath, 0 );

    return true;
  }

}

_.routineExtend( fileDeleteAct, Parent.prototype.fileDeleteAct );

//

function dirMakeAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( dirMakeAct, o );

  /* */

  if( o.sync )
  {
    __make();
  }
  else
  {
    return _.timeOut( 0, () => __make() );
  }

  /* - */

  function __make( )
  {
    if( self._descriptorRead( o.filePath ) )
    {
      debugger;
      throw _.err( 'File', _.strQuote( o.filePath ), 'already exists!' );
    }

    // _.assert( !!self._descriptorRead( self.path.dir( o.filePath ) ), 'Directory ', _.strQuote( o.filePath ), ' doesn\'t exist!' );

    let dstDir = self._descriptorRead( self.path.dir( o.filePath ) );
    if( !dstDir )
    throw _.err( 'Directory for', o.filePath, 'does not exist' );
    else if( !self._descriptorIsDir( dstDir ) )
    throw _.err( 'Parent of', o.filePath, 'is not a directory' );

    self._descriptorWrite( o.filePath, Object.create( null ) );

    return true;
  }

}

_.routineExtend( dirMakeAct, Parent.prototype.dirMakeAct );

// --
// linking
// --

function fileRenameAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( fileRenameAct, arguments );
  _.assert( self.path.isNormalized( o.srcPath ) );
  _.assert( self.path.isNormalized( o.dstPath ) );

  if( o.sync )
  {
    return rename();
  }
  else
  {
    return _.timeOut( 0, () => rename() );
  }

  /* - */

  /* rename */

  function rename( )
  {
    let dstName = self.path.name({ path : o.dstPath, full : 1 });
    let srcName = self.path.name({ path : o.srcPath, full : 1 });
    let srcDirPath = self.path.dir( o.srcPath );
    let dstDirPath = self.path.dir( o.dstPath );

    let srcDir = self._descriptorRead( srcDirPath );
    if( !srcDir || !srcDir[ srcName ] )
    throw _.err( 'Source path', _.strQuote( o.srcPath ), 'doesn`t exist!' );

    /*  */

    let dstDir = self._descriptorRead( dstDirPath );
    if( !dstDir )
    throw _.err( 'Directory for', o.dstPath, 'does not exist' );
    else if( !self._descriptorIsDir( dstDir ) )
    throw _.err( 'Parent of', o.dstPath, 'is not a directory' );
    if( dstDir[ dstName ] )
    throw _.err( 'Destination path', _.strQuote( o.dstPath ), 'already exists!' );

    dstDir[ dstName ] = srcDir[ srcName ];
    delete srcDir[ srcName ];

    self.extraStats[ o.dstPath ] = self.extraStats[ o.srcPath ];
    delete self.extraStats[ o.srcPath ];

    if( dstDir !== srcDir )
    {
      self._descriptorTimeUpdate( srcDirPath, 0 );
      self._descriptorTimeUpdate( dstDirPath, 0 );
    }

    return true;
  }

}

_.routineExtend( fileRenameAct, Parent.prototype.fileRenameAct );

//

function fileCopyAct( o )
{
  let self = this;
  let srcFile;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( fileCopyAct, arguments );
  _.assert( self.path.isNormalized( o.srcPath ) );
  _.assert( self.path.isNormalized( o.dstPath ) );

  if( o.sync  ) // qqq : synchronize async version aaa : done
  {
    _copyPre();

    let dstStat = self.statReadAct
    ({
      filePath : o.dstPath,
      resolvingSoftLink : 0,
      sync : 1,
      throwing : 0,
    });

    // let srcStat = self.statReadAct
    // ({
    //   filePath : o.srcPath,
    //   resolvingSoftLink : 0,
    //   sync : 1,
    //   throwing : 0,
    // });

    _.assert( self.isTerminal( o.srcPath ), () => _.strQuote( o.srcPath ), 'is not terminal' );

    if( dstStat )
    if( o.breakingDstHardLink && dstStat.isHardLink() )
    self.hardLinkBreak({ filePath : o.dstPath, sync : 1 });

    /* qqq : ? aaa : redundant, just copy the descriptor instead of this */
    // if( self.isSoftLink( o.srcPath ) )
    // {
    //   if( self.fileExistsAct({ filePath : o.dstPath }) )
    //   self.fileDeleteAct({ filePath : o.dstPath, sync : 1 })
    //   return self.softLinkAct
    //   ({
    //     originalDstPath : o.originalDstPath,
    //     originalSrcPath : o.originalSrcPath,
    //     srcPath : self.pathResolveSoftLink( o.srcPath ),
    //     dstPath : o.dstPath,
    //     sync : o.sync,
    //     type : null
    //   })
    // }
    // self.fileWriteAct({ filePath : o.dstPath, data : srcFile, sync : 1 });

    let data = self.fileRead({ filePath : o.srcPath, encoding : 'original.type', sync : 1, resolvingTextLink : 0 });
    _.assert( data !== null && data !== undefined );

    if( dstStat )
    if( dstStat.isSoftLink() )
    {
      o.dstPath = self.pathResolveLinkFull
      ({
        filePath : o.dstPath,
        allowingMissed : 1,
        allowingCycled : 0,
        resolvingSoftLink : 1,
        resolvingTextLink : 0,
        preservingRelative : 0,
        throwing : 1
      }).absolutePath;
    }

    self._descriptorWrite( o.dstPath, data );

  }
  else
  {
    let con = new _.Consequence().take( null );
    let dstStat;
    let data;

    con.then( () =>
    {
      _copyPre();
      return self.statReadAct
      ({
        filePath : o.dstPath,
        resolvingSoftLink : 0,
        sync : 0,
        throwing : 0,
      })
    })
    .then( ( got ) =>
    {
      dstStat = got;

      if( dstStat )
      if( o.breakingDstHardLink && dstStat.isHardLink() )
      return self.hardLinkBreak({ filePath : o.dstPath, sync : 0 });
      return true;
    })
    .then( () =>
    {
      return self.fileRead
      ({
        filePath : o.srcPath,
        encoding : 'original.type',
        sync : 0,
        resolvingTextLink : 0
      })
    })
    .then( ( got ) =>
    {
      data = got;

      _.assert( data !== null && data !== undefined );

      if( dstStat )
      if( dstStat.isSoftLink() )
      return self.pathResolveLinkFull
      ({
        filePath : o.dstPath,
        allowingMissed : 1,
        allowingCycled : 0,
        resolvingSoftLink : 1,
        resolvingTextLink : 0,
        preservingRelative : 0,
        sync : 0,
        throwing : 1
      })
      .then( ( resolved ) =>
      {
        o.dstPath = resolved.absolutePath;
        return true;
      })

      return true;
    })
    .then( () =>
    {
      self._descriptorWrite( o.dstPath, data );
      return true;
    })

    return con;
  }

  /* - */

  function _copyPre( )
  {

    let srcIsTerminal = self.isTerminal( o.srcPath );
    if( !srcIsTerminal )
    {
      debugger;
      throw _.err( 'File', _.strQuote( o.srcPath ), 'doesn`t exist or isn`t terminal!' );
    }

    let dstDirIsDir = self.isDir( self.path.dir( o.dstPath ) );
    if( !dstDirIsDir )
    {
      debugger;
      throw _.err( 'File', _.strQuote( self.path.dir( o.dstPath ) ), 'doesn`t exist or isn`t directory!' );
    }

    // srcFile  = self._descriptorRead( o.srcPath );
    //
    // if( !srcFile )
    // {
    //   debugger;
    //   throw _.err( 'File', _.strQuote( o.srcPath ), 'doesn`t exist!' );
    // }
    //
    // if( self._descriptorIsDir( srcFile ) )
    // {
    //   debugger;
    //   throw _.err( o.srcPath, ' is not a terminal file!' );
    // }

    // let dstDir = self._descriptorRead( self.path.dir( o.dstPath ) );
    // if( !dstDir )
    // throw _.err( 'Directory for', o.dstPath, 'does not exist' );

    // let dstDir = self._descriptorRead( self.path.dir( o.dstPath ) );
    // if( !dstDir )
    // throw _.err( 'Directory for', o.dstPath, 'does not exist' );
    // else if( !self._descriptorIsDir( dstDir ) )
    // throw _.err( 'Parent of', o.dstPath, 'is not a directory' );

    let dstIsDir = self.isDir( o.dstPath );
    // let dstPath = self._descriptorRead( o.dstPath );
    // if( self._descriptorIsDir( dstPath ) )
    if( dstIsDir )
    throw _.err( 'Can`t rewrite directory by terminal file : ' + o.dstPath );

    return true;
  }

}

_.routineExtend( fileCopyAct, Parent.prototype.fileCopyAct );

//

function softLinkAct( o )
{
  let self = this;

  // debugger
  _.assertRoutineOptions( softLinkAct, arguments );

  _.assert( self.path.is( o.srcPath ) );
  _.assert( self.path.isAbsolute( o.dstPath ) );
  _.assert( self.path.isNormalized( o.srcPath ) );
  _.assert( self.path.isNormalized( o.dstPath ) );

  // if( !self.path.isAbsolute( o.originalSrcPath ) )
  // debugger;
  // if( !self.path.isAbsolute( o.originalSrcPath ) )
  // o.srcPath = o.originalSrcPath;

  if( o.sync )
  {
    // if( o.dstPath === o.srcPath )
    // return true;

    if( self.statRead( o.dstPath ) )
    throw _.err( 'softLinkAct', o.dstPath, 'already exists' );

    dstDirCheck();

    /*
      qqq : add tests for linking act routines
      qqq : don't forget throwing cases
    */

    self._descriptorWrite( o.dstPath, self._descriptorSoftLinkMake( o.relativeSrcPath ) );

    return true;
  }
  else
  {
    // if( o.dstPath === o.srcPath )
    // return new _.Consequence().take( true );

    return self.statRead({ filePath : o.dstPath, sync : 0 })
    .finally( ( err, stat ) =>
    {
      if( err )
      throw _.err( err );

      if( stat )
      throw _.err( 'softLinkAct', o.dstPath, 'already exists' );

      dstDirCheck();

      self._descriptorWrite( o.dstPath, self._descriptorSoftLinkMake( o.relativeSrcPath ) );

      return true;
    })
  }

  /*  */

  function dstDirCheck()
  {
    let dstDir = self._descriptorRead( self.path.dir( o.dstPath ) );
    if( !dstDir )
    throw _.err( 'Directory for', o.dstPath, 'does not exist' );
    else if( !self._descriptorIsDir( dstDir ) )
    throw _.err( 'Parent of', o.dstPath, 'is not a directory' );
  }
}

_.routineExtend( softLinkAct, Parent.prototype.softLinkAct );

//

function hardLinkAct( o )
{
  let self = this;

  _.assertRoutineOptions( hardLinkAct, arguments );
  _.assert( self.path.isNormalized( o.srcPath ) );
  _.assert( self.path.isNormalized( o.dstPath ) );

  if( o.sync )
  {
    if( o.dstPath === o.srcPath )
    return true;

    let dstExists = self.fileExists( o.dstPath );
    let srcStat = self.statRead( o.srcPath );

    if( !srcStat )
    {
      debugger;
      throw _.err( o.srcPath, 'does not exist' );
    }

    if( !srcStat.isTerminal( o.srcPath ) )
    throw _.err( o.srcPath, 'is not a terminal file' );

    if( dstExists )
    throw _.err( o.dstPath, 'already exists' );

    dstDirCheck();

    let srcDescriptor = self._descriptorRead( o.srcPath );
    let descriptor = self._descriptorHardLinkMake( [ o.dstPath, o.srcPath ], srcDescriptor );
    if( srcDescriptor !== descriptor )
    self._descriptorWrite( o.srcPath, descriptor );
    self._descriptorWrite( o.dstPath, descriptor );

    if( self.usingExtraStat )
    self.extraStats[ o.dstPath ] = self.extraStats[ o.srcPath ]; /* Vova : check which stats hardlinked files should have in common */

    return true;
  }
  else
  {
    let con = new _.Consequence().take( true );

    /* qqq : synchronize wtih sync version, please aaa : done */

    if( o.dstPath === o.srcPath )
    return con;

    let dstExists;

    con.then( () => self.fileExists( o.dstPath ) );
    con.then( ( got ) =>
    {
      dstExists = got;
      return self.statRead({ filePath : o.srcPath, sync : 0 })
    });
    con.then( ( srcStat ) =>
    {
      if( !srcStat )
      {
        debugger;
        throw _.err( o.srcPath, 'does not exist' );
      }

      if( !srcStat.isTerminal() )
      throw _.err( o.srcPath, 'is not a terminal file' );

      if( dstExists )
      throw _.err( o.dstPath, 'already exists' );

      dstDirCheck();

      let srcDescriptor = self._descriptorRead( o.srcPath );
      let descriptor = self._descriptorHardLinkMake( [ o.dstPath, o.srcPath ], srcDescriptor );
      if( srcDescriptor !== descriptor )
      self._descriptorWrite( o.srcPath, descriptor );
      self._descriptorWrite( o.dstPath, descriptor );

      return true;
    })

    return con;


    // return self.statRead({ filePath : o.dstPath, sync : 0 })
    // .finally( ( err, stat ) =>
    // {
    //   if( err )
    //   throw _.err( err );

    //   if( stat )
    //   throw _.err( o.dstPath, 'already exists' );

    //   let file = self._descriptorRead( o.srcPath );

    //   if( !file )
    //   throw _.err( o.srcPath, 'does not exist' );

    //   // if( !self._descriptorIsLink( file ) )
    //   if( !self.isTerminal( o.srcPath ) )
    //   throw _.err( o.srcPath, ' is not a terminal file' );

    //   let dstDir = self._descriptorRead( self.path.dir( o.dstPath ) );
    //   if( !dstDir )
    //   throw _.err( 'hardLinkAct: dirs structure before', o.dstPath, ' does not exist' );

    //   self._descriptorWrite( o.dstPath, self._descriptorHardLinkMake( o.srcPath ) );

    //   return true;
    // })
  }

  /*  */

  function dstDirCheck()
  {
    let dstDir = self._descriptorRead( self.path.dir( o.dstPath ) );
    if( !dstDir )
    throw _.err( 'Directory for', o.dstPath, 'does not exist' );
    else if( !self._descriptorIsDir( dstDir ) )
    throw _.err( 'Parent of', o.dstPath, 'is not a directory' );
  }

}

_.routineExtend( hardLinkAct, Parent.prototype.hardLinkAct );

// --
// link
// --

function hardLinkBreakAct( o )
{
  let self = this;
  let descriptor = self._descriptorRead( o.filePath );

  _.assert( self._descriptorIsHardLink( descriptor ) );

  // let read = self._descriptorResolve({ descriptor : descriptor });
  // _.assert( self._descriptorIsTerminal( read ) );

  _.arrayRemoveOnce( descriptor[ 0 ].hardLinks, o.filePath );

  self._descriptorWrite
  ({
    filePath : o.filePath,
    data : descriptor[ 0 ].data,
    breakingHardLink : true
  });

  if( !o.sync )
  return new _.Consequence().take( null );
}

_.routineExtend( hardLinkBreakAct, Parent.prototype.hardLinkBreakAct );

//

function filesAreHardLinkedAct( o )
{
  let self = this;

  _.assertRoutineOptions( filesAreHardLinkedAct, arguments );
  _.assert( o.filePath.length === 2, 'Expects exactly two arguments' );

  if( o.filePath[ 0 ] === o.filePath[ 1 ] )
  return true;

  let filePath1 = self._pathResolveIntermediateDirs( o.filePath[ 0 ] );
  let filePath2 = self._pathResolveIntermediateDirs( o.filePath[ 1 ] );

  if( filePath1 === filePath2 )
  return true;

  let descriptor1 = self._descriptorRead( filePath1 );
  let descriptor2 = self._descriptorRead( filePath2 );

  if( !self._descriptorIsHardLink( descriptor1 ) )
  return false;
  if( !self._descriptorIsHardLink( descriptor2 ) )
  return false;

  if( descriptor1 === descriptor2 )
  return true;

  _.assert
  (
    !_.arrayHas( descriptor1[ 0 ].hardLinks, o.filePath[ 1 ] ),
    'Hardlinked files are desynchronized, two hardlinked files should share the same descriptor, but those do not :',
    '\n', o.filePath[ 0 ],
    '\n', o.filePath[ 1 ]
  );

  return false;
}

_.routineExtend( filesAreHardLinkedAct, Parent.prototype.filesAreHardLinkedAct );

// --
// etc
// --

function filesTreeSet( src )
{
  let self = this;

  if( self[ filesTreeSymbol ] === src )
  return src;

  _.mapDelete( self.extraStats );

  self[ filesTreeSymbol ] = src;

  if( src && _.mapKeys( src ).length && self.usingExtraStat )
  self.statsAdopt();

  return src;
}

//

function statsAdopt()
{
  let self = this;

  _.assert( arguments.length === 0 );

  self.filesFindNominal( '/', ( r ) =>
  {
    self._fileTimeSetAct({ filePath : r.absolute, atime : r.stat.atime || _.timeNow() });
    return r;
  });

  return self;
}

//

function linksRebase( o )
{
  let self = this;

  _.routineOptions( linksRebase, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( 0, 'not tested' );

  function onUp( file )
  {
    let descriptor = self._descriptorRead( file.absolute );

    xxx
    if( self._descriptorIsHardLink( descriptor ) )
    {
      debugger;
      descriptor = descriptor[ 0 ];
      let was = descriptor.hardLink;
      let url = _.uri.parseAtomic( descriptor.hardLink ); debugger; xxx
      url.longPath = self.path.rebase( url.longPath, o.oldPath, o.newPath );
      descriptor.hardLink = _.uri.str( url );
      logger.log( '* linksRebase :', descriptor.hardLink, '<-', was );
      debugger;
    }

    return file;
  }

  self.filesFind
  ({
    filePath : o.filePath,
    recursive : 2,
    onUp : onUp,
  });

}

linksRebase.defaults =
{
  filePath : '/',
  oldPath : '',
  newPath : '',
}

// --
//
// --

function _pathResolveIntermediateDirs( filePath )
{
  let self = this;

  // resolves intermediate dir(s) except terminal

  _.assert( self.path.isAbsolute( filePath ) );
  _.assert( self.path.isNormalized( filePath ) );

  if( _.strCount( filePath, self.path._upStr ) > 1 )
  {
    let fileName = self.path.name({ path : filePath, full : 1 });
    filePath = self.pathResolveSoftLinkAct
    ({
      filePath : self.path.dir( filePath ),
      resolvingIntermediateDirectories : 1,
      resolvingMultiple : 1
    });
    filePath = self.path.join( filePath, fileName );
  }

  return filePath;

}

// --
// descriptor read
// --

function _descriptorRead( o )
{
  let self = this;
  let path = self.path;

  if( _.strIs( arguments[ 0 ] ) )
  o = { filePath : arguments[ 0 ] };

  _.routineOptions( _descriptorRead, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !path.isGlobal( o.filePath ), 'Expects local path, but got', o.filePath );

  if( o.upToken === null )
  o.upToken = [ './', '/' ];
  if( o.filePath === '.' )
  o.filePath = '';
  if( !o.filesTree )
  o.filesTree = self.filesTree;

  let o2 = Object.create( null );

  o2.setting = 0;
  o2.selector = o.filePath;
  o2.src = o.filesTree;
  o2.upToken = o.upToken;
  o2.usingIndexedAccessToMap = 0;
  o2.globing = 0;

  let result = _.select( o2 );

  return result;
}

_descriptorRead.defaults =
{
  filePath : null,
  filesTree : null,
  upToken : null,
}

//

function _descriptorReadResolved( o )
{
  let self = this;

  if( _.strIs( arguments[ 0 ] ) )
  o = { filePath : arguments[ 0 ] };

  let result = self._descriptorRead( o );

  if( self._descriptorIsLink( result ) )
  result = self._descriptorResolve({ descriptor : result });

  return result;
}
_.routineExtend( _descriptorReadResolved, _descriptorRead );
// _descriptorReadResolved.defaults = Object.create( _descriptorRead.defaults );

//

function _descriptorResolve( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.descriptor );
  _.routineOptions( _descriptorResolve, o );
  self._providerDefaultsApply( o );
  _.assert( !o.resolvingTextLink );

  if( self._descriptorIsHardLink( o.descriptor ) /* && self.resolvingHardLink */ )
  {
    return self._descriptorResolveHardLink( o.descriptor );
    // o.descriptor = self._descriptorResolveHardLink( o.descriptor );
    // return self._descriptorResolve
    // ({
    //   descriptor : o.descriptor,
    //   // resolvingHardLink : o.resolvingHardLink,
    //   resolvingSoftLink : o.resolvingSoftLink,
    //   resolvingTextLink : o.resolvingTextLink,
    // });
  }

  if( self._descriptorIsSoftLink( o.descriptor ) && self.resolvingSoftLink )
  {
    o.descriptor = self._descriptorResolveSoftLink( o.descriptor );
    return self._descriptorResolve
    ({
      descriptor : o.descriptor,
      // resolvingHardLink : o.resolvingHardLink,
      resolvingSoftLink : o.resolvingSoftLink,
      resolvingTextLink : o.resolvingTextLink,
    });
  }

  return o.descriptor;
}

_descriptorResolve.defaults =
{
  descriptor : null,
  // resolvingHardLink : null,
  resolvingSoftLink : null,
  resolvingTextLink : null,
}

// function _descriptorResolvePath( o )
// {
//   let self = this;

//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( o.descriptor );
//   _.routineOptions( _descriptorResolve, o );
//   self._providerDefaultsApply( o );
//   _.assert( !o.resolvingTextLink );

//   let descriptor = self._descriptorRead( o.descriptor );

//   if( self._descriptorIsHardLink( descriptor ) && self.resolvingHardLink )
//   {
//     o.descriptor = self._descriptorResolveHardLinkPath( descriptor );
//     return self._descriptorResolvePath
//     ({
//       descriptor : o.descriptor,
//       resolvingHardLink : o.resolvingHardLink,
//       resolvingSoftLink : o.resolvingSoftLink,
//       resolvingTextLink : o.resolvingTextLink,
//     });
//   }

//   if( self._descriptorIsSoftLink( descriptor ) && self.resolvingSoftLink )
//   {
//     o.descriptor = self._descriptorResolveSoftLinkPath( descriptor );
//     return self._descriptorResolvePath
//     ({
//       descriptor : o.descriptor,
//       resolvingHardLink : o.resolvingHardLink,
//       resolvingSoftLink : o.resolvingSoftLink,
//       resolvingTextLink : o.resolvingTextLink,
//     });
//   }

//   return o.descriptor;
// }

// _descriptorResolvePath.defaults =
// {
//   descriptor : null,
//   resolvingHardLink : null,
//   resolvingSoftLink : null,
//   resolvingTextLink : null,
// }

//

// function _descriptorResolveHardLinkPath( descriptor )
// {
//   let self = this;
//   descriptor = descriptor[ 0 ];
//
//   _.assert( descriptor.data !== undefined );
//   return descriptor.data;
//
//   // _.assert( !!descriptor.hardLink );
//   // return descriptor.hardLink;
// }

//

function _descriptorResolveHardLink( descriptor )
{
  let self = this;
  let result;

  _.assert( descriptor.data !== undefined );
  return descriptor.data;

  // let filePath = self._descriptorResolveHardLinkPath( descriptor );
  // let url = _.uri.parse( filePath );
  //
  // _.assert( arguments.length === 1 )
  //
  // if( url.protocol )
  // {
  //   debugger;
  //   throw _.err( 'not implemented' );
  //   // _.assert( url.protocol === 'file', 'can handle only "file" protocol, but got', url.protocol );
  //   // result = _.fileProvider.fileRead( url.localPath );
  //   // _.assert( _.strIs( result ) );
  // }
  // else
  // {
  //   debugger;
  //   result = self._descriptorRead( url.localPath );
  // }

  return result;
}

//

function _descriptorResolveSoftLinkPath( descriptor, withPath )
{
  let self = this;
  descriptor = descriptor[ 0 ];
  _.assert( !!descriptor.softLink );
  return descriptor.softLink;
}

//

function _descriptorResolveSoftLink( descriptor )
{
  let self = this;
  let result;
  let filePath = self._descriptorResolveSoftLinkPath( descriptor );
  let url = _.uri.parse( filePath );

  _.assert( arguments.length === 1 )

  if( url.protocol )
  {
    debugger;
    throw _.err( 'not implemented' );
    // _.assert( url.protocol === 'file', 'can handle only "file" protocol, but got', url.protocol );
    // result = _.fileProvider.fileRead( url.localPath );
    // _.assert( _.strIs( result ) );
  }
  else
  {
    debugger;
    result = self._descriptorRead( url.localPath );
  }

  return result;
}

//

function _descriptorIsDir( file )
{
  return _.objectIs( file );
}

//

function _descriptorIsTerminal( file )
{
  return _.strIs( file ) || _.numberIs( file ) || _.bufferRawIs( file ) || _.bufferTypedIs( file );
}

//

function _descriptorIsLink( file )
{
  if( !_.arrayIs( file ) )
  return false;

  // if( _.arrayIs( file ) )
  {
    _.assert( file.length === 1 );
    file = file[ 0 ];
  }
  _.assert( !!file );
  return !!( file.hardLinks || file.softLink );
}

//

function _descriptorIsSoftLink( file )
{
  if( !_.arrayIs( file ) )
  return false;

  // if( _.arrayIs( file ) )
  {
    _.assert( file.length === 1 );
    file = file[ 0 ];
  }
  _.assert( !!file );
  return !!file.softLink;
}

//

function _descriptorIsHardLink( file )
{
  if( !_.arrayIs( file ) )
  return false;

  // if( _.arrayIs( file ) )
  {
    _.assert( file.length === 1 );
    file = file[ 0 ];
  }

  _.assert( !!file );
  _.assert( !file.hardLink );

  return !!file.hardLinks;
}

//

function _descriptorIsTextLink( file )
{
  if( !_.definedIs( file ) )
  return false;
  if( _.arrayIs( file ) )
  return false;
  if( _.objectIs( file ) )
  return false;

  let regexp = /^link ([^\n]+)\n?$/;
  if( _.bufferRawIs( file ) || _.bufferTypedIs( file ) )
  file = _.bufferToStr( file )
  _.assert( _.strIs( file ) );
  return regexp.test( file );
}

//

function _descriptorIsScript( file )
{
  if( !_.arrayIs( file ) )
  return false;

  // if( _.arrayIs( file ) )
  {
    _.assert( file.length === 1 );
    file = file[ 0 ];
  }
  _.assert( !!file );
  return !!file.code;
}

// --
// descriptor write
// --

function _descriptorWrite( o )
{
  let self = this;

  if( _.strIs( arguments[ 0 ] ) )
  o = { filePath : arguments[ 0 ], data : arguments[ 1 ] };

  _.routineOptions( _descriptorWrite, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( o.upToken === null )
  o.upToken = [ './', '/' ];
  if( o.filePath === '.' )
  o.filePath = '';

  if( !o.filesTree )
  {
    _.assert( _.objectLike( self.filesTree ) );
    o.filesTree = self.filesTree;
  }

  let file = self._descriptorRead( o.filePath );
  let willBeCreated = file === undefined;
  let time = _.timeNow();

  let result;

  if( !o.breakingHardLink && self._descriptorIsHardLink( file ) )
  {
    result = file[ 0 ].data = o.data;
  }
  else
  {
    let o2 = Object.create( null );

    o2.setting = 1;
    o2.set = o.data;
    o2.selector = o.filePath;
    o2.src = o.filesTree;
    o2.upToken = o.upToken;
    o2.usingIndexedAccessToMap = 0;
    o2.globing = 0;

    result = _.select( o2 );
  }

  o.filePath = self.path.join( '/', o.filePath );

  let timeOptions =
  {
    filePath : o.filePath,
    ctime : time,
    mtime : time
  }

  if( willBeCreated )
  {
    timeOptions.atime = time;
    timeOptions.birthtime = time;
    timeOptions.updatingDir = 1;
  }

  if( self.usingExtraStat )
  self._fileTimeSetAct( timeOptions );

  return result;
}

_descriptorWrite.defaults =
{
  filePath : null,
  filesTree : null,
  data : null,
  upToken : null,
  breakingHardLink : false
}

//

function _descriptorTimeUpdate( filePath, created )
{
  let self = this;
  let time = _.timeNow();

  _.assert( arguments.length === 2 );

  if( !self.usingExtraStat )
  return;

  let o2 =
  {
    filePath : filePath,
    ctime : time,
    mtime : time
  }

  if( created )
  {
    o2.atime = time;
    o2.birthtime = time;
    o2.updatingDir = 1; xxx
  }

  self._fileTimeSetAct( o2 );
}

//

function _descriptorScriptMake( filePath, data )
{

  if( _.strIs( data ) )
  try
  {
    data = _.routineMake({ code : data, prependingReturn : 0 });
  }
  catch( err )
  {
    debugger;
    throw _.err( 'Cant make routine for file :\n' + filePath + '\n', err );
  }

  _.assert( _.routineIs( data ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  let d = Object.create( null );
  d.filePath = filePath;
  d.code = data;
  // d.ino = ++Self.InoCounter;
  return [ d ];
}

//

function _descriptorSoftLinkMake( filePath )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  let d = Object.create( null );
  d.softLink = filePath;
  // d.ino = ++Self.InoCounter;
  return [ d ];
}

//

function _descriptorHardLinkMake( filePath, data )
{
  _.assert( arguments.length === 2 );
  _.assert( _.arrayIs( filePath ) );

  if( this._descriptorIsHardLink( data ) )
  {
    _.arrayAppendArrayOnce(  data[ 0 ].hardLinks, filePath );
    return data;
  }

  let d = Object.create( null );
  d.hardLinks = filePath;
  d.data = data;
  // d.ino = ++Self.InoCounter;

  return [ d ];
}

// --
// encoders
// --

let readEncoders = Object.create( null );
let writeEncoders = Object.create( null );

fileReadAct.encoders = readEncoders;
fileWriteAct.encoders = writeEncoders;

//

readEncoders[ 'utf8' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'utf8' );
  },

  onEnd : function( e )
  {
    if( !_.strIs( e.data ) )
    e.data = _.bufferToStr( e.data );
    _.assert( _.strIs( e.data ) );;
  },

}

//

readEncoders[ 'ascii' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'ascii' );
  },

  onEnd : function( e )
  {
    if( !_.strIs( e.data ) )
    e.data = _.bufferToStr( e.data );
    _.assert( _.strIs( e.data ) );;
  },

}

//

readEncoders[ 'latin1' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'latin1' );
  },

  onEnd : function( e )
  {
    if( !_.strIs( e.data ) )
    e.data = _.bufferToStr( e.data );
    _.assert( _.strIs( e.data ) );;
  },

}

//

readEncoders[ 'buffer.raw' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'buffer.raw' );
  },

  onEnd : function( e )
  {

    e.data = _.bufferRawFrom( e.data );

    _.assert( !_.bufferNodeIs( e.data ) );
    _.assert( _.bufferRawIs( e.data ) );

  },

}

//

readEncoders[ 'buffer.bytes' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'buffer.bytes' );
  },

  onEnd : function( e )
  {
    e.data = _.bufferBytesFrom( e.data );
  },

}

readEncoders[ 'original.type' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'original.type' );
  },

  onEnd : function( e )
  {
    _.assert( _descriptorIsTerminal( e.data ) );
  },

}

//

if( Config.interpreter === 'njs' )
readEncoders[ 'buffer.node' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'buffer.node' );
  },

  onEnd : function( e )
  {
    e.data = _.bufferNodeFrom( e.data );
    // let result = BufferNode.from( e.data );
    // _.assert( _.strIs( e.data ) );
    _.assert( _.bufferNodeIs( e.data ) );
    _.assert( !_.bufferRawIs( e.data ) );
    // return result;
  },

}

//

writeEncoders[ 'original.type' ] =
{
  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'original.type' );

    if( e.read === undefined || e.operation.writeMode === 'rewrite' )
    return;

    if( _.strIs( e.read ) )
    {
      if( !_.strIs( e.data ) )
      e.data = _.bufferToStr( e.data );
    }
    else
    {

      if( _.bufferBytesIs( e.read ) )
      e.data = _.bufferBytesFrom( e.data )
      else if( _.bufferRawIs( e.read ) )
      e.data = _.bufferRawFrom( e.data )
      else
      {
        _.assert( 0, 'not implemented for:', _.strType( e.read ) );
        // _.bufferFrom({ src : data, bufferConstructor : read.constructor });
      }
    }
  }
}

// --
// relationship
// --

/**
 * @typedef {Object} Fields
 * @property {Boolean} usingExtraStat
 * @property {Array} protocols
 * @property {Boolean} safe
 * @property {Object} filesTree
 * @memberof module:Tools/mid/Files.wTools.FileProvider.wFileProviderExtract
 */

let Composes =
{
  usingExtraStat : null,
  protocols : _.define.own( [] ),
  _currentPath : '/',
  safe : 0,
}

let Aggregates =
{
  filesTree : null,
}

let Associates =
{
}

let Restricts =
{
  extraStats : _.define.own( {} ),
}

let Accessors =
{
  filesTree : { setter : filesTreeSet },
}

let Statics =
{

  // filesTreeRead,
  // readToProvider,

  _descriptorIsDir,
  _descriptorIsTerminal,
  _descriptorIsLink,
  _descriptorIsSoftLink,
  _descriptorIsHardLink,
  _descriptorIsTextLink,

  _descriptorScriptMake,
  _descriptorSoftLinkMake,
  _descriptorHardLinkMake,

  Path : _.uri.CloneExtending({ fileProvider : Self }),
  InoCounter : 0,

}

let filesTreeSymbol = Symbol.for( 'filesTree' );

// --
// declare
// --

let Proto =
{

  init,

  // path

  pathCurrentAct,
  pathResolveSoftLinkAct,
  pathResolveTextLinkAct,

  // read

  fileReadAct,
  dirReadAct,
  streamReadAct : null,
  statReadAct,
  fileExistsAct,

  // write

  fileWriteAct,
  fileTimeSetAct,
  _fileTimeSetAct,
  fileDeleteAct,
  dirMakeAct,
  streamWriteAct : null,

  // linking

  fileRenameAct,
  fileCopyAct,
  softLinkAct,
  hardLinkAct,

  // link

  hardLinkBreakAct,
  filesAreHardLinkedAct,

  // etc

  filesTreeSet,
  statsAdopt,
  linksRebase,
  // filesTreeRead,
  // rewriteFromProvider,
  // readToProvider,

  //

  _pathResolveIntermediateDirs,

  // descriptor read

  _descriptorRead,
  _descriptorReadResolved,

  _descriptorResolve,
  // _descriptorResolvePath,

  // _descriptorResolveHardLinkPath,
  _descriptorResolveHardLink,
  _descriptorResolveSoftLinkPath,
  _descriptorResolveSoftLink,

  _descriptorIsDir,
  _descriptorIsTerminal,
  _descriptorIsLink,
  _descriptorIsSoftLink,
  _descriptorIsHardLink,
  _descriptorIsScript,

  // descriptor write

  _descriptorWrite,

  _descriptorTimeUpdate,

  _descriptorScriptMake,
  _descriptorSoftLinkMake,
  _descriptorHardLinkMake,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Accessors,
  Statics,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.FileProvider.Find.mixin( Self );
_.FileProvider.Secondary.mixin( Self );

// --
// export
// --

_.FileProvider[ Self.shortName ] = Self;

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
