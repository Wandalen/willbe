( function _WillFile_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillfile( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Willfile';

// --
// inter
// --

function finit()
{
  let willf = this;

  if( willf.formed )
  willf.unform();

  return _.Copyable.prototype.finit.apply( willf, arguments );
}

//

function init( o )
{
  let willf = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( willf );
  Object.preventExtensions( willf );

  _.Will.ResourceCounter += 1;
  willf.id = _.Will.ResourceCounter;

  if( o )
  willf.copy( o );

  _.assert( !!willf.will );

}

//

function unregister()
{
  let willf = this;
  let will = willf.will;
  let openerModule = willf.openerModule;
  let openedModule = willf.openedModule;

  if( openerModule )
  openerModule.willfileUnregister( willf );
  if( openedModule )
  openedModule.willfileUnregister( willf );
  will.willfileUnregister( willf );

}

//

function register()
{
  let willf = this;
  let will = willf.will;
  let openerModule = willf.openerModule;
  let openedModule = willf.openedModule;

  if( openerModule )
  openerModule.willfileRegister( willf );
  if( openedModule )
  openedModule.willfileRegister( willf );
  will.willfileRegister( willf );

}

//

function unform()
{
  let willf = this;
  let will = willf.will;

  _.assert( arguments.length === 0 );
  _.assert( !!willf.formed );

  /* begin */

  willf.unregister();

  /* end */

  willf.formed = 0;
  return willf;
}

//

function form()
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( 0, 'not tested' );

  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( openerModule.preformed > 0 );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( willf.formed === 0 )
  willf.preform();

  _.assert( willf.formed === 1 );

  if( willf.formed === 1 )
  willf.open();

  _.assert( willf.formed === 2 );

  return willf;
}

//

function preform()
{
  _.assert( !!this.will );

  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( willf.formed === 0 );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );

  /* begin */

  willf.register();

  if( will.verbosity >= 3 )
  if( willf.data )
  {
    logger.log( ' . Read from cache . ' + _.color.strFormat( willf.filePath, 'path' ) );
  }

  /* end */

  willf.formed = 1;
  return willf;
}

//

function open()
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( willf.formed === 1 || willf.formed === 2 );
  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );

  /* read */

  willf.read();
  willf.importToModule();

  _.assert( willf.formed === 3 );

  return true;
}

//

function read()
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( willf.formed > 1 )
  return true;

  _.assert( willf.formed === 1 );
  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );

  /* read */

  willf._inPathsForm();

  try
  {

    if( !willf.data )
    if( !willf.exists() )
    throw _.err( 'No willfile' );

    if( !willf.data )
    willf.data = fileProvider.fileConfigRead
    ({
      filePath : willf.filePath,
      verbosity : will.verbosity-2,
      found : willf._found,
    })

    _.assert( _.mapIs( willf.data ) );

  }
  catch( err )
  {
    throw _.errLogOnce( _.errBriefly( err ) );
  }

  _.sureMapHasOnly( willf.data, willf.KnownSections, () => 'Will file ' + willf.filePath + ' should not have section(s) :' );

  if( willf.data.format !== undefined && willf.data.format !== willf.FormatVersion )
  throw _.err( 'Does not support format', willf.data.format + ',', 'supports only', willf.FormatVersion );

  _.assert( willf.dirPath === path.dir( willf.filePath ) );

  /* */

  willf.formed = 2;
  return true;
}

//

function importToModule()
{
  let willf = this;
  let openedModule = willf.openedModule;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( willf.formed === 2 );
  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( _.mapIs( willf.data ) );

  _.sureMapHasOnly( willf.data, willf.KnownSections, () => 'Will file ' + willf.filePath + ' should not have section(s) :' );

  /* form */

  if( willf.data.format !== undefined && willf.data.format !== willf.FormatVersion )
  throw _.err( 'Does not support format', willf.data.format + ',', 'supports only', willf.FormatVersion );

  /* */

  _.assert( willf.dirPath === path.dir( willf.filePath ) );

  /* */

  if( willf.data.about )
  openedModule.about.copy( willf.data.about );

  let con = _.Consequence().take( null );

  /* */

  willf.resourcesImport( will.Exported, willf.data.exported );
  willf.resourcesImport( will.Submodule, willf.data.submodule );

  willf.pathsImport( will.PathResource, willf.data.path );

  willf.resourcesImport( will.Step, willf.data.step );
  willf.reflectorsImport( will.Reflector, willf.data.reflector );
  willf.resourcesImport( will.Build, willf.data.build );

  _.assert( path.s.allAreAbsolute( openedModule.pathResourceMap[ 'module.dir' ].path ) );
  _.assert( path.s.allAreAbsolute( openedModule.pathResourceMap[ 'module.willfiles' ].path ) );
  _.assert( path.s.allAreAbsolute( openedModule.pathResourceMap[ 'will' ].path ) );

  willf.formed = 3;
  return true;
}

