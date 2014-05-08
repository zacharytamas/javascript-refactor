/*global require,exports */

var _ = require('underscore');

var randInteger = function (min, max) {
    if (min === undefined) min = 0;
    if (max === undefined) max = 1000;
    return _.random(min, max);
};

var fun1 = function (a, b) {
    return a * b;
};

var fun2 = function (a, b) {
    var sum = 0;
    _(b).times(function() {
        sum += a;
    });
    return sum;
};

_.extend(exports, {
    // The arguments to call the functions with. If you don't
    // specify these randTest will generate completely
    // random inputs.
    args: [randInteger, randInteger],
    f: fun1,
    g: fun2,
    iterations: 10000,
    verbose: false
});

