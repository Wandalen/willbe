( function _File_s_()
{

'use strict';

const _ = _global_.wTools;
_.will = _.will || Object.create( null );

// --
// implementation
// --

function fileClassify( filePath )
{

  _.assert( arguments.length === 1, 'Expects single file path {-filePath-}' );
  _.assert( _.path.isAbsolute( filePath ) );

  let result = _.any( _.will.FileExtension, ( ext ) =>
  {

    if( !_.strEnds( filePath, ext ) )
    return;

    if( _.strEnds( filePath, '.out.will.' + ext ) )
    return { filePath, role : 'single', out : true }

    if( _.strEnds( filePath, '.im.will.' + ext ) )
    return { filePath, role : 'import', out : false }

    if( _.strEnds( filePath, '.ex.will.' + ext ) )
    return { filePath, role : 'export', out : false }

    if( _.strEnds( filePath, '.will.' + ext ) )
    return { filePath, role : 'single', out : false }

    if( _.strEnds( filePath, _.path.upToken + 'will.' + ext ) )
    return { filePath, role : 'single', out : false }

  });

  if( !result )
  return { filePath };

  return result;
}

//

/* aaa for Dmytro : bad : ? */ /* Dmytro : removed */
// function _fileAtClassifyTerminals( o )
// {
//   _.assert( _.will.filePathIs( o.commonPath ), 'Expects path to willfile' );
//
//   let r = _.will.fileClassify( o.commonPath );
//   if( r.out )
//   {
//     if( o.withOut )
//     return r;
//   }
//   else
//   {
//     if( o.withIn )
//     return r;
//   }
// }

//

function fileAt_head( routine, args )
{
  let o = args[ 0 ]

  if( _.strIs( o ) )
  o = { commonPath : o };

  o.fileProvider = o.fileProvider || _.fileSystem;

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  _.routine.options_( routine, o );

  return o;
}

//

function fileAt_body( o )
{
  let result = [];
  let fileProvider = o.fileProvider;
  let path = fileProvider.path;

  o.commonPath = path.normalize( o.commonPath );

  _.assert( arguments.length === 1 );
  _.assert( path.isAbsolute( o.commonPath ) );
  _.assert( !path.isGlob( o.commonPath ), 'Expects no glob in {-o.commonPath-}' );
  _.assert( !path.isGlobal( o.commonPath ), 'Expects local path {-o.commonPath-}' );
  _.assert
  (
    _.bool.likeTrue( o.withIn ) || _.bool.likeTrue( o.withOut ),
    'Routine searches in and out willfiles. Please, define option {-o.withIn-} or {-o.withOut-}'
  );

  let isTrailed = path.isTrailed( o.commonPath );

  // if( !isTrailed )
  // if( fileProvider.isTerminal( o.commonPath ) )
  // {
  //   let r = _.will._fileAtClassifyTerminals( o );
  //   if( r )
  //   result.push( r ); /* aaa for Dmytro : bad : ?? */ /* Dmytro : the previous realization is moved back */
  //   return result;
  // }

  if( !isTrailed )
  if( fileProvider.isTerminal( o.commonPath ) )
  {
    _.assert( _.will.filePathIs( o.commonPath ), 'Expects path to willfile' );
    let r = _.will.fileClassify( o.commonPath );
    if( r.out )
    {
      if( o.withOut )
      result.push( r );
    }
    else
    {
      if( o.withIn )
      result.push( r );
    }
    return result;
  }

  if( !path.isSafe( o.commonPath, o.safe ) )
  return result;

  _.will.FileExtension.forEach( ( ext ) =>
  {
    let filePath

    if( o.withOut )
    if( o.withSingle )
    {
      filePath = o.commonPath + '.out.will.' + ext;
      if( fileProvider.resolvedIsTerminal( filePath ) )
      result.push({ filePath, role : 'single', out : false });

      if( isTrailed )
      {
        filePath = o.commonPath + 'out.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath, role : 'single', out : false });
      }
    }

    if( o.withIn )
    {
      if( isTrailed )
      {
        if( o.withSingle )
        {
          filePath = o.commonPath + 'will.' + ext;
          if( fileProvider.resolvedIsTerminal( filePath ) )
          result.push({ filePath, role : 'single', out : false });
        }

        if( o.withExport )
        {
          filePath = o.commonPath + 'ex.will.' + ext;
          if( fileProvider.resolvedIsTerminal( filePath ) )
          result.push({ filePath, role : 'export', out : false });
        }

        if( o.withImport )
        {
          filePath = o.commonPath + 'im.will.' + ext;
          if( fileProvider.resolvedIsTerminal( filePath ) )
          result.push({ filePath, role : 'import', out : false });
        }
      }

      if( o.withSingle )
      {
        filePath = o.commonPath + '.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        {
          result.push({ filePath, role : 'single', out : false });
        }
        else
        {
          let path = o.commonPath + '.' + ext;
          if( _.will.filePathIs( path ) )
          if( fileProvider.resolvedIsTerminal( path ) )
          result.push({ filePath : path, role : 'single', out : false });
        }
      }

      if( o.withExport )
      {
        filePath = o.commonPath + '.ex.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath, role : 'export', out : false });
      }

      if( o.withImport )
      {
        filePath = o.commonPath + '.im.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath, role : 'import', out : false });
      }
    }
  });

  return result;
}

fileAt_body.defaults =
{
  commonPath : null,
  withIn : true,
  withOut : true,
  withSingle : true,
  withImport : true,
  withExport : true,
  safe : 1,
  fileProvider : null,
};

let fileAt = _.routine.unite( fileAt_head, fileAt_body );

//

function _filesAtFindTerminals( o )
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
    recursive : 1,
  };

  if( !o.withIn )
  filter.maskTerminal.includeAll.push( /(^|\.|\/)out(\.)/ )
  if( !o.withSingle )
  filter.maskTerminal.includeAll.push( /(^|\.|\/)(ex|im)(\.)/ )

  if( !o.withOut )
  filter.maskTerminal.excludeAny.push( /(^|\.|\/)out(\.)/ )
  if( !o.withExport )
  filter.maskTerminal.excludeAny.push( /(^|\.|\/)ex(\.)/ )
  if( !o.withImport )
  filter.maskTerminal.excludeAny.push( /(^|\.|\/)im(\.)/ )

  let hasExt = /(^|\.|\/)will\.[^\.\/]+$/.test( o.commonPath );
  let hasWill = /(^|\.|\/)will(\.)?[^\.\/]*$/.test( o.commonPath );

  let postfix = '?(.)';
  if( !hasWill )
  {
    if( o.withImport )
    postfix += '?(im.)';
    if( o.withExport )
    postfix += '?(ex.)';
    if( o.withOut )
    postfix += '?(out.)';

    postfix += 'will';

    if( !hasExt )
    postfix += '.*';

    o.commonPath += postfix;
  }

  var globTerminals = o.fileProvider.filesFinder
  ({
    filter,
    withTerminals : true,
    withDirs : false,
    maskPreset : false,
    mandatory : false,
    safe : 0,
    mode : 'distinct',
  });

  return globTerminals( o.commonPath );
}

