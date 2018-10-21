( function _Module_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wImModule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Module';

// --
// inter
// --

function finit()
{
  let module = this;

  if( module.formed )
  module.unform();

  module.about.finit();
  if( module.execution )
  module.execution.finit();
  if( module.link )
  module.link.finit();
  if( module.export )
  module.export.finit();

  _.assert( _.instanceIsFinited( module.about ) );
  if( module.execution )
  _.assert( _.instanceIsFinited( module.execution ) );
  if( module.link )
  _.assert( _.instanceIsFinited( module.link ) );
  if( module.export )
  _.assert( _.instanceIsFinited( module.export ) );

  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init( o )
{
  let module = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( module );
  Object.preventExtensions( module );

  if( o )
  module.copy( o );

}

//

function unform()
{
  let module = this;
  let im = module.im;

  _.assert( arguments.length === 0 );
  _.assert( !!module.formed );

  /* begin */

  for( let k in module.submoduleMap )
  module.submoduleMap[ k ].finit()
  for( let k in module.reflectorMap )
  module.reflectorMap[ k ].finit()
  for( let k in module.stepMap )
  module.stepMap[ k ].finit()
  for( let k in module.buildMap )
  module.buildMap[ k ].finit()

  debugger;

  _.assert( Object.keys( module.submoduleMap ).length === 0 );
  _.assert( Object.keys( module.reflectorMap ).length === 0 );
  _.assert( Object.keys( module.stepMap ).length === 0 );
  _.assert( Object.keys( module.buildMap ).length === 0 );

  for( let i = module.inFileArray.length-1 ; i >= 0 ; i-- )
  {
    let inf = module.inFileArray[ i ];
    _.assert( Object.keys( inf.submoduleMap ).length === 0 );
    _.assert( Object.keys( inf.reflectorMap ).length === 0 );
    _.assert( Object.keys( inf.stepMap ).length === 0 );
    _.assert( Object.keys( inf.buildMap ).length === 0 );
    inf.finit()
  }

  _.assert( module.inFileArray.length === 0 );
  _.assert( Object.keys( module.inFileWithRoleMap ).length === 0 );

  _.arrayRemoveOnceStrictly( im.moduleArray, module );

  /* end */

  module.formed = 0;
  return module;
}

//

function form()
{
  let module = this;
  let im = module.im;

  _.assert( arguments.length === 0 );
  _.assert( !module.formed );
  _.assert( !!module.im );

  /* begin */

  _.arrayAppendOnceStrictly( im.moduleArray, module );

  module.predefinedForm();

  /* end */

  _.assert( !!module.dirPath );

  module.formed = 1;
  return module;
}

//

function predefinedForm()
{
  let module = this;
  let im = module.im;

  _.assert( arguments.length === 0 );

  new im.Step
  ({
    name : 'grab',
    stepRoutine : im.Step.StepRoutineGrab,
    module : module,
  }).form1();

}

//

/*
iii : implement name glob filtering
*/

function buildsFor( name, filter )
{
  let module = this;

  _.assert( arguments.length === 2 );

  if( name )
  {
    debugger;
    if( module.buildMap[ name ] )
    return [ module.buildMap[ name ] ];
    return [];
  }

  if( !_.routineIs( filter ) )
  {

    let ofilter = filter;
    filter = function filter( build, k, c )
    {
      if( build.settings === null )
      return;
      let satisfied = _.mapSatisfy
      ({
        template : ofilter,
        src : build.settings,
        levels : 1,
      });
      if( satisfied )
      return build;
    }

  }

  let builds = _.mapVals( _.entityFilter( module.buildMap, filter ) );

  return builds;
}

//

/*
iii : implement name glob filtering
*/

function exportsFor( name, filter )
{
  let module = this;

  _.assert( arguments.length === 2 );

  if( name )
  {
    debugger;
    if( module.exportMap[ name ] )
    return [ module.exportMap[ name ] ];
    return [];
  }

  if( !_.routineIs( filter ) )
  {

    let ofilter = filter;
    filter = function filter( exp, k, c )
    {
      if( exp.settings === null )
      return;
      let satisfied = _.mapSatisfy
      ({
        template : ofilter,
        src : exp.settings,
        levels : 1,
      });
      if( satisfied )
      return exp;
    }

  }

  let exports = _.mapVals( _.entityFilter( module.exportMap, filter ) );

  return exports;
}

//

function strSplit( srcStr )
{
  let module = this;
  let im = module.im;
  let splits = _.strIsolateBeginOrNone( srcStr, ':' );
  return splits;
}

//

function strGetPrefix( srcStr )
{
  let module = this;
  let im = module.im;
  let splits = module.strSplit( srcStr );
  if( !splits[ 0 ] )
  return false;
  if( !_.arrayHas( module.KnownPrefixes, splits[ 0 ] ) )
  return false;
  return splits[ 0 ];
}

//

function _strResolve( srcStr )
{
  let module = this;
  let im = module.im;

  let result = module._strResolveMaybe( srcStr );

  if( _.errIs( result ) )
  throw result;

  return result;
}

//

function _strResolveMaybe( srcStr )
{
  let module = this;
  let im = module.im;

  let result = module._strResolveAct
  ({
    src : srcStr,
    visited : [],
  });

  return result;
}

//

function _strResolveAct( o )
{
  let module = this;
  let im = module.im;
  let result;

  _.assertRoutineOptions( _strResolveAct, arguments );

  let splits = module.strSplit( o.src );

  if( !splits[ 0 ] )
  return o.src;

  return module.componentGet( splits[ 0 ], splits[ 2 ] )
}

_strResolveAct.defaults =
{
  src : null,
  visited : null,
}

//

function componentGet( kind, name )
{
  let module = this;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;
  let result;

  _.assert( arguments.length === 2 );
  _.assert( _.strIs( kind ) );
  _.assert( _.strIs( name ) );

  if( !kind || !_.arrayHas( module.KnownPrefixes, kind ) )
  return o.src;

  if( kind === 'path' )
  {
    result = module.pathMap[ name ];
    result = path.s.resolve( module.dirPath, result );
  }
  else if( kind === 'reflector' )
  result = module.reflectorMap[ name ];
  else if( kind === 'submodule' )
  result = module.submoduleMap[ name ];
  else if( kind === 'step' )
  result = module.stepMap[ name ];
  else if( kind === 'build' )
  result = module.buildMap[ name ];

  if( result === undefined )
  {
    debugger;
    result = _.err( kind, _.strQuote( name ), 'was not found' );
  }

  return result;
}

//

function info()
{
  let module = this;
  let im = module.im;
  let result = '';

  result += module.about.info();
  result += module.execution.info();
  result += module.link.info();

  result += module.infoForReflectors( module.reflectorMap );
  result += module.infoForSteps( module.stepMap );
  result += module.infoForBuilds( module.buildMap );
  result += module.infoForExports( module.exportMap );

  return result;
}

//

function infoForReflectors( reflectors )
{
  let module = this;
  let im = module.im;
  let result = '';
  reflectors = reflectors || module.reflectorMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let b in reflectors )
  {
    let reflector = reflectors[ b ];
    result += reflector.info();
    result += '\n';
  }

  return result;
}

//

function infoForSteps( steps )
{
  let module = this;
  let im = module.im;
  let result = '';
  steps = steps || module.stepMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let b in steps )
  {
    let step = steps[ b ];
    result += step.info();
    result += '\n';
  }

  return result;
}

