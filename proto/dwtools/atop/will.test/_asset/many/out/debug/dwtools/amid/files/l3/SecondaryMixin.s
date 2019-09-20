( function _SecondaryMixin_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = _global_.wTools;
  if( !_.FileProvider )
  require( '../UseMid.s' );

}

let _global = _global_;
let _ = _global_.wTools;
let FileRecord = _.FileRecord;
let Abstract = _.FileProvider.Abstract;
let Partial = _.FileProvider.Partial;
let Find = _.FileProvider.Find;

let fileRead = Partial.prototype.fileRead;

_.assert( _.routineIs( _.FileRecord ) );
_.assert( _.routineIs( Abstract ) );
_.assert( _.routineIs( Partial ) );
_.assert( !!Find );
_.assert( _.routineIs( fileRead ) );

//

/**
 @classdesc Mixin to add operations on group of files with very specific purpose. For example, it has a method to search for text in files.
 @class wFileProviderSecondary
 @memberof module:Tools/mid/Files.wTools.FileProvider
*/

let Parent = null;
let Self = function wFileProviderSecondary( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Secondary';

// --
// files read
// --

function filesReadOld( o )
{
  let self = this;

  /* options */

  if( _.arrayIs( o ) )
  o = { paths : o };

  if( o.preset )
  {
    _.assert( _.objectIs( filesReadOld.presets[ o.preset ] ), 'unknown preset', o.preset );
    _.mapSupplementAppending( o, filesReadOld.presets[ o.preset ] );
  }

  _.routineOptions( filesReadOld, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayIs( o.paths ) || _.objectIs( o.paths ) || _.strIs( o.paths ) );

  o.onBegin = o.onBegin ? _.arrayAs( o.onBegin ) : [];
  o.onEnd = o.onEnd ? _.arrayAs( o.onEnd ) : [];
  o.onProgress = o.onProgress ? _.arrayAs( o.onProgress ) : [];

  let onBegin = o.onBegin;
  let onEnd = o.onEnd;
  let onProgress = o.onProgress;

  delete o.onBegin;
  delete o.onEnd;
  delete o.onProgress;

  if( Config.debug )
  {
    for( let i = 0 ; i < onBegin.length ; i++ )
    _.assert( onBegin[ i ].length === 1 );
    for( let i = 0 ; i < onEnd.length ; i++ )
    _.assert( onEnd[ i ].length === 1 );
    for( let i = 0 ; i < onProgress.length ; i++ )
    _.assert( onProgress[ i ].length === 1 );
  }

  /* paths */

  if( _.objectIs( o.paths ) )
  {
    let _paths = [];
    for( let p in o.paths )
    _paths.push({ filePath : o.paths[ p ], name : p });
    o.paths = _paths;
  }

  o.paths = _.arrayAs( o.paths );

  /* result */

  let result = Object.create( null );
  result.options = o;

  /* */

  o._filesReadOldEnd = _filesReadOldEnd;
  o._optionsForFileRead = _optionsForFileRead;

  /* begin */

  _filesReadOldBegin();

  if( o.sync )
  {
    return self._filesReadOldSync( o );
  }
  else
  {
    return self._filesReadOldAsync( o );
  }

  /* - */

  function _optionsForFileRead( src )
  {
    let readOptions = _.mapOnly( o, self.fileRead.defaults );
    readOptions.onEnd = o.onEach;

    if( _.objectIs( src ) )
    {
      if( _.FileRecord && src instanceof _.FileRecord )
      readOptions.filePath = src.absolute;
      else
      _.mapExtend( readOptions, _.mapOnly( src, self.fileRead.defaults ) );
    }
    else
    readOptions.filePath = src;

    // if( o.sync )
    // readOptions.returnRead = true;

    return readOptions;
  }

  /* */

  function _filesReadOldBegin()
  {
    if( !onBegin.length )
    return;
    debugger;
    _.routinesCall( self, onBegin, [ result ] );
  }

  /* */

  function _filesReadOldEnd( errs, got )
  {
    let err;
    let errsArray = [];

    for( let k in errs )
    errsArray.push( errs[ k ] );

    if( errsArray.length )
    {
      errs.total = errsArray.length;
      err = _.err.apply( _, errsArray );
    }

    let read = got;
    // if( !o.returningRead )
    // debugger;
    if( !o.returningRead )
    read = _.entityMap( got, ( e ) => e.result );

    if( o.map === 'name' )
    {

      // let read2 = Object.create( null );
      // for( let p = 0 ; p < o.paths.length ; p++ )
      // read2[ o.paths[ p ].name ] = read[ p ];
      // read = read2;

      // let got2 = Object.create( null );
      // for( let p = 0 ; p < o.paths.length ; p++ )
      // got2[ o.paths[ p ].name ] = got[ p ];
      // got = got2;

      let read2 = Object.create( null );
      let got2 = Object.create( null );

      for( let p = 0 ; p < o.paths.length ; p++ )
      {
        let path = o.paths[ p ];
        let name;

        if( _.strIs( path ) )
        {
          name = self.path.name( path );
        }
        else if( _.objectIs( path ) )
        {
          _.assert( _.strIs( path.name ) )
          name = path.name;
        }
        else
        _.assert( 0, 'unknown type of path', _.strType( path ) );

        read2[ name ] = read[ p ];
        got2[ name ] = got[ p ];
      }

      read = read2;
      got = got2;

    }
    else if( o.map )
    _.assert( 0, 'unknown map : ' + o.map );

    // debugger;

    result.read = read;
    result.data = read;
    result.got = got;
    result.errs = errs;
    result.err = err;

    if( onEnd.length )
    {
      _.routinesCall( self, onEnd, [ result ] );
    }

    return result;
  }

}

filesReadOld.defaults =
{
  paths : null,
  onEach : null,
  map : '',
  sync : 1,
  preset : null,
}

filesReadOld.defaults.__proto__ = fileRead.defaults;

filesReadOld.presets = Object.create( null );

filesReadOld.presets.js =
{
  onEnd : function format( o )
  {
    let prefix = '// ======================================\n( function() {\n';
    let postfix = '\n})();\n';
    _.assert( _.arrayIs( o.data ) );
    if( o.data.length > 1 )
    o.data = prefix + o.data.join( postfix + prefix ) + postfix;
    else
    o.data = o.data[ 0 ];
  }
}

//

function _filesReadOldSync( o )
{
  let self = this;

  _.assert( !o.onProgress, 'not implemented' );

  let read = [];
  let errs = Object.create( null );

  let _filesReadOldEnd = o._filesReadOldEnd;
  delete o._filesReadOldEnd;

  let _optionsForFileRead = o._optionsForFileRead;
  delete o._optionsForFileRead;

  let throwing = o.throwing;
  o.throwing = 1;

  /* exec */

  for( let p = 0 ; p < o.paths.length ; p++ )
  {
    let readOptions = _optionsForFileRead( o.paths[ p ] );

    try
    {
      read[ p ] = self.fileRead( readOptions );
    }
    catch( err )
    {

      if( throwing )
      throw err;

      errs[ p ] = err;
      read[ p ] = null;
    }
  }

  /* end */

  let result = _filesReadOldEnd( errs, read );

  /* */

  return result;
}

//

function _filesReadOldAsync( o )
{
  let self = this;
  let con = new _.Consequence();

  _.assert( !o.onProgress, 'not implemented' );

  let read = [];
  let errs = [];
  let err = null;

  let _filesReadOldEnd = o._filesReadOldEnd;
  delete o._filesReadOldEnd;

  let _optionsForFileRead = o._optionsForFileRead;
  delete o._optionsForFileRead;

  /* exec */

  for( let p = 0 ; p < o.paths.length ; p++ ) ( function( p )
  {

    con.give( 1 );

    let readOptions = _optionsForFileRead( o.paths[ p ] );

    _.Consequence.From( self.fileRead( readOptions ) ).give( function filesReadOldFileEnd( _err, arg )
    {

      if( _err || arg === undefined || arg === null )
      {
        err = _.errAttend( 'Cant read : ' + _.toStr( readOptions.filePath ) + '\n', ( _err || 'unknown reason' ) );
        errs[ p ] = err;
      }
      else
      {
        read[ p ] = arg;
      }

      con.take( null );

    });

  })( p );

  /* end */

  con.take( null ).give( function filesReadOldEnd()
  {
    let result = _filesReadOldEnd( errs, read );
    con.take( o.throwing ? err : undefined , result );
  });

  /* */

  return con;
}

// --
// etc
// --

// /**
//  * @summary Returns true if file from `dst` is newer than file from `src`.
//  * @param {String} src Source path.
//  * @param {String} dst Destination path.
//  * @returns {Boolean} Returns result of comparison as boolean.
//  * @function filesAreUpToDate
//  * @memberof module:Tools/mid/Files.wFileProviderSecondary#
//  */
//
// function filesAreUpToDate( dst, src )
// {
//   let self = this;
//   let odst = dst;
//   let osrc = src;
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//
//   /* */
//
//   dst = from( dst );
//   src = from( src );
//
//   // logger.log( 'dst', dst[ 0 ] );
//   // logger.log( 'src', src[ 0 ] );
//
//   let dstMax = _.entityMax( dst, function( e ){ return e.stat ? e.stat.mtime : Infinity; } );
//   let srcMax = _.entityMax( src, function( e ){ return e.stat ? e.stat.mtime : Infinity; } );
//
//   debugger;
//   // logger.log( 'dstMax.element.stat.mtime', dstMax.element.stat.mtime );
//   // logger.log( 'srcMax.element.stat.mtime', srcMax.element.stat.mtime );
//
//   if( !dstMax.element.stat )
//   return false;
//
//   if( !srcMax.element.stat )
//   return false;
//
//   if( dstMax.element.stat.mtime >= srcMax.element.stat.mtime )
//   return true;
//   else
//   return false;
//
//   /* */
//
//   function _from( file )
//   {
//     if( _.fileStatIs( file ) )
//     return  { stat : file };
//     else if( _.strIs( file ) )
//     return { stat : self.statResolvedRead( file ) };
//     else if( !_.objectIs( file ) )
//     throw _.err( 'unknown descriptor of file' );
//   }
//
//   /* */
//
//   function from( file )
//   {
//     if( _.arrayIs( file ) )
//     {
//       let result = [];
//       for( let i = 0 ; i < file.length ; i++ )
//       result[ i ] = _from( file[ i ] );
//       return result;
//     }
//     return [ _from( file ) ];
//   }
//
// }
//
// var having = filesAreUpToDate.having = Object.create( null );
//
// having.writing = 0;
// having.reading = 1;
// having.driving = 0;

//

/**
 * Returns true if any file from o.dst is newer than other any from o.src.
 * @example :
 * wTools.filesAreUpToDate2
 * ({
 *   src : [ 'foo/file1.txt', 'foo/file2.txt' ],
 *   dst : [ 'bar/file1.txt', 'bar/file2.txt' ],
 * });
 * @param {Object} o
 * @param {string[]} o.src array of paths
 * @param {Object} [o.srcOptions]
 * @param {string[]} o.dst array of paths
 * @param {Object} [o.dstOptions]
 * @param {boolean} [o.verbosity=true] turns on/off logging
 * @returns {boolean}
 * @throws {Error} If passed object has unexpected parameter.
 * @function filesAreUpToDate2
 * @memberof module:Tools/mid/Files.wFileProviderSecondary#
 */

/*
qqq :
- add GOOD coverage for the routine filesAreUpToDate2
- make pre/body for the routine
*/

function filesAreUpToDate2_pre( routine, args )
{
  var o = args[ 0 ];

  _.assert( args.length === 1, 'Expects single argument' )
  _.assert( arguments.length === 2 );
  _.assert( !o.newer || _.dateIs( o.newer ) );

  _.routineOptions( routine, o );

  return o;
}

function filesAreUpToDate2_body( o )
{
  let self = this;
  let factory = self.recordFactory({ allowingMissed : 1 });

  // _.assert( arguments.length === 1, 'Expects single argument' );
  // _.assert( !o.newer || _.dateIs( o.newer ) );
  // _.routineOptions( filesAreUpToDate2, o );

  // debugger;
  // let srcFiles = self.recordFactory().recordsFiltered( o.src );
  let srcFiles = factory.records( _.arrayAs( o.src ) );

  if( !srcFiles.length )
  {
    if( o.verbosity )
    logger.log( 'No source' );
    return true;
  }

  /*
    stat could have no mtime
  */

  let srcNewest = _.entityMax( srcFiles, function( file )
  {
    if( !file.stat )
    return +Infinity;
    if( !file.stat.mtime )
    return +Infinity;
    return file.stat.mtime.getTime();
  }).value;

  /* */

  // let dstFiles = self.recordFactory().recordsFiltered( o.dst );
  let dstFiles = factory.records( _.arrayAs( o.dst ) );
  if( !dstFiles.length )
  {
    if( o.verbosity )
    logger.log( 'No destination' );
    return false;
  }

  // let dstOldest = _.entityMin( dstFiles, function( file ) { return file.stat.mtime.getTime() } ).element;
  let dstOldest = _.entityMin( dstFiles, function( file )
  {
    // debugger;
    if( !file.stat )
    return -Infinity;
    if( !file.stat.mtime )
    return -Infinity;
    return file.stat.mtime.getTime();
  }).value;

  /* */

  if( o.youngerThan )
  {
    if( o.youngerThan.getTime() >= dstOldest )
    {
      if( o.verbosity )
      logger.log( 'Younger' );
      return true;
    }
    else
    {
      if( o.verbosity )
      logger.log( 'Older' );
      return false;
    }
  }
  else
  {
    if( srcNewest <= dstOldest )
    {
      if( o.verbosity )
      logger.log( 'Up to date' );
      return true;
    }
    else
    {
      if( o.verbosity )
      logger.log( 'Outdated' );
      return false;
    }
  }

}

filesAreUpToDate2_body.defaults =
{
  src : null,
  dst : null,
  verbosity : 0,
  youngerThan : null,
  // notOlder : null,
}

var having = filesAreUpToDate2_body.having = Object.create( null );

having.writing = 0;
having.reading = 1;
having.driving = 0;

var filesAreUpToDate2 = _.routineFromPreAndBody( filesAreUpToDate2_pre, filesAreUpToDate2_body );

//

/**
 * @summary Calculates date resolution time in milliseconds for current file system.
 * @function systemBitrateTimeGet
 * @memberof module:Tools/mid/Files.wFileProviderSecondary#
 */

function systemBitrateTimeGet()
{
  let self = this;

  let result = 10;

  if( _.FileProvider.HardDrive && self instanceof _.FileProvider.HardDrive )
  {
    // let testDir = self.path.dirTempAtOpen( self.path.join( __dirname, '../../..'  ), 'SecondaryMixin' );
    let testDir = self.path.pathDirTempOpen( self.path.join( __dirname, '../../..'  ), 'SecondaryMixin' );
    let tempFile = self.path.join( testDir, 'systemBitrateTimeGet' );
    self.fileWrite( tempFile, tempFile );
    let ostat = self.statResolvedRead( tempFile );
    let mtime = new Date( ostat.mtime.getTime() );
    let ms = 500;
    mtime.setMilliseconds( ms );
    try
    {
      self.fileTimeSet( tempFile, ostat.atime, mtime );
      let stat = self.statResolvedRead( tempFile );
      let diff = mtime.getTime() - stat.mtime.getTime();
      if( diff )
      {
        debugger
        result  = ( diff / 1000 ).toFixed() * 1000;
        _.assert( !!result );
      }
    }
    catch( err )
    {
      throw _.err( err );
    }
    finally
    {
      self.filesDelete( testDir );
      let statDir = self.statResolvedRead( testDir );
      _.assert( !statDir );
    }
  }

  return result;
}

systemBitrateTimeGet.defaults =
{
}

var having = systemBitrateTimeGet.having = Object.create( null );

having.writing = 1;
having.reading = 0;
having.driving = 1;

// --
// top
// --

function filesSearchText( o )
{
  let self = this;
  let result = [];

  _.routineOptions( filesSearchText, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  o.ins = _.arrayAs( o.ins );
  o.ins = _.regexpsMaybeFrom
  ({
    srcStr : o.ins,
    stringWithRegexp : o.stringWithRegexp,
    toleratingSpaces : o.toleratingSpaces,
  });

  let o2 = _.mapOnly( o, self.filesFind.defaults );

  o2.onUp = _.arrayAppendElement( o2.onUp, handleUp );

  let records = self.filesFind( o2 );

  return result;

  /* */

  function handleUp( record )
  {
    let read = record.factory.effectiveProvider.fileRead( record.absolute );

    let o2 = _.mapOnly( o, _.strSearch.defaults );
    o2.src = read;
    o2.stringWithRegexp = 0;
    o2.toleratingSpaces = 0;

    let matches = _.strSearch( o2 );

    for( let m = 0 ; m < matches.length ; m++ )
    {
      let match = matches[ m ];
      match.file = record;
      result.push( match );
    }

    return false;
  }

}

_.routineExtend( filesSearchText, Find.prototype.filesFind );

// var defaults = filesSearchText.defaults = Object.create( Find.prototype.filesFind.defaults );

var defaults = filesSearchText.defaults;

_.mapSupplement( defaults, _.mapBut( _.strSearch.defaults, { src : null } ) );

defaults.determiningLineNumber = 1;

// defaults.ins = null;
// defaults.stringWithRegexp = 0;
// defaults.toleratingSpaces = 0;
// defaults.determiningLineNumber = 1;

// var having = filesSearchText.having = Object.create( Find.prototype.filesFind.having );
//
// having.writing = 0;
// having.reading = 1;
// having.driving = 0;

// --
// read
// --

function fileConfigRead2( o )
{

  let self = this;
  o = o || Object.create( null );

  if( _.strIs( o ) )
  {
    o = { name : o };
  }

  if( o.dir === undefined )
  o.dir = self.path.normalize( self.path.effectiveMainDir() );

  if( o.result === undefined )
  o.result = Object.create( null );

  _.routineOptions( fileConfigRead2, o );

  if( !o.name )
  {
    o.name = 'config';
    self._fileConfigRead2( o );
    o.name = 'public';
    self._fileConfigRead2( o );
    o.name = 'private';
    self._fileConfigRead2( o );
  }
  else
  {
    self._fileConfigRead2( o );
  }

  return o.result;
}

fileConfigRead2.defaults =
{
  name : null,
  dir : null,
  result : null,
}

var having = fileConfigRead2.having = Object.create( null );

having.writing = 0;
having.reading = 1;
having.driving = 0;

//

function _fileConfigRead2( o )
{
  let self = this;
  let read;

  // _.include( 'wAppBasic' );

  if( o.name === undefined )
  o.name = 'config';

  let terminal = self.path.join( o.dir, o.name );

  /**/

  if( typeof Coffee !== 'undefined' )
  {
    let fileName = terminal + '.coffee';
    if( self.statResolvedRead( fileName ) )
    {

      read = self.fileReadSync( fileName );
      read = Coffee.eval( read,
      {
        filename : fileName,
      });
      _.mapExtend( o.result, read );

    }
  }

  /**/

  let fileName = terminal + '.json';
  if( self.statResolvedRead( fileName ) )
  {

    read = self.fileReadSync( fileName );
    read = JSON.parse( read );
    _.mapExtend( o.result, read );

  }

  /**/

  fileName = terminal + '.s';
  if( self.statResolvedRead( fileName ) )
  {

    debugger;
    read = self.fileReadSync( fileName );
    read = _.exec( read );
    _.mapExtend( o.result, read );

  }

  return o.result;
}

_fileConfigRead2.defaults = fileConfigRead2.defaults;

//

/**
 * @description Finds config files that have name of files from `o.filePath`.
 * Mixes name of files from `o.filePath` with different extensions to find config files that can be read by availbale read encoders.
 * Returns results as array or map.
 * @param {Object} o Options map.
 * @param {Array|String} o.filePath Source paths.
 * @param {String} o.outputFormat='array', Possible formats: array, map.
 * @function fileConfigFind
 * @memberof module:Tools/mid/Files.wFileProviderSecondary#
 */

/*
qqq : cover fileConfigFind
*/

function fileConfigFind_body( o )
{
  let self = this;
  let path = self.path;
  let result = o.outputFormat === 'array' ? [] : Object.create( null );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayHas( [ 'array', 'map' ], o.outputFormat ) );

  let exts = Object.create( null );

  for( let e in fileRead.encoders )
  {
    let encoder = fileRead.encoders[ e ];
    if( encoder === null )
    continue;
    _.assert( _.objectIs( encoder ), 'Read encoder', e, 'is missing' );
    if( encoder.exts )
    for( let s = 0 ; s < encoder.exts.length ; s++ )
    exts[ encoder.exts[ s ] ] = e;
  }

  o.filePath = _.arrayAs( o.filePath );
  _.assert( _.strsAreAll( o.filePath ) );

  /* */

  _.each( exts, ( encoderName, ext ) =>
  {
    _.each( o.filePath, ( filePath ) =>
    {
      _.assert( _.strIs( ext ) );
      _.assert( _.strIs( filePath ) );
      let filePath2 = _.strAppendOnce( filePath, '.' + ext );
      if( self.statRead( filePath2 ) )
      {
        let element =
        {
          particularPath : filePath2,
          abstractPath : filePath,
          encoding : exts[ ext ],
          ext : ext,
        }
        if( o.outputFormat === 'array' )
        {
          result.push( element );
        }
        else
        {
          _.sure( result[ filePath ] === undefined, () => 'Several configs exists for ' + _.strQuote( filePath ) );
          result[ filePath ] = element;
        }
      }
    });
  });

  /* */

  return result;
}

var defaults = fileConfigFind_body.defaults = Object.create( null );
defaults.filePath = null;
defaults.outputFormat = 'array';
// defaults.recursive = 1;

let fileConfigFind = _.routineFromPreAndBody( Partial.prototype._preFilePathVectorWithProviderDefaults, fileConfigFind_body );

//

// function _fileRead_pre( routine, args )
// {
//   let self = this;
//
//   _.assert( arguments.length === 2, 'Expects exactly two arguments' );
//   _.assert( args && args.length === 1 );
//
//   let o = args[ 0 ];
//
//   if( self.path.like( o ) )
//   o = { filePath : self.path.from( o ) };
//
//   _.routineOptions( routine, o );
//
//   o.filePath = self.path.normalize( o.filePath );
//
//   _.assert( self.path.isAbsolute( o.filePath ), 'Expects absolute path {-o.filePath-}, but got', o.filePath );
//
//   if( o.verbosity === null )
//   o.verbosity = _.numberClamp( self.verbosity - 4, 0, 9 );
//
//   self._providerDefaultsApply( o );
//
//   return o;
// }

//

/*
qqq : add test
*/

/**
 * @summary Read config files one by one and extends result with fields from each config file.
 * @description Finds config files if they were not provided through option `o.found`.
 * @param {Object} o Options map.
 * @param {Array|String} o.filePath Source paths.
 * @param {Array|Object} o.found Container to store found config files.
 * @param {String} o.many='all' Checks if each of files `o.filePath` have at least one config file.
 * @function fileConfigRead
 * @memberof module:Tools/mid/Files.wFileProviderSecondary#
 */

function fileConfigRead_body( o )
{
  let self = this;
  let result = null;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayHas( [ 'all', 'any' ], o.many ) );

  if( !o.found )
  o.found = self.fileConfigFind({ filePath : o.filePath });

  /* */

  if( o.many === 'all' )
  {
    let filePath = _.arrayAs( o.filePath ).slice();
    let found = o.found.slice();

    for( let f1 = filePath.length-1 ; f1 >= 0 ; f1-- )
    {
      let filePath1 = filePath[ f1 ];
      for( let f2 = found.length-1 ; f2 >= 0 ; f2-- )
      if( found[ f2 ].abstractPath === filePath1 || found[ f2 ].particularPath === filePath1 )
      {
        filePath.splice( f1, 1 );
        found.splice( f2, 1 );
        continue;
      }
    }

    for( let f1 = filePath.length-1 ; f1 >= 0 ; f1-- )
    {
      let filePath1 = filePath[ f1 ];
      debugger;
      throw _.err( 'None config was found\n', _.strQuote( filePath1 ) );
    }

    for( let f2 = found.length-1 ; f2 >= 0 ; f2-- )
    {
      debugger;
      throw _.err( 'Some configs were loaded several times\n', _.strQuote( found[ f2 ].particularPath ) );
    }

  }

  /* */

  if( o.found && o.found.length )
  {

    for( let f = 0 ; f < o.found.length ; f++ )
    {
      let file = o.found[ f ];

      let o2 = _.mapExtend( null, o );
      o2.filePath = file.particularPath;
      o2.encoding = file.encoding;
      // if( o2.verbosity >= 2 )
      // o2.verbosity = 5;
      delete o2.many;
      delete o2.found;

      let read = self.fileRead( o2 );

      if( read === undefined )
      read = Object.create( null );

      _.sure( _.mapIs( read ), () => 'Expects map, but read ' + _.toStrShort( result ) + ' from ' + o2.filePath );

      if( result === null )
      result = read;
      else
      result = _.mapExtendRecursive( result, read );

    }

  }

  /* */

  if( result === null || result === undefined )
  {
    debugger;
    if( o.throwing )
    throw _.err( 'Found no config at', () => o.filePath + '.*' );
    result = null;
  }

  /* */

  return result;
}

