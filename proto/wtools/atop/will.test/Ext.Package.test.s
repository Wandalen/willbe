( function _WillExternalsPackage_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../Tools.s' );

  _.include( 'wTesting' );;
  _.include( 'wProcess' );
  _.include( 'wFiles' );

  require( '../will/include/Top.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..'  ), 'willbe' );
  self.assetsOriginalPath = _.path.join( __dirname, '_asset' );
  self.repoDirPath = _.path.join( self.assetsOriginalPath, '-repo' );
  self.willPath = _.path.nativize( _.Will.WillPathGet() );
}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.suiteTempPath, '/willbe-' ) )
  _.path.tempClose( self.suiteTempPath );
}

// --
// tests
// --

function trivial( test )
{
  test.true( true );
}

function packageInstall( test )
{
  let self = this;
  let routinePath = _.path.join( self.suiteTempPath, test.name );

  let execUnrestrictedPath = _.path.nativize( _.path.join( __dirname, '../will/ExecUnrestricted' ) );
  let ready = new _.Consequence().take( null );

  _.fileProvider.dirMake( routinePath )

  let isCentOs = false;
  let isUbuntu = false;

  if( process.platform === 'linux' )
  {
    let info = linuxInfoGet();
    isCentOs = _.strHas( info.dist.toLowerCase(), 'centos' );
    isUbuntu = _.strHas( info.dist.toLowerCase(), 'ubuntu' );
  }

  let start = _.process.starter
  ({
    execPath : execUnrestrictedPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    outputGraying : 1,
    mode : 'fork',
    ready,
  });

  start( '.package.install package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.true( _.strHas( got.output, 'Installing:' ) )
        test.true( _.strHas( got.output, 'git                      x86_64   2.18.2-1.el8_1             AppStream   186 k' ) )
        test.true( _.strHas( got.output, 'Installed:' ) )
        test.true( _.strHas( got.output, 'git-2.18.2-1.el8_1.x86_64' ) )
        test.true( _.strHas( got.output, 'Complete!' ) )
      }
      else if( isUbuntu )
      {
        test.true( _.strHas( got.output, 'The following NEW packages will be installed:\n  git' ) );
        test.true( _.strHas( got.output, 'Unpacking git (1:2.17.1-1ubuntu0.5' ) );
        test.true( _.strHas( got.output, 'Setting up git (1:2.17.1-1ubuntu0.5)' ) );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })
  start( '.package.version package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.true( _.strHas( got.output, 'git-2.18.2-1.el8_1.x86_64' ) )
      }
      else if( isUbuntu )
      {
        test.true( _.strHas( got.output, '1:2.17.1-1ubuntu0.5' ) );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  if( process.platform === 'win32' )
  {
    start( '.package.install choco:///git' )
    .then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      _.assert( 0, 'implement test checks' )
      return null;
    })
    start( '.package.version package:///git' )
    .then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      _.assert( 0, 'implement test checks' )
      return null;
    })
  }

  if( process.platform === 'darwin' )
  {
    start( '.package.install brew:///git' )
    .then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      _.assert( 0, 'implement test checks' )
      return null;
    })
    start( '.package.version package:///git' )
    .then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      _.assert( 0, 'implement test checks' )
      return null;
    })
  }

  if( process.platform === 'linux' )
  {
    start( '.package.install apt:///git' )
    .then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      return null;
    })
    start( '.package.version package:///git' )
    .then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      if( isCentOs )
      {
        test.true( _.strHas( got.output, 'git-2.18.2-1.el8_1.x86_64' ) )
      }
      else if( isUbuntu )
      {
        test.true( _.strHas( got.output, '1:2.17.1-1ubuntu0.5' ) );
      }
      return null;
    })
  }

  // start( '.package.install package://git#2.11.0' )
  // .then( ( got ) =>
  // {
  //   test.identical( got.exitCode, 0 );
  //   return null;
  // })

  // start( '.package.install :///git#2.11.0' )
  // .then( ( got ) =>
  // {
  //   test.identical( got.exitCode, 0 );
  //   return null;
  // })

  // start( '.package.install git#2.11.0' )
  // .then( ( got ) =>
  // {
  //   test.identical( got.exitCode, 0 );
  //   return null;
  // })

  return ready;

  /* */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }
}

packageInstall.experimental = 1;

//

