// Generated by CoffeeScript 1.9.1
(function() {
  var Plugster, expect;

  expect = require('chai').expect;

  Plugster = require('../lib/Plugster');

  describe('Plugster tests', function() {
    var bar, foo;
    foo = new Plugster('foo', {
      input: {
        i1: function(msg) {
          console.log('input port 1 on Foo got message : ' + msg);
          return foo.send('o1', msg);
        }
      },
      output: ['o1']
    });
    bar = new Plugster('bar', {
      input: {
        i2: function(msg) {
          console.log('input port 2 on bar got message : ' + msg);
          return bar.baz = msg;
        }
      },
      output: ['o2']
    });
    foo.wire('o1', bar, 'i2');
    it('should be able to create a Plugster', function() {
      return expect(foo.isWiredTo('o1', 'bar', 'i2')).to.equal(true);
    });
    it('should be able to send a message between ports', function() {
      foo.send('o1', 'xyzzy');
      return expect(bar.baz).to.equal('xyzzy');
    });
    return it('should be able to send directly to an input port', function() {
      foo.sendDirectToInput('i1', 'quux');
      return expect(bar.baz).to.equal('quux');
    });
  });

}).call(this);

//# sourceMappingURL=plugster-spec.js.map
