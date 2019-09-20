( function _StarterMaker_s_() {

'use strict';

//

let _ = wTools;
let Parent = null
let Self = function wStarterMakerLight( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'StarterMakerLight';

// --
// routines
// --

function instanceOptions( o )
{
  let self = this;

  for( let k in o )
  {
    if( o[ k ] === null && _.arrayHas( self.InstanceDefaults, k ) )
    o[ k ] = self[ k ];
  }

  return o;
}

// --
// file
// --

function sourceWrapSplits( o )
{
  let self = this;

  _.routineOptions( sourceWrapSplits, arguments );
  _.assert( arguments.length === 1 );
  _.assert( _.arrayHas( [ 'njs', 'browser' ], o.interpreter ) );

  let relativeFilePath = _.path.dot( _.path.relative( o.basePath, o.filePath ) );
  let relativeDirPath = _.path.dot( _.path.dir( relativeFilePath ) );
  let fileName = _.strVarNameFor( _.path.fullName( o.filePath ) );
  let fileNameNaked = fileName + '_naked';

  let prefix1 = `/* */  /* begin of file ${fileName} */ ( function ${fileName}() { `;
  let prefix2 = `function ${fileNameNaked}() { `;

  let postfix2 = `\n/* */    };`;

  let ware = '\n';

  if( o.interpreter === 'browser' )
  ware +=
`
/* */  let _filePath_ = _starter_._pathResolve( null, '/', '${relativeFilePath}' );
/* */  let _dirPath_ = _starter_._pathResolve( null, '/', '${relativeDirPath}' );
`
  else
  ware +=
`
/* */  let _filePath_ = _starter_._pathResolve( null, _libraryFilePath_, '${relativeFilePath}' );
/* */  let _dirPath_ = _starter_._pathResolve( null, _libraryFilePath_, '${relativeDirPath}' );
`

  ware +=
`
/* */  let __filename = _filePath_;
/* */  let __dirname = _dirPath_;
/* */  let module = _starter_._sourceMake( _filePath_, _dirPath_, ${fileNameNaked} );
/* */  let require = module.include;
/* */  let include = module.include;
`

  if( o.running )
  ware += `/* */  ${fileNameNaked}();`;

  let postfix1 =
`
/* */  /* end of file ${fileName} */ })();
`

  let result = Object.create( null );
  result.prefix1 = prefix1;
  result.prefix2 = prefix2;
  result.ware = ware;
  result.postfix2 = postfix2;
  result.postfix1 = postfix1;
  return result;
}

sourceWrapSplits.defaults =
{
  filePath : null,
  basePath : null,
  running : 0,
  interpreter : 'njs',
}

//

function sourceWrap( o )
{
  let self = this;
  _.assert( arguments.length === 1 );
  _.routineOptions( sourceWrap, arguments );
  self.instanceOptions( o );

  if( o.removingShellPrologue )
  o.fileData = self.sourceRemoveShellPrologue( o.fileData );

  let splits = self.sourceWrapSplits({ filePath : o.filePath, basePath : o.basePath });
  let result = splits.prefix1 + splits.prefix2 + o.fileData + splits.postfix2 + splits.ware + splits.postfix1;
  return result;
}

var defaults = sourceWrap.defaults = Object.create( sourceWrapSplits.defaults );
defaults.fileData = null;
defaults.removingShellPrologue = null;

//

function sourceWrapSimple( o )
{
  let self = this;
  _.assert( arguments.length === 1 );
  _.routineOptions( sourceWrapSimple, arguments );
  self.instanceOptions( o );

  if( o.removingShellPrologue )
  o.fileData = self.sourceRemoveShellPrologue( o.fileData );

  let fileName = _.strCamelize( _.path.fullName( o.filePath ) );

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
  filePath : null,
  fileData : null,
  removingShellPrologue : null,
}

//

/*
qqq : investigate and add test case for such case
  if( fileData.charCodeAt( 0 ) === 0xFEFF )
  fileData = fileData.slice(1);
*/

function sourceRemoveShellPrologue( fileData )
{
  let self = this;
  let splits = _.strSplitFast( fileData, /^\s*\#\![^\n]*\n/ );
  _.assert( arguments.length === 1 );
  if( splits.length > 1 )
  return '// ' + splits[ 1 ] + splits[ 2 ];
  else
  return fileData;
}

// --
// files
// --

function sourcesJoinSplits( o )
{
  let self = this;
  let r = Object.create( null );
  r.prefix = '';
  r.ware = '';
  r.interpreter = '';
  r.starter = '';
  r.env = '';
  r.externalBefore = '';
  r.entry = '';
  r.externalAfter = '';
  r.postfix = '';
  Object.preventExtensions( r );

  o = _.routineOptions( sourcesJoinSplits, arguments );
  _.assert( _.arrayHas( [ 'njs', 'browser' ], o.interpreter ) );

  if( o.entryPath )
  {
    _.assert( _.strIs( o.basePath ) );
    _.assert( _.strIs( o.entryPath ) || _.arrayIs( o.entryPath ) )
    o.entryPath = _.arrayAs( o.entryPath );
    o.entryPath = _.path.s.join( o.basePath, o.entryPath );
  }

  if( o.libraryName === null )
  o.libraryName = _.strVarNameFor( _.path.fullName( o.outPath ) );

  /* prefix */

  r.prefix =
`
/* */  /* begin of library ${o.libraryName} */ ( function _library_() {
`

  /* ware */

  r.ware =
`
/* */  /* begin of ware */ ( function _StarterWare_() {

  ${_.routineParse( self.WareCode.begin ).bodyUnwrapped};

  ${gr( 'strIs' )}
  ${gr( '_strBeginOf' )}
  ${gr( '_strEndOf' )}
  ${gr( '_strRemovedBegin' )}
  ${gr( '_strRemovedEnd' )}
  ${gr( 'strBegins' )}
  ${gr( 'strEnds' )}
  ${gr( 'strRemoveBegin' )}
  ${gr( 'strRemoveEnd' )}
  ${gr( 'regexpIs' )}
  ${gr( 'longIs' )}
  ${gr( 'primitiveIs' )}
  ${gr( 'strBegins' )}
  ${gr( 'objectIs' )}
  ${gr( 'objectLike' )}
  ${gr( 'arrayLike' )}
  ${gr( 'arrayIs' )}
  ${gr( 'numberIs' )}
  ${gr( 'argumentsArrayIs' )}
  ${gr( 'routineIs' )}
  ${gr( 'mapSupplementStructureless' )}
  ${gr( 'routineOptions' )}
  ${gr( 'arrayAppendArrays' )}
  ${gr( 'arrayAppendedArrays' )}
  ${gr( 'arrayLeft' )}
  ${gr( 'arrayLeftIndex' )}
  ${gr( 'arrayLeftDefined' )}
  ${gr( 'err' )}
  ${gr( '_err' )}
  ${gr( 'errIs' )}
  ${gr( 'unrollIs' )}
  ${gr( 'diagnosticStack' )}
  ${gr( 'diagnosticStackCondense' )}
  ${gr( 'diagnosticLocation' )}
  ${gr( 'strType' )}
  ${gr( 'strPrimitiveType' )}
  ${gr( 'strHas' )}
  ${gr( 'strLike' )}
  ${gr( 'rangeIs' )}
  ${gr( 'numbersAre' )}
  ${gr( 'bufferTypedIs' )}
  ${gr( 'bufferNodeIs' )}

  ${pr( 'refine' )}
  ${pr( '_normalize' )}
  ${pr( 'canonize' )}
  ${pr( 'canonizeTolerant' )}
  ${pr( '_pathNativizeWindows' )}
  ${pr( '_pathNativizePosix' )}
  ${pr( 'isGlob' )}
  ${pr( 'isRelative' )}
  ${pr( 'isAbsolute' )}

  ${pfs()}

  ${_.routineParse( self.WareCode.end ).bodyUnwrapped};
  `

  if( o.interpreter === 'browser' )
  r.ware +=
`

`

  r.ware +=
`
/* */  /* end of ware */ })();

`

  /* bro */

  if( o.interpreter === 'browser' )
  r.interpreter =
`
/* */  /* end of bro */ ( function _Bro_() {

  ${_.routineParse( self.BroCode.begin ).bodyUnwrapped};
  ${_.routineParse( self.BroCode.end ).bodyUnwrapped};

/* */  /* end of bro */ })();

`

  /* njs */

  if( o.interpreter === 'njs' )
  r.interpreter =
`
/* */  /* end of njs */ ( function _Njs_() {

  ${_.routineParse( self.NjsCode.begin ).bodyUnwrapped};
  ${_.routineParse( self.NjsCode.end ).bodyUnwrapped};

/* */  /* end of njs */ })();

`

  /* starter */

  r.starter =
`
/* */  /* begin of starter */ ( function _Starter_() {

  ${_.routineParse( self.StarterCode.begin ).bodyUnwrapped};

/* */  let _platform_ = '${o.interpreter}';

  ${_.routineParse( self.StarterCode.end ).bodyUnwrapped};

/* */  /* end of starter */ })();

`

  /* env */

  r.env = ``;

  if( o.interpreter !== 'browser' )
  r.env +=
`
/* */  let _libraryFilePath_ = _starter_.path.canonizeTolerant( __filename );
/* */  let _libraryDirPath_ = _starter_.path.canonizeTolerant( __dirname );

`

  if( o.interpreter === 'browser' )
  r.env +=
`
/* */  if( !_global_._libraryFilePath_ )
/* */  _global_._libraryFilePath_ = '/';
/* */  if( !_global_._libraryDirPath_ )
/* */  _global_._libraryDirPath_ = '/';
`

  /* code */

  /* ... code goes here ... */

  /* external */

  if( o.externalBeforePath || o.externalAfterPath )
  _.assert( _.strIs( o.outPath ), 'Expects out path' );

  r.externalBefore = '\n';
  if( o.externalBeforePath )
  o.externalBeforePath.forEach( ( externalPath ) =>
  {
    if( _.path.isAbsolute( externalPath ) )
    externalPath = _.path.dot( _.path.relative( _.path.dir( o.outPath ), externalPath ) );
    r.externalBefore += `/* */  debugger;`;
    r.externalBefore += `/* */  _starter_._sourceInclude( null, _libraryDirPath_, '${externalPath}' );\n`;
  });

  r.externalAfter = '\n';
  if( o.externalAfterPath )
  o.externalAfterPath.forEach( ( externalPath ) =>
  {
    if( _.path.isAbsolute( externalPath ) )
    externalPath = _.path.dot( _.path.relative( _.path.dir( o.outPath ), externalPath ) );
    r.externalAfter += `/* */  _starter_._sourceInclude( null, _libraryDirPath_, '${externalPath}' );\n`;
  });

  /* entry */

  r.entry = '\n';
  if( o.entryPath )
  o.entryPath.forEach( ( entryPath ) =>
  {
    entryPath = _.path.relative( o.basePath, entryPath );
    r.entry += `/* */  module.exports = _starter_._sourceInclude( null, _libraryFilePath_, './${entryPath}' );\n`;
  });

  /* postfix */

  r.postfix =
`
/* */  /* end of library ${o.libraryName} */ })()
`

  /* */

  return r;

  function elementExport( srcContainer, dstContainerName, name )
  {
    let e = srcContainer[ name ];
    _.assert
    (
      _.routineIs( e ) || _.strIs( e ) || _.regexpIs( e ),
      () => 'Cant export ' + _.strQuote( name ) + ' is ' + _.strType( e )
    );
    let str = '';
    if( _.routineIs( e ) )
    {
      if( e.functor )
      str = '(' + e.functor.toString() + ')();';
      else
      str = e.toString();
    }
    else
    {
      str = _.toJs( e );
    }
    let r = dstContainerName + '.' + name + ' = ' + _.strIndentation( str, '  ' ) + ';\n\n//\n';
    return r;
  }

  function gr( name )
  {
    return elementExport( _, '_', name );
  }

  function pr( name )
  {
    return elementExport( _.path, 'path', name );
  }

  function pfs( name )
  {
    let result = [];
    for( let f in _.path )
    {
      let e = _.path[ f ];
      if( _.strIs( e ) || _.regexpIs( e ) )
      result.push( pr( f ) );
    }
    return result.join( '  ' );
  }

}

sourcesJoinSplits.defaults =
{
  basePath : null,
  entryPath : null,
  outPath : null,
  libraryName : null,
  externalBeforePath : null,
  externalAfterPath : null,
  interpreter : 'njs',
}

//

function sourcesJoin( o )
{
  let self = this;

  _.routineOptions( sourcesJoin, arguments );
  self.instanceOptions( o );

  /* */

  o.filesMap = _.map( o.filesMap, ( fileData, filePath ) =>
  {
    return self.sourceWrap
    ({
      filePath,
      fileData,
      basePath : o.basePath,
      removingShellPrologue : o.removingShellPrologue,
    });
  });

  /* */

  let result = _.mapVals( o.filesMap ).join( '\n' );

  let splits = self.sourcesJoinSplits
  ({
    entryPath : o.entryPath,
    basePath : o.basePath,
    externalBeforePath : o.externalBeforePath,
    externalAfterPath : o.externalAfterPath,
    outPath : o.outPath,
    interpreter : o.interpreter,
  });

  result = splits.prefix + splits.ware + splits.interpreter + splits.starter + splits.env + result + splits.externalBefore + splits.entry + splits.externalAfter + splits.postfix;

  return result;
}

var defaults = sourcesJoin.defaults = Object.create( sourcesJoinSplits.defaults );

defaults.filesMap = null;
defaults.removingShellPrologue = null;

// --
// etc
// --

function htmlSplitsFor( o )
{
  let self = this;
  let r = Object.create( null );

  _.routineOptions( htmlSplitsFor, arguments );

  if( o.starterIncluding === null )
  o.starterIncluding = htmlSplitsFor.defaults.starterIncluding;
  _.assert( _.arrayHas( [ 'include', 'inline', 0, false ], o.starterIncluding ) );
  _.assert( o.starterIncluding !== 'inline', 'not implemented' );

  r.prefix =
`
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${o.title}</title>
`

  if( o.starterIncluding === 'include' )
  r.starter = `  <script src="/.starter"></script>\n`;

  r.scripts = [];
  for( let filePath in o.srcScriptsMap )
  {
    let split = `  <script src="${filePath}"></script>`;
    r.scripts.push( split );
  }

  r.postfix =
`
</head>
<body>
</body>
</html>
`

  return r;
}

htmlSplitsFor.defaults =
{
  srcScriptsMap : null,
  starterIncluding : 'include',
  title : 'Title',
}

//

function htmlFor( o )
{
  let self = this;

  _.routineOptions( htmlFor, arguments );

  let splits = self.htmlSplitsFor( o );

  let result = splits.prefix + splits.starter + splits.scripts.join( '\n' ) + splits.postfix;

  return result;
}

htmlFor.defaults = Object.create( htmlSplitsFor.defaults );

/*

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Title</title>
  <script src="http://localhost:4444/Starter.js"></script>
  {each::<script src="{::filePath}"></script>}
</head>
<body>
  <script>
    require( '.' )
  </script>
</body>
</html>

*/

// --
// relationships
// --

let InstanceDefaults = [ 'removingShellPrologue' ];

let Composes =
{
  removingShellPrologue : 1,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  WareCode : require( './WareCode.s' ),
  BroCode : require( './BroCode.s' ),
  NjsCode : require( './NjsCode.s' ),
  StarterCode : require( './StarterCode.s' ),
  InstanceDefaults,
}

// --
// prototype
// --

let Proto =
{

  instanceOptions,

  sourceWrapSplits,
  sourceWrap,

  sourceWrapSimple,
  sourceRemoveShellPrologue,

  sourcesJoinSplits,
  sourcesJoin,

  htmlSplitsFor,
  htmlFor,

  /* */

  Composes,
  Associates,
  Restricts,
  Statics,

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
module[ 'exports' ] = Self;
_[ Self.shortName ] = Self;

})();
