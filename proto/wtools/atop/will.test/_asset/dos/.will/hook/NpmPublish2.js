//
// let aboutCache = Object.create( null );
// function onModule( context )
// {
//   let o = context.request.map;
//   let _ = context.tools;
//   let logger = context.logger;
//   let fileProvider = context.will.fileProvider;
//   let path = context.will.fileProvider.path;
//   let configPath = path.join( context.junction.dirPath, 'package.json' );
//
//   if( o.v !== null && o.v !== undefined )
//   o.verbosity = o.v;
//   _.routine.options( onModule, o );
//
//   if( !context.junction.module )
//   return;
//
//   if( !context.junction.module.about.enabled )
//   return;
//
//   if( !o.tag )
//   throw _.errBrief( 'Expects option {-tag-}' );
//
//   let diff;
//
//   {
//     let context2 = context.will.hookContextNew( context );
//     context2.request.subject = `-am "."`
//     context2.request.original = context2.request.subject;
//     delete context2.request.map.tag;
//     delete context2.request.map.dry;
//     delete context2.request.map.force;
//     _.assert( context2.request.map !== context.request.map );
//     context2.will.hooks.GitSync.call( context2 );
//   }
//
//   if( !o.force )
//   {
//     try
//     {
//       diff = _.git.diff
//       ({
//         state2 : `!${ o.tag }`,
//         localPath : context.junction.dirPath,
//         sync : 1,
//       });
//     }
//     catch( err )
//     {
//       _.errAttend( err );
//       logger.log( err );
//     }
//   }
//
//   if( o.force || !diff || diff.status )
//   {
//     if( o.verbosity )
//     logger.log( ` + Publishing ${context.junction.nameWithLocationGet()}` );
//     if( o.verbosity >= 2 && diff && diff.status )
//     {
//       logger.up();
//       logger.log( _.entity.exportStringNice( diff.status ) );
//       logger.down();
//     }
//   }
//   else
//   {
//     if( o.verbosity )
//     logger.log( ` x Nothing to publish in ${context.junction.nameWithLocationGet()}` );
//     return;
//   }
//
//   if( o.dry )
//   return;
//
//   /* */
//
//   let version = context.junction.module.willfileVersionBump( Object.create( null ) );
//
//   _.assert( path.isTrailed( context.junction.localPath ), 'not tested' );
//
//   let currentContext = context.junction.module.stepMap[ 'willfile.generate' ];
//   context.junction.module.npmGenerateFromWillfile
//   ({
//     packagePath : '{path::in}/package.json',
//     currentContext,
//     verbosity : o.verbosity,
//   });
//
//   context.start( 'will.local .export' );
//
//   _.npm.fileFixate
//   ({
//     dry : o.dry,
//     localPath : context.junction.dirPath,
//     configPath,
//     tag : o.tag,
//     onDep,
//     verbosity : o.verbosity - 2,
//   });
//
//   {
//     let context2 = context.will.hookContextNew( context );
//     context2.request.subject = `-am "version ${ version }"`
//     context2.request.original = context2.request.subject;
//     delete context2.request.map.tag;
//     delete context2.request.map.dry;
//     delete context2.request.map.force;
//     context2.will.hooks.GitSync.call( context2 );
//   }
//
//   {
//     let context2 = context.will.hookContextNew( context );
//     context2.request.subject = '';
//     context2.request.original = '';
//     context2.request.map = { name : `v${ version }` };
//     context2.will.hooks.GitTag.call( context2 );
//   }
//
//   {
//     let context2 = context.will.hookContextNew( context );
//     context2.request.subject = '';
//     context2.request.original = '';
//     context2.request.map = { name : o.tag };
//     context2.will.hooks.GitTag.call( context2 );
//   }
//
//   {
//     let context2 = context.will.hookContextNew( context );
//     context2.request.subject = '';
//     context2.request.original = '';
//     context2.will.hooks.GitPush.call( context2 );
//   }
//
//   _.npm.publish
//   ({
//     localPath : context.junction.dirPath,
//     tag : o.tag,
//     ready : context.ready,
//     verbosity : o.verbosity === 2 ? 2 : o.verbosity -1,
//   })
//
//   function onDep( dep )
//   {
//
//     if( dep.version )
//     return;
//
//     let about = aboutCache[ dep.name ];
//     if( !about )
//     about = aboutCache[ dep.name ] = _.npm.remoteAbout( dep.name );
//     if( about && about.author && _.strIs( about.author.name ) && _.strHas( about.author.name, 'Kostiantyn Wandalen' ) )
//     {
//       dep.version = o.tag;
//       return;
//     }
//     if( about && about.version )
//     {
//       dep.version = about.version;
//     }
//   }
//
// }
//
// var defaults = onModule.defaults = Object.create( null );
//
// defaults.tag = null;
// defaults.v = null;
// defaults.dry = 0;
// defaults.force = 0;
// defaults.verbosity = 2;
//
// //
//
// module.exports = onModule;
