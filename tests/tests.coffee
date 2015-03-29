'use strict';
assert = require 'assert'
GitterOverflow = require './GitterOverflow'
GitterOverflowPing = require './GitterOverflowPing'
GitterOverflowTime = require './GitterOverflowTime'
GitterOverflowPunto = require './GitterOverflowPunto'
GitterOverflowSimpleCalc = require './GitterOverflowSimpleCalc'
GitterOverflowCalc = require './GitterOverflowCalc'

describe 'gitter-overflow ping plugin', ->

  plugin = new GitterOverflowPing();

  it 'should return pong for ping request', ->
    assert.equal plugin.send('ping'), 'pong'

  it 'should return nothing for any other request', ->
    assert.equal plugin.send('pong'), false
    assert.equal plugin.send(''), false
    assert.equal plugin.send(42), false
    assert.equal plugin.send('pingping'), false
    assert.equal plugin.send('ping ping'), false
    assert.equal plugin.send('PING da'), false

describe 'gitter-overflow time plugin', ->

  plugin = new GitterOverflowTime()

  it 'should return current time', ->
    assert.equal plugin.send('time'), new Date()

describe 'gitter-overflow punto plugin', ->

  plugin = new GitterOverflowPunto()

  it 'should return converted string en:ru', ->
    assert.equal plugin.send('punto ghbdtn'), 'привет'

  it 'should return converted string ru:en', ->
    assert.equal plugin.send('punto руддщ'), 'hello'

describe 'gitter-overflow simplecalc plugin', ->

  plugin = new GitterOverflowSimpleCalc()

  it 'should return sum', ->
    assert.equal plugin.send('simplecalc 1+13'), '1+13 = 14'
    assert.equal plugin.send('simplecalc -5+13'), '-5+13 = 8'
    assert.equal plugin.send('simplecalc 0+0'), '0+0 = 0'

  it 'should return mul', ->
    assert.equal plugin.send('simplecalc 20*3'), '20*3 = 60'

describe 'gitter-overflow calc plugin', ->

  plugin = new GitterOverflowCalc()

  it 'should return sum0', ->
    assert.equal plugin.send('calc 1+13'), '1+13 = 14'

  it 'should return sum1', ->
    assert.equal plugin.send('calc 1+1+13'), '1+1+13 = 15'

  it 'should return sum2', ->
    assert.equal plugin.send('calc -5+13'), '-5+13 = 8'

  it 'should return sum3', ->
    assert.equal plugin.send('calc 0+0'), '0+0 = 0'

  it 'should return sum for floats', ->
    assert.equal plugin.send('calc 0.1+0.2'), '0.1+0.2 = 0.3'

  it 'should return sum for big numbers', ->
    assert.equal plugin.send('calc 1000000000000000000000+1000000000000000000000'), '1000000000000000000000+1000000000000000000000 = 2000000000000000000000'

  it 'should return mul', ->
    assert.equal plugin.send('calc 2*5'), '2*5 = 10'
    assert.equal plugin.send('calc 2*0'), '2*0 = 0'
    assert.equal plugin.send('calc 2*2*3'), '2*2*3 = 12'

  it 'should return mul for floats', ->
    assert.equal plugin.send('calc 0.1*3'), '0.1*3 = 0.3'

  it 'should return mul for big numbers', ->
    assert.equal plugin.send('calc 1000000000000000000000*2'), '1000000000000000000000*2 = 2000000000000000000000'

  it 'should return sub', ->
    assert.equal plugin.send('calc 13-8'), '13-8 = 5'
    assert.equal plugin.send('calc -13-8'), '-13-8 = -21'

  it 'should return sub for floats', ->
    assert.equal plugin.send('calc 0.3-0.1'), '0.3-0.1 = 0.2'

  it 'should return sub for big numbers', ->
    assert.equal plugin.send('calc 1000000000000000000000-1'), '1000000000000000000000-1 = 999999999999999999999'

  it 'should return div', ->
    assert.equal plugin.send('calc 4/2'), '4/2 = 2'
    assert.equal plugin.send('calc 5/2'), '5/2 = 2.5'

  it 'should return div for floats', ->
    assert.equal plugin.send('calc 0.3/0.1'), '0.3/0.1 = 3'

  it 'should return div for big numbers', ->
    assert.equal plugin.send('calc 1000000000000000000000/2'), '1000000000000000000000/2 = 500000000000000000000'

  it 'should calc hard cases', ->
    assert.equal plugin.send('calc 77+88*7/(2+25)+25/3-50*(12+5)'), '77+88*7/(2+25)+25/3-50*(12+5) = -741.85185185185185185186'

  it 'should process brackets', ->
    assert.equal plugin.send('calc 2+2*2'), '2+2*2 = 6'
    assert.equal plugin.send('calc (2+2)*2'), '(2+2)*2 = 8'

  it 'should process detect errors in brackets', ->
    assert.equal plugin.send('calc (2+2))*2'), '(2+2))*2 = ()ERROR'

  it 'should process detect errors in operators', ->
    assert.equal plugin.send('calc (2++2)*2'), '(2++2)*2 = OPERATOR ERROR'

  it 'should show error for wrong operations', ->
    assert.equal plugin.send('calc 1/0'), '1/0 = ERROR'
    assert.equal plugin.send('calc ()'), '() = ERROR'
