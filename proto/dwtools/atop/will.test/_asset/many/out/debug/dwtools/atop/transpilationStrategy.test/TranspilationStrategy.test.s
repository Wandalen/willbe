( function _TranspilationStrategy_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../transpilationStrategy/MainBase.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.tempDir = _.path.dirTempOpen( _.path.join( __dirname, '../..'  ), 'TransiplationStrategy' );
  self.assetDirPath = _.path.join( __dirname, '_asset' );

  self.find = _.fileProvider.filesFinder
  ({
    includingTerminals : 1,
    includingDirs : 1,
    withTransient/*maybe withStem*/ : 1,
    allowingMissed : 1,
    outputFormat : 'relative',
  });

  self.findIn = function findIn( fileProvider, filePath )
  {
    let self = this;
    return fileProvider.filesFindRecursive
    ({
      filePath : filePath,
      outputFormat : 'relative',
    })
  }

}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.tempDir, '/tmp.tmp' ) )
  _.fileProvider.filesDelete( self.tempDir );
}


// --
// tests
// --

function singleFileInputTerminal( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );
  let con = new _.Consequence().take( null );

  /* - */

  con.then( () =>
  {

    test.description = 'single input terminal';

    let outPath = _.path.join( routinePath, 'Output.js' );
    let ts = new _.TranspilationStrategy().form();
    let multiple = ts.multiple
    ({
      inPath : __filename,
      outPath : outPath,
    });

    return multiple.form().perform()
    .finally( ( err, got ) =>
    {
      if( err )
      throw _.err( err );

      test.is( _.fileProvider.fileExists( outPath ) );
      let expected = [ '.', './Output.js' ];
      test.is( _.fileProvider.fileSize( outPath ) > 100 );
      let found = self.find( routinePath );
      test.identical( found, expected );

      test.identical( multiple.dstCounter, 1 );
      test.identical( multiple.srcCounter, 1 );

      return true;
    });

  })

  /* - */

  con.then( () =>
  {

    test.description = 'repeat, should do nothing';

    let outPath = _.path.join( routinePath, 'Output.js' );
    let ts = new _.TranspilationStrategy().form();
    let multiple = ts.multiple
    ({
      inPath : __filename,
      outPath : outPath,
    });

    return multiple.form().perform()
    .finally( ( err, got ) =>
    {
      if( err )
      throw _.err( err );

      test.is( _.fileProvider.fileExists( outPath ) );
      let expected = [ '.', './Output.js' ];
      test.is( _.fileProvider.fileSize( outPath ) > 100 );
      let found = self.find( routinePath );
      test.identical( found, expected );

      test.identical( multiple.dstCounter, 0 );
      test.identical( multiple.srcCounter, 0 );

      return true;
    });

  })

  /* - */

  return con;
}

//

function singleFileInputDir( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  /* - */

  test.case = 'single input dir with glob';

  let outPath = _.path.join( routinePath, 'Output.js' );
  let ts = new _.TranspilationStrategy().form();
  let multiple = ts.multiple
  ({
    inPath : __dirname + '/**',
    outPath : outPath,
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    if( err )
    throw _.err( err );

    test.is( _.fileProvider.fileExists( outPath ) );
    test.is( _.fileProvider.fileSize( outPath ) > 100 );
    let expected = [ '.', './Output.js' ];
    let found = self.find( routinePath );
    test.identical( found, expected );
    return true;
  });

}

//

function singleFileInputDirThrowing( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  /* - */

  test.case = 'single input dir without glob';

  let outPath = _.path.join( routinePath, 'Output.js' );
  let ts = new _.TranspilationStrategy().form();
  let multiple = ts.multiple
  ({
    inPath : __dirname + '',
    outPath : outPath,
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    test.is( !!err );
    return true;
  });

  /* - */

}

//

