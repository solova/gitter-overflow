### Calc
Цільовий плагін - калькулятор.
Відповідає завданню. Дозволяє обчислювати арифметичні вирази у повідомленнях.

    GitterOverflowPlugin = require './GitterOverflowPlugin'

Для роботи з великими числами знадобиться бібліотека для роботи з довгою арифметикою.
Можна було б ще бібліотеку парсингу підключити - але що тоді писати?

    Big = require 'big.js'

    class GitterOverflowCalc extends GitterOverflowPlugin
      pattern: '^calc (.*)$'

Для перевірки виразу злічаємо кількість дужок, та перевіряємо появу ситуацію закриття невідкритої дужки.

      validateBrackets: (expression) ->
        stack = 0
        for chr in expression
          stack += 1 if chr is '('
          stack -= 1 if chr is ')'
          return false if stack < 0
        return stack == 0

Також перевірямо помилки у розтановці операторів, шукаючи ситуації їх дублювання.

      validateOperators: (expression) ->
        operators = ['+','-','*','/']
        for chr,idx in expression
          if expression[idx] in operators and expression[idx+1] in operators
            return false
        return true

Функція обчислю значення виразу, без урахування дужок.
Спочатку позбавляємося від операцій віднімання - перетворюючи їх на дадавання.
Можлива поява зайвого плюса на першій позиції - відрізаємо за необхідності.
Далі по плюсу розбиваємо на блоки з чисел та виразів.
Виразі розбиваємо ще раз отримуючи числа та операції.

      parse: (expression) ->
        expression = expression.replace(/-/g, '+-')
        expression = expression.slice(1) if expression.charAt(0)=='+'
        parts = expression.split('+').map((part)->
          if part.length
            operands = part.replace(/[*]/g, '|*|').replace(/[\/]/g, '|/|').split('|')
            result = Big(operands[0])
            i = 2
            while i<operands.length
              func = if operands[i-1] is '*' then 'mul' else 'div'
              result = result[func](operands[i])
              i += 2
            result
        ).reduce(((initial, current) -> initial.plus(current)), Big(0)).toFixed()

Функція опрацюваня дужок.
Шукає останню відкриваючу дужку та її пару. Після чого обчислює вираз й переходить до першого кроку.
Працює доки у виразі лишаються дужки.

      calculate: (expression) ->
        lastBracketIndex = expression.lastIndexOf '('
        while (lastBracketIndex >= 0)
          pairBracketIndex = expression.indexOf ')', lastBracketIndex
          inner = expression.slice(lastBracketIndex + 1, pairBracketIndex)
          result = @parse(inner)
          expression = expression.substr(0,lastBracketIndex) + result.toString() + expression.substr(pairBracketIndex+1);
          lastBracketIndex = expression.lastIndexOf '('
        @parse(expression)

      run: (message) ->
        expr = @re.exec(message)[1]
        unless @validateBrackets(expr)
          res = '()ERROR'
        else unless @validateOperators(expr)
          res = 'OPERATOR ERROR'
        else
          try
            res = @calculate(expr)
          catch
            res = "ERROR"
        [expr, res].join(' = ')

    module.exports = GitterOverflowCalc
