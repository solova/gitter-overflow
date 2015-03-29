### Ping
Найпростіший плагін. На вхідні повідомлення *ping* відопвідіє статичним рядком *pong*.

    GitterOverflowPlugin = require './GitterOverflowPlugin'

    class GitterOverflowPing extends GitterOverflowPlugin
      pattern: '^ping$',
      run: (message) -> 'pong'

    module.exports = GitterOverflowPing