//

function resourceImport_pre( routine, args )
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  let o = args[ 0 ]
  if( args.length > 1 )
  o = { resourceClass : args[ 0 ], resource : args[ 1 ] }

  _.routineOptions( routine, o );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( arguments.length === 2 );

  return o;
}

function resourceImport_body( o )
{
  let willf = this;
  let openedModule = willf.openedModule;
  let will = openedModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( resourceImport, arguments );

  if( !o.resource )
  return;

  _.assert( !!o.resource );
  _.assert( _.constructorIs( o.resourceClass ) );
  _.assert( arguments.length === 1 );

  let o2;
  if( o.resourceClass.OptionsFrom )
  o2 = o.resourceClass.OptionsFrom( o.resource );
  else
  o2 = _.mapExtend( null, o.resource );

  o2.willf = willf;
  o2.module = openedModule;
  o2.name = o.name;
  o2.Importing = 1;
  o2.IsOutFile = willf.isOutFile;

  // if( o2.name === 'module.common' )
  // debugger;

  try
  {
    o.resourceClass.MakeForEachCriterion( o2 );
  }
  catch( err )
  {
    debugger;
    throw _.err( 'Cant form', o.resourceClass.KindName + '::' + o2.name, '\n', err );
  }

}

resourceImport_body.defaults =
{
  resourceClass : null,
  resource : null,
  name : null,
}

let resourceImport = _.routineFromPreAndBody( resourceImport_pre, resourceImport_body );

//

function resourcesImport_pre( routine, args )
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  let o = args[ 0 ]
  if( args.length > 1 )
  o = { resourceClass : args[ 0 ], resources : args[ 1 ] }

  _.routineOptions( routine, o );
  _.assert( _.mapIs( o.resources ) || o.resources === null || o.resources === undefined );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( arguments.length === 2 );

  return o;
}

function resourcesImport_body( o )
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( resourcesImport, arguments );

  if( !o.resources )
  return;

  _.assert( _.mapIs( o.resources ) );
  _.assert( _.constructorIs( o.resourceClass ) );
  _.assert( arguments.length === 1 );

  _.each( o.resources, ( resource, k ) =>
  {

    willf.resourceImport
    ({
      resource : resource,
      resourceClass : o.resourceClass,
      name : k,
    });

  });

}

resourcesImport_body.defaults =
{
  resourceClass : null,
  resources : null,
}

let resourcesImport = _.routineFromPreAndBody( resourcesImport_pre, resourcesImport_body );

//

function pathsMake_body( o )
{
  let willf = this;
  let openedModule = willf.openedModule;
  let will = openedModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let dirPath = openedModule.dirPath;

  let result = willf.resourcesImport.body.call( willf, o );

  if( dirPath && path.isAbsolute( dirPath ) && dirPath !== openedModule.dirPath )
  {
    openedModule._dirPathChange( dirPath );
  }

  _.assert( path.isAbsolute( openedModule.inPath ) );

  for( let r in openedModule.pathResourceMap )
  {
    let resource = openedModule.pathResourceMap[ r ];

    if( !resource.exportable )
    continue;
    if( !resource.criterion.predefined )
    continue;
    if( !resource.path )
    continue;
    if( path.s.anyAreGlobal( resource.path ) )
    continue;

    resource.path = path.s.join( openedModule.inPath, resource.path );

  }

  return result;
}

pathsMake_body.defaults = Object.create( resourcesImport.defaults );

let pathsImport = _.routineFromPreAndBody( resourcesImport_pre, pathsMake_body );

