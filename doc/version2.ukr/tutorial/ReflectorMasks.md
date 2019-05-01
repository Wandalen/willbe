# Маски рефлектора

Використання масок рефлектора для відбору файлів для копіювання. 

Якщо розробнику потрібно фільтрувати файли по їх виду, то використовуються маски рефлектора.

В утиліті `willbe` рефлектори використовують три групи масок:
- `maskDirectory` - маски директорії, застосовуються лише до директорій;  
- `maskTerminal` - маски термінальних (звичайних) файлів, застосовуються лише до термінальних файлів;
- `maskAll` - маски, які застосовуються до всіх типів файлів.

В кожній із цих трьох груп масок є такі:  
`includeAny` - включити в вибірку будь-який елемент з вказаним параметром;  
`includeAll` - включити в вибірку всі знайдені елементи з вказаним параметром;  
`excludeAny` - виключити з вибірки будь-який елемент з вказаним параметром;  
`excludeAll` - виключити з вибірки всі елементи з вказаним параметром.  

В значеннях масок використовуються регулярні вирази JavaScript. Перед регулярним виразом в масці вказується фраза `!!js/regexp`.    

### Початкова конфігурація   

<details>
  <summary><u>Структура файлів</u></summary>

```
fileFilters
     ├── proto
     │     ├── proto.two
     │     │     └── script.js
     │     ├── files
     │     │     ├── manual.md
     │     │     └── tutorial.md
     │     ├── build.txt.js
     │     └── package.json   
     └── .will.yml       

```

</details>

Створіть приведену конфігурацію файлів для дослідження масок рефлектора. 

<details>
  <summary><u>Код файла <code>.will.yml</code> з масками файлових операцій</u></summary>

```yaml
about :
  name : maskFilter
  description : "To use reflector mask"
  version : 0.0.1

path :

  in : '.'
  out : 'out'
  proto : './proto'
  out.debug :
    path : './out/debug'
    criterion :
      debug : 1
  out.release :
    path : './out/release'
    criterion :
      debug : 0

reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
      maskAll:
        includeAll:
           - !!js/regexp '/\.js$/'
    dst:
       filePath: path::out.*=1
    criterion:
      debug: 0
      
  reflect.copy.debug :
    recursive: 2
    src:
      filePath: ./proto
      maskAll:
        excludeAll:
           - !!js/regexp '/\.md$/'
    dst:
       filePath: path::out.*=1
    criterion:
      debug: 1

step :

  reflect.copy :
    inherit : predefined.reflect
    reflector : reflect.*
    criterion :
       debug : [ 0,1 ]

build :

  copy :
    criterion :
      debug : [ 0,1 ]
    steps :
      - reflect.*

```

</details>

Внесіть в `.will.yml` код, що приведений вище.    

В `вілфайлі` [за розгортанням критеріонів](WillFileMinimization.md) збірка `copy` може виконати дві побудови. Перша, з критеріоном `debug : 0`, використовує рефлектор `reflect.copy.` для включення всіх файлів з розширенням `.js`. Друга, з критеріоном `debug : 1`, використовує рефлектор `reflect.copy.debug` для виключення всіх файлів з розширенням `.md`

### Копіювання файлів з маскою рефлектора

<details>
  <summary><u>Вивід команди <code>will .build copy.</code></u></summary>

```
[user@user ~]$ will .build copy.
...
 Building copy.
   + reflect.copy. reflected 4 files /path_to_file/ : out/release <- proto in 0.390s
  Built copy. in 0.440s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileFilters
     ├── proto
     │     ├── proto.two
     │     │     └── script.js
     │     ├── files
     │     │     ├── manual.md
     │     │     └── tutorial.md
     │     ├── build.txt.js
     │     └── package.json  
     ├── out
     │     ├── debug
     │     │     ├── proto.two
     │     │     │     └── script.js
     │     │     ├── files
     │     │     ├── build.txt.js
     │     │     └── package.json  
     │     └── release
     │            ├── proto.two
     │            │     └── script.js
     │            └── build.txt.js  
     └── .will.yml       

```

</details>

Запустіть реліз-побудову командою `will .build copy.`. Після виконання запустіть побудову відладки командою `will .build copy.debug`.  Перевірте структуру файлів в директорії `out`.

Після побудови в директорії `out/debug` рефлектор скопіював всі файли розширення яких відрізняється від `.md`. Директорія `files`, яка містила файли `manual.md` i `tutorial.md` також скопійовано. А в директорію `out/release` було поміщено всі файли, які мають розширення `.js`. Рефлектор скопіював файли відповідно до оригінальної структури тому файл `script.js` поміщений в директорію `proto.two`.

### Підсумок

- Маски рефлектора фільтрують файли за їх видом.
- Маски рефлектора можуть фільтрувати термінальні файли, директорії, а також, одночасно термінальні файли і директорії.
- Маски рефлектора використовують регулярні вирази JavaScript для здійснення відбору файлів.

[Повернутись до змісту](../README.md#tutorials)
