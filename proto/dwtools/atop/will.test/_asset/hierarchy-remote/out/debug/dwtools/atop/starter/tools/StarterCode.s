( function _StarterCode_s_() {

'use strict';

let _ = wTools;

// debugger;
// let wasPrepareStackTrace = Error.prepareStackTrace;
// Error.prepareStackTrace = function( err, stack )
// {
//   debugger;
// }

// --
// begin
// --

function _Begin()
{

  'use strict';

  let _global = _global_;
  if( _global._starter_ && _global._starter_._inited )
  return;

  let _starter_ = _global_._starter_;
  let _ = _starter_;
  let path = _starter_.path;
  let sourcesMap = _starter_.sourcesMap;

  //

  function SourceFile( o )
  {
    let starter = _starter_;

    if( !( this instanceof SourceFile ) )
    return new SourceFile( o );

    if( o.njsModule === undefined )
    o.njsModule = null;
    if( o.njsModule )
    o.njsModule.sourceFile = this;

    if( o.isScript === undefined )
    o.isScript = true;

    o.filePath = starter.path.canonizeTolerant( o.filePath );
    if( !o.dirPath )
    o.dirPath = starter.path.dir( o.filePath );
    o.dirPath = starter.path.canonizeTolerant( o.dirPath );

    this.filePath = o.filePath;
    this.dirPath = o.dirPath;
    this.nakedCall = o.nakedCall;
    this.isScript = o.isScript;

    this.filename = o.filePath;
    this.exports = undefined;
    this.parent = null;
    this.njsModule = o.njsModule;
    this.error = null;
    this.state = o.nakedCall ? 'preloaded' : 'created';

    this.starter = starter;
    this.include = starter._sourceInclude.bind( starter, this, this.dirPath );
    this.resolve = starter._sourceResolve.bind( starter, this, this.dirPath );
    this.include.resolve = this.resolve;
    this.include.sourceFile = this;

    /* njs compatibility */

    this.path = [ '/' ];
    this.loaded = false;
    this.id = o.filePath;

    if( _platform_ === 'browser' )
    starter._broSourceFile( this, o );
    else
    starter._njsSourceFile( this, o );

    starter.sourcesMap[ o.filePath ] = this;
    Object.preventExtensions( this );
    return this;
  }

  //

  function _sourceMake( filePath, dirPath, nakedCall )
  {
    let r = SourceFile({ filePath, dirPath, nakedCall });
    return r;
  }

  //

  function _sourceIncludeAct( parentSource, childSource, sourcePath )
  {
    let starter = this;

    try
    {

      if( !childSource )
      throw _._err({ args : [ `Found no source file ${sourcePath}` ], level : 4 });

      if( childSource.state === 'errored' || childSource.state === 'opening' || childSource.state === 'opened' )
      return childSource.exports;

      childSource.state = 'opening';
      childSource.parent = parentSource || null;
      childSource.nakedCall.call( childSource );
      childSource.loaded = true;
      childSource.state = 'opened';

      if( Config.interpreter === 'njs' )
      starter._njsModuleFromSource( childSource );

    }
    catch( err )
    {
      // debugger;
      // err.message += '\nError including ' + ( childSource ? childSource.filePath : 'source file' );
      err = _.err( err, `\nError including source file ${ childSource ? childSource.filePath : '' }` );
      if( childSource )
      {
        childSource.error = err;
        childSource.state = 'errored';
      }
      throw err;
    }

    return childSource.exports;
  }

  //

  function _sourceInclude( parentSource, basePath, filePath )
  {
    let starter = this; debugger;

    if( _.arrayIs( filePath ) )
    {
      let result = [];
      for( let f = 0 ; f < filePath.length ; f++ )
      {
        let r = starter._sourceInclude( parentSource, basePath, filePath[ f ] );
        if( r !== undefined )
        _.arrayAppendArrays( result, r );
        else
        result.push( r );
      }
      return result;
    }

    let childSource = starter._sourceForIncludeGet.apply( starter, arguments );
    if( childSource )
    return starter._sourceIncludeAct( parentSource, childSource, filePath );

    if( _platform_ === 'browser' )
    return starter._broInclude( parentSource, basePath, filePath );
    else
    return starter._njsInclude( parentSource, basePath, filePath );

  }

  //

  function _sourceResolve( parentSource, basePath, filePath )
  {
    let result = this._sourceOwnResolve( parentSource, basePath, filePath );
    if( result !== null )
    return result;

    if( _platform_ === 'browser' )
    {
      return this._broResolve( parentSource, basePath, filePath );
    }
    else
    {
      return this._njsResolve( parentSource, basePath, filePath );
    }

  }

  //

  function _sourceOwnResolve( parentSource, basePath, filePath )
  {
    let starter = this;
    let childSource = starter._sourceForIncludeGet.apply( this, arguments );
    if( !childSource )
    return null;
    return childSource.filePath;
  }

  //

  function _sourceForPathGet( filePath )
  {
    filePath = this.path.canonizeTolerant( filePath );
    let childSource = this.sourcesMap[ filePath ];
    if( childSource )
    return childSource;
    return null;
  }

  //

  function _sourceForIncludeGet( sourceFile, basePath, filePath )
  {
    let resolvedFilePath = this._pathResolve( sourceFile, basePath, filePath );
    let childSource = this.sourcesMap[ resolvedFilePath ];
    if( childSource )
    return childSource;
    return null;
  }

  //

  function _pathResolve( sourceFile, basePath, filePath )
  {
    let starter = this;

    if( sourceFile && !basePath )
    {
      basePath = sourceFile.dirPath;
    }

    if( !basePath && !sourceFile )
    {
      debugger;
      throw 'Base path is not specified, neither script file';
    }

    let isRelative = _.strBegins( filePath, './' ) || _.strBegins( filePath, '../' ) || filePath === '.' || filePath === '..';

    filePath = starter.path.canonizeTolerant( filePath );

    if( isRelative && filePath[ 0 ] !== '/' )
    {
      filePath = starter.path.canonizeTolerant( basePath + '/' + filePath );
      if( filePath[ 0 ] !== '/' )
      filePath = './' + filePath;
    }

    return filePath;
  }

  //

  function _init()
  {
    if( this._inited )
    {
      debugger;
      return;
    }
    if( Config.interpreter === 'njs' )
    this._njsInit();
    else
    this._broInit();
    this._inited = 1;
  }

}

// --
// end
// --

function _End()
{

  let Fields =
  {

    _inited : false,

  }

  let Routines =
  {

    SourceFile,

    _sourceMake,
    _sourceIncludeAct,
    _sourceInclude,
    _sourceResolve,
    _sourceOwnResolve,
    _sourceForPathGet,
    _sourceForIncludeGet,

    _pathResolve,

    _init,

  }

  Object.assign( _starter_, Routines );
  Object.assign( _starter_, Fields );

  _starter_._init();

}

// --
// export
// --

let Self =
{
  begin : _Begin,
  end : _End,
}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
