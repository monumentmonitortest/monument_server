core = {}; // Extend from this core object

var readyCore = function() {
  // core.readyDemoFunction();
};

$(document).on('page:load ready', readyCore);

// core.readyDemoFunction = function(name, url) {
// }