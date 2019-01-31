( function _WillFile_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillFile( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'WillFile';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let willf = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( willf );
  Object.preventExtensions( willf );

  if( o )
  willf.copy( o );

}

//

function unform()
{
  let willf = this;
  let module = willf.module;

  _.assert( arguments.length === 0 );
  _.assert( !!willf.formed );

  /* begin */

  _.arrayRemoveElementOnceStrictly( module.willFileArray, willf );

  if( willf.role )
  {
    _.assert( module.willFileWithRoleMap[ willf.role ] === willf )
    delete module.willFileWithRoleMap[ willf.role ];
  }

  /* end */

  willf.formed = 0;
  return willf;
}

//

function form()
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  debugger; xxx

  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( module.formed === 3 );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( willf.formed === 0 )
  willf.form1();

  _.assert( willf.formed === 1 );

  if( willf.formed === 1 )
  willf.open();

  _.assert( willf.formed === 2 );

  return willf;
}

//

function form1()
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( willf.formed === 0 );

  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( module.formed === 3 );
  _.assert( !!will.formed );

  /* begin */

  _.arrayAppendOnceStrictly( module.willFileArray, willf );

  if( willf.role )
  {
    _.assert( !module.willFileWithRoleMap[ willf.role ], 'Module already has willf file with role', willf.role )
    module.willFileWithRoleMap[ willf.role ] = willf;
  }

  /* end */

  willf.formed = 1;
  return willf;
}

//

function open()
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( willf.formed === 1 );
  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( module.formed === 3 );
  _.assert( !!willf.formed );

  /* read */

  willf._inPathsForm();

  try
  {
    // debugger;
    willf.data = fileProvider.fileConfigRead
    ({
      filePath : willf.filePath,
      verbosity : will.verbosity-2,
    });
    // debugger;
  }
  catch( err )
  {
    throw _.errLogOnce( _.errBriefly( err ) );
  }

  _.sureMapHasOnly( willf.data, willf.KnownSections, () => 'Will file ' + willf.filePath + ' should not have section(s) :' );

  /* form */

  if( willf.data.format !== undefined && willf.data.format !== willf.FormatVersion )
  throw _.err( 'Does not support format', willf.data.format + ',', 'supports only', willf.FormatVersion );

  /* */

  // if( 0 )
  if( willf.module.supermodule )
  {

    // debugger;
    let outPath = willf.data.path.out;
    if( _.mapIs( outPath ) )
    outPath = outPath.path;

    outPath = path.relative( outPath, '.' );
    let dirPath = path.join( willf.dirPath, outPath );
    module.dirPathSet( dirPath );

  }

  _.assert( willf.dirPath === path.dir( willf.filePath ) );
  // _.assert( !willf.data.path || !willf.data.path.baseDir, 'Will file should have no path::baseDir' ); // xxx : uncomment

  /* */

  // if( 0 )
  // if( willf.data.path && willf.data.path.baseDir )
  // {
  //   debugger;
  //   let p = willf.data.path.baseDir;
  //   if( _.mapIs( p ) )
  //   p = p.path;
  //   p = path.join( path.dir( willf.filePath ), p );
  //   module.dirPathSet( p );
  // }

  /* */

  if( willf.data.about )
  module.about.copy( willf.data.about );
  if( willf.data.execution )
  module.execution.copy( willf.data.execution );

  let con = _.Consequence().take( null );

  /* */

  // if( willf.data.exported )
  willf._resourcesMake( will.Exported, willf.data.exported || {} );

  // if( willf.data.submodule )
  willf._resourcesMake( will.Submodule, willf.data.submodule || {} );

  // if( willf.data.path )
  willf._resourcesMake( will.PathObj, willf.data.path || {} );

  // if( willf.data.reflector )
  willf._resourcesMake( will.Reflector, willf.data.reflector || {} );

  willf._resourcesMake( will.Step, willf.data.step || {} );

  // if( willf.data.build )
  willf._resourcesMake( will.Build, willf.data.build || {} );

  willf.formed = 2;

  return true;
}

//

function _resourcesMake( Resource, resources )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( resources ) );
  _.assert( _.constructorIs( Resource ) );
  _.assert( arguments.length === 2 );

  _.each( resources, ( resource, k ) =>
  {

    if( Resource.OptionsFrom )
    resource = Resource.OptionsFrom( resource );

    let o2 = _.mapExtend( null, resource );
    o2.willf = willf;
    o2.module = module;
    o2.name = k;
    try
    {
      Resource.MakeForEachCriterion( o2 );
    }
    catch( err )
    {
      throw _.err( 'Cant form', Resource.shortName, _.strQuote( o2.name ), '\n', err );
    }

  });

}

//

function _inPathsForm()
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!will.formed );
  _.assert( module.formed === 3 );
  _.assert( !!willf.formed );

  if( !willf.filePath )
  {
    if( !willf.dirPath )
    willf.dirPath = module.dirPath;
    _.assert( _.strIs( willf.dirPath ) );
    willf.filePath = path.join( willf.dirPath, module.prefixPathForRole( willf.role ) );
  }

  willf.dirPath = path.dir( willf.filePath );

}

//

function exists()
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  willf._inPathsForm();

  let r = fileProvider.fileConfigPathGet({ filePath : willf.filePath });

  return !!r && !!r.length;
}

// --
// relations
// --

let KnownSections =
{

  format : null,
  about : null,
  execution : null,

  submodule : null,
  path : null,
  reflector : null,
  step : null,
  build : null,
  exported : null,

}

let Composes =
{
  role : null,
  filePath : null,
  dirPath : null,
}

let Aggregates =
{

  submoduleMap : _.define.own({}),
  pathMap : _.define.own({}),
  pathObjMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportedMap : _.define.own({}),

}

let Associates =
{
  module : null,
  data : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  KnownSections : KnownSections,
  FormatVersion : 'willfile-1.0.0',
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,
  unform,
  form,
  form1,
  open,

  // form3,

  _resourcesMake,
  // _resourcesForm3,

  _inPathsForm,
  exists,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