function singleDst( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );
  let originalDirPath = _.path.join( __dirname, '../transpilationStrategy' );

  test.case = 'single destination';

  let outPath = _.path.join( routinePath, 'Output.js' );
  let ts = new _.TranspilationStrategy().form();
  let multiple = ts.multiple
  ({
    inPath :
    {
      filePath :
      {
        [ originalDirPath + '/**' ] : '',
        [ originalDirPath + '/Exec*' ] : 0,
      }
    },
    outPath : outPath,
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    if( err )
    throw _.err( err );

    test.is( _.fileProvider.fileExists( outPath ) ); debugger;
    test.is( _.fileProvider.fileSize( outPath ) > 5000 );
    let expected = [ '.', './Output.js' ];
    let found = self.find( routinePath );
    test.identical( found, expected );

    return true;
  });

}

//

function severalDst( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  test.case = 'trivial';

  var filesTree =
  {
    'File1.js' : `console.log( 'File1.js' );`,
    'File2.js' : `console.log( 'File2.js' );`,
    'File1.s' : `console.log( 'File1.s' );`,
    'File2.s' : `console.log( 'File2.s' );`,
  }

  var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });
  var inPath = { filePath : { '**.js' : 'All.js', '**.s' : 'All.s' } }
  var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
  var multiple = ts.multiple
  ({
    inPath : inPath,
    outPath : null,
    diagnosing : 1,
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    if( err )
    throw _.err( err );

    var expected = [ '.', './All.js', './All.s', './File1.js', './File1.s', './File2.js', './File2.s' ];
    var found = self.findIn( fileProvider, '/' );
    test.identical( found, expected );
    test.is( _.strHas( fileProvider.fileRead( '/All.js' ), 'File1.js' ) );
    test.is( _.strHas( fileProvider.fileRead( '/All.js' ), 'File2.js' ) );
    test.is( _.strHas( fileProvider.fileRead( '/All.s' ), 'File1.s' ) );
    test.is( _.strHas( fileProvider.fileRead( '/All.s' ), 'File2.s' ) );

    return true;
  });

}

//

function complexMask( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  test.case = 'trivial';

  var filesTree =
  {
    'File1.js' : `console.log( 'File1.js' );`,
    'File2.js' : `console.log( 'File2.js' );`,
    'File1.s' : `console.log( 'File1.s' );`,
    'File2.s' : `console.log( 'File2.s' );`,
  }
  var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });

  var inPath = { filePath : { '**.js' : 'All.js', '**.s' : 'All.s' } }
  var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
  var multiple = ts.multiple
  ({
    inPath : inPath,
    outPath : { prefixPath : '/dst' },
    splittingStrategy : 'ManyToOne',
    diagnosing : 1,
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    if( err )
    throw _.err( err );

    var expected = [ '.', './File1.js', './File1.s', './File2.js', './File2.s', './dst', './dst/All.js', './dst/All.s' ];
    var found = self.findIn( fileProvider, '/' );
    test.identical( found, expected );
    test.is( _.strHas( fileProvider.fileRead( '/dst/All.js' ), 'File1.js' ) );
    test.is( _.strHas( fileProvider.fileRead( '/dst/All.js' ), 'File2.js' ) );
    test.is( _.strHas( fileProvider.fileRead( '/dst/All.s' ), 'File1.s' ) );
    test.is( _.strHas( fileProvider.fileRead( '/dst/All.s' ), 'File2.s' ) );

    return true;
  });

}

//

