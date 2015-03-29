### SimpleCalc
Приклад простого калькулятору.
Що відповідає завданню. Дозволяє обчислювати арифметичні вирази у повідомленнях.

    GitterOverflowPlugin = require './GitterOverflowPlugin'

    class GitterOverflowSimpleCalc extends GitterOverflowPlugin
      pattern: '^simplecalc (.*)$'
      calculate: (expression) ->
        eval(expression.replace(/[^0-9\+\*\-\/\(\)]/g, ""))
      run: (message) ->
        expr = @re.exec(message)[1]
        [expr, @calculate(expr)].join(' = ')

    module.exports = GitterOverflowSimpleCalc
