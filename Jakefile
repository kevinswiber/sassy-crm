desc("run specs");
task("test", function() {
    var jasmine = require('jasmine-node');
    jasmine.dev_mode = "src";
    
    var Path = require('path');
    var specFolder = Path.join(process.cwd(), "spec");
console.log(specFolder);
    
    for (var key in jasmine) {
        global[key] = jasmine[key];
    }

    var isVerbose = false;
    var showColors = true;
    var extensions = "coffee|js";
    jasmine.loadHelpersInFolder(specFolder, new RegExp("[-]helper\\.(" + extensions + ")$"));
    jasmine.executeSpecsInFolder(specFolder, function(runner, log) {
        if (runner.results().failedCount === 0) {
            process.exit(0);
        } else {
            process.exit(1);
        }
    }, isVerbose, showColors, false, new RegExp(".spec\\.(" + extensions + ")$", 'i'), false);
});
