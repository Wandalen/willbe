( function _Reflector_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wImReflector( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Reflector';

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
  let reflector = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( reflector );
  Object.preventExtensions( reflector );

  if( o )
  reflector.copy( o );

}

//

function unform()
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;

  _.assert( arguments.length === 0 );
  _.assert( !!reflector.formed );
  _.assert( module.reflectorMap[ reflector.name ] === reflector );
  if( inf )
  _.assert( inf.reflectorMap[ reflector.name ] === reflector );

  /* begin */

  delete module.reflectorMap[ reflector.name ];
  if( inf )
  delete inf.reflectorMap[ reflector.name ];

  /* end */

  reflector.formed = 0;
  return reflector;
}

//

function form1()
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 0 );
  _.assert( !reflector.formed );

  _.assert( !!im );
  _.assert( !!module );
  _.assert( !!inf );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!im.formed );
  _.assert( !!module.formed );
  _.assert( !!inf.formed );
  _.assert( _.strDefined( reflector.name ) );
  // _.assert( reflector.reflectMap === null || _.objectIs( reflector.reflectMap ) )

  /* begin */

  module.reflectorMap[ reflector.name ] = reflector;
  inf.reflectorMap[ reflector.name ] = reflector;

  if( reflector.srcFilter )
  {
    reflector.srcFilter.hubFileProvider = fileProvider;

    if( reflector.srcFilter.basePath )
    reflector.srcFilter.basePath = path.s.resolve( module.dirPath, reflector.srcFilter.basePath );

    reflector.srcFilter._formMask();
  }

  if( reflector.reflectMap )
  {
    reflector.reflectMap = _.path.globMapExtend( null, reflector.reflectMap, true );
  }

  // if( reflector.filePath )
  // reflector.filePath = path.s.resolve( module.dirPath, reflector.filePath );

  /* end */

  reflector.formed = 1;
  return reflector;
}

//

function inheritForm()
{
  let reflector = this;
  _.assert( arguments.length === 0 );
  _.assert( reflector.formed === 1 );

  /* begin */

  reflector._inheritForm({ visited : [] })

  /* end */

  reflector.formed = 2;
  return reflector;
}

//

function _inheritForm( o )
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assert( _.arrayIs( reflector.inherit ) );
  _.assertRoutineOptions( _inheritForm, arguments );

  /* begin */

  _.arrayAppendOnceStrictly( o.visited, reflector.name );

  reflector.inherit.map( ( reflectorName ) =>
  {
    reflector._inheritFrom({ visited : o.visited, reflectorName : reflectorName, defaultDst : true });
  });

  if( reflector.reflectMap )
  {
    reflector._reflectMapForm({ visited : o.visited });
  }

  /* end */

  reflector.formed = 2;
  return reflector;
}

_inheritForm.defaults=
{
  visited : null,
}

//

function _inheritFrom( o )
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assert( _.strIs( o.reflectorName ) );
  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let reflector2 = module.reflectorMap[ o.reflectorName ];
  _.sure( _.objectIs( reflector2 ), () => 'Reflector ' + _.strQuote( o.reflectorName ) + ' does not exist' );
  _.assert( !!reflector2.formed );

  if( reflector2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency reflector ' + _.strQuote( reflector.name ) + ' of ' + _.strQuote( reflector2.name ) );
    reflector2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( reflector2, _.mapNulls( reflector ) );
  delete extend.srcFilter;

  // xxx

  if( extend.reflectMap )
  {
    // extend.reflectMap = _.path.globMapExtend( null, extend.reflectMap, o.defaultDst );
    // debugger;
    // for( let r in extend.reflectMap )
    // if( extend.reflectMap[ r ] === true && extend.reflectMap[ r ] !== o.defaultDst )
    // {
    //   debugger;
    //   extend.reflectMap[ r ] = o.defaultDst;
    // }
    reflector.reflectMap = _.path.globMapExtend( reflector.reflectMap, extend.reflectMap, o.defaultDst );
    // debugger;
  }

  reflector.copy( extend );

  if( reflector2.srcFilter )
  {
    if( reflector.srcFilter )
    reflector.srcFilter.and( reflector2.srcFilter ).pathsExtend( reflector2.srcFilter );
    else
    reflector.srcFilter = reflector2.srcFilter.clone();
  }

}