function oneToOne( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  test.case = 'trivial';

  var filesTree =
  {
    'File1.js' : `console.log( './File1.js' );`,
    'File2.js' : `console.log( './File2.js' );`,
    'File1.s' : `console.log( './File1.s' );`,
    'File2.s' : `console.log( './File2.s' );`,

    dir :
    {
      'File1.js' : `console.log( './dir/File1.js' );`,
      'File2.js' : `console.log( './dir/File2.js' );`,
      'File1.s' : `console.log( './dir/File1.s' );`,
      'File2.s' : `console.log( './dir/File2.s' );`,
    }

  }

  var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });

  var inPath = { filePath : { '/' : null, '**.js' : true } }
  var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
  var multiple = ts.multiple
  ({
    inPath : inPath,
    outPath : { prefixPath : '/dst' },
    splittingStrategy : 'OneToOne',
    transpilingStrategy : [ 'Nop' ],
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {

    debugger;
    if( err )
    throw _.err( err );

    var expected = [ '.', './File1.js', './File1.s', './File2.js', './File2.s', './dir', './dir/File1.js', './dir/File1.s', './dir/File2.js', './dir/File2.s', './dst', './dst/File1.js', './dst/File2.js', './dst/dir', './dst/dir/File1.js', './dst/dir/File2.js' ];
    var found = self.findIn( fileProvider, '/' );
    test.identical( found, expected );

    var src = fileProvider.fileRead( '/File1.js' );
    var dst = fileProvider.fileRead( '/dst/File1.js' );
    test.is( _.strHas( dst, src ) );

    var src = fileProvider.fileRead( '/dir/File2.js' );
    var dst = fileProvider.fileRead( '/dst/dir/File2.js' );
    test.is( _.strHas( dst, src ) );

    return true;

  });

}

//

function nothingFoundOneToOne( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  /* */

  test.case = 'OneToOne';

  var filesTree =
  {
    'File1.js' : `console.log( './File1.js' );`,
    'File2.js' : `console.log( './File2.js' );`,
    'File1.s' : `console.log( './File1.s' );`,
    'File2.s' : `console.log( './File2.s' );`,
    dir :
    {
      'File1.js' : `console.log( './dir/File1.js' );`,
      'File2.js' : `console.log( './dir/File2.js' );`,
      'File1.s' : `console.log( './dir/File1.s' );`,
      'File2.s' : `console.log( './dir/File2.s' );`,
    }
  }
  var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });

  var inPath = { filePath : { '**.test*' : true, '/' : '/dst' } }
  var outPath = { filePath : { '**.test*' : true, '/' : '/dst' } }
  var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
  var multiple = ts.multiple
  ({
    inPath : inPath,
    outPath : outPath,
    splittingStrategy : 'OneToOne',
    transpilingStrategy : [ 'Nop' ],
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    test.is( !!err );
    var expected = [ '.', './File1.js', './File1.s', './File2.js', './File2.s', './dir', './dir/File1.js', './dir/File1.s', './dir/File2.js', './dir/File2.s' ];
    var found = self.findIn( fileProvider, '/' );
    test.identical( found, expected );
    if( err )
    _.errLogOnce( err );
    return null;
  });

}

//

function nothingFoundManyToOne( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );

  /* */

  test.case = 'ManyToOne';

  var filesTree =
  {
    'File1.js' : `console.log( './File1.js' );`,
    'File2.js' : `console.log( './File2.js' );`,
    'File1.s' : `console.log( './File1.s' );`,
    'File2.s' : `console.log( './File2.s' );`,
    dir :
    {
      'File1.js' : `console.log( './dir/File1.js' );`,
      'File2.js' : `console.log( './dir/File2.js' );`,
      'File1.s' : `console.log( './dir/File1.s' );`,
      'File2.s' : `console.log( './dir/File2.s' );`,
    }
  }
  var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });

  var inPath = { filePath : { '**.test*' : true, '/' : '/dst' } }
  var outPath = { filePath : { '**.test*' : true, '/' : '/dst' } }
  var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
  var multiple = ts.multiple
  ({
    inPath : inPath,
    outPath : outPath,
    splittingStrategy : 'ManyToOne',
    transpilingStrategy : [ 'Nop' ],
  });

  return multiple.form().perform()
  .finally( ( err, got ) =>
  {
    test.is( !!err );
    var expected = [ '.', './File1.js', './File1.s', './File2.js', './File2.s', './dir', './dir/File1.js', './dir/File1.s', './dir/File2.js', './dir/File2.s' ];
    var found = self.findIn( fileProvider, '/' );
    test.identical( found, expected );
    test.is( !fileProvider.fileExists( '/dst' ) );
    // test.is( fileProvider.fileRead( '/dst' ) === '' );
    if( err )
    _.errLogOnce( err );
    return null;
  });

  /* */

}

