xxx

// ( function _ExportRun_s_( ) {
//
// 'use strict';
//
// if( typeof module !== 'undefined' )
// {
//
//   require( '../IncludeBase.s' );
//
// }
//
// //
//
// let _ = wTools;
// let Parent = null;
// let Self = function wWillExportRun( o )
// {
//   return _.instanceConstructor( Self, this, arguments );
// }
//
// Self.shortName = 'ExportRun';
//
// // --
// // inter
// // --
//
// function finit()
// {
//   if( this.formed )
//   this.unform();
//   return _.Copyable.prototype.finit.apply( this, arguments );
// }
//
// //
//
// function init( o )
// {
//   let run = this;
//
//   _.assert( arguments.length === 0 || arguments.length === 1 );
//
//   _.instanceInit( run );
//   Object.preventExtensions( run );
//
//   if( o )
//   run.copy( o );
//
// }
//
// //
//
// function unform()
// {
//   let run = this;
//   let module = run.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   _.assert( arguments.length === 0 );
//   _.assert( run.formed );
//
//   /* begin */
//
//   /* end */
//
//   run.formed = 0;
//   return run;
// }
//
// //
//
// function form()
// {
//   let run = this;
//   let module = run.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   _.assert( arguments.length === 0 );
//   _.assert( !run.formed );
//
//   _.assert( !!will );
//   _.assert( !!module );
//   _.assert( !!fileProvider );
//   _.assert( !!logger );
//   _.assert( !!will.formed );
//   _.assert( !!module.formed );
//   _.assert( module.formed >= 1 );
//
//   /* begin */
//
//   /* end */
//
//   run.formed = 1;
//   return run;
// }
//
// //
//
// function run( exp )
// {
//   let run = this;
//   let module = run.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//   let con = new _.Consequence().give();
//
//   _.assert( arguments.length === 1 );
//   _.assert( run.formed === 1 );
//   _.assert( exp.formed === 3 );
//   _.assert( exp instanceof will.Export );
//   _.assert( _.objectIs( module.inFileWithRoleMap.import ) );
//   _.assert( _.objectIs( module.inFileWithRoleMap.export ) );
//
//   let expf = new ExportFile({ module : module, export : exp });
//
//   // build.stepsEach( function( it )
//   // {
//   //   if( it.element instanceof will.Step )
//   //   {
//   //     _.assert( _.routineIs( it.element.stepRoutine ), 'Step', it.element.name, 'does not have step routine' );
//   //     it.element.stepRoutine( run );
//   //   }
//   //   else if( it.element instanceof will.Build )
//   //   {
//   //     debugger;
//   //     run.run( it.element );
//   //   }
//   // });
//
//   return con;
// }
//
// // --
// // relations
// // --
//
// let Composes =
// {
// }
//
// let Aggregates =
// {
// }
//
// let Associates =
// {
//   module : null,
// }
//
// let Restricts =
// {
//   formed : 0,
// }
//
// let Statics =
// {
// }
//
// let Forbids =
// {
//   setting : 'setting',
// }
//
// let Accessors =
// {
// }
//
// // --
// // declare
// // --
//
// let Proto =
// {
//
//   // inter
//
//   finit : finit,
//   init : init,
//   unform : unform,
//   form : form,
//
//   run : run,
//
//   // relation
//
//   Composes : Composes,
//   Aggregates : Aggregates,
//   Associates : Associates,
//   Restricts : Restricts,
//   Statics : Statics,
//   Forbids : Forbids,
//   Accessors : Accessors,
//
// }
//
// //
//
// _.classDeclare
// ({
//   cls : Self,
//   parent : Parent,
//   extend : Proto,
// });
//
// _.Copyable.mixin( Self );
//
// //
//
// if( typeof module !== 'undefined' && module !== null )
// module[ 'exports' ] = wTools;
//
// _.staticDecalre
// ({
//   prototype : _.Will.prototype,
//   name : Self.shortName,
//   value : Self,
// });
//
// })();