//

function filesAt_body( o )
{
  let fileProvider = o.fileProvider;
  let path = fileProvider.path;

  _.assert( !path.isGlobal( o.commonPath ), 'Expects local path {-o.commonPath-}' );
  _.assert
  (
    _.bool.likeTrue( o.withIn ) || _.bool.likeTrue( o.withOut ),
    'Routine searches in and out willfiles. Please, define option {-o.withIn-} or {-o.withOut-}'
  );

  let result = [];

  let isTrailed = path.isTrailed( o.commonPath );
  let commonPathIsGlob = path.isGlob( o.commonPath );

  // if( !isTrailed && !commonPathIsGlob )
  // if( fileProvider.isTerminal( o.commonPath ) )
  // {
  //   let r = _.will._fileAtClassifyTerminals( o );
  //   if( r )
  //   result.push( r );
  //   return result;
  // }

  if( !isTrailed && !commonPathIsGlob )
  if( fileProvider.isTerminal( o.commonPath ) )
  {
    _.assert( _.will.filePathIs( o.commonPath ), 'Expects path to willfile' );
    let r = _.will.fileClassify( o.commonPath );
    if( r.out )
    {
      if( o.withOut )
      result.push( r );
    }
    else
    {
      if( o.withIn )
      result.push( r );
    }
    return result;
  }

  if( commonPathIsGlob )
  return willfilesFind( o );
  else
  return _.will.fileAt( o );

  /* */

  function willfilesFind( o )
  {
    if( !path.isSafe( o.commonPath, o.safe ) )
    return [];

    let commonPathDir = o.commonPath;
    if( !isTrailed )
    commonPathDir = path.dir( o.commonPath );
    let commonDirIsGlob = path.isGlob( commonPathDir );
    let recursive = _.strHas( path.fullName( o.commonPath ), '**' );

    if( !commonDirIsGlob )
    if( !recursive )
    return willfilesFindTerminals( o );

    /* */

    let optionsForDirSearch = optionsMake( o.commonPath );
    let dirs = fileProvider.filesFind( optionsForDirSearch );

    if( commonDirIsGlob )
    {
      let optionsForDirSearch2 = optionsMake( commonPathDir );
      let dirsExcludedMaybe = fileProvider.filesFind( optionsForDirSearch2 );
      dirs = _.arrayAppendArrayOnce( dirs, dirsExcludedMaybe );
    }
    else
    {
      dirs = _.arrayAppendOnce( dirs, commonPathDir );
    }

    /* */

    if( isTrailed )
    result = findAtTrailed( dirs );
    else
    result = findAtNotTrailed( dirs );

    return result;
  }

  /* */

  function willfilesFindTerminals( o )
  {
    let o2 = _.mapExtend( null, o );

    let terminals = _filesAtFindTerminals( o2 );
    let globGetsAllNames = _.strBegins( path.name( o2.commonPath ), [ '?', '*' ] );
    let names = [ 'will', '.will', '.im.will', '.ex.will', '.out.will' ];
    let o3 = { withIn : o2.withIn, withOut : o2.withOut };
    let onRecord = ( record ) =>
    {
      record = path.globShortFilter({ src : record, selector : o.commonPath, onEvaluate : ( el ) => el.absolute });
      if( record && globGetsAllNames && !o.withAllNamed )
      record = _.strHasAny( record.name, names ) ? record : undefined;

      if( record === null )
      {
        return undefined;
      }
      else
      {
        _.assert( _.will.filePathIs( record.absolute ), 'Expects path to willfile' );
        let r = _.will.fileClassify( record.absolute );
        if( r.out )
        {
          if( o.withOut )
          return r;
        }
        else
        {
          if( o.withIn )
          return r;
        }
        return undefined;
        // return _.will._fileAtClassifyTerminals( o3 );
      }
    };
    _.filter_( terminals, terminals, onRecord );
    return terminals;
  }

  /* */

  function optionsMake( commonPath )
  {
    let filter =
    {
      filePath : commonPath,
      maskDirectory : {},
      maskTransientDirectory : {},
    };

    if( _.strHas( commonPath, '**' ) )
    filter.recursive = 2;

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

    return o2;
  }

  /* */

  function findAtTrailed( dirs )
  {
    let result = [];
    let o2 = _.mapExtend( null, o );

    for( let i = 0; i < dirs.length; i++ )
    {
      o2.commonPath = path.join( dirs[ i ], './' );
      let records = _.will.fileAt( o2 );
      _.arrayAppendArray( result, records );
    }

    return result;
  }

  /* */

  function findAtNotTrailed( dirs )
  {
    let result = [];
    let o2 = _.mapExtend( null, o );
    let name = path.fullName( o2.commonPath );

    for( let i = 0; i < dirs.length; i++ )
    {
      o2.commonPath = path.join( dirs[ i ], name );
      let records = willfilesFindTerminals( o2 );
      _.arrayAppendArray( result, records );
    }

    return result;
  }
}

