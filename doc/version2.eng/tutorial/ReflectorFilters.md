# Filters of reflector  

How to use filters of reflectors for selection of files for coping.

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

Відмінність від скороченої полягає в розділенні ресурсу на фільтр джерела файлів `src` та фільтру директорії призначення `dst`. Поле `filePath` внесено в ресурси полів `src` і `dst` відповідно.

### Початкова конфігурація модуля  
Створіть конфігурацію системи для дослідження фільтрів рефлектора:  

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

### Прості фільтри рефлектора  
Рефлектори мають декілька видів фільтрів, одним з яких є прості. Прості фільтри - це фільтри, які використовуються для сортування файлів за назвою та розширенням. До простих фільтрів відносяться:  
`begins` - включає в вибірку файли, назва яких починається з указаного в фільтрі слова.  
`ends` - включає в вибірку файли, назва яких закінчується на вказане в фільтрі слово.  
`hasExtension` - включає в вибірку файли з указаним розширенням. Розширення файла може бути складним і утиліта `willbe` зчитує його, починаючи з першої крапки в назві файла. Наприклад, файл `somefile.txt.md` має два розширення - `.txt` i `.md`.  
Фільтри рефлектора поміщаються в поля `src` і `dst`.  

##### Фільтр `begins`
Для вибору файлів, які починаються на `pac` та `file`, помістіть в `.will.yml` код:  

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

Запустіть реліз-побудову:  

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

Є розбіжність - знайдено три файла і один каталог в директорії `release`, а не п'ять файлів. Зверніть увагу, рефлектор утиліти `willbe` враховує директорію, де поміщаються файли, в даному випадку, директорію `release`. Також, при використанні фільтра `begins` рефлектор копіює внутрішню структуру в вибраних директоріях.   

##### Фільтр `ends`
Щоб використати відбір за закінченням назви файла змініть в рефлекторі фільтр `begins` на `ends`:  

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

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

Фільтр згідно опції `recursive` буде шукати всі файли, які закінчуються на `js`. При цьому, не важливо, чи це буде розширення, чи закінчення назви директорії `nodejs`.  
Запустіть побудову відладки та прогляньте зміни в директоріях `out/`:  

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

##### Фільтр `hasExtension`  
Фільтр `hasExtension` зчитує частини розширення файла починаючи від першої крапки в назві. Переважно, він використовується для файлів зі складними розширеннями, адже, розширення в середині файла вказує додаткові особливості. Наприклад, файл має назву `somefile.debug.js`, де перше розширення `.debug` вказує на статус файла - відладка. Тоді, файл в реліз-модулі може мати розширення `.release`.  
В директорії `proto` є файл `build.txt.js`. Створіть вибірку елементів з розширеннями `.txt` i `.two` - змініть фільтр `ends` на `hasExtension` згідно приведеного коду:  

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

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

Очистіть директорію `out` (`rm -Rf out/`) та запустіть збірку відладки, перевірте вміст в директорії `out/debug`:  

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

### Маски рефлектора
Маски рефлектора - фільтрування файлових операцій за місцем виконання.  
Утиліта `willbe` здатна фільтрувати операції в консолі операційної системи (поле `maskTerminal`), в директоріях (поле `maskDirectory`) та одночасно в консолі і директоріях (поле `maskAll`).  
Кожне з зазначених полів вибірково включає ресурси:   
`includeAny` - включити в вибірку будь-який елемент з вказаним параметром;  
`includeAll` - включити в вибірку всі знайдені елементи з вказаним параметром;  
`excludeAny` - виключити з вибірки будь-який елемент з вказаним параметром;  
`excludeAll` - виключити з вибірки всі елементи з вказаним параметром.  
Правила для вибірки формуються з застосуванням регулярних виразів JavaScript - перед регулярним виразом в фільтрі маски вказується фраза `!!js/regexp`.    
Якщо потрібно включити всі файли з розширенням `.js` та виключити документи з розширенням `.md`, то потрібно додати маску в поле `src`. Внесіть в `.will.yml` код:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

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

Видаліть директорію `out` (`rm -Rf out/`). Запустіть реліз-побудову, та перевірте структуру файлів:  

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

### Підсумок
- При повній формі запису рефлектора, фільтри вносяться в поля `src` і `dst`.   
- Прості фільтри вибирають файли за початком назви файла, закінченням назви і розширенням.   
- Маски рефлектора фільтрують операції на рівні файлової і операційної системи.    
- Маски рефлектора використовують регулярні вирази JavaScript.  

[Повернутись до змісту](../README.md#tutorials)
