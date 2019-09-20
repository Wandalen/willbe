( function _StarterMaker_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../starter/IncludeTop.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.tempDir = _.path.dirTempOpen( _.path.join( __dirname, '../..'  ), 'Starter' );
  self.assetDirPath = _.path.join( __dirname, '_asset' );
  self.find = _.fileProvider.filesFinder
  ({
    includingTerminals : 1,
    includingDirs : 1,
    withTransient/*maybe withStem*//*maybe withStem*/ : 1,
    allowingMissed : 1,
    maskPreset : 0,
    outputFormat : 'relative',
    filter :
    {
      filePath : { 'node_modules' : 0, 'package.json' : 0, 'package-lock.json' : 0 },
      recursive : 2,
    }
  });

}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.tempDir, '/dwtools/tmp.tmp' ) )
  _.fileProvider.filesDelete( self.tempDir );
}

// --
// tests
// --

function sourcesJoin( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'several' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outputPath = _.path.join( routinePath, 'Index.js' );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();

  let shell = _.process.starter
  ({
    execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  starter.sourcesJoin
  ({
    inPath : '**',
    entryPath : 'File2.js',
    basePath : routinePath,
  })

  var files = self.find( routinePath );
  test.identical( files, [ '.', './File1.js', './File2.js', './Index.js' ] );

  let read = _.fileProvider.fileRead( outputPath );
  test.identical( _.strCount( read, 'setTimeout( f, 1000 );' ), 2 );

  shell( _.path.nativize( outputPath ) )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );

    var output =
    `
    File1.js:0
    File1.js:1
    File1.js:2
    File2.js:0
    File2.js:1
    File2.js:2
    File1.js:timeout
    File2.js:timeout
    `;
    test.equivalent( op.output, output );
    return op;
  });

  return ready;
}

//

