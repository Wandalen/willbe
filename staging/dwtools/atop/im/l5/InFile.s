( function _InFile_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillInFile( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'InFile';

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
    _.assert( module.inFileWithRoleMap[ inf.role ] === inf )
    delete module.inFileWithRoleMap[ inf.role ];
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
    _.assert( !module.inFileWithRoleMap[ inf.role ], 'Module already has inf file with role', inf.role )
    module.inFileWithRoleMap[ inf.role ] = inf;
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

  inf.inPathsForm();
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

  _.sureMapHasOnly( inf.data, inf.KnownSections );

  /* form */

  if( inf.data.path )
  inf.pathsForm( inf.data.path );

  if( inf.data.reflector )
  inf.reflectorsForm( inf.data.reflector );

  if( inf.data.step )
  inf.stepsForm( inf.data.step );

  if( inf.data.build )
  inf.buildsForm( inf.data.build );

  if( inf.data.export )
  inf.exportsForm( inf.data.export );

  if( inf.data.about )
  module.about.copy( inf.data.about );
  if( inf.data.execution )
  module.execution.copy( inf.data.execution );

  // if( inf.data.link )
  // module.link.copy( inf.data.link );

  /* */

  inf.formed = 2;
}

//

function inPathsForm()
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

function pathsForm( paths )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( paths ) );
  _.assert( arguments.length === 1 );

  _.each( paths, ( path, k ) =>
  {

    _.sure( !inf.pathMap[ k ], () => 'Mod file ' + _.strQuote( inf.dirPath ) + ' already has path ' + _.strQuote( k ) );
    _.sure( !module.pathMap[ k ], () => 'Module file ' + _.strQuote( module.name ) + ' already has path ' + _.strQuote( k ) );
    _.sure( _.strIs( path ) );

    inf.pathMap[ k ] = path;
    module.pathMap[ k ] = path;

  });

}

//

function reflectorsForm( reflectors )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( reflectors ) );
  _.assert( arguments.length === 1 );

  _.each( reflectors, ( reflector, k ) =>
  {

    let o2 = _.mapExtend( null, reflector );
    o2.inf = inf;
    o2.module = module;
    o2.name = k;
    try
    {
      will.Reflector( o2 ).form1();
    }
    catch( err )
    {
      throw _.err( 'Cant form reflector', _.strQuote( o2.name ), '\n', err );
    }

  });

  for( let s in inf.reflectorMap )
  {
    let reflector = inf.reflectorMap[ s ];
    _.assert( !!reflector.formed );
    if( reflector.formed < 2 )
    reflector.form2();
  }

  for( let s in inf.reflectorMap )
  {
    let reflector = inf.reflectorMap[ s ];
    if( reflector.formed < 3 )
    reflector.form3();
  }

}

//

function stepsForm( steps )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( steps ) );
  _.assert( arguments.length === 1 );

  _.each( steps, ( step, k ) =>
  {

    if( _.strIs( step ) )
    step = { filePath : step };

    let o2 = _.mapOnly( step, { inherit : null, filePath : null } );
    o2.settings = _.mapBut( step, o2 );
    o2.inf = inf;
    o2.module = module;
    o2.name = k;

    try
    {
      will.Step( o2 ).form1();
    }
    catch( err )
    {
      throw _.err( 'Cant form step', _.strQuote( o2.name ), '\n', err );
    }

  });

  for( let s in inf.stepMap )
  {
    let step = inf.stepMap[ s ];
    _.assert( !!step.formed );
    if( step.formed < 2 )
    step.form2();
  }

}

//

function buildsForm( builds )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( builds ) );
  _.assert( arguments.length === 1 );

  /* form1 */

  _.each( builds, ( build, k ) =>
  {

    let o2 = _.mapExtend( null, build );
    o2.inf = inf;
    o2.module = module;
    o2.name = k;

    try
    {
      will.Build( o2 ).form1();
    }
    catch( err )
    {
      throw _.err( 'Cant form build', _.strQuote( o2.name ), '\n', err );
    }

  });

  /* form2 */

  for( let s in inf.buildMap )
  {
    let build = inf.buildMap[ s ];
    _.assert( !!build.formed );
    if( build.formed < 2 )
    build.form2();
  }

  /* form3 */

  for( let s in inf.buildMap )
  {
    let build = inf.buildMap[ s ];
    _.assert( build.formed >= 2 );
    if( build.formed < 3 )
    build.form3();
  }

}

//

function exportsForm( exports )
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( exports ) );
  _.assert( arguments.length === 1 );

  /* form1 */

  _.each( exports, ( exp, k ) =>
  {

    let o2 = _.mapExtend( null, exp );
    o2.inf = inf;
    o2.module = module;
    o2.name = k;

    try
    {
      will.Export( o2 ).form1();
    }
    catch( err )
    {
      throw _.err( 'Cant form export', _.strQuote( o2.name ), '\n', err );
    }

  });

  /* form2 */

  for( let s in inf.exportMap )
  {
    let exp = inf.exportMap[ s ];
    _.assert( !!exp.formed );
    if( exp.formed < 2 )
    exp.form2();
  }

  /* form3 */

  for( let s in inf.exportMap )
  {
    let exp = inf.exportMap[ s ];
    _.assert( exp.formed >= 2 );
    if( exp.formed < 3 )
    exp.form3();
  }

}

//
//
// function prefixPathGet()
// {
//   let inf = this;
//
//   if( inf.role === 'import' )
//   return '.im.in';
//   else if( inf.role === 'export' )
//   return '.ex.in';
//
//   _.sure( 0, 'Unknown prefix path for role', inf.role );
// }

//

function exists()
{
  let inf = this;
  let module = inf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  inf.inPathsForm();

  let r = fileProvider.fileConfigPathGet({ filePath : inf.filePath });

  return !!r;
}

// --
// relations
// --

let KnownSections =
{

  submodule : null,
  path : null,
  reflector : null,
  step : null,
  build : null,

  about : null,
  execution : null,
  // link : null,
  export : null,

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
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportMap : _.define.own({}),

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
  inPathsForm : inPathsForm,

  pathsForm : pathsForm,
  reflectorsForm : reflectorsForm,
  stepsForm : stepsForm,
  buildsForm : buildsForm,
  exportsForm : exportsForm,

  // prefixPathGet : prefixPathGet,
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
