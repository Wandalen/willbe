# Time filters of reflector  

How to use filters to select files by age.

### Фільтри по часу (часові фільтри)  
Крім [масок](ReflectorFilters.md#Маски-рефлектора) та [простих фільтрів](ReflectorFilters.md#Прості-фільтри-рефлектора) рефлектори здатні фільтрувати файли по часу створення (модифікації). Для цього рефлектори використовують спеціальні поля: `notOlder`, `notNewer`, `notOlderAge`, `notNewerAge`:  
`notOlder` - всі файли не старше на момент вибірки;  
`notNewer` - всі файли не новіше на момент вибірки;  
`notOlderAge` - вік окремих файлів, не старший від встановленого на час проведення процедури;  
`notNewerAge` - вік окремих файлів, не менше від встановленого на час проведення процедури.  
В параметрах полів `notOlder`, `notNewer`, `notOlderAge` і `notNewerAge` вказуються значення в мілісекундах (1 с = 1000 мс). Рисунок іллюструє як працюють фільтри. Порівнюється вік файла з встановленим обмеженням.  

![time.filter](./Images/time.filter.png)  

Часові фільтри можна комбінувати між собою, щоб задати діапазон вибірки, а також можна комбінувати з іншими. Єдиною умовою є виключення конфліктів між фільтрами.  

### Використання часових фільтрів  
Створіть наступну структуру файлів для дослідження часових фільтрів:  

<details>
  <summary><u>Структура модуля</u></summary>

```
timeFilters
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

Якщо діапазон для вибірки файлів буде не менше однієї хвилини і не більше 10 діб, то в секундах: `1 хв = 60 с`; `10 діб = 10 * 24 * 60 * 60 с = 864000 с`.  
Скопіюйте код в файл `.will.yml`:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : timeFilter
  description : "To use reflector time filters"
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
      notNewerAge : 60000
      notOlderAge : 864000000
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


Запустіть побудову збірки відладки `will .build copy.debug`:  

<details>
  <summary><u>Вивід команди <code> will .build copy.debug</code></u></summary>

```
[user@user ~]$ will .build copy.debug
...
  Building copy.debug
   + reflect.copy.debug reflected 8 files /path_to_file/ : out/debug <- proto in 0.390s
  Built copy.debug in 0.432s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
timeFilters
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
     │           ├── proto.two
     │           │     └── script.js
     │           ├── files
     │           │     ├── manual.md
     │           │     └── tutorial.md
     │           ├── build.txt.js
     │           └── package.json    
     └── .will.yml       

```

</details>

Всі файли скопійовано. Змініть діапазон в `notNewerAge` з 60000 до 80000000, щоб виключити можливість копіювання файлів створених для випробування. Запустіть реліз-побудову:  

<details>
  <summary><u>Вивід команди <code> will .build copy.</code></u></summary>

```
[user@user ~]$ will .build copy.
...
  Building copy.
   + reflect.copy. reflected 3 files /path_to_file/ : out/release <- proto in 0.311s
  Built copy. in 0.358s

```

</details>

Скопійовано три файла, перевірте вміст директорії `out/release`:  

<details>
  <summary><u>Вивід команди <code>ls -a out/release/</code></u></summary>

```
[user@user ~]$ ls -a out/release/
.  ..  files  proto.two

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
timeFilters
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
     │     │     │     ├── manual.md
     │     │     │     └── tutorial.md
     │     │     ├── build.txt.js
     │     │     └── package.json 
     │     └── release
     │           ├── proto.two
     │           └── files
     └── .will.yml       

```

</details>

Тобто, скопіювано директорії без файлів.  
Випробуйте часовий фільтр `notOlder` з новим діапазоном - не менше 1 хвилини.  
Відповідно, змініть рефлектор:  

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
      notOlder : 60000
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

```

</details>

Видаліть директорію `out` та запустіть побудову відладки:  

<details>
  <summary><u>Вивід команди <code>will .build copy.debug</code></u></summary>

```
[user@user ~]$ will .build copy.debug
...
  Building copy.debug
   + reflect.copy. reflected 8 files /path_to_file/ : out/debug <- proto in 0.311s
  Built copy. in 0.358s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
timeFilters
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
     │           ├── proto.two
     │           │     └── script.js
     │           ├── files
     │           │     ├── manual.md
     │           │     └── tutorial.md
     │           ├── build.txt.js
     │           └── package.json    
     └── .will.yml       

```

</details>

На момент побудови вік всіх файлів більше однієї хвилини, тому скопійовано всю структуру.

### Підсумок
- Часові фільтри рефлектора формують діапазони вибірки файлів за часом створення (модифікації).  
- Часові фільтри комбінуються з іншими фільтрами рефлектора.  
- Фільтри `notOlder` і `notNewer` здійснюють операцію, якщо всі файли входять в діапазон вибірки, а фільтри `notOlderAge` і `notNewerAge` здійснюють відбір відносно кожного файла.  

[Повернутись до змісту](../README.md#tutorials)
