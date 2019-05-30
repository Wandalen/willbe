# Транспіляція

Використання вбудованого кроку <code>files.transpile</code> для транспіляції <code>JavaScript</code> файлів або їх конкатенації.

Транспіляція, це переклад вихідного коду з однієї мови на іншу. В утиліті `willbe` є можливість перетворювати вихідні `JavaScript` файли в стиснений і перетворений код. Для цього використовується вбудований крок `files.transpile`.  

### Структура модуля   

<details>
  <summary><u>Структура файлів</u></summary>

```
transpile
    ├── proto
    │     ├── -Excluded.js
    │     ├── File1.debug.js
    │     ├── File1.release.js
    │     ├── File2.debug.js
    │     ├── File2.release.js
    │     └── File.experiment.js
    └── .will.yml

```

</details>

Для дослідження кроку створіть приведену вище структуру файлів.

Внесіть в відповідні файли приведений код.

<details>
  <summary><u>Код файла <code>-Excluded.js</code></u></summary>

```js
console.log( '-Excluded.js' );

```

</details>

При запуску виводить повідомлення `-Excluded.js` в консоль операційної системи.

<details>
  <summary><u>Код файла <code>File1.debug.js</code></u></summary>

```js
function sum( a, b )
{
    return a + b;
}
console.log( 'File1.debug.js' );

```

</details>

Файл містить функцію додавання двох значень, а при запуску виводить повідомлення `File1.debug.js` в консоль.

<details>
  <summary><u>Код файла <code>File1.release.js</code></u></summary>

```js
function sum( a, b )
{
    return a + b;
}
console.log( 'File1.release.js' );

```

</details>

Файл містить функцію додавання двох значень, а при запуску виводить повідомлення `File1.release.js` в консоль.

<details>
  <summary><u>Код файла <code>File2.debug.js</code></u></summary>

```js
function sum( a, b )
{
    return a + b;
}
console.log( 'Sum of 2 and 3 is: ' + sum( 2, 3 ) );

```

</details>

Файл містить функцію `summ` для додавання двох значень. При запуску функція виводить повідомлення, котре генерується з використанням функції `sum`.

<details>
  <summary><u>Код файла <code>File2.release.js</code></u></summary>

```js
function sum( a, b )
{
    return a + b;
}
console.log( 'Sum of 3 and 7 is: ' + sum( 3, 7 ) );

```

</details>

Файл містить функцію `summ` для додавання двох значень. При запуску функція виводить повідомлення, котре генерується з використанням функції `sum`.

<details>
  <summary><u>Код файла <code>File1.experiment.js</code></u></summary>

```js
console.log( 'File2.experiment.js' );

```

</details>

При запуску файл виводить повідомлення в консоль.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : transpile
  description : "To transpile js-files"
  version : 0.0.1

path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug:
    path : './out/debug'
    criterion :
      debug : 1
  out.release:
    path : './out/release'
    criterion :
      debug : 0

reflector :

  transpile.proto :
    inherit : predefined.*
    step : files.transpile
    criterion :
      debug : [ 0, 1 ]
    filePath :
      path::proto : '{path::out.*=1}/Main.s'

build :

  transpile.proto :
    criterion :
      debug : [ 0,1 ]
    steps :
      - transpile.proto*=1

```

</details>

В `вілфайлі` відсутній крок `transpile.proto`, який вказано в збірці. Це пов'язано з тим, що утиліта вміє генерувати кроки для виклику рефлектора. Такий крок має назву рефлектора, по якому він згенерований, поміщається в оперативну пам'ять і не змінює `вілфайл`. В рефлекторі указується поле `step` з назвою вбудованого кроку - цей вбудований крок буде поміщено в щоб згенерований ресурс секції `step`. В рефлекторі `transpile.proto` указано поле `step : files.transpile`.  

<details>
  <summary><u>Вивід команди <code>will .steps.list</code></u></summary>

```
[user@user ~]$ will .steps.list
...
step::transpile.proto.
  criterion :
    debug : 0
  opts :
    reflector : reflector::transpile.proto*
  inherit :
    files.transpile

step::transpile.proto.debug
  criterion :
    debug : 1
  opts :
    reflector : reflector::transpile.proto*
  inherit :
    files.transpile