//

function reflectorsImport( Reflector, resources )
{
  let willf = this;
  let openedModule = willf.openedModule;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.mapIs( resources ) || resources === null || resources === undefined );
  _.assert( arguments.length === 2 );

  if( !resources )
  return;

  _.each( resources, ( resource, name ) =>
  {

    let resource2 = _.mapExtend( null, resource )
    if( Reflector.OptionsFrom )
    resource2 = Reflector.OptionsFrom( resource2 );

    willf.resourceImport
    ({
      resource : resource2,
      resourceClass : Reflector,
      name : name,
    });

    if( resource.shell )
    {

      let o3 = Object.create( null );
      o3.criterion = _.mapExtend( null, resource.criterion || {} );
      o3.forEachDst = 'reflector::' + name + '*';
      if( resource.step )
      o3.inherit = resource.step;
      else
      o3.inherit = 'shell.run';
      o3.shell = resource.shell;
      o3.Importing = 1;

      willf.resourceImport
      ({
        resource : o3,
        resourceClass : will.Step,
        name : name,
      });

    }
    else if( !openedModule.stepMap[ name ] )
    {

      let o3 = Object.create( null );
      o3.criterion = _.mapExtend( null, resource.criterion || {} );
      o3.reflector = 'reflector::' + name + '*';
      if( resource.step )
      o3.inherit = resource.step;
      else
      o3.inherit = 'files.reflect';
      o3.Optional = 1;
      o3.Importing = 1;

      willf.resourceImport
      ({
        resource : o3,
        resourceClass : will.Step,
        name : name,
      });

    }

  });

}

//

function _inPathsForm()
{
  let willf = this;
  let openerModule = willf.openerModule;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( !!will.formed );
  _.assert( !!openerModule );
  _.assert( openerModule.preformed > 0 );
  _.assert( !!willf.formed );

  if( !willf.filePath )
  {
    if( !willf.dirPath )
    willf.dirPath = openerModule.dirPath;
    _.assert( _.strIs( willf.dirPath ) );
    willf.filePath = path.join( willf.dirPath, openerModule.prefixPathForRole( willf.role, willf.isOutFile ) );
  }

  willf.dirPath = path.dir( willf.filePath );

  if( willf.isOutFile === null )
  {
    willf.isOutFile = _.strHas( willf.filePath, /\.out\.\w+\.\w+$/ );
  }

}

//

function CommonPathFor( willfilesPath )
{
  if( _.arrayIs( willfilesPath ) )
  willfilesPath = willfilesPath[ 0 ];

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( willfilesPath ) );

  let common = willfilesPath.replace( /\.will(\.\w+)?$/, '' );

  return common;
}

//

function commonPathGet()
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let willfilesPath = willf.filePath ? willf.filePath : willf.dirPath;

  let common = willf.CommonPathFor( willfilesPath );

  return common;
}

//

function exists()
{
  let willf = this;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  willf._inPathsForm();

  if( !willf._found )
  {

    willf._found = fileProvider.fileConfigPathGet({ filePath : willf.filePath });

    _.assert( willf._found.length === 0 || willf._found.length === 1 );

    if( willf._found.length )
    {
      willf.unregister();
      willf.filePath = willf._found[ 0 ].particularPath;
      willf.register();
    }

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
  module : null,

}

let Composes =
{
  role : null,
  isOutFile : null,
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
  will : null,
}

let Medials =
{
  openerModule : null,
  openedModule : null,
}

let Restricts =
{
  openerModule : null,
  openedModule : null,
  formed : 0,
  id : 0,
  _found : null,
}

let Statics =
{
  KnownSections : KnownSections,
  FormatVersion : 'willfile-1.0.0',
  CommonPathFor,
}

let Forbids =
{
  module : 'module',
}

let Accessors =
{

  commonPath : { getter : commonPathGet, readOnly : 1 },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,
  register,
  unregister,
  unform,
  form,
  preform,
  open,
  read,
  importToModule,

  resourceImport,
  resourcesImport,
  pathsImport,
  reflectorsImport,

  _inPathsForm,
  CommonPathFor,
  commonPathGet,
  exists,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
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
  extend : Extend,
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