filesAt_body.defaults =
{
  commonPath : null,
  withIn : true,
  withOut : true,
  withSingle : true,
  withImport : true,
  withExport : true,
  safe : 1,
  fileProvider : null,
};

//

const filesAt = _.routine.unite( fileAt_head, filesAt_body );

//

function filePathIs( filePath )
{
  let fname = _.path.fullName( filePath );
  let r = /(^|\.)will\.\w+/;
  // let r = /\.will\.\w+/; /* Dmytro : the regexp does not include willfiles that start with word `will` */
  if( _.strHas( fname, r ) )
  return true;
  return false;
}

//

function filePathIsOut( filePath )
{
  if( _.arrayIs( filePath ) )
  filePath = filePath[ 0 ];
  return _.strHas( filePath, /\.out(\.\w+)?(\.\w+)?$/ );
}

//

function fileResource_head( routine, args )
{
  let o = args[ 0 ];
  if( _.strIs( o ) )
  o = { commonPath : args[ 0 ], resourceName : ( args.length > 1 ? args[ 1 ] : null ) };
  o.fileProvider = o.fileProvider || _.fileSystem;

  _.routine.options_( routine, o );
  _.assert( _.will.ResourceKind.has( o.resourceKind ) );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( arguments.length === 2 );

  return o;
}

