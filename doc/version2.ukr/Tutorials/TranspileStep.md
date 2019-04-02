# Транспіляція файлів

Використання кроку `predefined.transpile` для трансформації JavaScript-файлів  

Транспіляція, це переклад вихідного коду з однієї мови на іншу. В утиліті `willbe` є можливість перетворювати вихідні JavaScript файли в стиснений і перетворений код. Для цього використовується вбудований крок `predefined.transpile`.  

### Структура модуля  
Побудуйте структуру та внесіть в файли код:  

<details>
  <summary><u>Структура і код файлів</u></summary>
<p>Структура файлів</p>

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

<p>Код <code>-Excluded.js</code></p>

```yaml
console.log( '-Excluded.js' );

```

<p>Код <code>File1.debug.js</code></p>

```yaml
console.log( 'File1.debug.js' );

```

<p>Код <code>File1.release.js</code></p>

```yaml
console.log( 'File1.release.js' );

```

<p>Код <code>File1.debug.js</code></p>

```yaml
console.log( 'File2.debug.js' );

```

<p>Код <code>File1.release.js</code></p>

```yaml
console.log( 'File2.release.js' );

```

<p>Код <code>File1.experiment.js</code></p>

```yaml
console.log( 'File2.experiment.js' );

```

</details>

В файл `.will.yml` помістіть код для транспіляції файлів:  

<details>
  <summary><u>Повний код файла <code>.will.yml</code></u></summary>

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

В `will-файлі` відсутній крок `transpile.proto`, який вказано в збірці. Справа в тому, що для вбудованих кроків, яким необхідний рефлектор можна неявно його створити, указавши поле `step` з назвою вбудованого кроку. В рефлекторі `transpile.proto` указано поле `step : predefined.transpile`. Перевірте вивід команди `.steps.list` (в директорії `will-файла`):  

<details>
  <summary><u>Вивід фрази <code>will .steps.list</code></u></summary>

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

Кроки сформовані в оперативній пам'яті і не змінили вихідний `will-файл`. Використання автоматичного створення кроків для рефлекторів зменшує об'єм, збільшує швидкість написання, полегшує зчитування інформації з `will-файла`.   

### Побудова модуля. Транспільовані файли
Для вбудованого кроку `predefined.transpile` в рефлекторі використовується особливий синтаксис для запису транспільованого файла: `path::proto : '{path::out.*=1}/Main.s'` - використовуються фігурні дужки для запису шляху призначення і через слеш вказується назва файла який буде створено - `'{path::out.*=1}/Main.s'`
Проведіть дебаг і реліз-побудови:  

<details>
  <summary><u>Реліз і дебаг-побудови</u></summary>
<p>Вивід фрази <code>will .build transpile.proto.</code></p>
    
```
[user@user ~]$ will .build transpile.proto.
...
  Building transpile.proto.
   # Transpiled 2 file(s) to /path_to_file/out/release/Main.s in 0.167s
   # Compression factor : 198.0 b / 107.0 b / 66.0 b
  Built transpile.proto. in 3.205s
      
```

<p>Структура файлів після реліз-побудови</p>

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

<p>Вивід фрази <code>will .build transpile.proto.debug</code></p>

```
[user@user ~]$ will .build transpile.proto.debug
...
  Building transpile.proto.debug
   # Transpiled 3 file(s) to /path_to_file/out/debug/Main.s in 0.120s
   # Compression factor : 295.0 b / 295.0 b / 100.0 b
  Built transpile.proto.debug in 3.296s
      
```

<p>Структура файлів після дебаг-побудови</p>

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
  <summary><u>Код в <code>Main.s</code></u></summary>
<p><code>Main.s</code> в <code>./out/debug/</code></p>
    
```js
// ======================================
( function() {
console.log( 'File.experiment.js' );

})();
// ======================================
( function() {
console.log( 'File1.debug.js' );

})();
// ======================================
( function() {
console.log( 'File2.debug.js' );

})();

```    
    
<p><code>Main.s</code> в <code>./out/debug/</code></p>

```js
// ======================================
console.log("File1.release.js"), console.log("File2.release.js");

``` 

</details>

Утиліта використовує критеріон `debug` як тригер, що визначає форму побудови транспільованого файла. При значенні критеріона `debug : 1`, утиліта формує файл із автопідключаємих функцій, що відділені коментарем `//=====`, де в окремих функціях поміщено код із файлів. При реліз-побудові (`debug : 0`) - код із вихідних файлів утворює рядок.

### Підсумок  
- Транспіляція в утиліті `willbe` - інструмент для перетворення групи JavaScript-файлів в єдиний модуль.  
- Транспіляція проходить за двома сценаріями - відладки і релізу.

[Повернутись до змісту](../README.md#tutorials)