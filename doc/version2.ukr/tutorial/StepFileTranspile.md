# Транспіляція

Використання вбудованого кроку <code>files.transpile</code> для транспіляції <code>JavaScript</code> файлів або їх конкатенації.

Транспіляція, це переклад вихідного коду з однієї мови на іншу. В утиліті `willbe` є можливість перетворювати вихідні JavaScript файли в стиснений і перетворений код. Для цього використовується вбудований крок `files.transpile`.  

### Структура модуля  

Побудуйте структуру та внесіть в файли код:  

<details>
  <summary><u>Файлова структура</u></summary>

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
<details>
  <summary><u>Код файла <code>-Excluded.js</code></u></summary>

```js
console.log( '-Excluded.js' );

```

</details>
<details>
  <summary><u>Код файла <code>File1.debug.js</code></u></summary>

```js
function sum(a, b){
    return a+b;
}
console.log( 'File1.debug.js' );

```

</details>
<details>
  <summary><u>Код файла <code>File1.release.js</code></u></summary>

```js
function sum(a, b){
    return a+b;
}
console.log( 'File1.release.js' );

```

</details>
<details>
  <summary><u>Код файла <code>File2.debug.js</code></u></summary>

```js
function sum(a, b){
    return a+b;
}
console.log( 'Sum of 2 and 3 is: ' + sum(2, 3) );

```

</details>
<details>
  <summary><u>Код файла <code>File2.release.js</code></u></summary>

```js
function sum(a, b){
    return a+b;
}
console.log( 'Sum of 3 and 7 is: ' + sum(3, 7) );

```

</details>
<details>
  <summary><u>Код файла <code>File1.experiment.js</code></u></summary>

```js
console.log( 'File2.experiment.js' );

```

</details>
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

В `вілфайлі` відсутній крок `transpile.proto`, який вказано в збірці. Це пов'язано з тим, що утиліта вміє генерувати кроки для виклику рефлектора. Такий крок має назву рефлектора, по якому він знерований, поміщається в оперативну пам'ять і не змінює `вілфайл`. Для цього, щоб згенерований ресурс обирав потрібний вбудований крок в рефлекторі указується поле `step` з назвою відповідного вбудованого кроку. В рефлекторі `transpile.proto` указано поле `step : files.transpile`.  

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

Кроки сформовані в оперативній пам'яті і не змінили вихідний `вілфайл`. Використання автоматичного створення кроків для рефлекторів зменшує об'єм `вілфайла`, збільшує швидкість написання, полегшує зчитування інформації.   

### Побудова модуля. Транспільовані файли

Для вбудованого кроку `files.transpile` в рефлекторі використовується особливий синтаксис для запису транспільованого файла: `'{path::out.*=1}/Main.s'` - в фігурних дужках вказується шлях призначення і через слеш назва файла, який буде створено. 

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
<details>
  <summary><u>Файлова структура після реліз-побудови</u></summary>

```
transpile
    ├── out
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
<details>
  <summary><u>Файлова структура після дебаг-побудови</u></summary>

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

Проведіть дебаг і реліз-побудови модуля. Перевірте результати виконання.

Вивід фраз включає інформацію про кількість файлів з яких побудовано транспільований файл та його розташування, а також, коефіцієнт компресії `# Compression factor`. 

<details>
  <summary><u>Код в <code>Main.s</code> за шляхом <code>./out/debug/</code></u></summary>

```js
// ======================================
( function() {
console.log( 'File.experiment.js' );

})();
// ======================================
( function() {
function sum(a, b){
    return a+b;
}
console.log( 'File1.debug.js' );

})();
// ======================================
( function() {
function sum(a, b){
    return a+b;
}
console.log( 'Sum of 2 and 3 is: ' + sum(2, 3) );

})();
```

</details>
<details>
  <summary><u>Код в <code>Main.s</code> за шляхом <code>./out/release/</code></u></summary>

```js
// ======================================
console.log("File1.release.js"), console.log("Sum of 3 and 7 is: " + function sum(o, e) {
  return o + e;
}(3, 7));

```

</details>

Відкрийте згенеровані файли `Main.s` в директоріях `./out/debug/` i `./out/release/` в текстовому редакторі та порівняйте з приведеним вище кодом. 

Утиліта використовує критеріон `debug` як тригер, що визначає форму побудови транспільованого файла. При значенні критеріона `debug : 1` утиліта проводить конкатенацію. Код із вибраних файлів в перетворюється в автопідключаємі функції об'єднані в одному JavaScript-файлі. Функції об'єднаного файлу відділені одна від одної коментарем `//=====`.  
В приведеній побудові було обрано три файли і, відповідно, утворено три автопідключаємі функції. 

При реліз-побудові, коли критеріон `debug` має значення `0`, код транспілюється. Тобто, код із вихідних файлів утворює рядок з оптимізованих функцій.  
В даному випадку, утиліта не включила визначення функції `sum` з файла `File1.release.js` в транспільований файл. Функція `sum` не використовується ні в одному з обраних файлів тому, вона є зайвою. Також,  утиліта вигляд рядка `console.log("Sum of 3 and 7 is: " + sum(3, 7));` в файлі `File2.release.js` підставивши функцію: `console.log("Sum of 3 and 7 is: " + function sum(o, e) {  return o + e;}(3, 7));`. Це рішення пояснюється тим, що функція `sum` використовується один раз і краще її записати відразу.  

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

Змініть `вілфайл` для виконання конкатенації з критеріоном `raw : 1`. Виконайте побудову та перевірте структуру директорії `out`.

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

Таким чином, рефлектор не об'єднав JS файли в один, а скопіював їх в директорію `Main.s`.

### Підсумок 

- Крок `files.transpile` в утиліті `willbe` - інструмент для перетворення JavaScript-файлів.  
- Перетворення проходить за двома сценаріями - конкатенації і транспіляції.
- Для вибору режиму перетворення використовуються критеріони `debug` і `raw`.
- Критеріон `raw` керує можливістю конкатенації. 
- Якщо критеріон `raw` не вказаний, або його значення `0`, то конкатенація можлива. При `raw : 1` утиліта не конкатенує код в єдиний файл, а кладе окремі файли в директорію призначення.
- Критеріон `debug` переключає режими перетворення між конкатенацією і транспіляцією.
- При значенні `debug : 1` виконується конкатенація, значення критеріона `raw` враховується.
- При значенні `debug : 0` виконується транспіляція.
- Транспільовані файли мають оптимізований результуючий код.  

[Повернутись до змісту](../README.md#tutorials)