//

function fileReadResource_body( o )
{
  let found = _.will.fileAt.body.call( _.will, o );

  _.assert( _.arrayIs( found ) );

  if( !found.length )
  {
    debugger;
    if( o.throwing )
    throw _.err( `Found no willfile at ${o.commonPath}` );
    return;
  }

  /* aaa : for Dmytro : ? */
  /* Dmytro : this realization handles undefines, but routine `any` does not.
     Example:
     about :
       enabled : 0

     `has` returns undefined
     cycle `for` returns 0
  */

  for( let i = 0 ; i < found.length ; i++ )
  {
    let read = o.fileProvider.fileReadUnknown({ filePath : found[ i ].filePath });
    if( read[ o.resourceKind ] && _.props.has( read[ o.resourceKind ], o.resourceName ) )
    return read[ o.resourceKind ][ o.resourceName ];
  };
  // return _.any( found, ( file ) => /* Dmytro : routine not handle undefines */
  // {
  //   let read = o.fileProvider.fileReadUnknown({ filePath : file.filePath });
  //   if( read[ o.resourceKind ] && _.props.has( read[ o.resourceKind ], o.resourceName ) )
  //   return read[ o.resourceKind ][ o.resourceName ];
  // });

}

fileReadResource_body.defaults =
{
  ... fileAt.defaults,
  throwing : 1,
  resourceName : null,
  resourceKind : null,
};

//

let fileReadResource = _.routine.unite( fileResource_head, fileReadResource_body );

//

let fileReadPath = _.routine.uniteCloning( fileResource_head, fileReadResource_body );
fileReadPath.defaults.resourceKind = 'path';

//

function fileWriteResource_body( o )
{
  let found = _.will.fileAt.body.call( _.will, o );

  _.assert( _.arrayIs( found ) );

  if( !found.length )
  {
    debugger;
    if( o.throwing )
    throw _.err( `Found no willfile at ${o.commonPath}` );
    return;
  }

  let cache = Object.create( null );
  let file = _.any( found, ( file ) =>
  {
    let read = cache[ file.filePath ] = o.fileProvider.fileReadUnknown({ filePath : file.filePath });
    if( read[ o.resourceKind ] && _.props.has( read[ o.resourceKind ], o.resourceName ) )
    {
      read[ o.resourceKind ][ o.resourceName ] = o.val;
      return file;
    }
  });

  if( !file )
  file = _.any( found, ( file ) =>
  {
    let read = cache[ file.filePath ];
    if( read[ o.resourceKind ] )
    {
      read[ o.resourceKind ][ o.resourceName ] = o.val;
      return file;
    }
  });

  if( file )
  {
    o.fileProvider.fileWriteUnknown({ filePath : file.filePath, data : cache[ file.filePath ] });
  }

  return file;
}