function shellSourcesJoin( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'several' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outputPath = _.path.join( routinePath, 'Index.js' );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();

  let shell = _.process.starter
  ({
    execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  shell( `${execPath} .sources.join ${routinePath}/** entryPath:File2.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoin\/Index\.js/ ), 1 )

    var files = self.find( routinePath );
    test.identical( files, [ '.', './File1.js', './File2.js', './Index.js' ] );

    let read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, 'setTimeout( f, 1000 );' ), 2 );

    return op;
  })

  shell( _.path.nativize( outputPath ) )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    debugger;
    var output =
    `
    File1.js:0
    File1.js:1
    File1.js:2
    File2.js:0
    File2.js:1
    File2.js:2
    File1.js:timeout
    File2.js:timeout
    `;
    test.equivalent( op.output, output );
    return op;
  });

  return ready;
}

//

function shellSourcesJoinWithEntry( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'dep' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outputPath = _.path.join( routinePath, 'out/app0.js' );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();

  let shell = _.process.starter
  ({
    execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
    throwingExitCode : 0,
  });

  /* */

  ready.then( () =>
  {
    test.case = 'default';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `${execPath} .sources.join app0/** entryPath:app0/File2.js outPath:out/app0.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinWithEntry\/out\/app0\.js/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js', './out', './out/app0.js' ] );

    let read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, 'setTimeout( f, 1000 );' ), 2 );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'base path : .';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `${execPath} .sources.join app0/** entryPath:app0/File2.js outPath:out/app0.js basePath:.` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinWithEntry\/out\/app0\.js/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js', './out', './out/app0.js' ] );

    let read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, 'setTimeout( f, 1000 );' ), 2 );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'base path : app0';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `${execPath} .sources.join ** entryPath:File2.js outPath:../out/app0.js basePath:app0` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinWithEntry\/out\/app0\.js/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js', './out', './out/app0.js' ] );

    let read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, 'setTimeout( f, 1000 );' ), 2 );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'bad entry';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `${execPath} .sources.join app0/** entryPath:File2.js outPath:out/app0.js` )
  .then( ( op ) =>
  {
    test.notIdentical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'List of source files should have all entry files' ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js' ] );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'bad entry, base path defined';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `${execPath} .sources.join ** entryPath:app0/File2.js outPath:../out/app0.js basePath:app0` )
  .then( ( op ) =>
  {
    test.notIdentical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'List of source files should have all entry files' ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js' ] );

    return op;
  })

  /* */

  return ready;
}

//

function shellSourcesJoinDep( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'dep' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();
  var output =
`
app0/File2.js:begin main:true
app2/File2.js:begin main:false
app0/File1.js:begin main:false
numberIs:true
app0/File1.js:end
app2/File2.js:end
app0/File2.js:end
app0/File1.js:timeout numberIs:true
app0/File1.js:timeout numberIs:true
app0/File1.js:timeout numberIs:true
`

  let shell = _.process.starter
  ({
    // execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
    throwingExitCode : 1,
  });

  /* */

  ready.then( () =>
  {
    test.case = 'default';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `npm i` )
  shell( `node ${execPath} .sources.join app2/** outPath:out/app2` )
  shell( `node ${execPath} .sources.join app0/** outPath:out/app0 entryPath:app0/File2.js externalBeforePath:out/app2` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinDep\/out\/app0/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js', './out', './out/app0', './out/app2' ] );

    return op;
  })

  shell( `node out/app0` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  shell( `node app0/File2.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  /* */

  return ready;
}

//

function shellSourcesJoinRequireInternal( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'dep' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();
  var output =
`
app2/File2.js:begin main:false
app0/File1.js:begin main:false
numberIs:true
app0/File1.js:end
app2/File2.js:end
app0/File1.js:timeout numberIs:true
app0/File1.js:timeout numberIs:true
`

  let shell = _.process.starter
  ({
    // execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
    throwingExitCode : 1,
  });

  /* */

  ready.then( () =>
  {
    test.case = 'default';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `npm i` )
  shell( `node ${execPath} .sources.join app0/** outPath:out/dir/app0` )
  shell( `node ${execPath} .sources.join app2/** outPath:out/dir/app2` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinRequireInternal\/out\/dir\/app2/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app2', './app2/File1.js', './app2/File2.js', './ext', './ext/RequireApp2File2.js', './out', './out/dir', './out/dir/app0', './out/dir/app2' ] );

    return op;
  })

  shell( `node ext/RequireApp2File2.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  /* */

  return ready;
}

//

function shellSourcesJoinComplex( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'complex' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();
  var output =
`
app0/File2.js:begin
app2/File2.js:begin
app0/File1.js:begin
numberIs true
app0/File1.js:end
app1/File2.js:begin
app1/File1.js:begin
app1/File1.js:end
app1/File2.js:end
app2/File2.js:end
app0/File2.js:end
app0/File1.js:timeout true
app1/File1.js:timeout
app1/File2.js:timeout
app1/File2.js:timeout
app0/File1.js:timeout true
app0/File1.js:timeout true
`

  let shell = _.process.starter
  ({
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
    throwingExitCode : 1,
  });

  /* */

  ready.then( () =>
  {
    test.case = 'default';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `npm i` )
  shell( `node ${execPath} .sources.join app2/** outPath:out/app2` )
  shell( `node ${execPath} .sources.join app1/** outPath:out/app1` )
  shell( `node ${execPath} .sources.join app0/** outPath:out/app0 entryPath:app0/File2.js externalBeforePath:[out/app1, out/app2]` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinComplex\/out\/app0/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './app0', './app0/File1.js', './app0/File2.js', './app1', './app1/File1.js', './app1/File2.js', './app2', './app2/File1.js', './app2/File2.js', './out', './out/app0', './out/app1', './out/app2' ] );

    return op;
  })

  shell( `node out/app0` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  shell( `node app0/File2.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );

    return op;
  })

  /* */

  return ready;
}

//

function shellSourcesJoinTree( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'tree' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outPath = _.path.join( routinePath, 'out' );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();

  let shell = _.process.starter
  ({
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
    throwingExitCode : 1,
  });

  /* */

  ready.then( () =>
  {
    test.case = 'app1, entry:File1';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `node ${execPath} .sources.join in/app1/** outPath:out/app1 entryPath:in/app1/dir1/File1.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinTree\/out\/app1/ ), 1 );

    var expected = [ '.', './app1' ];
    var files = self.find( outPath );
    test.identical( files, expected );

    return op;
  })

  shell( `node in/app1/dir1/File1.js` )
  .then( ( op ) =>
  {
    var output =
`
app1/File1.js:begin main:true
External1.js main:false
app1/File1.js:end main:true
`
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  shell( `node out/app1` )
  .then( ( op ) =>
  {
    var output =
`
app1/File1.js:begin main:true
External1.js main:false
app1/File1.js:end main:true
`
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'app1, entry:File2';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `node ${execPath} .sources.join in/app1/** outPath:out/app1 entryPath:in/app1/dir1/dir2/File2.js` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinTree\/out\/app1/ ), 1 );

    var expected = [ '.', './app1' ];
    var files = self.find( outPath );
    test.identical( files, expected );

    return op;
  })

  shell( `node in/app1/dir1/dir2/File2.js` )
  .then( ( op ) =>
  {
    var output =
`
app1/File2.js:begin main:true
External2.js main:false
app1/File2.js:end main:true
`
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  shell( `node out/app1` )
  .then( ( op ) =>
  {
    var output =
`
app1/File2.js:begin main:true
External2.js main:false
app1/File2.js:end main:true
`
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'app2';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    _.fileProvider.filesDelete( routinePath + '/out' );
    return null;
  })

  shell( `node ${execPath} .sources.join in/app1/** outPath:out/app1` )
  shell( `node ${execPath} .sources.join in/app2/** outPath:out/app2 entryPath:in/app2/File2.js externalBeforePath:out/app1` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ sourcesJoin to .*shellSourcesJoinTree\/out\/app2/ ), 1 );

    var expected = [ '.', './app1', './app2' ];
    var files = self.find( outPath );
    test.identical( files, expected );

    return op;
  })

  shell( `node in/app2/File2.js` )
  .then( ( op ) =>
  {
    var output =
`
app0/File2.js:begin main:true
app2/File1.js:begin main:false
app1/File2.js:begin main:false
External2.js main:false
app1/File2.js:end main:false
app2/File1.js:end main:false
app0/File2.js:end main:true
`
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  shell( `node out/app2` )
  .then( ( op ) =>
  {
    var output =
`
app0/File2.js:begin main:true
app2/File1.js:begin main:false
app1/File2.js:begin main:false
External2.js main:false
app1/File2.js:end main:false
app2/File1.js:end main:false
app0/File2.js:end main:true
`
    test.identical( op.exitCode, 0 );
    test.equivalent( op.output, output );
    return op;
  })

  /* */

  return ready;
} /* end of shellSourcesJoinTree */

//

function htmlFor( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'several' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outputPath = _.path.join( routinePath, 'Index.html' );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();

  /* */

  test.case = 'default';

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  starter.htmlFor
  ({
    inPath : '**',
    basePath : routinePath,
    title : 'Html for test',
  })

  var files = self.find( routinePath );
  test.identical( files, [ '.', './File1.js', './File2.js', './Index.html' ] );

  var read = _.fileProvider.fileRead( outputPath );
  test.identical( _.strCount( read, '<html' ), 1 );
  test.identical( _.strCount( read, 'src="/.starter"' ), 1 );
  test.identical( _.strCount( read, 'src="./File1.js"' ), 1 );
  test.identical( _.strCount( read, 'src="./File2.js"' ), 1 );
  test.identical( _.strCount( read, '<title>Html for test</title>' ), 1 );
  test.identical( _.strCount( read, '<script src' ), 3 );

  /* */

  test.case = 'without starter';

  _.fileProvider.filesDelete( routinePath );
  _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })

  starter.htmlFor
  ({
    inPath : '**',
    basePath : routinePath,
    title : 'Html for test',
    starterIncluding : 0,
  })

  var files = self.find( routinePath );
  test.identical( files, [ '.', './File1.js', './File2.js', './Index.html' ] );

  var read = _.fileProvider.fileRead( outputPath );
  test.identical( _.strCount( read, '<html' ), 1 );
  test.identical( _.strCount( read, 'src="/.starter"' ), 0 );
  test.identical( _.strCount( read, 'src="./File1.js"' ), 1 );
  test.identical( _.strCount( read, 'src="./File2.js"' ), 1 );
  test.identical( _.strCount( read, '<title>Html for test</title>' ), 1 );
  test.identical( _.strCount( read, '<script src' ), 2 );

  /* */

  return ready;
}

//

function shellHtmlFor( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'several' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let outputPath = _.path.join( routinePath, 'Index.html' );
  let execPath = _.path.nativize( _.path.join( __dirname, '../starter/Exec' ) );
  let ready = new _.Consequence().take( null );
  let starter = new _.Starter().form();

  let shell = _.process.starter
  ({
    execPath : 'node',
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* */

  ready.then( () =>
  {
    test.case = 'default';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  shell( `${execPath} .html.for ${routinePath}/**` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ html saved to .*shellHtmlFor\/Index\.html/ ), 1 )

    var files = self.find( routinePath );
    test.identical( files, [ '.', './File1.js', './File2.js', './Index.html' ] );

    var read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, '<html' ), 1 );
    test.identical( _.strCount( read, 'src="/.starter"' ), 1 );
    test.identical( _.strCount( read, 'src="./File1.js"' ), 1 );
    test.identical( _.strCount( read, 'src="./File2.js"' ), 1 );
    test.identical( _.strCount( read, '<title>' ), 1 );
    test.identical( _.strCount( read, '<script src' ), 3 );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'with title';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  shell( `${execPath} .html.for ${routinePath}/** title:"Html for test"` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ html saved to .*shellHtmlFor\/Index\.html/ ), 1 )

    var files = self.find( routinePath );
    test.identical( files, [ '.', './File1.js', './File2.js', './Index.html' ] );

    var read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, '<html' ), 1 );
    test.identical( _.strCount( read, 'src="/.starter"' ), 1 );
    test.identical( _.strCount( read, 'src="./File1.js"' ), 1 );
    test.identical( _.strCount( read, 'src="./File2.js"' ), 1 );
    test.identical( _.strCount( read, '<title>Html for test</title>' ), 1 );
    test.identical( _.strCount( read, '<title>' ), 1 );
    test.identical( _.strCount( read, '<script src' ), 3 );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'without starter';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  shell( `${execPath} .html.for ${routinePath}/** title:"Html for test" starterIncluding:0` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ html saved to .*shellHtmlFor\/Index\.html/ ), 1 )

    var files = self.find( routinePath );
    test.identical( files, [ '.', './File1.js', './File2.js', './Index.html' ] );

    var read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, '<html' ), 1 );
    test.identical( _.strCount( read, 'src="/.starter"' ), 0 );
    test.identical( _.strCount( read, 'src="./File1.js"' ), 1 );
    test.identical( _.strCount( read, 'src="./File2.js"' ), 1 );
    test.identical( _.strCount( read, '<title>Html for test</title>' ), 1 );
    test.identical( _.strCount( read, '<script src' ), 2 );

    return op;
  })

  /* */

  ready.then( () =>
  {
    test.case = 'empty';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } })
    return null;
  })

  shell( `${execPath} .html.for []` )
  .then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /\+ html saved to .*shellHtmlFor\/Index\.html/ ), 1 )

    var files = self.find( routinePath );
    test.identical( files, [ '.', './File1.js', './File2.js', './Index.html' ] );

    var read = _.fileProvider.fileRead( outputPath );
    test.identical( _.strCount( read, '<html' ), 1 );
    test.identical( _.strCount( read, 'src="/.starter"' ), 1 );
    test.identical( _.strCount( read, './src="File1.js"' ), 0 );
    test.identical( _.strCount( read, './src="File2.js"' ), 0 );
    test.identical( _.strCount( read, '<script src' ), 1 );

    return op;
  })

  /* */

  return ready;
}

// --
// declare
// --

var Self =
{

  name : 'Tools.StarterMaker',
  silencing : 1,
  enabled : 1,
  routineTimeOut : 60000,
  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    tempDir : null,
    assetDirPath : null,
    find : null,
  },

  tests :
  {

    sourcesJoin,
    shellSourcesJoin,
    shellSourcesJoinWithEntry,
    shellSourcesJoinDep,
    shellSourcesJoinRequireInternal,
    shellSourcesJoinComplex,
    shellSourcesJoinTree,

    htmlFor,
    shellHtmlFor,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
