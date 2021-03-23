( function _Namespace_s_()
{

'use strict';

// --
// relations
// --

let _ = _global_.wTools;
let Parent = null;
let Self = _.Will;

//

function WillfilesFindAtDir( o )
{
  if( _.strIs( o ) )
  o = { filePath : o };

  let fileProvider = o.fileProvider = o.fileProvider || _.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.routineOptions( WillfilesFindAtDir, o );
  _.assert( !path.isGlob( o.filePath ), 'Expects no glob in {-o.filePath-}' );
  _.assert( !path.isGlobal( o.filePath ), 'Expects local path {-o.filePath-}' );
  _.assert( o.withIn || o.withOut, 'Routine searches in and out willfiles. Please, define option {-o.withIn-} or {-o.withOut-}' );

  if( o.filePath === '.' )
  o.filePath = './';
  o.filePath = path.normalize( o.filePath );
  o.filePath = path.resolve( o.filePath );

  if( fileProvider.isTerminal( o.filePath ) )
  {
    _.assert( _.Will.WillfilePathIs( o.filePath ), 'Expects path to willfile' );
    return [ fileProvider.record( o.filePath ) ];
  }

  let namePrefix = '';
  if( _.strEnds( o.filePath, path.upToken ) )
  if( o.withAllNamed )
  namePrefix = '*';

  return _willfilesFindAtDir( o.filePath );

  /* */

  function _willfilesFindAtDir( filePath )
  {

    if( !path.isSafe( filePath, 1 ) )
    return [];

    let o2 = _.mapExtend( null, o );
    o2.filePath += namePrefix;
    o2.recursive = 1;
    let files = _WillfilesFindTerminalsWithGlob( o2 );

    let files2 = [];
    files.forEach( ( file ) =>
    {
      if( _.Will.PathIsOut( file.absolute ) )
      files2.push( file );
    });
    files.forEach( ( file ) =>
    {
      if( !_.Will.PathIsOut( file.absolute ) )
      files2.push( file );
    });

    return files2;
  }
}

WillfilesFindAtDir.defaults =
{
  filePath : null,
  withIn : 1,
  withOut : 1,
  withAllNamed : 0,
  exact : 0,
  fileProvider : null,
};

//

function WillfilesFindWithGlob( o )
{

  if( _.strIs( o ) )
  o = { filePath : o };

  _.assert( arguments.length === 1 );
  _.routineOptions( WillfilesFindWithGlob, o );
  _.assert( o.withIn || o.withOut, 'Routine searches in and out willfiles. Please, define option {-o.withIn-} or {-o.withOut-}' );

  o = _.mapExtend( null, o );

  let fileProvider = o.fileProvider = o.fileProvider || _.fileProvider;
  let path = fileProvider.path;
  let recursive = o.recursive;
  let tracing = o.tracing;
  let excludingUnderscore = o.excludingUnderscore;
  _.mapBut_( o, o, { recursive : null, tracing : null, excludingUnderscore : null } );

  if( o.filePath === '.' )
  o.filePath = './';
  o.filePath = path.normalize( o.filePath );
  o.filePath = path.resolve( o.filePath );

  if( recursive === 0 )
  {
    _.assert( _.Will.WillfilePathIs( o.filePath ) );
    return [ fileProvider.record( o.filePath ) ];
  }

  let filePathIsGlob = path.isGlob( o.filePath );

  if( filePathIsGlob )
  {
    _.assert( !path.isGlobal( path.fromGlob( o.filePath ) ), 'Expects local path' );
    return willfilesFindRecursively( o );
  }
  else
  {
    if( recursive === 2 )
    {
      o.filePath += '**';
      return willfilesFindRecursively( o );
    }
    return _.Will.WillfilesFindAtDir( o )
  }

  /* */

  function willfilesFindRecursively( o )
  {
    if( !path.isSafe( o.filePath, 1 ) )
    return [];

    let filter =
    {
      filePath : o.filePath,
      maskDirectory : {},
      maskTransientDirectory : {},
    };

    if( !path.isGlob( o.filePath ) )
    filter.recursive = recursive;

    if( excludingUnderscore && path.isGlob( o.filePath ) )
    {
      filter.maskDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
      filter.maskTransientDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
    }

    /* */

    let terminals = _WillfilesFindTerminalsWithGlob( o );
    let globGetsAllNames = _.strBegins( path.name( o.filePath ), [ '?', '*' ] );
    let onRecord = ( record ) =>
    {
      record = path.globShortFilter({ src : record, selector : o.filePath, onEvaluate : ( el ) => el.absolute });
      if( record && globGetsAllNames && !o.withAllNamed )
      record = _.longHas( [ 'will', '.will', '.im.will', '.ex.will', '.out.will' ], record.name ) ? record : undefined;
      return record === null ? undefined : record;
    };
    _.filter_( terminals, terminals, onRecord );

    if( recursive < 2 )
    if( !_.strHas( o.filePath, '**' ) )
    if( !path.isGlob( path.dir( o.filePath ) ) )
    return terminals;

    let o2 =
    {
      filter,
      withTerminals : 0,
      withDirs : 1,
      maskPreset : 0,
      mandatory : 0,
      safe : 0,
      mode : 'distinct',
      outputFormat : 'absolute',
    };
    let dirs = fileProvider.filesFind( o2 );

    /* */

    let result = terminals;
    for( let i = 0; i < dirs.length; i++ )
    {
      o.filePath = path.join( dirs[ i ], './' );
      let records = _.Will.WillfilesFindAtDir( o );
      _.arrayAppendArray( result, records );
    }

    result = _.arrayRemoveDuplicates( result, ( e1, e2 ) => e1.absolute === e2.absolute );

    return result;
  }
}

WillfilesFindWithGlob.defaults =
{
  filePath : null,
  withIn : 1,
  withOut : 1,
  withAllNamed : 0,
  excludingUnderscore : 0,
  exact : 0,
  fileProvider : null,
  recursive : 1,
};

//

function _WillfilesFindTerminalsWithGlob( o )
{
  let filter =
   {
     maskTerminal :
     {
      includeAny : /(\.|((^|\.|\/)will(\.[^.]*)?))$/,
      excludeAny :
      [
        /\.DS_Store$/,
        /(^|\/)-/,
      ],
      includeAll : []
    },
    recursive : o.recursive >= 0 ? o.recursive : 1,
  };

  if( !o.withIn )
  filter.maskTerminal.includeAll.push( /(^|\.|\/)out(\.)/ )
  if( !o.withOut )
  filter.maskTerminal.excludeAny.push( /(^|\.|\/)out(\.)/ )

  let hasExt = /(^|\.|\/)will\.[^\.\/]+$/.test( o.filePath );
  let hasWill = /(^|\.|\/)will(\.)?[^\.\/]*$/.test( o.filePath );

  let postfix = '?(.)';
  if( !hasWill )
  {
    postfix += '?(im.|ex.)';

    if( !o.exact )
    if( o.withOut && o.withIn )
    postfix += '?(out.)';
    else if( o.withIn )
    postfix += '';
    else if( o.withOut )
    postfix += 'out.';

    postfix += 'will';

    if( !hasExt )
    postfix += '.*';

    o.filePath += postfix;
  }

  var globTerminals = o.fileProvider.filesFinder
  ({
    filter,
    withTerminals : 1,
    withDirs : 0,
    maskPreset : 0,
    mandatory : 0,
    safe : 0,
    mode : 'distinct',
  });

  if( !o.fileProvider.path.isGlob( o.filePath ) )
  o.filePath += '*';
  return globTerminals( o.filePath );
}

// --
// declare
// --

let Extension =
{

  WillfilesFindAtDir,
  WillfilesFindWithGlob,
  _WillfilesFindTerminalsWithGlob,

}

//

_.mapSupplement( Self, Extension );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
