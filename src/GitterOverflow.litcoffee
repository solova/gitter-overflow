# Gitter Overflow

**GitterOverflow** це бот для [gitter.im](https://gitter.im),
що написано для участі в [UaWebChallenge](http://uawebchallenge.com)
на мові [Literate CoffeeScript](http://coffeescript.org/#literate).
з використанням можливостей [IcedCoffeeScript](https://github.com/maxtaco/coffee-script/)
Ядро боту дозволяє створювати плагіни, що реагують на повідомлення користувачів чату.

Для взаємодії з [gitter.im](https://gitter.im) використовується бібліотека [https://github.com/gitterHQ/node-gitter](node-gitter)

    Gitter = require 'node-gitter'
    GitterOverflowPing = require './GitterOverflowPing'
    GitterOverflowTime = require './GitterOverflowTime'
    GitterOverflowPunto = require './GitterOverflowPunto'
    GitterOverflowSimpleCalc = require './GitterOverflowSimpleCalc'
    GitterOverflowCalc = require './GitterOverflowCalc'

Ядро забезпечує авторизацію у [gitter.im](https://gitter.im) й містить функції контролю над сервісами.
Використання [IcedCoffeeScript](https://github.com/maxtaco/coffee-script/) дозволяє працювати з асінхроними викликами лаконічно та ефективно

    class GitterOverflow

      constructor: (@roomName, @token) ->
        @gitter = new Gitter @token
        @services = []
        await @gitter.currentUser defer(err,@user)
        await @gitter.rooms.join @roomName, defer(err,@room)
        if err
          console.error err
        else
          @room.send 'hello'
          @room.listen().on 'message', @message

Всі повідомлення кімнати прослуховуються. Якщо повідомлення надійшло не від самого боту - воно пропонується сервісам на опрацювання.

      message: (data) =>
        @room.send service.send data.text.trim() for service in @services unless data.fromUser.id is @user.id

Для реєєстрації сервісом використовується функція `addService`, яка додає сервіс у загальний масив та ініціалізує сервіс за потреби

      addService: (service) ->
        @services.push service
        # service.init?()


## Експорт *node* модулю
Модуль забезпечує створення інстансу з підключенням усіх плагінів.

    module.exports = (room, token) ->
      instance = new GitterOverflow room, token
      instance.addService (new GitterOverflowCalc)
      instance.addService (new GitterOverflowTime)
      instance.addService (new GitterOverflowPing)
      instance.addService (new GitterOverflowPunto)

