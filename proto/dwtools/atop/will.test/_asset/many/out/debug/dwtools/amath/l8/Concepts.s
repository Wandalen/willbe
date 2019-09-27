(function _Concepts_s_() {

'use strict';

/**
 * Collection of functions to operate such geometrical concepts as Sphere, Box, Plane, Frustum, Ray, Axis and Angle, Euler's Angles, Quaternion and other. Why MathConcepts? Three reasons. All functions of the module are purely functional. MathConcepts heavily relies on another great concept MathVector what makes the module less sensible to data formats of operational objects. The module provides functions for conversions from one to another conceptual form, for example from Quaternion to Euler's Angles or from Euler's Angles to Quaternion or between different representations of Euler's Angles. Unlike MatchConcepts many alternatives do conversions inconsistently or inaccurately. MatchConcepts is densely covered by tests and optimized for accuracy. Use MatchConcepts to have uniform experience solving geometrical problems and to get a more flexible program.
  @module Tools/math/Concepts
*/

/**
 * @file geometric/Concepts.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wMathScalar' );
  _.include( 'wMathVector' );
  _.include( 'wMathSpace' );

  require( '../l7_concept/Box.s' );
  require( '../l7_concept/Capsule.s' );
  require( '../l7_concept/Frustum.s' );
  require( '../l7_concept/Line.s' );
  require( '../l7_concept/Plane.s' );
  require( '../l7_concept/Ray.s' );
  require( '../l7_concept/Segment.s' );
  require( '../l7_concept/Sphere.s' );

  require( '../l7_concept/AxisAndAngle.s' );
  require( '../l7_concept/Quat.s' );
  require( '../l7_concept/Euler.s' );

}

})();
