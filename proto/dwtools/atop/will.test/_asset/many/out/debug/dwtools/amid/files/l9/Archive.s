( function _FilesArchive_s_() {

'use strict';

/**
 * Experimental. Several classes to reflect changes of files on dependent files and keep links of hard linked files. FilesArchive provides means to define interdependence between files and to forward changes from dependencies to dependents. Use FilesArchive to avoid unnecessary CPU workload.
  @module Tools/mid/FilesArchive
*/

/**
 * @file files/FilesArchive.s.
 */

//

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wFilesArchive( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'FilesArchive';

//

function init( o )
{
  let archive = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( archive );
  Object.preventExtensions( archive )

  if( o )
  {
    if( o.fileProvider )
    archive.fileProvider = o.fileProvider;
    archive.copy( o );
  }

  if( archive.fileProvider && archive.fileProvider.safe >= 2 )
  archive.fileProvider.safe = 1;

}

//

function filesUpdate()
{
  let archive = this;
  let fileProvider = archive.fileProvider;
  let time = _.timeNow();

  let fileMapOld = archive.fileMap;
  archive.fileAddedMap = Object.create( null );
  archive.fileRemovedMap = null;
  archive.fileModifiedMap = Object.create( null );
  archive.hashReadMap = null;

  _.assert( _.strDefined( archive.basePath ) || _.strsDefined( archive.basePath ) );

  let filePath = _.strJoin([ archive.basePath, '/**' ]);
  if( archive.verbosity >= 3 )
  logger.log( ' : filesUpdate', filePath );

  /* */

  let fileMapNew = Object.create( null );

  /* */

  debugger;
  archive.mask = _.RegexpObject( archive.mask );

  let files = [];
  let found = fileProvider.filesFind
  ({
    filePath,
    filter :
    {
      maskAll : archive.mask,
      maskTransientAll : archive.mask,
    },
    onUp : onFile,
    includingTerminals : 1,
    includingDirs : 1,
    withStem/*maybe withTransient*/ : 0,
    resolvingSoftLink : 1,
    recursive : 2,
  });

  archive.fileRemovedMap = fileMapOld;
  archive.fileMap = fileMapNew;

  // debugger;
  if( archive.fileMapAutosaving ) /* xxx */
  archive.storageSave();

  if( archive.verbosity >= 8 )
  {
    logger.log( 'fileAddedMap',archive.fileAddedMap );
    logger.log( 'fileRemovedMap',archive.fileRemovedMap );
    logger.log( 'fileModifiedMap',archive.fileModifiedMap );
  }
  else if( archive.verbosity >= 6 )
  {
    logger.log( 'fileAddedMap', _.entityLength( archive.fileAddedMap ) );
    logger.log( 'fileRemovedMap', _.entityLength( archive.fileRemovedMap ) );
    logger.log( 'fileModifiedMap', _.entityLength( archive.fileModifiedMap ) );
  }

  if( archive.verbosity >= 4 )
  {
    logger.log( ' . filesUpdate', filePath, 'found', _.entityLength( fileMapNew ),'file(s)', _.timeSpent( 'in ',time ) );
  }

  return archive;

  /* */

  function onFile( fileRecord, op )
  {
    let d = null;
    let isDir = fileRecord.stat.isDir();

    if( isDir )
    if( archive.fileMapAutoLoading )
    {
      let loaded = archive._storageFilesRead( fileRecord.absolute );
      let storagageFilePath = archive.storageFileFromDirPath( fileRecord.absolute );
      let storage = loaded[ storagageFilePath ].storage;
      if( storage && fileRecord.isStem )
      archive.storageLoaded({ storageFilePath : storagageFilePath, storage });
    }

    if( archive.verbosity >= 7 )
    logger.log( ' . investigating ' + fileRecord.absolute );

    if( fileMapOld[ fileRecord.absolute ] )
    {
      d = _.mapExtend( null,fileMapOld[ fileRecord.absolute ] );
      files.push( d );
      delete fileMapOld[ fileRecord.absolute ];
      let same = true;
      same = same && d.mtime === fileRecord.stat.mtime.getTime();
      same = same && d.birthtime === fileRecord.stat.birthtime.getTime();
      same = same && ( isDir || d.size === fileRecord.stat.size );
      if( same && archive.comparingRelyOnHardLinks && !isDir )
      {
        if( d.nlink === 1 )
        debugger;
        same = d.nlink === fileRecord.stat.nlink;
      }

      if( same )
      {
        fileMapNew[ d.absolutePath ] = d;
        return fileRecord;
        // return d;
      }
      else
      {
        if( archive.verbosity >= 5 )
        logger.log( ' . change ' + fileRecord.absolute );
        archive.fileModifiedMap[ fileRecord.absolute ] = d;
        d = _.mapExtend( null,d );
      }
    }
    else
    {
      d = Object.create( null );
      archive.fileAddedMap[ fileRecord.absolute ] = d;
      files.push( d );
    }

    d.mtime = fileRecord.stat.mtime.getTime();
    d.ctime = fileRecord.stat.ctime.getTime();
    d.birthtime = fileRecord.stat.birthtime.getTime();
    d.absolutePath = fileRecord.absolute;
    if( !isDir )
    {
      d.size = fileRecord.stat.size;
      if( archive.maxSize === null || fileRecord.stat.size <= archive.maxSize )
      d.hash = fileProvider.hashRead({ filePath : fileRecord.absolute, throwing : 0, sync : 1 });
      d.hash2 = _.statHash2Get( fileRecord.stat );
      d.nlink = fileRecord.stat.nlink;
    }

    fileMapNew[ d.absolutePath ] = d;
    // return d;

    return fileRecord;
  }

}

//

function filesHashMapForm()
{
  let archive = this;

  _.assert( !archive.hashReadMap );

  archive.hashReadMap = Object.create( null );

  for( let f in archive.fileMap )
  {
    let file = archive.fileMap[ f ];
    if( file.hash )
    if( archive.hashReadMap[ file.hash ] )
    archive.hashReadMap[ file.hash ].push( file.absolutePath );
    else
    archive.hashReadMap[ file.hash ] = [ file.absolutePath ];
  }

  return archive.hashReadMap;
}

//

function filesLinkSame( o )
{
  let archive = this;
  let provider = archive.fileProvider;
  let hashReadMap = archive.filesHashMapForm();
  o = _.routineOptions( filesLinkSame,arguments );

  for( let f in hashReadMap )
  {
    let files = hashReadMap[ f ];

    if( files.length < 2 )
    continue;

    if( o.consideringFileName )
    {
      let byName = {};
      debugger;
      _.entityFilter( files,function( path )
      {
        let name = _.path.fullName( path );
        if( byName[ name ] )
        byName[ name ].push( path );
        else
        byName[ name ] = [ path ];
      });
      for( let name in byName )
      provider.hardLink({ dstPath : byName[ name ], verbosity : archive.verbosity });
    }
    else
    {
      // console.log( 'archive.verbosity',archive.verbosity );
      provider.hardLink({ dstPath : files, verbosity : archive.verbosity });
    }

  }

  return archive;
}

filesLinkSame.defaults =
{
  consideringFileName : 0,
}

//

function restoreLinksBegin()
{
  let archive = this;
  let provider = archive.fileProvider;

  archive.filesUpdate();

}

//

function restoreLinksEnd()
{
  let archive = this;
  let provider = archive.fileProvider;
  let fileMap1 = _.mapExtend( null, archive.fileMap );
  let hashReadMap = archive.filesHashMapForm();
  let restored = 0;

  archive.filesUpdate();

  _.assert( !!archive.fileMap,'restoreLinksBegin should be called before calling restoreLinksEnd' );

  let fileMap2 = _.mapExtend( null,archive.fileMap );
  let fileModifiedMap = archive.fileModifiedMap;
  let linkedMap = Object.create( null );

  /* */

  for( let f in fileModifiedMap )
  {
    let modified = fileModifiedMap[ f ];
    let filesWithHash = hashReadMap[ modified.hash ];

    if( linkedMap[ f ] )
    continue;

    if( !modified.hash )
    continue;

    if( modified.hash === undefined )
    continue;

    /* remove removed files and use old file descriptors */

    filesWithHash = _.entityFilter( filesWithHash,( e ) => fileMap2[ e ] ? fileMap2[ e ] : undefined );

    /* find newest file */

    if( archive.replacingByNewest )
    filesWithHash.sort( ( e1,e2 ) => e2.mtime-e1.mtime );
    else
    filesWithHash.sort( ( e1,e2 ) => e1.mtime-e2.mtime );

    let newest = filesWithHash[ 0 ];
    let mostLinked = _.entityMax( filesWithHash,( e ) => e.nlink ).element;

    if( mostLinked.absolutePath !== newest.absolutePath )
    {
      let read = provider.fileRead({ filePath : newest.absolutePath, encoding : 'original.type' });
      provider.fileWrite( mostLinked.absolutePath,read );
    }

    /* use old file descriptors */

    filesWithHash = _.entityFilter( filesWithHash,( e ) => fileMap1[ e.absolutePath ] );
    mostLinked = fileMap1[ mostLinked.absolutePath ];

    /* verbosity */

    if( archive.verbosity >= 4 )
    logger.log( 'modified',_.toStr( _.select( filesWithHash,'*/absolutePath' ),{ levels : 2 } ) );

    /*  */

    let srcPath = mostLinked.absolutePath;
    let srcFile = mostLinked;
    linkedMap[ srcPath ] = srcFile;
    for( let last = 0 ; last < filesWithHash.length ; last++ )
    {
      let dstPath = filesWithHash[ last ].absolutePath;
      if( srcFile.absolutePath === dstPath )
      continue;
      if( linkedMap[ dstPath ] )
      continue;
      let dstFile = filesWithHash[ last ];
      /* if this files where linked before changes, relink them */
      _.assert( !!srcFile.hash2 ); debugger;
      _.assert( !!srcFile.size >= 0 );
      _.assert( !!dstFile.size >= 0 );
      if( srcFile.hash2 && srcFile.hash2 === dstFile.hash2 && srcFile.size > 0 )
      {
        debugger;
        _.assert( dstFile.size === srcFile.size );
        restored += 1;
        provider.hardLink({ dstPath, srcPath, verbosity : archive.verbosity });
        linkedMap[ dstPath ] = filesWithHash[ last ];
      }
    }

  }

  if( archive.verbosity >= 1 )
  logger.log( '+ Restored',restored,'links' );
}

//

function _loggerGet()
{
  let self = this;
  let fileProvider = self.fileProvider;
  if( fileProvider )
  return fileProvider.logger;
  return null;
}

// --
// storage
// --

function storageFilePathToSaveGet( storageDirPath )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let storageFilePath = null;

  _.assert( arguments.length === 0 || arguments.length === 1 ); debugger;

  storageFilePath = _.select( self.storagesLoaded, '*/filePath' );

  if( !storageFilePath.length )
  storageFilePath = fileProvider.path.s.join( self.basePath, self.storageFileName );

  _.sure
  (
    _.all( storageFilePath, ( storageFilePath ) => _.fileProvider.isDir( _.fileProvider.path.dir( storageFilePath ) ) ),
    () => 'Directory for storage file does not exist ' + _.strQuote( storageFilePath )
  );

  return storageFilePath;
}

//

function storageToSave( o )
{
  let self = this;

  o = _.routineOptions( storageToSave, arguments );

  let storage = self.fileMap;

  if( o.splitting )
  {
    let storageDirPath = _.path.dir( o.storageFilePath );
    let fileMap = self.fileMap;
    storage = Object.create( null );
    for( let m in fileMap )
    {
      if( _.strBegins( m, storageDirPath ) )
      storage[ m ] = fileMap[ m ];
    }
  }

  return storage;
}

storageToSave.defaults =
{
  storageFilePath : null,
  splitting : 1,
}

//

function storageLoaded( o )
{
  let self = this;
  let fileProvider = self.fileProvider;

  _.sure( self.storageIs( o.storage ), () => 'Strange storage : ' + _.toStrShort( o.storage ) );
  _.assert( arguments.length === 1, 'Expects exactly two arguments' );
  _.assert( _.strIs( o.storageFilePath ) );

  if( self.storagesLoaded !== undefined )
  {
    _.assert( _.arrayIs( self.storagesLoaded ), () => 'Expects {-self.storagesLoaded-}, but got ' + _.strType( self.storagesLoaded ) );
    self.storagesLoaded.push({ filePath : o.storageFilePath });
  }

  _.mapExtend( self.fileMap, o.storage );

  return true;
}

// --
// vars
// --

let verbositySymbol = Symbol.for( 'verbosity' );
let mask =
{
  excludeAny :
  [
    /(\W|^)node_modules(\W|$)/,
    /\.unique$/,
    /\.git$/,
    /\.svn$/,
    /\.hg$/,
    /\.DS_Store$/,
    /\.tmp($|\/|\.)/,
    /\.big($|\/|\.)/,
    // /(^|\/)\.(?!$|\/)/,
    /(^|\/)\-(?!$|\/)/,
  ],
};

// --
// relations
// --

let Composes =
{
  verbosity : 0,

  basePath : null,

  comparingRelyOnHardLinks : 0,
  replacingByNewest : 1,
  maxSize : null,

  // fileByHashMap : _.define.own( {} ),
  fileMap : _.define.own( {} ),
  fileAddedMap : _.define.own( {} ),
  fileRemovedMap : _.define.own( {} ),
  fileModifiedMap : _.define.own( {} ),
  hashReadMap : null,

  fileMapAutosaving : 0,
  fileMapAutoLoading : 1,

  mask : _.define.own( mask ), /* !!! not shallow clone required */

  storageFileName : '.warchive',
  storageSaveAsJs : true

}

let Aggregates =
{
}

let Associates =
{
  fileProvider : null,
}

let Restricts =
{
  storagesLoaded : _.define.own([]),
}

let Statics =
{
}

let Forbids =
{
  dependencyMap : 'dependencyMap',
}

let Accessors =
{
  logger : { readOnly : 1 },
}

// --
// declare
// --

let Proto =
{

  init,

  filesUpdate,
  filesHashMapForm,
  filesLinkSame,

  restoreLinksBegin,
  restoreLinksEnd,

  _loggerGet,

  // storage

  storageFilePathToSaveGet,
  storageToSave,
  storageLoaded,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

_.Copyable.mixin( Self );
_.StateStorage.mixin( Self );
_.Verbal.mixin( Self );
_global_[ Self.name ] = _[ Self.shortName ] = Self;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
