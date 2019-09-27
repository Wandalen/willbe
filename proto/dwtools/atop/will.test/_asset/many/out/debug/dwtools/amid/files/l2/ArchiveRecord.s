( function _AtchiveRecord_s_() {

'use strict';

//

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wArchiveRecord( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ArchiveRecord';

// --
// inter
// --

function finit()
{
  let record = this;
  let factory = record.factory;

  _.assert( factory.records.filePath[ record.absolute ] === record );
  delete factory.records.filePath[ record.absolute ];

  // debugger;

  record.deleting = 0;
  record.deletingOptions = null;
  record.stat = null;

  _.Copyable.prototype.finit.apply( record, arguments );
}

//

function init( o )
{
  let record = this;

  _.workpiece.initFields( record );

  if( o )
  {
    record.copy( o );
    if( o.absolute )
    record.absolute = o.absolute;
  }

  Object.preventExtensions( record );

  _.assert( _.strIs( record.absolute ) );
  _.assert( record.factory instanceof _.ArchiveRecordFactory );

  let factory = record.factory;
  let path = factory.originalFileProvider.path;

  _.assert( path.isAbsolute( record.absolute ) );
  _.assert( factory.records.filePath[ record.absolute ] === undefined );

  factory.records.filePath[ record.absolute ] = record;

}

//

function hashRead()
{
  let record = this;

  _.assert( arguments.length === 0 );

  if( !record.hash )
  record.hash = record.factory.originalFileProvider.hashRead( record.absolute );

  return record.hash;
}

//

function timelapsedDelete()
{
  let record = this;
  let factory = record.factory;

  logger.log( 'timelapsedDelete', record.absolute ); debugger;

  _.assert( _.mapIs( record.deletingOptions ) );
  _.assert( arguments.length === 0 );

  record.deletingOptions.sync = 1;

  let result = factory.originalFileProvider.fileDeleteAct( record.deletingOptions );

  record.deletingOptions = null;
  record.deleting = 0;

  return result;
}

//

function timelapsedSubFilesDelete()
{
  let record = this;
  let factory = record.factory;
  let path = factory.originalFileProvider.path;
  let result = 0;

  _.assert( _.mapIs( record.deletingOptions ) );
  _.assert( arguments.length === 0 );

  for( let f in factory.records.filePath )
  {
    let record2 = factory.records.filePath[ f ];

    if( record2.deleting && record2 !== record )
    if( path.begins( record2.absolute, record.absolute ) )
    {
      record2.timelapsedDelete();
      record2.finit();
      result += 1;
    }

  }

  return result;
}

// --
//
// --

let Composes =
{
  deleting : 0,
  hash : null,
}

let Aggregates =
{
}

let Associates =
{
  deletingOptions : null,
  stat : null,
  factory : null,
}

let Restricts =
{
  absolute : null,
}

let Medials =
{
  absolute : null,
}

let Statics =
{
}

let Forbids =
{
  fileProvider : 'fileProvider',
}

// --
// declare
// --

let Extend =
{

  finit,
  init,

  hashRead,
  timelapsedDelete,
  timelapsedSubFilesDelete,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

_[ Self.shortName ] = Self;

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
