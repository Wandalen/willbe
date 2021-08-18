
_global_.Test = Object.create( null );

function sumOfAll( a, b )
{
  return a + b;
}

_global_.Test.sumOfAll = sumOfAll;

module.exports = _global_.Test;
