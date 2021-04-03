( function _Namespace_s_()
{

'use strict';

/*
= Principles
- Willbe prepends all relative paths by path::in. path::out and path::temp are prepended by path::in as well.
- Willbe prepends path::in by module.dirPath, a directory which has the willfile.
- Major difference between generated out-willfiles and manually written willfile is section exported. out-willfiles has such section, manually written willfile does not.
- Output files are generated and input files are for manual editing, but the utility can help with it.
*/

/*
= Requested features
- Command .submodules.update should change back manually updated fixated submodules.
- Faster loading, perhaps without submodules
- Timelapse for transpilation
- Reflect submodules into dir with the same name as submodule
*/

/*

qqq : make working command `will .with file1 file2 file3.will.yml`
- for example `will .with file1 file2 file3.will.yml .clean`

*/

const _ = _global_.wTools;
const Self = _.will = _.will || Object.create( null );

// --
// routines
// --

function isJunction( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  if( !object )
  return false;
  if( object instanceof _.will.ModuleJunction )
  return true;
  return false;
}

//

function fileClassify( filePath )
{

  _.assert( _.path.isAbsolute( filePath ) );

  let result = _.any( _.will.FileExtension, ( ext ) =>
  {

    if( !_.strEnds( filePath, ext ) )
    return;

    if( _.strEnds( filePath, '.out.will.' + ext ) )
    return { filePath, role : 'single', out : true }

    if( _.strEnds( filePath, '.will.' + ext ) )
    return { filePath, role : 'single', out : false }

    if( _.strEnds( filePath, '.im.will.' + ext ) )
    return { filePath, role : 'import', out : false }

    if( _.strEnds( filePath, '.ex.will.' + ext ) )
    return { filePath, role : 'export', out : false }

  });

  if( !result )
  return { filePath }

  return result;
}

//

function fileAt_head( routine, args )
{
  let o = args[ 0 ]

  if( _.strIs( o ) )
  o = { commonPath : o };

  o.fileProvider = o.fileProvider || _.fileSystem;

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  _.routineOptions( routine, o );

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
  _.assert( o.withIn || o.withOut, 'Routine searches in and out willfiles. Please, define option {-o.withIn-} or {-o.withOut-}' );

  let isTrailed = path.isTrailed( o.commonPath );

  if( !isTrailed ) /* qqq : cover */
  if( fileProvider.isTerminal( o.commonPath ) )  /* qqq : cover */
  {
    _.assert( _.will.filePathIs( o.commonPath ), 'Expects path to willfile' );
    let r = _.will.fileClassify( o.commonPath );
    if( r.out )
    {
      if( o.withOut )
      result.push( r );
      return result;
    }
    else
    {
      if( o.withIn )
      result.push( r );
      return result;
    }
  }

  if( !path.isSafe( o.commonPath, o.safe ) )
  return result;

  _.will.FileExtension.forEach( ( ext ) =>
  {
    let filePath

    if( o.withOut )
    {
      filePath = o.commonPath + '.out.will.' + ext;
      if( fileProvider.resolvedIsTerminal( filePath ) )
      result.push({ filePath : filePath, role : 'single', out : false });

      if( isTrailed )
      {
        filePath = o.commonPath + 'out.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath : filePath, role : 'single', out : false });
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
          result.push({ filePath : filePath, role : 'single', out : false });
        }

        if( o.withImport )
        {
          filePath = o.commonPath + 'im.will.' + ext;
          if( fileProvider.resolvedIsTerminal( filePath ) )
          result.push({ filePath : filePath, role : 'import', out : false });
        }

        if( o.withExport )
        {
          filePath = o.commonPath + 'ex.will.' + ext;
          if( fileProvider.resolvedIsTerminal( filePath ) )
          result.push({ filePath : filePath, role : 'export', out : false });
        }
      }

      if( o.withSingle )
      {
        filePath = o.commonPath + '.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath : filePath, role : 'single', out : false });
      }

      if( o.withImport )
      {
        filePath = o.commonPath + '.im.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath : filePath, role : 'import', out : false });
      }

      if( o.withExport )
      {
        filePath = o.commonPath + '.ex.will.' + ext;
        if( fileProvider.resolvedIsTerminal( filePath ) )
        result.push({ filePath : filePath, role : 'export', out : false });
      }

    }

  });

  return result;
}

fileAt_body.defaults =
{
  commonPath : null,
  withIn : 1,
  withOut : 1,
  withSingle : 1,
  withImport : 1,
  withExport : 1,
  safe : 1,
  fileProvider : null,
}

let fileAt = _.routine.unite( fileAt_head, fileAt_body );

//

function filePathIsOut( filePath )
{
  if( _.arrayIs( filePath ) )
  filePath = filePath[ 0 ];
  return _.strHas( filePath, /\.out(\.\w+)?(\.\w+)?$/ );
}

//

function filePathIs( filePath )
{
  let fname = _.path.fullName( filePath );
  let r = /\.will\.\w+/;
  if( _.strHas( fname, r ) )
  return true;
  return false;
}

//

function fileResource_head( routine, args )
{
  let o = args[ 0 ];
  if( _.strIs( o ) )
  o = { commonPath : args[ 0 ], resourceName : args[ 1 ] };
  o.fileProvider = o.fileProvider || _.fileSystem;

  _.routineOptions( routine, o );
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
    if( o.throwing )
    throw _.err( `Found no willfile at ${o.commonPath}` );
    return;
  }

  return _.any( found, ( file ) =>
  {
    let read = o.fileProvider.fileReadUnknown({ filePath : file.filePath });
    if( read[ o.resourceKind ] && _.property.has( read[ o.resourceKind ], o.resourceName ) )
    return read[ o.resourceKind ][ o.resourceName ];
  });

}

