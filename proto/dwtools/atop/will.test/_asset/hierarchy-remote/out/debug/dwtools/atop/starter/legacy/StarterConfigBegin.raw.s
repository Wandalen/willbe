
// > StarterConfigBegin

let _global = undefined;
if( !_global && typeof Global !== 'undefined' && Global.Global === Global ) _global = Global;
if( !_global && typeof global !== 'undefined' && global.global === global ) _global = global;
if( !_global && typeof window !== 'undefined' && window.window === window ) _global = window;
if( !_global && typeof self   !== 'undefined' && self.self === self ) _global = self;
let _realGlobal = _global._realGlobal_ = _global;
let _wasGlobal = _global._global_ || _global;
_global = _wasGlobal;
_global._global_ = _wasGlobal;

//

let _starter_ = _realGlobal._starter_ = _realGlobal._starter_ || Object.create( null );
_realGlobal.Config = _realGlobal.Config || Object.create( null );

// < StarterConfigBegin