_inheritFrom.defaults=
{
  reflectorName : null,
  visited : null,
  defaultDst : true,
}

//

function _reflectMapForm( o )
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
  let im = module.im;
  let fileProvider = im.fileProvider;
  let path = fileProvider.path;
  let logger = im.logger;

  _.assertRoutineOptions( _reflectMapForm, arguments );

  let map = reflector.reflectMap;
  for( let r in map )
  {
    let dst = map[ r ];

    if( !_.boolIs( dst ) )
    dst = module.strResolve( dst );

    if( module.strGetPrefix( r ) )
    {
      let resolved = module.strResolveMaybe( r );
      if( !_.errIs( resolved ) && !_.strIs( resolved ) && !( resolved instanceof im.Reflector ) )
      resolved = _.err( 'Source of reflects map was resolved to unexpected type', _.strTypeOf( resolved ) );
      if( _.errIs( resolved ) )
      throw _.err( 'Failed to form reflector', reflector.name, '\n', resolved );
      if( _.strIs( resolved ) )
      {
        delete map[ r ];
        map[ resolved ] = dst;
      }
      else if( resolved instanceof im.Reflector )
      {
        delete map[ r ];
        reflector._inheritFrom({ visited : o.visited, reflectorName : resolved.name, defaultDst : dst });
        _.sure( !!resolved.reflectMap );
        _.path.globMapExtend( map, resolved.reflectMap, dst );
      }
    }
  }

}

_reflectMapForm.defaults =
{
  visited : null,
}

//

function forReflect()
{
  let reflector = this;
  let result = Object.create( null );

  result.srcFilter = reflector.srcFilter.clone();

  // if( reflector.basePath )
  // result.srcBasePath = reflector.basePath;

  result.reflectMap = reflector.reflectMap;

  return result;
}

//

function info()
{
  let reflector = this;
  let result = '';
  let fields = _.mapOnly( reflector, { description : null, inherit : null, /*filePath : null,*/ srcFilter : null, reflectMap : null } );
  fields = _.mapButNulls( fields );

  _.assert( !!reflector.formed );

  let srcFilter;
  if( fields.srcFilter && _.routineIs( fields.srcFilter.toStr ) )
  {
    srcFilter = fields.srcFilter.toStr();
    delete fields.srcFilter;
  }
  else
  {
    fields.srcFilter = fields.srcFilter ? fields.srcFilter.hasMask() : fields.srcFilter;
  }

  result += 'Reflector ' + reflector.name;
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );

  if( srcFilter )
  result += '\n' + _.strIndentation( 'srcFilter : ' + srcFilter, '  ' );

  result += '\n';

  return result;
}

// --
// relations
// --

let Composes =
{

  name : null,
  description : null,

  reflectMap : null,

  // filePath : null,
  // basePath : null,

  srcFilter : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
}

let Associates =
{
  inf : null,
  module : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
}

let Forbids =
{
  inherited : 'inherited',
  filePath : 'filePath',
  filter : 'filter',
}

let Accessors =
{
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
  srcFilter : { setter : _.accessor.setter.copyable({ name : 'srcFilter', maker : _.FileRecordFilter }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Proto =
{

  // inter

  finit : finit,
  init : init,
  unform : unform,
  form1 : form1,

  inheritForm : inheritForm,
  _inheritForm : _inheritForm,
  _inheritFrom : _inheritFrom,

  _reflectMapForm : _reflectMapForm,

  forReflect : forReflect,

  info : info,

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

/*_.Im[ Self.shortName ] = Self;*/
_.staticDecalre
({
  prototype : _.Im.prototype,
  name : Self.shortName,
  value : Self,
});

})();