//

function transpileManyToOne( test )
{
  let self = this;
  let routinePath = _.path.join( self.tempDir, test.name );
  let con = new _.Consequence().take( null );

  /* */

  con.then( () =>
  {

    test.case = 'ManyToOne';

    var filesTree =
    {
      src :
      {
        dir1 : {},
        dir2 :
        {
          '-Excluded.js' : `console.log( 'dir2/-Ecluded.js' );`,
          'File.js' : `console.log( 'dir2/File.js' );`,
          'File.test.js' : `console.log( 'dir2/File.test.js' );`,
          'File1.debug.js' : `console.log( 'dir2/File1.debug.js' );`,
          'File1.release.js' : `console.log( 'dir2/File1.release.js' );`,
          'File2.debug.js' : `console.log( 'dir2/File2.debug.js' );`,
          'File2.release.js' : `console.log( 'dir2/File2.release.js' );`,
        },
        dir3 :
        {
          'File.js' : `console.log( 'dir3/File.js' );`,
          'File.test.js' : `console.log( 'dir3/File.test.js' );`,
        },
      }
    }
    var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });

    var inPath =
    {
      filePath : { '**.test*' : false, '**.test/**' : false, '.' : '.' },
      prefixPath : '/src',
      maskAll : { excludeAny : [ /(^|\/)-/, /\.release($|\.|\/)/i ] }
    }
    var outPath =
    {
      filePath : { '**.test*' : false, '**.test/**' : false, '.' : '.' },
      prefixPath : '/dst/Main.s',
    }
    var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
    var multiple = ts.multiple
    ({
      inPath : inPath,
      outPath : outPath,
      totalReporting : 0,
      transpilingStrategy : [ 'Nop' ],
      splittingStrategy : 'ManyToOne',
      writingTerminalUnderDirectory : 1,
      upToDate : 'preserve',
      verbosity : 2,
      optimization : 9,
      minification : 8,
      diagnosing : 1,
      beautifing : 0,
    });

    return multiple.form().perform()
    .finally( ( err, got ) =>
    {
      if( err )
      throw _.err( err );

      var expected = [ '.', './dst', './dst/Main.s', './src', './src/dir1', './src/dir2', './src/dir2/File.js', './src/dir2/File.test.js', './src/dir2/File1.debug.js', './src/dir2/File1.release.js', './src/dir2/File2.debug.js', './src/dir2/File2.release.js', './src/dir3', './src/dir3/File.js', './src/dir3/File.test.js' ];
      var found = self.findIn( fileProvider, '/' );
      test.identical( found, expected );

      var read = fileProvider.fileRead( '/dst/Main.s' );
      test.is( !_.strHas( read, 'dir2/-Ecluded.js' ) );
      test.is( _.strHas( read, 'dir2/File.js' ) );
      test.is( !_.strHas( read, 'dir2/File.test.js' ) );
      test.is( _.strHas( read, 'dir2/File1.debug.js' ) );
      test.is( !_.strHas( read, 'dir2/File1.release.js' ) );
      test.is( _.strHas( read, 'dir2/File2.debug.js' ) );
      test.is( !_.strHas( read, 'dir2/File2.release.js' ) );

      return true;
    });

  })

  /* */

  con.then( () =>
  {

    test.case = 'ManyToOne';

    var filesTree =
    {
      src :
      {
        dir1 : {},
        dir2 :
        {
          '-Excluded.js' : `console.log( 'dir2/-Ecluded.js' );`,
          'File.js' : `console.log( 'dir2/File.js' );`,
          'File.test.js' : `console.log( 'dir2/File.test.js' );`,
          'File1.debug.js' : `console.log( 'dir2/File1.debug.js' );`,
          'File1.release.js' : `console.log( 'dir2/File1.release.js' );`,
          'File2.debug.js' : `console.log( 'dir2/File2.debug.js' );`,
          'File2.release.js' : `console.log( 'dir2/File2.release.js' );`,
        },
        dir3 :
        {
          'File.js' : `console.log( 'dir3/File.js' );`,
          'File.test.js' : `console.log( 'dir3/File.test.js' );`,
        },
      }
    }
    var fileProvider = _.FileProvider.Extract({ filesTree : filesTree });

    var inPath =
    {
      filePath : { '**.test*' : true, '.' : '.' },
      prefixPath : '/src',
      maskAll : { excludeAny : [ /(^|\/)-/, /\.release($|\.|\/)/i ] },
    }
    var outPath =
    {
      filePath : { '**.test*' : true, '.' : '.' },
      prefixPath : '/dst/Tests.s',
    }
    var ts = new _.TranspilationStrategy({ fileProvider : fileProvider }).form();
    var multiple = ts.multiple
    ({
      inPath : inPath,
      outPath : outPath,
      totalReporting : 0,
      transpilingStrategy : [ 'Nop' ],
      splittingStrategy : 'ManyToOne',
      writingTerminalUnderDirectory : 1,
      upToDate : 'preserve',
      verbosity : 2,
      optimization : 9,
      minification : 8,
      diagnosing : 1,
      beautifing : 0,
    });

    return multiple.form().perform()
    .finally( ( err, got ) =>
    {
      if( err )
      throw _.err( err );

      var expected = [ '.', './dst', './dst/Tests.s', './src', './src/dir1', './src/dir2', './src/dir2/File.js', './src/dir2/File.test.js', './src/dir2/File1.debug.js', './src/dir2/File1.release.js', './src/dir2/File2.debug.js', './src/dir2/File2.release.js', './src/dir3', './src/dir3/File.js', './src/dir3/File.test.js' ];
      var found = self.findIn( fileProvider, '/' );
      test.identical( found, expected );

      var read = fileProvider.fileRead( '/dst/Tests.s' );
      test.is( !_.strHas( read, 'dir2/-Ecluded.js' ) );
      test.is( !_.strHas( read, 'dir2/File.js' ) );
      test.is( _.strHas( read, 'dir2/File.test.js' ) );
      test.is( !_.strHas( read, 'dir2/File1.debug.js' ) );
      test.is( !_.strHas( read, 'dir2/File1.release.js' ) );
      test.is( !_.strHas( read, 'dir2/File2.debug.js' ) );
      test.is( !_.strHas( read, 'dir2/File2.release.js' ) );

      return true;
    });

  })

  /* */

  return con;
}

