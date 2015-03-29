# Gitter Overflow

**GitterOverflow** - це бот для [gitter.im](https://gitter.im),
що було написано для участі в [UaWebChallenge](http://uawebchallenge.com)
на мові [Literate CoffeeScript](http://coffeescript.org/#literate).
з використанням можливостей [IcedCoffeeScript](https://github.com/maxtaco/coffee-script/)
Ядро боту дозволяє створювати плагіни, що реагують на повідомлення користувачів чату.

Для взаємодії з [gitter.im](https://gitter.im) використовується бібліотека [node-gitter](https://github.com/gitterHQ/node-gitter).

## Запуск

У файлі config.json треба вказати валідний токен для gitter.im.
Необхідні пакети встановлються командою `npm install`.
Компіляція та юніт-тести запускаються командою `grunt`.

Далі бот може бути запущений як
```bash
node bot.js username/test
```

## Переваги

* Коментований програмний код
* Модульна система
* Покриття тестами
* [0.1 + 0.2 = 0.3](http://floating-point-gui.de/)
* [99999999999*99999999999 = 9999999999800000000001] (http://en.wikipedia.org/wiki/Scientific_notation)
