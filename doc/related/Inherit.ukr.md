# Наслідування

Керівництво по написанню коду (Code Convention)

### Структура модуля
Модуль будується за стандартною структурою, яка зображена на рисунку:  

```
wSomeModule                                                         # назва модуля, починається з "w"
     ├── proto                                                      # загальноприйнята директорія, де поміщається модуль
     │     └── dwtools                                              # директорія модуля з файлом "Tools.s"
     │            ├── atop                                          #
     │            │     ├── someModuleName                          # директорія з файлами модуля
     │            │     │         └── module_files_and_directories  # файли і директорії модуля (розглянуто нижче)
     │            │     └── someModuleName.test                     # директорія з тестами модуля (для відладки, тимчасова)
     │            │               └── module_files_and_directories  # тести для модуля
     │            └── Tools.s                                       #
     │                                                              #
     ├── doc (modules_documentation)                                # при наявності документації
     ├── README.md                                                  # загальна інформація про модуль
     ├── other_auxiliary_files_and_directories                      # допоміжні файли і папки модуля (необов'язково)
    
```  

В рамках компанії, модулі мають назву, яка починаєтьс з літери "w" та має продовження відповідно до призначення модуля. В директорії `proto` знаходиться модуль. Файл `Tools.s` - конструктор модуля. В директорії `atop` поміщені файли модуля.  
Структура модуля може бути простою та складною. На наступному рисунку показана проста конфігурація (шлях '/wSomeModule/proto/dwtools/atop/'):  

```
someModuleName                  # назва модуля
     ├── fileOfModule.s         #
     ├── fileOfModule.s         # файли модуля
     ├── fileOfModule.s         #

```
Проста конфігурація - файли модуля поміщені в директорію за шляхом '/wSomeModule/proto/dwtools/atop/someModuleName/'. Складна конфігурація від простої наявністю рівнів - розділення функціональностей модуля за пріоритетом. Приклад складної конфігурації з двома рівнями:  

```
someModuleName                  # назва модуля
     ├── l0                     # перший рівень модуля
     │    ├── fileOfLayer0.s    #
     │    ├── fileOfLayer0.s    # файли першого рівня
     │
     ├── l1                     # другий рівень модуля
     │    ├── fileOfLayer0.s    #
     │    ├── fileOfLayer0.s    # файли другого рівня
     │                          
     ├── fileOfModules.s        # файли модуля (зазвичай, конфыгураційні)

```

### Загальна структура файла  
При написанні коду притримуйтесь структури файлу та побудови структурних одиниць.  
Загальна структура файла:  

```js
( function _NameFunction_s_(){

'use strict';

// секція з підключенням залежностей
require('path_to_file');  
require('module');

// секція глобальних змінних і конструктор функції
var x = some_value;
var y = some_value;

// конструктор функції
var Self = function wNameFunction( argument )
{
  return constructor( arguments );
}

// секція рутин (функцій)
function one(){
    // some code
}
function two(){
    // some code
}

// композицію об'єкта
var Composes =
{
    arg1 : value,
    arg2 : value,
}

// асоціації виконання для окремих рутин
var Associates =
{
}

//
var Aggregates =
{
}

//
let Medials =
{
}

//
var Events =
{
  event : routine,
  event : routine,
}

/*
let Supplement =
{
  Statics : Statics,
}

let Tools =
{
  after,
  // before,
}
*/

// обмеження по вхідним даним
var Restricts =
{
}

// карта рутин
var Proto =
{
    one: one,
    two: two,
    // other routins
    Composes : Composes,
    Associates : Associates,
    Restricts : Restricts,
}

// об'явлення класу
_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

// об'явлення додаткових властивостей
_.accessor.declare( Self.prototype,
{
  width : 'width',
  rawMode : 'rawMode',
});

// секція експорту модуля

} )();

```

### Частини коду  
##### Об'явлення функції
Об'явлення функції має вигляд:

```js
( function _NameFunction_s_(){
    'use strict';
    // all code
})();

```
Один файл - окрема анонімна функція - заключена в дужки. Назва функція починається зі знаку нижнього підкреслювання "_", далі йде назва функції "NameFunction" (назва функції і назва файла співпадає) і закінчується назва функції на розширення файла заключене в знаки нижнього підкреслювання '_s_'. Директива 'use strict' позначає включення строгого режиму.

##### Додавання залежностей
Якщо для роботи модуля необхідні зовнішні файли, то вони підключаються в цій секції.

```js
// секція з підключенням залежностей
require('path_to_file');  
require('module');  

```

Приклад секції з перевірками на дійсність модуля і слідкуванням за помилками підключення.

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```js
if( typeof module !== 'undefined' )
{

  try
  {
    require( 'babel-regenerator-runtime' );
  }
  catch( err )
  {
  }

  try
  {
    require( 'babel-runtime' );
  }
  catch( err )
  {
  }

  require( './TerminalAbstract.s' );

  //

  var _ = _global_.wTools; // змінна, що необхідна для роботи модулів

}

```

</details>

##### Об'явлення глобальних змінних
Змінні, які потрібні для роботи файла об'являються в цій секції. Таким чином формується карта змінних файла.  

```js
// секція глобальних змінних
var x = some.value;
var y = some.value;

```

##### Конструктор функції
Конструктор об'являється тільки для класів, які повертають об'єкт. Конструктор поміщається в змінну 'Self' для позначення об'єкта з яким будуть працювати рутини класу.  

```js
// секція глобальних змінних і конструктор функції
var Self = function wNameFunction( argument )
{
  return constructor( arguments );
}

```

Приклад конструктора, який прийнято використовувати.

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```js
let Self = function wFileRecord( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'FileRecord';  

```

</details>

##### Секція рутин (функцій)
Після (або замість) конструктора йде секція рутин. В секцію поміщені функції модуля, які можуть виконувати операції як з об'єктами модуля, так і з зовнішніми викликами.

```js
// секція рутин (функцій)
function one(){
    // some code
}
function two(){
    // some code
}

```

Приклад рутини.

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```js
function question( question )
{
  var self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  return Parent.prototype.question.call( self,question );
}

```

</details>

Зверніть увагу, що посилання на рутини поміщені в змінну-об'єкт `Proto`.  

##### Композиція (будова) об'єкта
При створенні об'єкта класа необхідно передавати параметри. Параменри за замовчуванням поміщені в змінну `Composes`. За відсутністю параметрів об'явлення не обов'язкове. Змінна вказується в змінній `Proto`.

```js
// композицію об'єкта
var Composes =
{
    arg1 : value,
    arg2 : value,
}

```

Приклад змінної `Composes`.

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```js
let Composes =
{
  name : null,         
  description : null,
  version : null,
  enabled : 1,              // встановленен за замовчуванням значення, інші передаються
  interpreters : null,
  keywords : null,

}

```

</details>


##### Асоціаціативні зв'язки  
Змінна вказує на пов'язані модулі. Наприклад, код нижче показує, що асоціативними є модулі: `original` - початковий шлях, `path` - поточний шлях.

```js
var Associates =
{
  original : null,
  path : null,
}

```

#####

```js
//
var Aggregates =
{
}

```


//
let Medials =
{
}



##### Системні події
В змінну `Events` вносяться рутини з подіями модуля.
```js
//
var Events =
{
  event : routine,
  event : routine,
}

```
Приклад змінної `Composes`.

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```js
var Events =
{
  close : 'close',
  pause : 'pause',
  resume : 'resume',

  historyChange : 'historyChange',
  line : 'line',
}

```

</details>
