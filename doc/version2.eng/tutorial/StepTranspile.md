# Transpilation

How to use predefined step <code>predefined.transpile</code> to transpile <code>JavaScript</code> files or concatenate them.  

Транспіляція, це переклад вихідного коду з однієї мови на іншу. В утиліті `willbe` є можливість перетворювати вихідні JavaScript файли в стиснений і перетворений код. Для цього використовується вбудований крок `predefined.transpile`.  

### Структура модуля  

Побудуйте структуру та внесіть в файли код:  

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
    step : predefined.transpile
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

В `will-файлі` відсутній крок `transpile.proto`, який вказано в збірці - утиліта генерує вбудовані кроки, яким необхідний рефлектор в оперативну пам'ять. Для цього в рефлекторі указується поле `step` з назвою вбудованого кроку. В рефлекторі `transpile.proto` указано поле `step : predefined.transpile`, відповідно, рефлектор здійснює відбір файлів для транспіляції. Перевірте вивід команди `.steps.list` (в директорії `will-файла`):  

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
    predefined.transpile

step::transpile.proto.debug
  criterion :
    debug : 1
  opts :
    reflector : reflector::transpile.proto*
  inherit :
    predefined.transpile

```

</details>

Кроки сформовані в оперативній пам'яті і не змінили вихідний `will-файл`. Використання автоматичного створення кроків для рефлекторів зменшує об'єм `will-файла`, збільшує швидкість написання, полегшує зчитування інформації.   

### Побудова модуля. Транспільовані файли
Для вбудованого кроку `predefined.transpile` в рефлекторі використовується особливий синтаксис для запису транспільованого файла: `'{path::out.*=1}/Main.s'` - в фігурних дужках вказується шлях призначення і через слеш назва файла, який буде створено.
Проведіть дебаг і реліз-побудови:  

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
  <summary><u>Структура файлів після реліз-побудови</u></summary>

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
  <summary><u>Структура файлів після дебаг-побудови</u></summary>

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

Вивід фраз включає інформацію про кількість файлів з яких побудовано транспільований файл та його розташування, а також, коефіцієнт компресії `# Compression factor`.
Відкрийте файли `Main.s` з директорій `./out/debug/` i `./out/release/` в текстовому редакторі та порівняйте:  

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

Утиліта використовує критеріон `debug` як тригер, що визначає форму побудови транспільованого файла. При значенні критеріона `debug : 1`, утиліта формує JavaScript-файл із автопідключаємих функцій, що відділені коментарем `//=====`, де в окремих функціях поміщено код із файлів. При реліз-побудові (`debug : 0`) - код із вихідних файлів утворює рядок з оптимізованих функцій. В даному випадку, утиліта не включила визначення функції `sum` з файла `File1.release.js`  - функція не використовується, а в файлі `File2.release.js` замінила аргумент `sum(3, 7)` на функцію: `function sum(o, e) {  return o + e;}(3, 7)`, оскільки, остання використовується один раз.  

### Підсумок  
- Транспіляція в утиліті `willbe` - інструмент для перетворення JavaScript-файлів в єдиний модуль.  
- Транспіляція проходить за двома сценаріями - відладки і релізу.  
- При транспіляції за реліз-побудовою утиліта `willbe` оптимізує результуючий код.  

[Повернутись до змісту](../README.md#tutorials)