//

function infoForBuilds( builds )
{
  let module = this;
  let im = module.im;
  let result = '';
  builds = builds || module.buildMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let b in builds )
  {
    let build = builds[ b ];
    result += build.info();
    result += '\n';
  }

  return result;
}

//

function infoForExports( exports )
{
  let module = this;
  let im = module.im;
  let result = '';
  exports = exports || module.buildMap;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  for( let e in exports )
  {
    let exp = exports[ e ];
    result += exp.info();
    result += '\n';
  }

  return result;
}

// --
// relations
// --

let KnownPrefixes = [ 'submodule', 'step', 'path', 'reflector', 'build', 'about', 'execution', 'link', 'export' ];

let Composes =
{
  dirPath : null,
}

let Aggregates =
{

  inFileArray : _.define.own([]),
  inFileWithRoleMap : _.define.own({}),

  submoduleMap : _.define.own({}),
  pathMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportMap : _.define.own({}),

  about : _.define.ownInstanceOf( _.Im.ParagraphAbout ),
  execution : _.define.ownInstanceOf( _.Im.ParagraphExecution ),
  link : _.define.ownInstanceOf( _.Im.ParagraphLink ),

}

let Associates =
{
  im : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  KnownPrefixes : KnownPrefixes,
}

let Forbids =
{
  name : 'name',
}

let Accessor =
{
  about : { setter : _.accessor.setter.friend({ name : 'about', friendName : 'module', maker : _.Im.ParagraphAbout }) },
  execution : { setter : _.accessor.setter.friend({ name : 'execution', friendName : 'module', maker : _.Im.ParagraphExecution }) },
  link : { setter : _.accessor.setter.friend({ name : 'link', friendName : 'module', maker : _.Im.ParagraphLink }) },
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
  predefinedForm : predefinedForm,

  buildsFor : buildsFor,
  exportsFor : exportsFor,

  strSplit : strSplit,
  strGetPrefix : strGetPrefix,

  _strResolve : _strResolve,
  strResolve : _.routineVectorize_functor( _strResolve ),

  _strResolveMaybe : _strResolveMaybe,
  strResolveMaybe : _.routineVectorize_functor( _strResolveMaybe ),

  _strResolveAct : _strResolveAct,
  componentGet : componentGet,

  info : info,
  infoForReflectors : infoForReflectors,
  infoForSteps : infoForSteps,
  infoForBuilds : infoForBuilds,
  infoForExports : infoForExports,

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

/*_.Im[ Self.shortName ] = Self;*/
_.staticDecalre
({
  prototype : _.Im.prototype,
  name : Self.shortName,
  value : Self,
});

})();
