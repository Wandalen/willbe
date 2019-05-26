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

  _.arrayRemoveElementOnceStrictly( module.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( module.willfileWithRoleMap[ willf.role ] === willf )
    delete module.willfileWithRoleMap[ willf.role ];
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

  _.assert( 0, 'not tested' );

  _.assert( arguments.length === 0 );
  _.assert( !!will );
  _.assert( module.preformed > 0 );
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
  _.assert( module.preformed > 0 );
  _.assert( !!will.formed );

  /* begin */

  _.arrayAppendOnceStrictly( module.willfilesArray, willf );

  if( willf.role )
  {
    _.assert( !module.willfileWithRoleMap[ willf.role ], 'Module already has willf file with role', willf.role )
    module.willfileWithRoleMap[ willf.role ] = willf;
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
  _.assert( module.preformed > 0 );
  _.assert( !!willf.formed );

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

  /* form */

  if( willf.data.format !== undefined && willf.data.format !== willf.FormatVersion )
  throw _.err( 'Does not support format', willf.data.format + ',', 'supports only', willf.FormatVersion );

  /* */

  _.assert( willf.dirPath === path.dir( willf.filePath ) );

  /* */

  if( willf.data.about )
  module.about.copy( willf.data.about );

  let con = _.Consequence().take( null );

  /* */

  // debugger;

  // if( _.strEnds( willf.filePath, 'module-a' ) )
  // debugger;

  willf.resourcesMake( will.Exported, willf.data.exported );
  willf.resourcesMake( will.Submodule, willf.data.submodule );

  // if( module.nickName === 'module::Proto' )
  // debugger;

  willf.pathsMake( will.PathResource, willf.data.path );

  // if( module.nickName === 'module::Proto' )
  // debugger;

  willf.resourcesMake( will.Step, willf.data.step );
  willf.reflectorsMake( will.Reflector, willf.data.reflector );
  willf.resourcesMake( will.Build, willf.data.build );

  // debugger;

  _.assert( path.s.allAreAbsolute( module.pathResourceMap[ 'module.dir' ].path ) );
  _.assert( path.s.allAreAbsolute( module.pathResourceMap[ 'module.willfiles' ].path ) );
  _.assert( path.s.allAreAbsolute( module.pathResourceMap[ 'local' ].path ) );
  _.assert( path.s.allAreAbsolute( module.pathResourceMap[ 'will' ].path ) );

  // if( _.strEnds( willf.filePath, 'module-a' ) )
  // debugger;

  willf.formed = 2;
  return true;
}

//

function resourceMake_pre( routine, args )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
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

function resourceMake_body( o )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( resourceMake, arguments );

  if( !o.resource )
  return;

  _.assert( !!o.resource );
  _.assert( _.constructorIs( o.resourceClass ) );
  _.assert( arguments.length === 1 );

  // debugger;
  // if( o.resourceClass.shortName === 'Reflector' )
  // debugger;

  let o2;
  if( o.resourceClass.OptionsFrom )
  o2 = o.resourceClass.OptionsFrom( o.resource );
  else
  o2 = _.mapExtend( null, o.resource );

  o2.willf = willf;
  o2.module = module;
  o2.name = o.name;
  o2.Importing = 1;

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

resourceMake_body.defaults =
{
  resourceClass : null,
  resource : null,
  name : null,
}

let resourceMake = _.routineFromPreAndBody( resourceMake_pre, resourceMake_body );

//

function resourcesMake_pre( routine, args )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
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

function resourcesMake_body( o )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( resourcesMake, arguments );

  if( !o.resources )
  return;

  _.assert( _.mapIs( o.resources ) );
  _.assert( _.constructorIs( o.resourceClass ) );
  _.assert( arguments.length === 1 );

  _.each( o.resources, ( resource, k ) =>
  {

    willf.resourceMake
    ({
      resource : resource,
      resourceClass : o.resourceClass,
      name : k,
    });

  });

  //   if( o.resourceClass.OptionsFrom )
  //   resource = o.resourceClass.OptionsFrom( resource );
  //
  //   let o2 = _.mapExtend( null, resource );
  //   o2.willf = willf;
  //   o2.module = module;
  //   o2.name = k;
  //   o2.Importing = 1;
  //
  //   try
  //   {
  //     o.resourceClass.MakeForEachCriterion( o2 );
  //   }
  //   catch( err )
  //   {
  //     debugger;
  //     throw _.err( 'Cant form', o.resourceClass.KindName + '::' + o2.name, '\n', err );
  //   }
  //
  // });

}

