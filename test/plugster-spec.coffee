expect      = require('chai').expect
Plugster    = require('../lib/Plugster')

describe 'Plugster tests', ->

  # setup stuff
  foo = new Plugster(
    'foo',
      input:
        i1: (msg) ->
          console.log 'input port 1 on Foo got message : '+msg
          foo.send('o1', msg)
      output: ['o1']
  )

  bar = new Plugster(
    'bar',
    input:
      i2: (msg) ->
        console.log 'input port 2 on bar got message : '+msg
        bar.baz = msg
    output: ['o2']
  )

  foo.wire('o1', bar, 'i2')

  # testing
  it 'should be able to create a Plugster', () ->
    expect(foo.isWiredTo('o1', 'bar', 'i2')).to.equal(true)

  it 'should be able to send a message between ports', () ->
    foo.send('o1', 'xyzzy')
    expect(bar.baz).to.equal('xyzzy')

  it 'should be able to send directly to an input port', () ->
    foo.sendDirectToInput('i1', 'quux')
    expect(bar.baz).to.equal('quux')
