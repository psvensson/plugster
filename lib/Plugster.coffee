uuid             = require('node-uuid')
promise          = require('node-promise')

class Plugster

  @modules = []

  # ports looks like: {input: {'name': function(), ..}, output: ['name1', 'name2',..}
  constructor: (@name, ports) ->
    #console.log ' Plugster constructor'
    #console.dir ports
    @input = ports.input
    @output = {}
    ports.output.forEach (portName) => @output[portName] = undefined
    Plugster.modules[@name] = @


  # xModule are references to instances of this class, xName are names of input or output ports to be wired between the modules
  wire: (outputPortName, inputModule, inputPortName) ->
    console.log 'Plugster::wire wiring module "'+@name+'" port "'+outputPortName+'" to module "'+inputModule.name+'" port "'+outputPortName+'"'
    @output[outputPortName] = { inputModuleName: inputModule.name, inputPortName: inputPortName }

  isWiredTo: (outputPortName, inputModuleName, inputPortName) ->
    @output[outputPortName] and @output[outputPortName].inputModuleName == inputModuleName and @output[outputPortName].inputPortName == inputPortName

  # sends the data to any input port of another module previously wired to the named output port of this
  send: (outputPortName, data) ->
    wire = @output[outputPortName]
    console.log 'Plugster::send sending data from module "'+@name+'" port "'+outputPortName+'" to module "'+wire.inputModuleName+'" port "'+wire.inputPortName+'"'
    iModule = Plugster.modules[wire.inputModuleName]
    iPort = iModule.input[wire.inputPortName]
    if iPort
      iPort(data)
      return true
    else
      console.log 'Plugster::send could find no connected input port function for module "'+wire.inputModuleName+'" port "'+wire.inputPortName
      return false

module.exports = Plugster