```

</details>

Перевірте наявні кроки в модулі (команда `will .steps.list` в директорії `вілфайла`). 

Кроки сформовані в оперативній пам'яті і не змінили вихідний `вілфайл`, кожен із згенерованих кроків наслідує вбудований `files.transpile`. Використання автоматичного створення кроків для рефлекторів зменшує об'єм `вілфайла`, збільшує швидкість написання, полегшує зчитування інформації.   

### Побудова модуля. Транспільовані файли

Для вбудованого кроку `files.transpile` в рефлекторі використовується особливий синтаксис для запису транспільованого файла: `'{path::out.*=1}/Main.s'` - в фігурних дужках вказується шлях призначення і через слеш назва файла, який буде створено. 

<details>
  <summary><u>Вивід команди <code>will .build transpile.proto.debug</code></u></summary>

```
[user@user ~]$ will .build transpile.proto.debug
...
  Building transpile.proto.debug
   # Transpiled 3 file(s) to /path_to_file/out/debug/Main.s in 0.120s
   # Compression factor : 295.0 b / 295.0 b / 100.0 b
  Built transpile.proto.debug in 3.296s

```
</details>

Проведіть дебаг-побудову модуля виконавши команду `will .build transpile.proto.debug`. Перевірте результати виконання.

<details>
  <summary><u>Файлова структура після дебаг-побудови</u></summary>

```
transpile
    ├── out
    │    └── debug
    │          └── Main.s
    ├── proto
    │     ├── -Excluded.js
    │     ├── File1.debug.js
    │     ├── File1.release.js
    │     ├── File2.debug.js
    │     ├── File2.release.js
    │     └── File.experiment.js
    └── .will.yml

```

</details>

Вивід свідчить, що утиліта створила файл `Main.s` в директорії `out/debug`. Файл `Main.s` створено з трьох вихідних файлів.

Відкрийте згенерований файл `Main.s` в директорії `./out/debug/` в текстовому редакторі та порівняйте з приведеним кодом. 

<details>
  <summary><u>Код в <code>Main.s</code> за шляхом <code>./out/debug/</code></u></summary>

```js
// ======================================
( function() {
console.log( 'File.experiment.js' );

})();
// ======================================
( function() {
function sum( a, b ){
    return a + b;
}
console.log( 'File1.debug.js' );

})();
// ======================================
( function() {
function sum( a, b ){
    return a + b;
}
console.log( 'Sum of 2 and 3 is: ' + sum( 2, 3 ) );

})();
```

</details>

В створеному файлі зконкатеновано три інших - `File.experiment.js`, `File1.debug.js`, `File2.debug.js`. Всі файли відібрано згідно [рефлектора `predefined.debug`](ReflectorPredefined.md). Код із кожного файла поміщається в окремій анонімній функції, функції відділені коментарем `//====`.

<details>
  <summary><u>Вивід команди <code>will .build transpile.proto.</code></u></summary>

```
[user@user ~]$ will .build transpile.proto.
...
  Building transpile.proto.
   # Transpiled 2 file(s) to /path_to_file/out/release/Main.s in 0.167s
   # Compression factor : 198.0 b / 107.0 b / 66.0 b
  Built transpile.proto. in 3.205s

```

</details>

Проведіть реліз-побудову модуля командою `will .build transpile.proto`. 

<details>
  <summary><u>Файлова структура після реліз-побудови</u></summary>

```
transpile
    ├── out
    │    ├── debug
    │    │     └── Main.s
    │    └── release
    │           └── Main.s
    ├── proto
    │     ├── -Excluded.js
    │     ├── File1.debug.js
    │     ├── File1.release.js
    │     ├── File2.debug.js
    │     ├── File2.release.js
    │     └── File.experiment.js
    └── .will.yml

```

</details>

На основі двох файлів утиліта згенерувала файл `Main.s` в директорії `out/release`.

Відкрийте згенерований файл `Main.s` в директорії `./out/release/` в текстовому редакторі та порівняйте з приведеним кодом. 


<details>
  <summary><u>Код в <code>Main.s</code> за шляхом <code>./out/release/</code></u></summary>

```js
// ======================================
console.log("File1.release.js"), console.log("Sum of 3 and 7 is: " + function sum(o, e) {
  return o + e;
}(3, 7));

```

</details>

