// Generated by CoffeeScript 1.9.1
(function() {
  var Plugster, promise, uuid,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  uuid = require('node-uuid');

  promise = require('node-promise');

  Plugster = (function() {
    Plugster.modules = [];

    function Plugster(name, ports, serviceModel) {
      this.name = name;
      this.serviceModel = serviceModel;
      this.sendDirectToInput = bind(this.sendDirectToInput, this);
      this.input = ports.input;
      this.output = {};
      ports.output.forEach((function(_this) {
        return function(portName) {
          return _this.output[portName] = void 0;
        };
      })(this));
      Plugster.modules[this.name] = this;
    }

    Plugster.prototype.wire = function(outputPortName, inputModule, inputPortName) {
      console.log('Plugster::wire wiring module "' + this.name + '" port "' + outputPortName + '" to module "' + inputModule.name + '" port "' + outputPortName + '"');
      return this.output[outputPortName] = {
        inputModuleName: inputModule.name,
        inputPortName: inputPortName
      };
    };

    Plugster.prototype.isWiredTo = function(outputPortName, inputModuleName, inputPortName) {
      return this.output[outputPortName] && this.output[outputPortName].inputModuleName === inputModuleName && this.output[outputPortName].inputPortName === inputPortName;
    };

    Plugster.prototype.send = function(outputPortName, data) {
      var iModule, iPort, wire;
      wire = this.output[outputPortName];
      console.log('Plugster::send sending data from module "' + this.name + '" port "' + outputPortName + '" to module "' + wire.inputModuleName + '" port "' + wire.inputPortName + '"');
      iModule = Plugster.modules[wire.inputModuleName];
      iPort = iModule.input[wire.inputPortName];
      if (iPort) {
        iPort(data);
        return true;
      } else {
        console.log('Plugster::send could find no connected input port function for module "' + wire.inputModuleName + '" port "' + wire.inputPortName);
        return false;
      }
    };

    Plugster.prototype.sendDirectToInput = function(inputPortName, data) {
      var iPort;
      iPort = this.input[inputPortName];
      if (iPort) {
        return iPort(data);
      } else {
        return console.log('Plugster::sendDirectToInput no input function connected to name "' + inputPortName + '"');
      }
    };

    return Plugster;

  })();

  module.exports = Plugster;

}).call(this);

//# sourceMappingURL=Plugster.js.map