fileReadResource_body.defaults =
{
  ... fileAt.defaults,
  throwing : 1,
  resourceName : null,
  resourceKind : null,
}

let fileReadResource = _.routine.unite( fileResource_head, fileReadResource_body );
let fileReadPath = _.routine.uniteCloning( fileResource_head, fileReadResource_body );
fileReadPath.defaults.resourceKind = 'path';

//

function fileWriteResource_body( o )
{
  let found = _.will.fileAt.body.call( _.will, o );

  _.assert( _.arrayIs( found ) );

  if( !found.length )
  {
    if( o.throwing )
    throw _.err( `Found no willfile at ${o.commonPath}` );
    return;
  }

  let cache = Object.create( null );
  let file = _.any( found, ( file ) =>
  {
    let read = cache[ file.filePath ] = o.fileProvider.fileReadUnknown({ filePath : file.filePath });
    if( read[ o.resourceKind ] && _.property.has( read[ o.resourceKind ], o.resourceName ) )
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
}

let fileWriteResource = _.routine.unite( fileResource_head, fileWriteResource_body );
let fileWritePath = _.routine.uniteCloning( fileResource_head, fileWriteResource_body );
fileWritePath.defaults.resourceKind = 'path';

// --
// relations
// --

const ModuleVariant = [ '/', '*/object', '*/module', '*/relation', '*/handle' ];

const FileExtension = [ 'yml', 'json' ];

const ResourceKind = new Set
([
  'submodule',
  'step',
  'path',
  'reflector',
  'build',
  'about',
  'execution',
  'exported',
]);

// --
// declare
// --

let Extension =
{

  isJunction,

  fileClassify, /* qqq : for Dmytro : cover */
  fileAt, /* qqq : for Dmytro : cover */
  filePathIs,
  filePathIsOut,

  fileReadResource, /* qqq : for Dmytro : cover */
  fileReadPath, /* qqq : for Dmytro : light coverage */
  fileWriteResource, /* qqq : for Dmytro : cover */
  fileWritePath, /* qqq : for Dmytro : light coverage */

  //

  FileExtension,
  ModuleVariant,
  ResourceKind,

}

_.mapExtend( Self, Extension );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
