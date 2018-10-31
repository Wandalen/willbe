( function _Export_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillExport( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Export';

// --
// inter
// --

function _inheritFrom( o )
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.strIs( o.name ) );
  _.assert( arguments.length === 1 );
  _.assert( exp.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let exp2 = module.exportMap[ o.name ];
  _.sure( _.objectIs( exp2 ), () => 'Export ' + _.strQuote( o.name ) + ' does not exist' );
  _.assert( !!exp2.formed );

  if( exp2.formed !== 2 )
  {
    _.sure( !_.arrayHas( o.visited, exp2.name ), () => 'Cyclic dependency exp ' + _.strQuote( exp.name ) + ' of ' + _.strQuote( exp2.name ) );
    exp2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( exp2, _.mapNulls( exp ) );
  exp.copy( extend );

  if( exp2.settings )
  exp.settings = _.mapSupplement( exp.settings, exp2.settings );

}

_inheritFrom.defaults=
{
  name : null,
  visited : null,
}

//

function form3()
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( exp.formed === 2 );

  /* begin */

  if( exp.default === null )
  exp.default = 0;

  if( exp.tar === null )
  exp.tar = 1;

  _.sure( _.strIs( module.strResolve( exp.files ) ), () => 'Expects path to files, but got ' + _.toStrShort( exp.files ) );

  /* end */

  exp.formed = 3;
  return exp;
}

//

function exportPathFor()
{
  let exp = this
  let module = exp.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( exp.files ) );

  return hd.path.resolve( module.dirPath, module.strResolve( exp.files ) );
}

//

function archivePathFor()
{
  let exp = this
  let module = exp.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inExportFile = module.inFileWithRoleMap.export || module.inFileWithRoleMap.single;

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( exp.name ) );
  _.assert( inExportFile instanceof will.InFile );

  let outDir = module.pathMap.outDir || hd.path.dir( inExportFile.filePath ) || '.';

  return hd.path.resolve( module.dirPath, outDir, module.about.name + exp.name + '.out.tgs' );
}

//

function outFilePathFor()
{
  let exp = this
  let module = exp.module;
  let will = module.will;
  let hub = will.fileProvider;
  let hd = hub.providersWithProtocolMap.file;
  let inExportFile = module.inFileWithRoleMap.export || module.inFileWithRoleMap.single;

  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( exp.name ) );
  _.assert( inExportFile instanceof will.InFile );

  let outDir = module.pathMap.outDir || hd.path.dir( inExportFile.filePath ) || '.';

  return hd.path.resolve( module.dirPath, outDir, module.about.name + exp.name + '.out.yml' );
}

// --
// relations
// --

let Composes =
{
  default : null,
  tar : null,
  files : null,
  settings : null,
  inherit : _.define.own([]),
}

let Aggregates =
{
  name : null,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  MapName : 'exportMap',
}

let Forbids =
{
}

let Accessors =
{
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  _inheritFrom : _inheritFrom,
  form3 : form3,

  exportPathFor : exportPathFor,
  archivePathFor : archivePathFor,
  outFilePathFor : outFilePathFor,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

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
