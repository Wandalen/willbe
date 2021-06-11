# Маски рефлектора

Використання масок рефлектора для відбору файлів для копіювання.

Для фільтрування файлів по виду використовуються маски рефлектора. В утиліті `willbe` рефлектори використовують три групи масок:
- `maskDirectory` - маски директорії, застосовуються лише до директорій;
- `maskTerminal` - маски термінальних (звичайних) файлів, застосовуються лише до термінальних файлів;
- `maskAll` - маски, які застосовуються до всіх типів файлів.

В кожній із цих трьох груп масок є такі фільтри:
- `includeAny` - виключити файли, які не мають співпадіння із жодним із регулярних виразів даного фільтра;
- `includeAll` - виключити файли, які не мають співпадіння із всіма регулярними виразами даного фільтра;
- `excludeAny` - виключити файли, які мають принаймні одне співпадіння із регулярними виразами даного фільтра;
- `excludeAll` - виключити файли, які мають співпадіння із всіма регулярними виразами даного фільтра.

В значеннях масок використовуються регулярні вирази `JavaScript`. Перед регулярним виразом в масці вказується фраза `!!js/regexp`.

### Структура модуля

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
      maskTerminal:
        excludeAll:
           - !!js/regexp '/\.md$/'
    dst:
       filePath: path::out.*=1
    criterion:
      debug: 1

step :

  reflect.copy :
    inherit : files.reflect
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

В `вілфайлі` збірка `copy` використовує [розгортання критеріонів](WillFileMinimization.md). Тому, вона розділяється на дві збірки. Перша збірка з назвою `copy.` має критеріон `debug : 0` , вона використовує рефлектор `reflect.copy.` для виключення файлів, що не містять розширенням `.js`. Друга збірка - `copy.debug` з критеріоном `debug : 1`, використовує рефлектор `reflect.copy.debug` для виключення всіх термінальних файлів з розширенням `.md`.

### Копіювання файлів з маскою рефлектора

<details>
  <summary><u>Вивід команди <code>will .build copy.</code></u></summary>

```
[user@user ~]$ will .build copy.
...
 Building module::maskFilter / build::copy.
   + reflect.copy. reflected 4 files /path_to_file/ : out/release <- proto in 0.390s
  Built module::maskFilter / build::copy. in 0.440s

```

</details>

Запустіть реліз-побудову командою `will .build copy.`.

Утиліта скопіювала чотири файла. Це два файла з розширенням `.js`, а також директорії, в які ці файли поміщені - `proto.two` i `release`. Рефлектор скопіював файли відповідно до оригінальної структури, тому файл `script.js` поміщений в директорію `proto.two`.

<details>
  <summary><u>Вивід команди <code>will .build copy.debug</code></u></summary>

```
[user@user ~]$ will .build copy.debug
...
 Building module::maskFilter / build::copy.debug
   + reflect.copy.debug reflected 6 files /path_to_file/ : out/debug <- proto in 0.625s
  Built module::maskFilter / build::copy.debug in 0.701s

```

</details>

Виконайте побудову відладки командою `will .build copy.debug`. Порівняйте результати виводу команди з приведеними вище.

Після побудови перевірте структуру файлів в директорії `out`.

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

Після побудови в директорії `out/debug` рефлектор скопіював всі файли розширення яких відрізняється від `.md`. Директорію `files`, яка містила файли `manual.md` i `tutorial.md`, також скопійовано.

### Підсумок

- Маски рефлектора фільтрують файли за їх видом.
- Маски рефлектора можуть фільтрувати термінальні файли, директорії, а також, одночасно термінальні файли і директорії.
- Маски рефлектора використовують регулярні вирази `JavaScript` для здійснення відбору файлів.

[Повернутись до змісту](../README.md#tutorials)
