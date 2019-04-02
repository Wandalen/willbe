# Транспіляція файлів

Використання кроку `predefined.transpile` для трансформації JavaScript файлів  

Транспіляція, це переклад вихідного коду з однієї мови на іншу. В утиліті `willbe` є можливість перетворювати вихідні JavaScript файли в стиснений і перетворений код. Для цього використовується вбудований крок `predefined.transpile`.  

### Структура модуля  
Побудуйте структуру та внесіть в файли код:  

<details>
  <summary><u>Структура і код файлів</u></summary>
<p>Структура файлів</p>

```
.
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

  transpile :
    criterion :
      debug : [ 0,1 ]
    steps :
      - transpile.proto*=1
      
```

</details>