resourcesMake_body.defaults =
{
  resourceClass : null,
  resources : null,
}

let resourcesMake = _.routineFromPreAndBody( resourcesMake_pre, resourcesMake_body );

//

function pathsMake_body( o )
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  // if( module.nickName === 'module::Proto' )
  // debugger;

  let dirPath = module.dirPath;

  let result = willf.resourcesMake.body.call( willf, o );

  if( dirPath && path.isAbsolute( dirPath ) && dirPath !== module.dirPath )
  {
    // debugger;
    module._dirPathChange( dirPath );
  }

  _.assert( path.isAbsolute( module.inPath ) );

  for( let r in module.pathResourceMap )
  {
    let resource = module.pathResourceMap[ r ];

    // if( module.nickName === 'module::Proto' )
    // if( resource.name === 'in' )
    // debugger;
    // if( module.nickName === 'module::Proto' )
    // if( resource.name === 'module.willfiles' )
    // debugger;

    if( !resource.exportable )
    continue;
    if( !resource.criterion.predefined )
    continue;
    if( !resource.path )
    continue;
    if( path.s.anyAreGlobal( resource.path ) )
    continue;

    resource.path = path.s.join( module.inPath, resource.path );

  }

  return result;
}

pathsMake_body.defaults = Object.create( resourcesMake.defaults );

let pathsMake = _.routineFromPreAndBody( resourcesMake_pre, pathsMake_body );

//

function reflectorsMake( Reflector, resources )
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

    // debugger;
    let resource2 = _.mapExtend( null, resource )
    if( Reflector.OptionsFrom )
    resource2 = Reflector.OptionsFrom( resource2 );

    willf.resourceMake
    ({
      resource : resource2,
      resourceClass : Reflector,
      name : name,
    });

    // let o2 = _.mapExtend( null, resource );
    // o2.willf = willf;
    // o2.module = module;
    // o2.name = name;
    // o2.Importing = 1;
    //
    // delete o2.step;
    //
    // try
    // {
    //   Reflector.MakeForEachCriterion( o2 );
    // }
    // catch( err )
    // {
    //   debugger;
    //   throw _.err( 'Cant form', Reflector.KindName + '::' + o2.name, '\n', err );
    // }

    if( resource.shell )
    {

      let o3 = Object.create( null );
      o3.criterion = _.mapExtend( null, resource.criterion || {} );
      // o3.willf = willf;
      // o3.module = module;
      // o3.name = name;
      o3.forEachDst = 'reflector::' + name + '*';
      if( resource.step )
      o3.inherit = resource.step;
      else
      o3.inherit = 'shell.run';
      o3.shell = resource.shell;
      o3.Importing = 1;
      // o3.Optional = 1;

      willf.resourceMake
      ({
        resource : o3,
        resourceClass : will.Step,
        name : name,
      });

      // try
      // {
      //   will.Step.MakeForEachCriterion( o3 );
      // }
      // catch( err )
      // {
      //   debugger;
      //   throw _.err( 'Cant form', will.Step.KindName + '::' + o3.name, '\n', err );
      // }

    }
    else if( !module.stepMap[ name ] )
    {

      let o3 = Object.create( null );
      o3.criterion = _.mapExtend( null, resource.criterion || {} );
      // o3.willf = willf;
      // o3.module = module;
      // o3.name = name;
      o3.reflector = 'reflector::' + name + '*';
      if( resource.step )
      o3.inherit = resource.step;
      else
      o3.inherit = 'predefined.reflect';
      o3.Optional = 1;
      o3.Importing = 1;

      willf.resourceMake
      ({
        resource : o3,
        resourceClass : will.Step,
        name : name,
      });

      // try
      // {
      //   will.Step.MakeForEachCriterion( o3 );
      // }
      // catch( err )
      // {
      //   debugger;
      //   throw _.err( 'Cant form', will.Step.KindName + '::' + o3.name, '\n', err );
      // }

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
  _.assert( module.preformed > 0 );
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

function commonPathGet()
{
  let willf = this;
  let module = willf.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let willfilesPath = willf.filePath ? willf.filePath : willf.dirPath;

  // debugger;
  let common = module.CommonPathFor( willfilesPath );
  // debugger;

  return common;
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
  module : null,

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

let Accessors =
{

  commonPath : { getter : commonPathGet, readOnly : 1 },

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

  resourceMake,
  resourcesMake,
  pathsMake,
  reflectorsMake,

  _inPathsForm,
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
