// ======================================
(function() {
  console.log("dir2/File.s");
})(), 
// ======================================
function() {
  console.log("dir2/File1.debug.js");
}(), 
// ======================================
function() {
  console.log("dir2/File1.release.js");
}(), 
// ======================================
function() {
  console.log("dir2/File2.debug.js");
}(), 
// ======================================
function() {
  console.log("dir2/File2.release.js");
}();