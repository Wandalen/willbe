( function _FileProvider_Git_test_ss_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  try
  {
    require( 'gitconfiglocal' )
  }
  catch( err )
  {
    return;
  }

  require( '../files/UseTop.s' );
}

//

var _ = _global_.wTools;

//

function onSuiteBegin( test )
{
  let context = this;

  context.providerSrc = _.FileProvider.Git();
  context.providerDst = _.FileProvider.HardDrive();
  context.system = _.FileProvider.System({ providers : [ context.providerSrc, context.providerDst ] });
  context.system.defaultProvider = context.providerDst;

  let path = context.providerDst.path;

  context.suitePath = path.pathDirTempOpen( path.join( __dirname, '../..'  ),'FileProviderGit' );
  context.suitePath = context.providerDst.pathResolveLinkFull({ filePath : context.suitePath, resolvingSoftLink : 1 });
  context.suitePath = context.suitePath.absolutePath;

}

function onSuiteEnd( test )
{
  let context = this;
  let path = context.providerDst.path;
  _.assert( _.strHas( context.suitePath, 'FileProviderGit' ), context.suitePath );
  path.pathDirTempClose( context.suitePath );
}

// --
// tests
// --

function filesReflectTrivial( test )
{
  let context = this;
  let providerSrc = context.providerSrc;
  let providerDst = context.providerDst;
  let system = context.system;
  let path = context.providerDst.path;
  let testPath = path.join( context.suitePath, 'routine-' + test.name );
  let localPath = path.join( testPath, 'wPathBasic' );
  debugger;
  let clonePathGlobal = providerDst.path.globalFromPreferred( localPath );

  let con = new _.Consequence().take( null )

  .then( () =>
  {
    test.case = 'no hash, no trailing /';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    let expected =
    [
      '.',
      './LICENSE',
      './package.json',
      './README.md',
      './out',
      './out/wPathBasic.out.will.yml',
      './out/debug',
      './proto',
      './sample'
    ]

    test.is( _.arraySetContainAll( files, expected ) )
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'no hash, trailing /';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git/';
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    let expected =
    [
      '.',
      './LICENSE',
      './package.json',
      './README.md',
      './out',
      './out/wPathBasic.out.will.yml',
      './out/debug',
      './proto',
      './sample'
    ]

    test.is( _.arraySetContainAll( files, expected ) )
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'hash, no trailing /';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#master';
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    let expected =
    [
      '.',
      './LICENSE',
      './package.json',
      './README.md',
      './out',
      './out/wPathBasic.out.will.yml',
      './out/debug',
      './proto',
      './sample'
    ]

    test.is( _.arraySetContainAll( files, expected ) )
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'not existing repository';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///DoesNotExist.git';
    let result = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
    return test.shouldThrowErrorAsync( result );
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    test.identical( files, [ '.' ] );
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'reflect twice in a row';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#master';
    let o = { reflectMap : { [ remotePath ] : clonePathGlobal }};

    let ready = new _.Consequence().take( null );
    ready.then( () => system.filesReflect( _.mapExtend( null, o ) ) )
    ready.then( () => system.filesReflect( _.mapExtend( null, o ) ) )

    return ready;
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    let expected =
    [
      '.',
      './LICENSE',
      './package.json',
      './README.md',
      './out',
      './out/wPathBasic.out.will.yml',
      './out/debug',
      './proto',
      './sample'
    ]

    test.is( _.arraySetContainAll( files, expected ) )
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'reflect twice in a row, fetching off';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#master';
    let o =
    {
      reflectMap : { [ remotePath ] : clonePathGlobal },
      extra : { fetching : false }
    };

    let ready = new _.Consequence().take( null );
    ready.then( () => system.filesReflect( _.mapExtend( null, o ) ) )
    ready.then( () => system.filesReflect( _.mapExtend( null, o ) ) )

    return ready;
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    let expected =
    [
      '.',
      './LICENSE',
      './package.json',
      './README.md',
      './out',
      './out/wPathBasic.out.will.yml',
      './out/debug',
      './proto',
      './sample'
    ]

    test.is( _.arraySetContainAll( files, expected ) )
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'commit hash, no trailing /';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#05930d3a7964b253ea3bbfeca7eb86848f550e96';
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })
  .then( ( got ) =>
  {
    let files = providerDst.filesFind
    ({
      filePath : localPath,
      withTerminals : 1,
      withDirs : 1,
      outputFormat : 'relative',
      filter : { recursive : 2 }
    });

    let expected =
    [
      '.',
      './LICENSE',
      './package.json',
      './README.md',
      './out',
      './out/wPathFundamentals.out.will.yml',
      './out/debug',
      './proto',
      './sample'
    ]

    test.is( _.arraySetContainAll( files, expected ) )
    let packagePath = providerDst.path.join( localPath, 'package.json' );
    let packageRead = providerDst.fileRead
    ({
      filePath : packagePath,
      encoding : 'json'
    });
    test.identical( packageRead.version, '0.6.157' );
    return got;
  })

  /*  */

  .then( () =>
  {
    test.case = 'local is behind remote';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git reset --hard HEAD~1',
      currentPath : localPath,
      ready
    })

    ready.then( () => system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 }) );

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) )
      return null;
    })

    return ready;
  })

  /*  */

  .then( () =>
  {
    test.case = 'local has new commit, remote up to date, no merge required';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git commit --allow-empty -m emptycommit',
      currentPath : localPath,
      ready
    })

    ready.then( () => system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 }) );

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is ahead of 'origin/master' by 1 commit` ) )
      return null;
    })

    _.process.start
    ({
      execPath : 'git log -n 2',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( !_.strHas( got.output, `Merge remote-tracking branch 'refs/remotes/origin/master'` ) )
      test.is( _.strHas( got.output, `emptycommit` ) )
      return null;
    })

    return ready;
  })

  /*  */

  .then( () =>
  {
    test.case = 'local and remote have one new commit, should be merged';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git reset --hard HEAD~1',
      currentPath : localPath,
      ready
    })

    _.process.start
    ({
      execPath : 'git commit --allow-empty -m emptycommit',
      currentPath : localPath,
      ready
    })

    ready.then( () => system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 }) );

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is ahead of 'origin/master' by 2 commits` ) )
      return null;
    })

    _.process.start
    ({
      execPath : 'git log -n 2',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Merge remote-tracking branch 'refs/remotes/origin/master'` ) )
      test.is( _.strHas( got.output, `emptycommit` ) )
      return null;
    })

    return ready;
  })

  /*  */

  .then( () =>
  {
    test.case = 'local version is fixate and has local commit, update to latest';
    providerDst.filesDelete( localPath );
    let remotePathFixate = 'git+https:///github.com/Wandalen/wPathBasic.git#05930d3a7964b253ea3bbfeca7eb86848f550e96';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePathFixate ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git commit --allow-empty -m emptycommit',
      currentPath : localPath,
      ready
    })

    ready.then( () => system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 }) );

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) )
      return null;
    })

    return ready;
  })

  /*  */

  .then( () =>
  {
    test.case = 'local has fixed version, update to latest';
    providerDst.filesDelete( localPath );
    let remotePathFixate = 'git+https:///github.com/Wandalen/wPathBasic.git#05930d3a7964b253ea3bbfeca7eb86848f550e96';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePathFixate ] : clonePathGlobal }, verbosity : 5 });

    ready.then( () => system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 }) );

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) )
      return null;
    })

    return ready;
  })

  /*  */

  .then( () =>
  {
    test.case = 'local has changes, checkout throws an error';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
    let remotePathUnknownHash = 'git+https:///github.com/Wandalen/wPathBasic.git#other';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    ready.then( ( got ) =>
    {
      providerDst.fileWrite( providerDst.path.join( localPath, 'README.md' ), 'test' );
      return null;
    })

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `modified:   README.md` ) )
      return null;
    })

    ready.then( () =>
    {
      let con = system.filesReflect({ reflectMap : { [ remotePathUnknownHash ] : clonePathGlobal }, verbosity : 5 });
      return test.shouldThrowErrorAsync( con );
    })

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `modified:   README.md` ) )
      return null;
    })

    return ready;
  })

  /* */

  .then( () =>
  {
    test.case = 'no local changes, checkout throws an error';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
    let remotePathUnknownHash = 'git+https:///github.com/Wandalen/wPathBasic.git#other';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) )
      return null;
    })

    ready.then( () =>
    {
      let con = system.filesReflect({ reflectMap : { [ remotePathUnknownHash ] : clonePathGlobal }, verbosity : 5 });
      return test.shouldThrowErrorAsync( con );
    })

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `Your branch is up to date with 'origin/master'.` ) )
      return null;
    })

    return ready;
  })

  return con;
}

filesReflectTrivial.timeOut = 60000;

//

function filesReflectNoStashing( test )
{
  let context = this;
  let providerSrc = context.providerSrc;
  let providerDst = context.providerDst;
  let system = context.system;
  let path = context.providerDst.path;
  let testPath = path.join( context.suitePath, 'routine-' + test.name );
  let localPath = path.join( testPath, 'wPathBasic' );
  debugger;
  let clonePathGlobal = providerDst.path.globalFromPreferred( localPath );

  let con = new _.Consequence().take( null )

  .then( () =>
  {
    test.case = 'local has changes, remote have one new commit, error expected';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git reset --hard HEAD~1',
      currentPath : localPath,
      ready
    })

    ready.then( () =>
    {
      _.fileProvider.fileWrite( _.path.join( localPath, 'README.md' ), '' );
      return null;
    })

    ready.then( () =>
    {
      let con = system.filesReflect
      ({
        reflectMap : { [ remotePath ] : clonePathGlobal },
        verbosity : 5,
        extra : { stashing : 0 }
      });
      return test.shouldThrowErrorAsync( con );
    });

    _.process.start
    ({
      execPath : 'git status',
      currentPath : localPath,
      ready,
      outputCollecting : 1
    })

    ready.then( ( got ) =>
    {
      test.identical( got.exitCode, 0 );
      test.is( _.strHas( got.output, `modified:   README.md` ) )
      return null;
    })

    return ready;
  })

  return con;

}

filesReflectNoStashing.timeOut = 60000;


//

function isUpToDate( test )
{
  let context = this;
  let providerSrc = context.providerSrc;
  let providerDst = context.providerDst;
  let system = context.system;
  let path = context.providerDst.path;
  let testPath = path.join( context.suitePath, 'routine-' + test.name );
  let localPath = path.join( testPath, 'wPathBasic' );
  let clonePathGlobal = providerDst.path.globalFromPreferred( localPath );

  let con = new _.Consequence().take( null )

  .then( () =>
  {
    test.open( 'local master' );
    test.case = 'setup';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
    providerDst.filesDelete( localPath );
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })

  .then( () =>
  {
    test.case = 'remote master';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
    return providerSrc.isUpToDate({ localPath, remotePath })
    .then( ( got ) =>
    {
      test.identical( got, true );
      return got;
    })
  })

  .then( () =>
  {
    test.case = 'remote has different branch';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#other';
    return providerSrc.isUpToDate({ localPath, remotePath })
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })
  })

  .then( () =>
  {
    test.case = 'remote has fixed version';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#c94e0130358ba54fc47237e15bac1ab18024c0a9';
    return providerSrc.isUpToDate({ localPath, remotePath })
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })
  })

  .then( () =>
  {
    test.close( 'local master' );
    return null;
  })

  /**/

  .then( () =>
  {
    test.open( 'local detached' );
    test.case = 'setup';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#c94e0130358ba54fc47237e15bac1ab18024c0a9';
    providerDst.filesDelete( localPath );
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })

  .then( () =>
  {
    test.case = 'remote has same fixed version';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#c94e0130358ba54fc47237e15bac1ab18024c0a9';
    return providerSrc.isUpToDate({ localPath, remotePath })
    .then( ( got ) =>
    {
      test.identical( got, true );
      return got;
    })
  })

  .then( () =>
  {
    test.case = 'remote has other fixed version';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#469a6497f616cf18639b2aa68957f4dab78b7965';
    return providerSrc.isUpToDate({ localPath, remotePath })
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })
  })

  .then( () =>
  {
    test.case = 'remote has other branch';
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git#other';
    return providerSrc.isUpToDate({ localPath, remotePath })
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })
  })

  .then( () =>
  {
    test.close( 'local detached' );
    return null;
  })

  /**/

  .then( () =>
  {
    test.case = 'local is behind remote';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git reset --hard HEAD~1',
      currentPath : localPath,
      ready
    })

    ready
    .then( () => providerSrc.isUpToDate({ localPath, remotePath }) )
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })

    return ready;
  })

  .then( () =>
  {
    test.case = 'local is ahead remote';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git commit --allow-empty -m emptycommit',
      currentPath : localPath,
      ready
    })

    ready
    .then( () => providerSrc.isUpToDate({ localPath, remotePath }) )
    .then( ( got ) =>
    {
      test.identical( got, true );
      return got;
    })

    return ready;
  })

  .then( () =>
  {
    test.case = 'local and remote have new commit';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';

    let ready = system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git reset --hard HEAD~1',
      currentPath : localPath,
      ready
    })

    _.process.start
    ({
      execPath : 'git commit --allow-empty -m emptycommit',
      currentPath : localPath,
      ready
    })

    ready
    .then( () => providerSrc.isUpToDate({ localPath, remotePath }) )
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })

    return ready;
  })

  .then( () =>
  {
    test.case = 'local is detached and has local commit';
    providerDst.filesDelete( localPath );
    let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
    let remotePathFixate = 'git+https:///github.com/Wandalen/wPathBasic.git#05930d3a7964b253ea3bbfeca7eb86848f550e96';

    let ready = system.filesReflect({ reflectMap : { [ remotePathFixate ] : clonePathGlobal }, verbosity : 5 });

    _.process.start
    ({
      execPath : 'git commit --allow-empty -m emptycommit',
      currentPath : localPath,
      ready
    })

    ready
    .then( () => providerSrc.isUpToDate({ localPath, remotePath }) )
    .then( ( got ) =>
    {
      test.identical( got, false );
      return got;
    })

    return ready;
  })

  return con;
}

isUpToDate.timeOut = 30000;

//

function isDownloadedFromRemote( test )
{
  let context = this;
  let providerSrc = context.providerSrc;
  let providerDst = context.providerDst;
  let system = context.system;
  let path = context.providerDst.path;
  let testPath = path.join( context.suitePath, 'routine-' + test.name );
  let localPath = path.join( testPath, 'wPathBasic' );
  let clonePathGlobal = providerDst.path.globalFromPreferred( localPath );
  let remotePath = 'git+https:///github.com/Wandalen/wPathBasic.git';
  let remotePath2 = 'git+https:///github.com/Wandalen/wTools.git';

  let con = new _.Consequence().take( null )


  .then( () =>
  {
    let got = providerSrc.isDownloadedFromRemote({ localPath, remotePath : remotePath });
    test.identical( got.downloaded, false )
    test.identical( got.downloadedFromRemote, false )
    return null;
  })

  .then( () =>
  {
    test.case = 'setup';
    providerDst.filesDelete( localPath );
    return system.filesReflect({ reflectMap : { [ remotePath ] : clonePathGlobal }});
  })

  .then( () =>
  {
    let got = providerSrc.isDownloadedFromRemote({ localPath, remotePath });
    test.identical( got.downloaded, true )
    test.identical( got.downloadedFromRemote, true )
    return null;
  })

  .then( () =>
  {
    let got = providerSrc.isDownloadedFromRemote({ localPath, remotePath : remotePath2 });
    test.identical( got.downloaded, true )
    test.identical( got.downloadedFromRemote, false )
    return null;
  })

  return con;
}

// --
// declare
// --

var Proto =
{

  name : 'Tools.mid.files.fileProvider.Git',
  abstract : 0,
  silencing : 1,
  enabled : 1,
  verbosity : 4,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suitePath : null,
    providerSrc : null,
    providerDst : null,
    system : null
  },

  tests :
  {
    filesReflectTrivial,
    filesReflectNoStashing,
    isUpToDate,
    isDownloadedFromRemote
  },

}

//

var Self = new wTestSuite( Proto )/* .inherit( Parent ); */
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