_.routineExtend( fileConfigRead_body, fileRead );

var defaults = fileConfigRead_body.defaults;

defaults.encoding = null;
defaults.many = 'all';
defaults.found = null;

//

var fileConfigRead = _.routineFromPreAndBody( Partial.prototype._preFilePathVectorWithProviderDefaults, fileConfigRead_body );

fileConfigRead.having.aspect = 'entry';

//

/**
 * @summary Read source code from provided file `o.filePath` and wraps it with self enclosed function of name `o.name`.
 * @param {Object} o Options map.
 * @param {String} o.filePath Source path.
 * @param {String} o.encoding='utf8' Encoding used in file reading.
 * @param {Boolean} o.wrapping=1 Adds custom `o.prefix` and `o.postfix` to source code.
 * @param {Boolean} o.routine=0 Creates routine from result string.
 * @param {String} o.name Name for self enclosed function.
 * @param {String} o.prefix Inserts this string before source code.
 * @param {String} o.postfix Inserts this string after source code.
 * @function fileCodeRead
 * @memberof module:Tools/mid/Files.wFileProviderSecondary#
 */

function fileCodeRead_body( o )
{
  let self = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( o.sync, 'not implemented' );

  let o2 = _.mapOnly( o, self.fileRead.defaults );
  let result = self.fileRead( o2 );

  if( o.name === null )
  o.name = _.strVarNameFor( self.path.fullName( o.filePath ) );

  if( o.wrapping )
  {

    if( _.TemplateTreeResolver )
    {
      let resolver = _.TemplateTreeResolver({ tree : o });
      o.prefix = resolver.resolve( o.prefix );
      o.postfix = resolver.resolve( o.postfix );
    }

    result = o.prefix + result + o.postfix;

  }

  if( o.routine )
  {
    result = _.routineMake({ code : result, name : o.name });
  }

  return result;
}

