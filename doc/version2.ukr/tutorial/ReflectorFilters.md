# Фільтри рефлектора

Використання фільтрів рефлектора для відбору файлів для копіювання.

### Повна форма запису рефлектора  

При використанні в рефлекторі поля `filePath`, вибір елементів здійснюється за іменем файлів. Якщо потрібно внести інші фільтри, то необхідно записати повну форму рефлектора.  

Прогляньте рефлектор копіювання файлів з повною формою запису:

<details>
    <summary><u>Рефлектор з повною формою запису</u></summary>

```yaml
  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

```

</details>

Відмінність від скороченої полягає в розділенні ресурсу на фільтр джерела файлів `src` та фільтр директорії призначення `dst`. Поле `filePath` внесено в ресурси полів `src` і `dst` відповідно.

### Початкова конфігурація модуля   

<details>
  <summary><u>Структура модуля</u></summary>

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

Створіть конфігурацію системи для дослідження фільтрів рефлектора.  

### Прості фільтри рефлектора  

Рефлектори мають декілька видів фільтрів, одним з яких є прості. Прості фільтри - це фільтри, які використовуються для сортування файлів за назвою та розширенням.  

До простих фільтрів відносяться:  
`begins` - виключає з вибірки файли, назва яких не починається з указаного в фільтрі слова.  
`ends` - виключає з вибірки файли, назва яких не закінчується на вказане в фільтрі слово.  
`hasExtension` - виключає з вибірки файли, які не мають вказаного розширення. Розширення файла може бути складним і утиліта `willbe` зчитує його, починаючи з першої крапки в назві файла. Наприклад, файл `somefile.txt.md` має два розширення - `.txt` i `.md`.  

##### Фільтр `begins`

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml

about :
  name : filters
  description : "To use reflector filter"
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
      begins:
        - 'pac'
        - 'file'
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

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

Для вибору файлів, які починаються на `pac` та `file`, помістіть в файл `.will.yml` приведений вище код. 

<details>
  <summary><u>Вивід команди <code>will .build copy.</code></u></summary>

```
[user@user ~]$ will .build copy.
...
 Building copy.
   + reflect.copy. reflected 5 files /path_to_file/ : out/release <- proto in 0.416s
  Built copy. in 0.463s

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
     │     └── release
     │            ├── files
     │            │     ├── manual.md
     │            │     └── tutorial.md
     │            └── package.json  
     └── .will.yml       

```

</details>

Запустіть реліз-побудову (`will .build.copy`).

Є розбіжність - знайдено три файла і один каталог в директорії `release`, а не п'ять файлів. Тобто, рефлектор враховує директорію `release`, в яку поміщаються файли, як додатковий файл. Також, рефлектор копіює фільтр внутрішню структуру скопійованих директорій (файлів). Тому, в директорії `files` поміщено файли `manual.md` i `tutorial.md`.  

##### Фільтр `ends`

Щоб використати відбір за закінченням назви файла змініть фільтр `begins` на `ends`.    

<details>
  <summary><u>Секція <code>reflector</code> з фільтром <code>ends</code></u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
      ends: 'js'
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

```

</details>

Змініть секцію `reflector` в `will-файлі` як в приведеному прикладі. 

Фільтр, згідно опції `recursive`, буде шукати всі файли, які закінчуються на `js`. При цьому, не важливо, чи це буде розширення, чи закінчення назви директорії `nodejs`.   

<details>
  <summary><u>Вивід команди <code> will .build copy.debug</code></u></summary>

```
[user@user ~]$ will .build copy.debug
...
 Building copy.debug
   + reflect.copy. reflected 4 files /path_to_file/ : out/debug <- proto in 0.316s
  Built copy. in 0.463s

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
     │     ├── release
     │     └── debug
     │           ├── build.txt.js
     │           └── proto.two
     │                   └── script.js
     └── .will.yml       

```

</details>

Запустіть побудову відладки та прогляньте зміни в директоріях `out/`.

##### Фільтр `hasExtension`  

Фільтр `hasExtension` переважно використовується для файлів зі складними розширеннями. Адже, складне розширення вказує додаткові особливості. Наприклад, файл має назву `somefile.debug.js`, де перше розширення `.debug` вказує на призначення файла - відладка. Тоді, файл для реліз-модуля може мати розширення `.release.js`.  

<details>
  <summary><u>Секція <code>reflector</code> з фільтром <code>hasExtension</code></u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
      hasExtension:
         - 'txt'
         - 'two'
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

```

</details>

В директорії `proto` є файл `build.txt.js`. Для вибору файлів з розширеннями `.txt` i `.two` змініть фільтр `ends` на `hasExtension` згідно приведеного вище коду.   

<details>
  <summary><u>Вивід команди <code>will .build copy.debug</code></u></summary>

```
[user@user ~]$ will .build copy.debug
...
 Building copy.
   + reflect.copy. reflected 4 files /path_to_file/ : out/release <- proto in 0.342s
  Built copy. in 0.384s

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
     │     └── debug
     │           ├── build.txt.js
     │           └── proto.two
     │                   └── script.js 
     └── .will.yml       

```

</details>

Очистіть директорію `out` (`rm -Rf out/`) та запустіть збірку відладки, перевірте вміст в директорії `out/debug`.

### Маски рефлектора

Рефлектори `willbe` має три групи масок, в залежності від того до яких типів файлів вони застосовуються:
- `maskDirectory` - маски директорії, застосовуються лише до директорій;  
- `maskTerminal` - маски термінальних файлів, застосовуються лише до термінальних (звичайних) файлів, до директорій не застосовуються;
- `maskAll` - маски, які застосовуються до всіх типів файлів.

В кожній із цих трьох груп масок є такі:  
`includeAny` - включити в вибірку будь-який елемент з вказаним параметром;  
`includeAll` - включити в вибірку всі знайдені елементи з вказаним параметром;  
`excludeAny` - виключити з вибірки будь-який елемент з вказаним параметром;  
`excludeAll` - виключити з вибірки всі елементи з вказаним параметром.  

В значеннях масок використовуються регулярні вирази JavaScript. Перед регулярним виразом в масці вказується фраза `!!js/regexp`.    

<details>
  <summary><u>Код файла <code>.will.yml</code> з масками файлових операцій</u></summary>

```yaml
about :
  name : maskFilter
  description : "To use reflector filter"
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
        excludeAll:
           - !!js/regexp '/\.md$/'
        includeAll:
           - !!js/regexp '/\.js$/'
    dst:
       filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

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

Якщо потрібно включити всі файли з розширенням `.js` та виключити документи з розширенням `.md`, то можна використати маски. Внесіть в `.will.yml` код, що приведений вище.    

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
     │     └── release
     │            ├── proto.two
     │            │     └── script.js
     │            └── build.txt.js  
     └── .will.yml       

```

</details>

Видаліть директорію `out` (`rm -Rf out/`). Запустіть реліз-побудову, та перевірте структуру файлів.

### Підсумок

- Фільтри вносяться в поля `src` і `dst`.   
- Прості фільтри вибирають файли за початком назви файла, закінченням назви і розширенням.   
- Маски фільтрують файлові операції над директоріями і термінальними (звичайними) файлами.    
- В масках файлових операцій рефлектора використовують регулярні вирази JavaScript.  

[Повернутись до змісту](../README.md#tutorials)
