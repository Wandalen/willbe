( function _Multiple_s_() {

'use strict';

let Zlib;

//

let _ = wTools;
let Parent = null;
let Self = function wTsMultiple( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Multiple';

// --
// inter
// --

function finit()
{
  let multiple = this;
  _.Copyable.prototype.finit.call( multiple );
}

//

function init( o )
{
  let multiple = this;

  _.assert( !!o.sys.logger );

  if( !multiple.logger )
  multiple.logger = new _.Logger({ output : o.sys.logger });

  _.Copyable.prototype.init.call( multiple, o );
  Object.preventExtensions( multiple );
}

//

function form()
{
  let multiple = this;

  /* verification */

  _.assert( arguments.length === 0 );
  _.assert( _.numberInRange( multiple.optimization, [ 0, 9 ] ), 'Expects integer in range [ 0, 9 ] {-multiple.optimization-}' );
  _.assert( _.numberInRange( multiple.minification, [ 0, 9 ] ), 'Expects integer in range [ 0, 9 ] {-multiple.minification-}' );
  _.assert( _.numberInRange( multiple.diagnosing, [ 0, 9 ] ), 'Expects integer in range [ 0, 9 ] {-multiple.diagnosing-}' );
  _.assert( _.boolLike( multiple.beautifing ), 'Expects bool-like {-multiple.beautifing-}' );
  _.sure( _.arrayHas( [ 'ManyToOne', 'OneToOne' ], multiple.splittingStrategy ) );
  _.sure( _.arrayHas( [ 'preserve', 'rebuild' ], multiple.upToDate ), () => 'Unknown value of upToDate ' + _.strQuote( multiple.upToDate ) );

  /* parent */

  _.assert( multiple.formed === 0 );
  _.assert( _.objectIs( multiple.sys ) );
  _.assert( multiple.errors === null );
  _.assert( arguments.length === 0 );

  multiple.errors = [];
  multiple.onBegin = _.routinesCompose( multiple.onBegin );
  multiple.onEnd = _.routinesCompose( multiple.onEnd );

  if( !multiple.fileProvider )
  multiple.fileProvider = multiple.sys.fileProvider || _.FileProvider.Default();

  if( !multiple.logger )
  multiple.logger = new _.Logger({ output : multiple.sys.logger });

  _.assert( _.boolLike( multiple.sizeReporting ) );
  _.assert( multiple.fileProvider instanceof _.FileProvider.Abstract );
  _.assert( _.routineIs( multiple.onBegin ) );
  _.assert( _.routineIs( multiple.onEnd ) );

  multiple.formed = 1;

  let fileProvider = multiple.fileProvider;
  let path = fileProvider.path;

  /* path temp */

  multiple.outPath = fileProvider.recordFilter( multiple.outPath );
  multiple.inPath = fileProvider.recordFilter( multiple.inPath );

  multiple.outPath.prefixPath = multiple.outPath.prefixPath || path.current();
  multiple.inPath.prefixPath = multiple.inPath.prefixPath || path.current();
  multiple.inPath.pairWithDst( multiple.outPath );
  multiple.inPath.pairRefineLight();

  multiple.outPath._formPaths();
  multiple.inPath._formPaths();

  if( multiple.entryPath )
  {
    multiple.entryPath = fileProvider.recordFilter( multiple.entryPath );
    if( !multiple.entryPath.basePath )
    multiple.entryPath.basePath = multiple.inPath.basePaths[ 0 ];
    multiple.entryPath = fileProvider.filesFind
    ({
      filter : multiple.entryPath,
      outputFormat : 'absolute',
      mode : 'distinct',
    });

    // qqq xxx : cover the condition
    _.sure
    (
      multiple.entryPath.length === 0 || multiple.splittingStrategy === 'ManyToOne',
      () => 'Splitting strategy should be "ManyToOne" if entryPath defined'
    );

  }

  if( multiple.externalBeforePath )
  {
    multiple.externalBeforePath = fileProvider.recordFilter( multiple.externalBeforePath );
    if( !multiple.externalBeforePath.basePath )
    multiple.externalBeforePath.basePath = multiple.inPath.basePaths[ 0 ];
    multiple.externalBeforePath = fileProvider.filesFind
    ({
      filter : multiple.externalBeforePath,
      outputFormat : 'absolute',
      mode : 'distinct',
    });

    // qqq xxx : cover the condition
    _.sure
    (
      multiple.externalBeforePath.length === 0 || multiple.splittingStrategy === 'ManyToOne',
      () => 'Splitting strategy should be "ManyToOne" if externalBeforePath defined'
    );

  }

  if( multiple.externalAfterPath )
  {
    multiple.externalAfterPath = fileProvider.recordFilter( multiple.externalAfterPath );
    if( !multiple.externalAfterPath.basePath )
    multiple.externalAfterPath.basePath = multiple.inPath.basePaths[ 0 ];
    multiple.externalAfterPath = fileProvider.filesFind
    ({
      filter : multiple.externalAfterPath,
      outputFormat : 'absolute',
      mode : 'distinct',
    });

    // qqq xxx : cover the condition
    _.sure
    (
      multiple.externalAfterPath.length === 0 || multiple.splittingStrategy === 'ManyToOne',
      () => 'Splitting strategy should be "ManyToOne" if externalAfterPath defined'
    );

  }

  // multiple.entryPath = multiple.entryPath ? _.arrayAs( multiple.entryPath ) : [];
  // multiple.entryPath = path.s.join( multiple.inPath.basePaths[ 0 ], multiple.entryPath );

  multiple.tempPath = path.resolve( multiple.tempPath );

  if( multiple.writingTempFiles && multiple.tempPath )
  fileProvider.dirMake( multiple.tempPath );

  /* transpilation strategies */

  if( _.strIs( multiple.transpilingStrategy ) )
  multiple.transpilingStrategy = [ multiple.transpilingStrategy ];
  else if( !multiple.transpilingStrategy )
  multiple.transpilingStrategy = [ 'Uglify' ];
  // multiple.transpilingStrategy = [ 'Babel', 'Uglify', 'Babel' ];

  _.assert( _.strsAreAll( multiple.transpilingStrategy ) );

  for( let s = 0 ; s < multiple.transpilingStrategy.length ; s++ )
  {
    let strategy = multiple.transpilingStrategy[ s ];
    if( _.strIs( strategy ) )
    {
      _.sure( !!_.TranspilationStrategy.Transpiler[ strategy ], 'Transpiler not found', strategy )
      strategy = _.TranspilationStrategy.Transpiler[ strategy ];
    }

    if( _.routineIs( strategy ) )
    strategy = strategy({});

    multiple.transpilingStrategy[ s ] = strategy;
    _.assert( strategy instanceof _.TranspilationStrategy.Transpiler.Abstract );
  }

  /* validation */

  _.assert( _.boolLike( multiple.sizeReporting ) );
  _.assert( multiple.fileProvider instanceof _.FileProvider.Abstract );
  _.assert( _.routineIs( multiple.onBegin ) );
  _.assert( _.routineIs( multiple.onEnd ) );
  _.assert( multiple.entryPath === null || _.arrayIs( multiple.entryPath ) );

  return multiple;
}

//

function performThen()
{
  let multiple = this;
  multiple.form();
  return multiple.perform();
}

//

function perform()
{
  let multiple = this;
  let logger = multiple.logger;
  let result = _.Consequence().take( null );
  let time = _.timeNow();

  result
  .then( function( arg )
  {
    return _.routinesCall( multiple, multiple.onBegin, [ multiple ] );
  })

  result
  .then( function( arg )
  {
    multiple.singleEach( ( single ) =>
    {
      result.then( () => single.perform() );
    });
    return arg;
  });

  result
  .then( function( arg )
  {
    return _.routinesCall( multiple, multiple.onEnd, [ multiple ] );
  })
  .finally( function( err, arg )
  {
    if( err )
    {
      _.arrayAppendOnce( multiple.errors, err );
      throw _.err( err );
    }

    let reporting = false;
    if( multiple.totalReporting === null )
    reporting = multiple.verbosity === 1 || multiple.verbosity === 2 || multiple.verbosity > 5;
    else if( multiple.totalReporting )
    reporting = multiple.verbosity >= 1

    if( reporting )
    logger.log( ` # Transpiled ${multiple.srcCounter} source files to ${multiple.dstCounter} in ${_.timeSpent( time )}` );
    return null;
  });

  return result;
}

//

function singleEach( onEach )
{
  let multiple = this;
  let sys = multiple.sys;
  let logger = multiple.logger;
  let fileProvider = multiple.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( multiple.inPath.formed === 3 );
  _.assert( multiple.outPath.formed === 3 );

  /* */

  try
  {

    // debugger;
    let groups = fileProvider.filesFindGroups
    ({
      src : multiple.inPath,
      dst : multiple.outPath,
      throwing : 1,
      // recursive : 2,
      outputFormat : 'absolute',
    });
    // debugger;

    for( let dstPath in groups.filesGrouped )
    {
      let srcPaths = groups.filesGrouped[ dstPath ];
      let dataMap = Object.create( null );

      if( multiple.upToDate === 'preserve' )
      {
        let upToDate = fileProvider.filesAreUpToDate2({ dst : dstPath, src : srcPaths });
        if( upToDate )
        continue;
      }

      srcPaths.map( ( srcPath ) =>
      {
        dataMap[ srcPath ] = fileProvider.fileRead( srcPath );
      });

      if( multiple.splittingStrategy === 'ManyToOne' )
      {

        let single = sys.Single
        ({
          dataMap : dataMap,
          outPath : dstPath,
          multiple : multiple,
          sys : sys,
        });

        single.form();
        onEach( single );

      }
      else if( multiple.splittingStrategy === 'OneToOne' )
      {

        for( let srcPath in dataMap )
        {

          let basePath = multiple.inPath.basePathForFilePath( srcPath );
          let relativePath = path.relative( basePath, srcPath );
          let outPath = path.join( dstPath, relativePath );
          let dataMap2 = Object.create( null );
          dataMap2[ srcPath ] = dataMap[ srcPath ];

          let single = sys.Single
          ({
            dataMap : dataMap2,
            outPath : outPath,
            multiple : multiple,
            sys : sys,
          });

          single.form();
          onEach( single );

        }

      }
      else _.assert( 0 );

    }

  }
  catch( err )
  {
    err = _.err( err );
    throw err;
  }

}

// --
// relationships
// --

let Composes =
{

  optimization : 9,
  minification : 8,
  diagnosing : 0,
  beautifing : 0,

  /* */

  simpleConcatenator : 0,
  writingTerminalUnderDirectory : 0,
  splittingStrategy : 'ManyToOne', /* [ 'ManyToOne', 'OneToOne' ] */
  upToDate : 'preserve', /* [ 'preserve', 'rebuild' ] */
  writingTempFiles : 0,
  writingSourceMap : 1,
  sizeReporting : 1,
  dstCounter : 0,
  srcCounter : 0,

  /* */

  inPath : null,
  outPath : null,
  entryPath : null,
  externalBeforePath : null,
  externalAfterPath : null,
  tempPath : 'temp.tmp',

  /* */

  totalReporting : null,
  verbosity : 4,
  onBegin : null,
  onEnd : null,

}

let Aggregates =
{
}

let Associates =
{
  sys : null,
  transpilingStrategy : null,
  fileProvider : null,
  logger : null
}

let Restricts =
{
  formed : 0,
  errors : null,
}

let Forbids =
{
}

let Accessors =
{
  transpilingStrategy : { setter : _.accessor.setter.arrayCollection({ name : 'transpilingStrategy' }) },
}

// --
// prototype
// --

let Proto =
{

  finit,
  init,
  form,
  perform,
  performThen,

  singleEach,

  /* */

  Composes,
  Aggregates,
  Associates,
  Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.staticDeclare
({
  prototype : _.TranspilationStrategy.prototype,
  name : Self.shortName,
  value : Self,
});

})();