//

function shell( test )
{
  let self = this;
  let originalDirPath = _.path.join( __dirname, '../transpilationStrategy' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let inPath = _.path.normalize( __dirname ) + '/**';
  let outPath = _.path.join( routinePath, 'out.js' );
  let execRelativePath = '../transpilationStrategy/Exec';
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), execRelativePath ) );
  let ready = new _.Consequence().take( null );
  let shell = _.process.starter
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.transpile';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.dirMake( routinePath );
    // _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    return null;
  })

  shell({ args : [ '.transpile inPath:' + inPath + ' outPath:' + outPath + ' writingTempFiles:0' ] })
  .then( ( got ) =>
  {

    var files = self.find( routinePath );
    test.identical( files, [ '.', './out.js' ] );
    test.identical( got.exitCode, 0 );
    test.is( _.fileProvider.isTerminal( outPath ) );

    return null;
  })
  .then( ( got ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    return null;
  })

  return ready;
}

//

function combinedShell( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'combined' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execRelativePath = '../transpilationStrategy/Exec';
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), execRelativePath ) );
  let inPath = 'main/**';
  let outPath = 'out/Main.s';
  let entryPath = 'main/File1.s';
  let outMainPath = _.path.join( routinePath, './out/Main.s' );
  let externalBeforePath = 'External.s';
  let ready = new _.Consequence().take( null );

  let shell = _.process.starter
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  });

  let shell2 = _.process.starter
  ({
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    ready : ready,
  });

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.transpile';
    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.dirMake( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
    return null;
  })

  shell({ args : `.transpile inPath:${inPath} outPath:${outPath} entryPath:${entryPath} externalBeforePath:${externalBeforePath} splittingStrategy:ManyToOne transpilingStrategy:Nop` })
  /* node ../../../transpilationStrategy/Exec .transpile inPath:main/** outPath:out/Main.s entryPath:main/File1.s externalBeforePath:External.s splittingStrategy:ManyToOne transpilingStrategy:Nop */

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /# Transpiled 2 file\(s\) to .*out\/Main\.s.* in/ ), 1 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './External.s', './main', './main/File1.s', './main/File2.s', './out', './out/Main.s' ] );

    var read = _.fileProvider.fileRead( outMainPath );
    test.identical( _.strCount( read, `console.log( 'main/File1.s' );` ), 1 );
    test.identical( _.strCount( read, `console.log( 'external', external );` ), 1 );
    test.identical( _.strCount( read, `console.log( 'main/File2.s' );` ), 1 );
    test.identical( _.strCount( read, `_starter_._sourceInclude( null, _libraryDirPath_, '../External.s' );` ), 1 );
    test.identical( _.strCount( read, `module.exports = _starter_._sourceInclude( null, _libraryDirPath_, './main/File1.s' );` ), 1 );
    test.identical( _.strCount( read, `_starter_._sourceInclude(` ), 2 );
    test.identical( _.strCount( read, `module.exports = _starter_._sourceInclude` ), 1 );

    return null;
  })

  shell2({ execPath : 'node ' + _.path.nativize( outMainPath ) })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, `External.s` ), 1 );
    test.identical( _.strCount( got.output, `main/File1.s` ), 1 );
    test.identical( _.strCount( got.output, `external 13` ), 1 );

    return null;
  })

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = 'repeat';
    debugger;
    return null;
  })

  /*
    qqq xxx : why does it thow error???
  */

  shell({ args : `.transpile inPath:${inPath} outPath:${outPath} entryPath:${entryPath} externalBeforePath:${externalBeforePath} splittingStrategy:ManyToOne transpilingStrategy:Nop` })
  /* node ../../../transpilationStrategy/Exec .transpile inPath:main/** outPath:out/Main.s entryPath:main/File1.s externalBeforePath:External.s splittingStrategy:ManyToOne transpilingStrategy:Nop */

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, /# Transpiled/ ), 0 );

    var files = self.find( routinePath );
    test.identical( files, [ '.', './External.s', './main', './main/File1.s', './main/File2.s', './out', './out/Main.s' ] );

    var read = _.fileProvider.fileRead( outMainPath );
    test.identical( _.strCount( read, `console.log( 'main/File1.s' );` ), 1 );
    test.identical( _.strCount( read, `console.log( 'external', external );` ), 1 );
    test.identical( _.strCount( read, `console.log( 'main/File2.s' );` ), 1 );
    test.identical( _.strCount( read, `_starter_._sourceInclude( null, _libraryDirPath_, '../External.s' );` ), 1 );
    test.identical( _.strCount( read, `module.exports = _starter_._sourceInclude( null, _libraryDirPath_, './main/File1.s' );` ), 1 );
    test.identical( _.strCount( read, `_starter_._sourceInclude(` ), 2 );
    test.identical( _.strCount( read, `module.exports = _starter_._sourceInclude` ), 1 );

    return null;
  })

  shell2({ execPath : 'node ' + _.path.nativize( outMainPath ) })

  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    test.identical( _.strCount( got.output, `External.s` ), 1 );
    test.identical( _.strCount( got.output, `main/File1.s` ), 1 );
    test.identical( _.strCount( got.output, `external 13` ), 1 );

    return null;
  })

  .then( ( got ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    return null;
  })

  /* - */

  // ready
  // .then( ( got ) =>
  // {
  //   test.case = 'throwing';
  //   _.fileProvider.filesDelete( routinePath );
  //   _.fileProvider.dirMake( routinePath );
  //   _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });
  //   return null;
  // })
  //
  // shell({ currentPath : routinePath + '/..', args : `.transpile inPath:${inPath} outPath:${outPath} entryPath:${entryPath} externalBeforePath:${externalBeforePath} splittingStrategy:ManyToOne transpilingStrategy:Nop` })
  // /* node ../../transpilationStrategy/Exec .transpile inPath:main/** outPath:out/Main.s entryPath:main/File1.s externalBeforePath:External.s splittingStrategy:ManyToOne transpilingStrategy:Nop */
  //
  // .then( ( got ) =>
  // {
  //   test.notIdentical( got.exitCode, 0 );
  //
  //   test.identical( _.strCount( got.output, /Nothing found. Stem file .*main.* does not exist!/ ), 1 );
  //
  //   var files = self.find( routinePath );
  //   test.identical( files, [ '.', './External.s', './main', './main/File1.s', './main/File2.s' ] );
  //
  //   return null;
  // })
  // .then( ( got ) =>
  // {
  //   _.fileProvider.filesDelete( routinePath );
  //   return null;
  // })

  /* - */

  return ready;
}

