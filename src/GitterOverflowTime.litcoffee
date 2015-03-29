### Time
Трохи складніший плагін. Відміність у використанні динамічних даних, а саме часу у таймзоні серверу.

    GitterOverflowPlugin = require './GitterOverflowPlugin'

    class GitterOverflowTime extends GitterOverflowPlugin
      pattern: '^time$',
      run: (message) -> (new Date).toString()

    module.exports = GitterOverflowTime
