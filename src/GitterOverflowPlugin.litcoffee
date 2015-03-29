*Абстрактний клас* плагіну забезпечує розбір регулярного виразу й перевірку його на відповідность повідомленню.

    class GitterOverflowPlugin
      constructor: -> @re = new RegExp @pattern
      send: (message) -> @re.test(message) && @run(message)

    module.exports = GitterOverflowPlugin