combinedShell.timeOut = 150000;

//

function combinedProgramatic( test )
{
  let self = this;
  let originalDirPath = _.path.join( self.assetDirPath, 'combined' );
  let routinePath = _.path.join( self.tempDir, test.name );
  let execRelativePath = '../transpilationStrategy/Exec';
  let execPath = _.path.nativize( _.path.join( _.path.normalize( __dirname ), execRelativePath ) );
  let inPath = _.path.join( routinePath, 'main/**' );
  let outPath = _.path.join( routinePath, 'out/Main.s' );
  let entryPath = 'main/File1.s';
  let externalBeforePath = 'External.s';
  let ready = new _.Consequence().take( null );
  let shell = _.process.starter
  ({
    execPath : 'node ' + execPath,
    currentPath : routinePath,
    outputCollecting : 1,
    ready : ready,
  });

  /* - */

  ready
  .then( ( got ) =>
  {
    test.case = '.transpile';

    _.fileProvider.filesDelete( routinePath );
    _.fileProvider.dirMake( routinePath );
    _.fileProvider.filesReflect({ reflectMap : { [ originalDirPath ] : routinePath } });

    let ts = new _.TranspilationStrategy({}).form();
    let multiple = ts.multiple
    ({

      inPath : inPath,
      outPath : outPath,
      entryPath : entryPath,
      externalBeforePath : externalBeforePath,
      totalReporting : 0,
      transpilingStrategy : [ 'Nop' ],
      splittingStrategy : 'ManyToOne',
      writingTerminalUnderDirectory : 1,
      simpleConcatenator : 0,
      upToDate : 'preserve',
      verbosity : 2,

      optimization : 9,
      minification : 8,
      diagnosing : 1,
      beautifing : 0,

    });

    return multiple.form().perform()
    .finally( ( err, arg ) =>
    {
      if( err )
      throw _.err( err );
      return arg;
    });

  })

  .then( ( got ) =>
  {

    var files = self.find( routinePath );
    test.identical( files, [ '.', './External.s', './main', './main/File1.s', './main/File2.s', './out', './out/Main.s' ] );

    return null;
  })
  .then( ( got ) =>
  {
    _.fileProvider.filesDelete( routinePath );
    return null;
  })

  /* - */

  return ready;
}

combinedProgramatic.timeOut = 150000;

// --
// define
// --

var Self =
{

  name : 'Tools.top.TranspilationStrategy',
  silencing : 1,
  routineTimeOut : 60000,
  onSuiteBegin : onSuiteBegin,
  onSuiteEnd : onSuiteEnd,

  context :
  {
    tempDir : null,
    find : null,
    findIn : null,
  },

  tests :
  {

    singleFileInputTerminal,
    singleFileInputDir,
    singleFileInputDirThrowing,
    singleDst,
    severalDst,
    complexMask,
    oneToOne,
    nothingFoundOneToOne,
    nothingFoundManyToOne,
    transpileManyToOne,
    shell,

    combinedShell,
    combinedProgramatic,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
