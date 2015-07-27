uuid             = require('node-uuid')
promise          = require('node-promise')

class Plugster

  @modules = []

  # ports looks like: {input: {'name': function(), ..}, output: ['name1', 'name2',..}
  constructor: (@moduleName, ports) ->
    @input = ports.input
    @output = {}
    ports.output.forEach (portName) -> @output[portName] = undefined
    Plugster.modules[moduleName] = @


  # xModule are references to instances of this class, xName are names of input or output ports to be wired between the modules
  @wire: (outputModule, outputPortName, inputModule, inputPortName) ->
    console.log 'Plugster::wire wiring module "'+outputModule.name+" port "+outputPortName+'" to module "'+inputModule.name+'" port "'+outputPortName
    outputModule.output[outputPortName] = inputModule.input[inputPortName]

  isWiredTo: (outputPortName, inputModule, inputPortname) ->
    @output[outputPortName] == inputModule.input[inputPortName]

  # sends the data to any input port of another module previousy wired to the named output port of this
  send: (outputPortName, data) ->



module.exports = Plugster