В файлі `Main.s` присутній код з файлів `File1.release.js` i `File2.release.js`, котрі відібрані рефлектором `predefined.release`. Код в файлі `Main.s` маэ відмінності від початкових даних. В даному випадку, утиліта не включила визначення функції `sum` з файла `File1.release.js` в транспільований файл. Функція `sum` не використовується ні в одному з обраних файлів тому, вона є зайвою. Також,  утиліта змінила рядок `console.log("Sum of 3 and 7 is: " + sum(3, 7));` в файлі `File2.release.js` підставивши функцію: `console.log("Sum of 3 and 7 is: " + function sum(o, e) {  return o + e;}(3, 7));`. Це рішення пояснюється тим, що функція `sum` використовується один раз і її краще записати відразу в визначенні.  

Таким чином, утиліта використовує критеріон `debug` як тригер, що визначає форму побудови транспільованого файла. При значенні критеріона `debug : 1` утиліта проводить конкатенацію. Код із вибраних файлів в перетворюється в автопідключаємі функції об'єднані в одному `JavaScript`-файлі. Функції об'єднаного файлу відділені одна від одної коментарем `//=====`. При реліз-побудові, коли критеріон `debug` має значення `0`, код транспілюється. Тобто, код із вихідних файлів утворює рядок з оптимізованих функцій. 

### Конкатенація файлів

Додатково, можливістю конкатенації керує критеріон `raw`: 
- `raw : raw` або `raw : 1` - утиліта не виконує конкатенацію, а кладе кожен файл окремо в директорію призначення.
- `raw : compiled` або `raw : 0` - виконується конкатенація декількох файлів в один. Значення за замовчуванням.

<details>
  <summary><u>Код файла <code>.will.yml</code> з критеріоном <code>raw</code></u></summary>

```yaml
about :

  name : transpile
  description : "To use raw criterion"
  version : 0.0.1

path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug:
    path : './out/debug'
    criterion :
      debug : 1

reflector :

  transpile.proto :
    inherit : predefined.*
    step : files.transpile
    criterion :
      debug : 1
      raw : 1
    filePath :
      path::proto : '{path::out.*=1}/Main.s'

build :

  transpile.proto :
    criterion :
      default : 1
      debug : 1
      raw : 1
    steps :
      - transpile.proto*=1

```

</details>

Змініть `вілфайл` для виконання конкатенації з критеріоном `raw : 1`.

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build 
...
   Building module::transpile / build::transpile.proto
   # Transpiled 1 file(s) to /path_to_file/out/debug/Main.s/File.experiment.js in 0.267s
   # Compression factor : 37.0 b / 37.0 b / 55.0 b
   # Transpiled 1 file(s) to /path_to_file/out/debug/Main.s/File1.debug.js in 0.059s
   # Compression factor : 71.0 b / 71.0 b / 89.0 b
   # Transpiled 1 file(s) to /path_to_file/out/debug/Main.s/File2.debug.js in 0.061s
   # Compression factor : 88.0 b / 88.0 b / 102.0 b
  Built module::transpile / build::transpile.proto in 12.470s

```
</details>

 Виконайте побудову збірки за замовчуванням. Порівняйте вивід в консолі та перевірте структуру директорії `out` після виконання.

<details>
  <summary><u>Файлова структура після дебаг-побудови</u></summary>

```
transpile
    ├── out
    │    └── debug
    │         └── Main.s
    │               ├── File.experiment.js
    │               ├── File1.debug.js
    │               └── File2.debug.js
    ├── proto
    │     ├── -Excluded.js
    │     ├── File1.debug.js
    │     ├── File1.release.js
    │     ├── File2.debug.js
    │     ├── File2.release.js
    │     └── File.experiment.js
    └── .will.yml

```

</details>

Утиліта не здійснила конкатенацію JS-файлів в один, а скопіювала їх в директорію `Main.s`.

### Підсумок 

- Крок `files.transpile` в утиліті `willbe` - інструмент для перетворення `JavaScript`-файлів.  
- Перетворення проходить за двома сценаріями - конкатенації і транспіляції.
- Для вибору режиму перетворення використовуються критеріони `debug` і `raw`.
- Критеріон `raw` керує можливістю конкатенації. 
- Якщо критеріон `raw` не вказаний, або його значення `0`, то конкатенація можлива. При `raw : 1` утиліта не конкатенує код в єдиний файл, а кладе окремі файли в директорію призначення.
- Критеріон `debug` переключає режими перетворення між конкатенацією і транспіляцією.
- При значенні `debug : 1` виконується конкатенація, значення критеріона `raw` враховується.
- При значенні `debug : 0` виконується транспіляція.
- Транспільовані файли мають оптимізований результуючий код.  

[Повернутись до змісту](../README.md#tutorials)
