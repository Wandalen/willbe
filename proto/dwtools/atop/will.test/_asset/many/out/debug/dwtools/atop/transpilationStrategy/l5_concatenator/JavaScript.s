( function _JavaScript_s_() {

'use strict';

//

let _ = wTools;
let Parent = _.TranspilationStrategy.Concatenator.Abstract;
let Self = function wTsConcatenatorJavaScript( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'JavaScript';

// --
// routines
// --

function init()
{
  let self = Parent.prototype.init.apply( this, arguments );

  self.starter = new _.StarterMakerLight();

  return self;
}

//

function _performAct( single )
{
  let self = this;
  let sys = self.sys;
  let result = '';
  let filesMap = single.dataMap;
  let starter = self.starter;
  let multiple = single.multiple;
  let basePath = multiple.inPath.basePaths[ 0 ];
  let entryPath = multiple.entryPath;
  let externalBeforePath = multiple.externalBeforePath;
  let externalAfterPath = multiple.externalAfterPath;

  _.assert( _.mapIs( filesMap ) );
  _.assert( arguments.length === 1 );
  _.assert( single instanceof sys.Single );

  /* wrap */

  if( multiple.simpleConcatenator || multiple.splittingStrategy === 'OneToOne' )
  {

    filesMap = _.map( filesMap, ( fileData, filePath ) =>
    {
      return starter.sourceWrapSimple
      ({
        filePath,
        fileData,
        removingShellPrologue : self.removingShellPrologue,
      });
    });

    result = _.mapVals( filesMap ).join( '\n' );

  }
  else
  {

    result = starter.sourcesJoin
    ({
      outPath : single.outPath,
      entryPath : entryPath,
      basePath : basePath,
      externalBeforePath : externalBeforePath,
      externalAfterPath : externalAfterPath,
      filesMap : filesMap,
      removingShellPrologue : self.removingShellPrologue,
    });

  }

  /* */

  return result;
}

//

function sourceWrapSimple( o )
{
  let self = this;

  _.routineOptions( sourceWrapSimple, arguments );

  let fileName = _.strVarNameFor( _.path.fullName( o.filePath ) );

  let prefix = `( function ${fileName}() { // == begin of file ${fileName}\n`;

  let postfix =
`// == end of file ${fileName}
})();
`

  let result = prefix + o.fileData + postfix;

  return result;
}

sourceWrapSimple.defaults =
{
  basePath : null,
  filePath : null,
  fileData : null,
}

// --
// relationships
// --

let Composes =
{
  ext : _.define.own([ 'js', 's', 'ss' ]),
  removingShellPrologue : 1,
}

let Associates =
{
  starter : null,
}

let Restricts =
{
}

// --
// prototype
// --

let Proto =
{

  init,

  _performAct,

  sourceWrapSimple,

  /* */

  Composes,
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

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.TranspilationStrategy.Concatenator[ Self.shortName ] = Self;

})();
