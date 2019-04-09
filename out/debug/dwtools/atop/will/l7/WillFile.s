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
  _.assert( module.preformed === 3 );
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
  _.assert( module.preformed === 3 );
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
  _.assert( module.preformed === 3 );
  _.assert( !!willf.formed );

  /* read */

  willf._inPathsForm();

  try
  {

    if( !willf.exists() )
    throw _.err( 'No will-file' );

    willf.data = fileProvider.fileConfigRead
    ({
      filePath : willf.filePath,
      verbosity : will.verbosity-2,
      found : willf._found,
    })

    _.assert( _.mapIs( willf.data ) );

    // willf.data = willf.data || Object.create( null );

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

  _.assert( willf.dirPath === path.dir( willf.filePath ) );

  /* */

  if( willf.data.about )
  module.about.copy( willf.data.about );
  if( willf.data.execution )
  module.execution.copy( willf.data.execution );

  let con = _.Consequence().take( null );

  /* */

  willf._resourcesMake( will.Exported, willf.data.exported );
  willf._resourcesMake( will.Submodule, willf.data.submodule );
  willf._resourcesMake( will.PathResource, willf.data.path );
  willf._resourcesMake( will.Step, willf.data.step );
  willf._reflectorsMake( will.Reflector, willf.data.reflector );
  willf._resourcesMake( will.Build, willf.data.build );

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

  _.assert( _.mapIs( resources ) || resources === null || resources === undefined );
  _.assert( arguments.length === 2 );

  if( !resources )
  return;

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
      debugger;
      throw _.err( 'Cant form', Resource.KindName + '::' + o2.name, '\n', err );
    }

  });

}

//

function _reflectorsMake( Reflector, resources )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( resources ) || resources === null || resources === undefined );
  _.assert( arguments.length === 2 );

  if( !resources )
  return;

  _.each( resources, ( resource, name ) =>
  {

    if( Reflector.OptionsFrom )
    resource = Reflector.OptionsFrom( resource );

    let o2 = _.mapExtend( null, resource );
    o2.willf = willf;
    o2.module = module;
    o2.name = name;

    delete o2.step;

    try
    {
      Reflector.MakeForEachCriterion( o2 );
    }
    catch( err )
    {
      debugger;
      throw _.err( 'Cant form', Reflector.KindName + '::' + o2.name, '\n', err );
    }

    if( resource.shell )
    {

      let o3 = Object.create( null );
      o3.criterion = _.mapExtend( null, resource.criterion || {} );
      o3.willf = willf;
      o3.module = module;
      o3.name = name;
      o3.forEachDst = 'reflector::' + name + '*';
      if( resource.step )
      o3.inherit = resource.step;
      else
      o3.inherit = 'predefined.shell';
      o3.shell = resource.shell;
      // o3.Optional = 1;

      try
      {
        will.Step.MakeForEachCriterion( o3 );
      }
      catch( err )
      {
        debugger;
        throw _.err( 'Cant form', will.Step.KindName + '::' + o3.name, '\n', err );
      }

    }
    else if( !module.stepMap[ name ] )
    {

      let o3 = Object.create( null );
      o3.criterion = _.mapExtend( null, resource.criterion || {} );
      o3.willf = willf;
      o3.module = module;
      o3.name = name;
      o3.reflector = 'reflector::' + name + '*';
      if( resource.step )
      o3.inherit = resource.step;
      else
      o3.inherit = 'predefined.reflect';
      o3.Optional = 1;

      try
      {
        will.Step.MakeForEachCriterion( o3 );
      }
      catch( err )
      {
        debugger;
        throw _.err( 'Cant form', will.Step.KindName + '::' + o3.name, '\n', err );
      }

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
  _.assert( module.preformed === 3 );
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

  if( !willf._found )
  {

    willf._found = fileProvider.fileConfigPathGet({ filePath : willf.filePath });

    _.assert( willf._found.length === 0 || willf._found.length === 1 );

    if( willf._found.length )
    willf.filePath = willf._found[ 0 ].particularPath;
  }

  return !!willf._found && !!willf._found.length;
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
  pathResourceMap : _.define.own({}),
  reflectorMap : _.define.own({}),
  stepMap : _.define.own({}),
  buildMap : _.define.own({}),
  exportedMap : _.define.own({}),

}

let Associates =
{
  data : null,
}

let Medials =
{
  module : null,
}

let Restricts =
{
  module : null,
  formed : 0,
  _found : null,
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

  _resourcesMake,
  _reflectorsMake,
  _inPathsForm,
  exists,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
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

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
