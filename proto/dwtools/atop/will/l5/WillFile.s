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
  let inf = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( inf );
  Object.preventExtensions( inf );

  if( o )
  inf.copy( o );

}

//

function unform()
{
  let inf = this;
  let module = inf.module;

  _.assert( arguments.length === 0 );
  _.assert( !!inf.formed );

  /* begin */

  _.arrayRemoveElementOnceStrictly( module.inFileArray, inf );

  if( inf.role )
  {
    _.assert( module.willFileWithRoleMap[ inf.role ] === inf )
    delete module.willFileWithRoleMap[ inf.role ];
  }

  /* end */

  inf.formed = 0;
  return inf;
}

//

function form()
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( module.formed === 1 );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( inf.formed === 0 )
  inf.form1();

  _.assert( inf.formed === 1 );

  inf.form2();

  if( !inf.formed )
  return inf;

  _.assert( inf.formed === 2 );

  return inf;
}

//

function form1()
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( inf.formed === 0 );

  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!module.formed );
  _.assert( !!will.formed );

  /* begin */

  _.arrayAppendOnceStrictly( module.inFileArray, inf );

  if( inf.role )
  {
    _.assert( !module.willFileWithRoleMap[ inf.role ], 'Module already has inf file with role', inf.role )
    module.willFileWithRoleMap[ inf.role ] = inf;
  }

  /* end */

  inf.formed = 1;
  return inf;
}

//

function form2()
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( inf.formed === 1 );
  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.formed );
  _.assert( !!inf.formed );

  /* read */

  inf._inPathsForm();

  try
  {
    inf.data = fileProvider.fileConfigRead
    ({
      filePath : inf.filePath,
      verbosity : will.verbosity+1,
    });
  }
  catch( err )
  {
    throw _.errLogOnce( _.errBriefly( err ) );
  }

  _.sureMapHasOnly( inf.data, inf.KnownSections, () => 'Will file ' + inf.filePath + ' should not have section(s) :' );

  /* form */

  if( inf.data.format !== undefined && inf.data.format !== inf.FormatVersion )
  throw _.err( 'Does not support format', inf.data.format, 'supports', inf.FormatVersion );

  if( inf.data.path && inf.data.path.baseDir )
  {
    let p = inf.data.path.baseDir;
    if( _.mapIs( p ) )
    p = p.path;
    p = path.join( path.dir( inf.filePath ), p);
    module.baseDirPathChange( p );
  }

  if( inf.data.about )
  module.about.copy( inf.data.about );
  if( inf.data.execution )
  module.execution.copy( inf.data.execution );

  let con = _.Consequence().give();

  /* */

  if( inf.data.exported )
  inf._resourcesForm1( will.Exported, inf.data.exported );

  if( inf.data.submodule )
  inf._resourcesForm1( will.Submodule, inf.data.submodule );

  if( inf.data.path )
  inf._resourcesForm1( will.PathObj, inf.data.path );

  if( inf.data.reflector )
  inf._resourcesForm1( will.Reflector, inf.data.reflector );

  inf._resourcesForm1( will.Step, inf.data.step || {} );

  if( inf.data.build )
  inf._resourcesForm1( will.Build, inf.data.build );

  /* */

  if( inf.data.exported )
  inf._resourcesForm2( will.Exported, inf.data.exported, con );

  // if( !module.supermodule )
  // debugger;

  if( inf.data.submodule )
  inf._resourcesForm2( will.Submodule, inf.data.submodule, con );

  // if( !module.supermodule )
  // debugger;

  if( inf.data.path )
  inf._resourcesForm2( will.PathObj, inf.data.path, con );

  if( inf.data.reflector )
  inf._resourcesForm2( will.Reflector, inf.data.reflector, con );

  inf._resourcesForm2( will.Step, inf.data.step || {}, con );

  if( inf.data.build )
  inf._resourcesForm2( will.Build, inf.data.build, con );

  /* */

  // if( !module.supermodule )
  // debugger;
  // con.ifNoErrorThen( function()
  // {
  //   // console.log( inf.role );
  //   // if( !module.supermodule )
  //   // debugger;
  // });

  /* */

  inf.formed = 2;

  return con.split();
}

//

function _inPathsForm()
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!module );
  _.assert( !!will );
  _.assert( !!will.formed );
  _.assert( !!module.formed );
  _.assert( !!inf.formed );

  if( !inf.filePath )
  {
    if( !inf.dirPath )
    inf.dirPath = module.dirPath;
    _.assert( _.strIs( inf.dirPath ) );
    inf.filePath = path.join( inf.dirPath, module.prefixPathForRole( inf.role ) );
  }

  inf.dirPath = path.dir( inf.filePath );

}

//

function _resourcesForm1( Resource, resources )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  // let con = _.Consequence().give();

  _.assert( _.mapIs( resources ) );
  _.assert( _.constructorIs( Resource ) );
  _.assert( arguments.length === 2 );

  _.each( resources, ( resource, k ) =>
  {

    if( Resource.OptionsFrom )
    resource = Resource.OptionsFrom( resource );

    let o2 = _.mapExtend( null, resource );
    o2.inf = inf;
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

function _resourcesForm2( Resource, resources, con )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  // let con = _.Consequence().give();

  _.assert( _.mapIs( resources ) );
  _.assert( _.constructorIs( Resource ) );
  _.assert( arguments.length === 3 );

  // _.each( resources, ( resource, k ) =>
  // {
  //
  //   if( Resource.OptionsFrom )
  //   resource = Resource.OptionsFrom( resource );
  //
  //   let o2 = _.mapExtend( null, resource );
  //   o2.inf = inf;
  //   o2.module = module;
  //   o2.name = k;
  //   try
  //   {
  //     Resource.MakeForEachCriterion( o2 );
  //   }
  //   catch( err )
  //   {
  //     throw _.err( 'Cant form', Resource.shortName, _.strQuote( o2.name ), '\n', err );
  //   }
  //
  // });

  if( Resource.MapName === 'build' )
  debugger;

  for( let s in inf[ Resource.MapName ] )
  {
    let resource = inf[ Resource.MapName ][ s ];
    _.assert( !!resource.formed );
    // if( resource.formed < 2 )
    con.ifNoErrorThen( () => resource.form2() );
  }

  for( let s in inf[ Resource.MapName ] )
  {
    let resource = inf[ Resource.MapName ][ s ];
    // if( resource.formed < 3 )
    con.ifNoErrorThen( () => resource.form3() );
  }

  // return con;
}

//

function exists()
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  inf._inPathsForm();

  let r = fileProvider.fileConfigPathGet({ filePath : inf.filePath });

  return !!r;
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

  finit : finit,
  init : init,
  unform : unform,
  form : form,
  form1 : form1,
  form2 : form2,
  _inPathsForm : _inPathsForm,
  _resourcesForm1 : _resourcesForm1,
  _resourcesForm2 : _resourcesForm2,

  exists : exists,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

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
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