function packageLocalVersions( test )
{
  let self = this;
  let routinePath = _.path.join( self.suiteTempPath, test.name );

  let execUnrestrictedPath = _.path.nativize( _.path.join( __dirname, '../will/ExecUnrestricted' ) );
  let ready = new _.Consequence().take( null );

  _.fileProvider.dirMake( routinePath )

  let isCentOs = false;
  let isUbuntu = false;

  if( process.platform === 'linux' )
  {
    let info = linuxInfoGet();
    isCentOs = _.strHas( info.dist.toLowerCase(), 'centos' );
    isUbuntu = _.strHas( info.dist.toLowerCase(), 'ubuntu' );
  }

  let start = _.process.starter
  ({
    execPath : execUnrestrictedPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    outputGraying : 1,
    mode : 'fork',
    ready,
  });

  let shell = _.process.starter
  ({
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    outputGraying : 1,
    mode : 'spawn',
    ready,
  });

  //

  if( process.platform === 'linux' )
  {
    if( isCentOs )
    shell( 'yum remove -y git' )
    else if( isUbuntu )
    shell( 'apt --purge -y remove git' )
  }
  else if( process.platform === 'win32' )
  {
    shell( 'choco uninstall -y git' )
  }
  else if( process.platform === 'darwin' )
  {
    shell( 'brew uninstall --force git' )
  }

  //

  ready.then( () =>
  {
    test.case = 'package is not installed yet'
    return null;
  })

  start( '.package.local.versions package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.true( _.strHas( got.output, 'No matching Packages to list' ) )
      }
      else if( isUbuntu )
      {
        let lines = _.strSplitNonPreserving({ src : got.output, delimeter : '\n' })
        test.true( _.strHas( lines[ lines.length - 1 ], 'Listing...' ) );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  //

  ready.then( () =>
  {
    test.case = 'after install'
    return null;
  })
  start( '.package.install package:///git' )
  start( '.package.local.versions package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.true( _.strHas( got.output, '2.18.2-1.el8_1' ) )
      }
      else if( isUbuntu )
      {
        test.true( _.strHas( got.output, '1:2.17.1-1ubuntu0.5' ) );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  return ready;

  /* */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }
}

packageLocalVersions.experimental = 1;


//

function packageRemoteVersions( test )
{
  let self = this;
  let routinePath = _.path.join( self.suiteTempPath, test.name );

  let execUnrestrictedPath = _.path.nativize( _.path.join( __dirname, '../will/ExecUnrestricted' ) );
  let ready = new _.Consequence().take( null );

  _.fileProvider.dirMake( routinePath )

  let isCentOs = false;
  let isUbuntu = false;

  if( process.platform === 'linux' )
  {
    let info = linuxInfoGet();
    isCentOs = _.strHas( info.dist.toLowerCase(), 'centos' );
    isUbuntu = _.strHas( info.dist.toLowerCase(), 'ubuntu' );
  }

  let start = _.process.starter
  ({
    execPath : execUnrestrictedPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    outputGraying : 1,
    mode : 'fork',
    ready,
  });

  //

  ready.then( () =>
  {
    test.case = 'all:0'
    return null;
  })

  start( '.package.remote.versions package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.ge( _.strCount( got.output, 'git.x86_64' ), 1 );
      }
      else if( isUbuntu )
      {
        let lines = _.strSplitNonPreserving({ src : got.output, delimeter : '\n' })
        test.true( lines.length > 0 );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  //

  ready.then( () =>
  {
    test.case = 'all:1'
    return null;
  })

  start( '.package.remote.versions package:///git all:1' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.ge( _.strCount( got.output, 'git.x86_64' ), 2 );
      }
      else if( isUbuntu )
      {
        let lines = _.strSplitNonPreserving({ src : got.output, delimeter : '\n' })
        test.ge( lines.length, 2 );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  //

  return ready;

  /* */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }
}

packageRemoteVersions.experimental = 1;


//

function packageVersion( test )
{
  let self = this;
  let routinePath = _.path.join( self.suiteTempPath, test.name );

  let execUnrestrictedPath = _.path.nativize( _.path.join( __dirname, '../will/ExecUnrestricted' ) );
  let ready = new _.Consequence().take( null );

  _.fileProvider.dirMake( routinePath )

  let isCentOs = false;
  let isUbuntu = false;

  if( process.platform === 'linux' )
  {
    let info = linuxInfoGet();
    isCentOs = _.strHas( info.dist.toLowerCase(), 'centos' );
    isUbuntu = _.strHas( info.dist.toLowerCase(), 'ubuntu' );
  }

  let start = _.process.starter
  ({
    execPath : execUnrestrictedPath,
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    outputGraying : 1,
    mode : 'fork',
    ready,
  });

  let shell = _.process.starter
  ({
    currentPath : routinePath,
    outputCollecting : 1,
    throwingExitCode : 0,
    outputGraying : 1,
    mode : 'spawn',
    ready,
  });

  //

  if( process.platform === 'linux' )
  {
    if( isCentOs )
    shell( 'yum remove -y git' )
    else if( isUbuntu )
    shell( 'apt --purge -y remove git' )
  }
  else if( process.platform === 'win32' )
  {
    shell( 'choco uninstall -y git' )
  }
  else if( process.platform === 'darwin' )
  {
    shell( 'brew uninstall --force git' )
  }

  //

  ready.then( () =>
  {
    test.case = 'package is not installed yet'
    return null;
  })

  start( '.package.version package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.true( _.strHas( got.output, 'package git is not installed' ) )
      }
      else if( isUbuntu )
      {
        test.true( _.strHas( got.output, `package 'git' is not installed` ) )
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  //

  ready.then( () =>
  {
    test.case = 'after install'
    return null;
  })
  start( '.package.install package:///git' )
  start( '.package.version package:///git' )
  .then( ( got ) =>
  {
    test.identical( got.exitCode, 0 );

    if( process.platform === 'linux' )
    {
      if( isCentOs )
      {
        test.true( _.strHas( got.output, '2.18.2-1.el8_1' ) )
      }
      else if( isUbuntu )
      {
        test.true( _.strHas( got.output, '1:2.17.1-1ubuntu0.5' ) );
      }
    }
    else if( process.platform === 'win32' )
    {
      _.assert( 0, 'implement test checks' )
    }
    else if( process.platform === 'darwin' )
    {
      _.assert( 0, 'implement test checks' )
    }

    return null;
  })

  return ready;

  /* */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }
}

packageVersion.experimental = 1;


// --
// declare
// --

const Proto =
{

  name : 'Tools.WillExternals.Package',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,
  routineTimeOut : 60000,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    repoDirPath : null,
    willPath : null,
  },

  tests :
  {
    trivial,
    packageInstall, /* aaa Vova : impelemnt test checks for Windows and MacOS */
    packageLocalVersions, /* aaa Vova : impelemnt test checks for Windows and MacOS */
    packageRemoteVersions, /* aaa Vova : impelemnt test checks for Windows and MacOS */
    packageVersion, /* aaa Vova : impelemnt test checks for Windows and MacOS */
  }

}

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
