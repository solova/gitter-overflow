### Punto
Приклад плагіну, що використовує інформацію отриману з повідомлення.
Плагін конвертує повідомленя набрані у неправильній розкладці.

    GitterOverflowPlugin = require './GitterOverflowPlugin'

    class GitterOverflowPunto extends GitterOverflowPlugin
      pattern: '^punto (.*)$',
      charsArray: 'Q':'Й','W':'Ц','E':'У','R':'К','T':'Е','Y':'Н','U':'Г','I':'Ш','O':'Щ','P':'З','[':'Х',']':'Ъ','A':'Ф','S':'Ы','D':'В','F':'А','G':'П','H':'Р','J':'О','K':'Л','L':'Д',';':'Ж','\'':'Э','Z':'Я','X':'Ч','C':'С','V':'М','B':'И','N':'Т','M':'Ь',',':'Б','.':'Ю','/':'.','q':'й','w':'ц','e':'у','r':'к','t':'е','y':'н','u':'г','i':'ш','o':'щ','p':'з','[':'х',']':'ъ','a':'ф','s':'ы','d':'в','f':'а','g':'п','h':'р','j':'о','k':'л','l':'д',';':'ж','\'':'э','z':'я','x':'ч','c':'с','v':'м','b':'и','n':'т','m':'ь',',':'б','.':'ю','/':'.'
      charsArrayInvert: "Й":"Q","Ц":"W","У":"E","К":"R","Е":"T","Н":"Y","Г":"U","Ш":"I","Щ":"O","З":"P","х":"[","ъ":"]","Ф":"A","Ы":"S","В":"D","А":"F","П":"G","Р":"H","О":"J","Л":"K","Д":"L","ж":";","э":"'","Я":"Z","Ч":"X","С":"C","М":"V","И":"B","Т":"N","Ь":"M","б":",","ю":".",".":"/","й":"q","ц":"w","у":"e","к":"r","е":"t","н":"y","г":"u","ш":"i","щ":"o","з":"p","ф":"a","ы":"s","в":"d","а":"f","п":"g","р":"h","о":"j","л":"k","д":"l","я":"z","ч":"x","с":"c","м":"v","и":"b","т":"n","ь":"m"
      convert: (chr) => @charsArray[chr] or chr
      convertBack: (chr) => @charsArrayInvert[chr] or chr
      translate: (str) ->
        convertor = if str[0] of @charsArray then @convert else @convertBack
        str.split('').map(convertor).join('')
      run: (message) -> @translate @re.exec(message)[1]

    module.exports = GitterOverflowPunto