fileWriteResource_body.defaults =
{
  ... fileAt.defaults,
  throwing : 1,
  resourceName : null,
  resourceKind : null,
  val : null,
};

//

let fileWriteResource = _.routine.unite( fileResource_head, fileWriteResource_body );

//

let fileWritePath = _.routine.uniteCloning( fileResource_head, fileWriteResource_body );
fileWritePath.defaults.resourceKind = 'path';

//

function environmentPathFind( o )
{

  if( _.strIs( o ) )
  o = { dirPath : o }

  _.routine.options_( environmentPathFind, o );
  _.assert( arguments.length === 1 );

  let fileProvider = o.fileProvider || _.fileProvider;
  let path = fileProvider.path;

  o.dirPath = path.canonize( o.dirPath );

  if( check( o.dirPath ) )
  return o.dirPath;

  let paths = path.traceToRoot( o.dirPath );
  for( var i = paths.length - 1; i >= 0; i-- )
  if( check( paths[ i ] ) )
  return paths[ i ];

  return o.dirPath;

  function check( dirPath )
  {
    if( !fileProvider.isDir( path.join( dirPath, '.will' ) ) )
    return false
    return true;
  }
}

environmentPathFind.defaults =
{
  dirPath : null,
  fileProvider : null,
}

//

function importFileStructureAdapt( willf )
{
  _.assert( arguments.length === 1 );
  _.assert( willf instanceof _.will.Willfile );

  let structure = willf.structure;

  if( willf.isOut || willf.role === 'export' )
  return;

  if( structure.format === willf.FormatVersion )
  return;

  /* submodule */

  if( structure.submodule )
  _.each( structure.submodule, ( val, key ) =>
  {
    let path = null;
    let objectIs = _.object.isBasic( val );

    if( objectIs )
    path = val.path;
    else
    path = val;

    if( !_.path.isGlobal( path ) )
    return;
    let vcs = _.repo.vcsFor( path );
    if( !vcs )
    return;

    let parsed = vcs.path.parse( path );
    let isOldFormat = parsed.hash && !parsed.isFixated;
    if( !isOldFormat )
    return;

    parsed.tag = parsed.hash;
    delete parsed.hash;

    if( parsed.localVcsPath && vcs.path.name( parsed.localVcsPath ) )
    {
      let ext = vcs.path.ext( parsed.localVcsPath );

      if( !ext )
      parsed.localVcsPath = vcs.path.changeExt( parsed.localVcsPath, 'out.will.yml' )

      if( parsed.query )
      parsed.query = `${parsed.query}&out=${parsed.localVcsPath}`
      else
      parsed.query = `out=${parsed.localVcsPath}`;

      delete parsed.localVcsPath;
    }

    path = vcs.path.str( parsed );

    if( objectIs )
    val.path = path;
    else
    structure.submodule[ key ] = path;
  })

}

// --
// relations
// --

const FileExtension = [ 'yml', 'json' ];

// --
// declare
// --

let Extension =
{

  fileClassify,

  // _fileAtClassifyTerminals,
  fileAt,
  _filesAtFindTerminals,
  filesAt,

  filePathIs,
  filePathIsOut,

  fileReadResource,
  fileReadPath,
  fileWriteResource,
  fileWritePath,

  environmentPathFind,

  importFileStructureAdapt,

  //

  FileExtension,

}

/* _.props.extend */Object.assign( _.will, Extension );

})();