var defaults = fileCodeRead_body.defaults = Object.create( fileRead.defaults );

defaults.encoding = 'utf8';
defaults.wrapping = 1;
defaults.routine = 0;
defaults.name = null;
defaults.prefix = '// ======================================\n( function {{name}}() {\n';
defaults.postfix = '\n})();\n';

// var paths = fileCodeRead_body.paths = Object.create( fileRead.paths );
// var having = fileCodeRead_body.having = Object.create( fileRead.having );

_.routineExtend( fileCodeRead_body, fileRead );

//

var fileCodeRead = _.routineFromPreAndBody( fileRead.pre, fileCodeRead_body );

fileCodeRead.having.aspect = 'entry';

// --
// relationship
// --

let Composes =
{
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

// --
// declare
// --

let Supplement =
{

  // files read

  filesReadOld,
  _filesReadOldAsync,
  _filesReadOldSync,

  // etc

  // filesAreUpToDate,
  filesAreUpToDate2,

  filesSearchText,

  systemBitrateTimeGet,

  // read

  fileConfigRead2,
  _fileConfigRead2,

  fileConfigFind,
  fileConfigRead,

  fileCodeRead,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,

}

//

_.classDeclare
({
  cls : Self,
  supplement : Supplement,
  withMixin : true,
  withClass : true,
});

_.FileProvider = _.FileProvider || Object.create( null );
_.FileProvider[ Self.shortName ] = Self;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
