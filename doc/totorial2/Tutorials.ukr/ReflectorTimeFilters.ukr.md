# Часові фільтри рефлектора  

В туторіалі показано як використовуються фільтри відбору файлів по часу

### <a name="time-filters"></a> Фільтри по часу (часові фільтри)  
Крім масок та простих фільтрів рефлектори здатні фільтрувати файли по часу створення. Для цього в поле `src` вносять спеціальні поля: `notOlder`, `notNewer`, `notOlderAge`, `notNewerAge`:  
`notOlder` - не старше на момент вибірки;  
`notNewer` - не новіше на момент вибірки;  
`notOlderAge` - вік, не старший від встановленого на час проведення процедури;  
`notNewerAge` - вік, не менше від встановленого на час проведення процедури.  
В параметрах полів `notOlder`, `notNewer` вказуються значення в мілісекундах (1 с = 1000 мс), а в полях `notOlderAge` і `notNewerAge` в секундах. Рисунок іллюструє як працюють фільтри. Порівнюється вік файла з встановленим обмеженням.  
![time.filter](./Images/time.filter.png)  

Часові фільтри можна комбінувати між собою, щоб задати діапазон вибірки, а також можна комбінувати з масками. Єдиною умовою є виключення конфліктів між фільтрами.  

### <a name="time-filters-using"></a> Використання часових фільтрів  
Створіть структуру файлів як в попередньому туторіалі:  

```
.
├── proto
│     ├── proto.two
│     │     └── script.js
│     ├── files
│     │     ├── manual.md
│     │     └── tutorial.md
│     ├── build.txt.js 
│     └── package.json   
│
└── .will.yml       

```

Виберемо діапазон для вибірки файлів:  
\- не менше однієї хвилини;  
\- не більше 10 діб.  
Розраховуємо в секундах: `1 хв = 60 с`; `10 діб = 10 * 24 * 60 * 60 с = 864000 с`.  
Вкажемо діапазон вибірки в рефлекторі:  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
      notNewerAge : 3600
      notOlderAge : 864000
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

```

<details>
  <summary><u>Відкрийте, щоб проглянути повний лістинг `.will.yml`</u></summary>

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
      notNewerAge : 3600
      notOlderAge : 864000
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
      default : 1
      debug : [ 0,1 ]
    steps :
      - reflect.*

```

</details>

</br>
Запустимо побудову збірки відладки `will .build copy.debug`:  

```
[user@user ~]$ will .build copy.debug
...
  Building copy.debug
   + reflect.copy.debug reflected 8 files /path_to_file/ : out/debug <- proto in 0.390s
  Built copy.debug in 0.432s

```

Всі файли скопійовано. Змінимо діапазон в `notNewerAge` з 3600 до 800000, щоб виключити можливість копіювання файлів створених для випробування. Запустимо реліз-побудову:  

```
[user@user ~]$ will .build copy.
...
  Building copy.
   + reflect.copy. reflected 3 files /path_to_file/ : out/release <- proto in 0.311s
  Built copy. in 0.358s

```

Скопійовано три файла. перевіримо вміст директорії `out/release`:  

```
[user@user ~]$ ls -a out/release/
.  ..  files  proto.two

``` 

Тобто, `willbe` скопіював директорії без файлів.  
Випробуємо часові фільтри `notNewer` i `notOlder`. Задамо новий діапазон:  
\- не менше 1 секунди;  
\- не більше 10 хвилин.  
Відповідно, змініть рефлектор:  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto
      notNewer : 600000
      notOlder : 1000
    dst:
      filePath: path::out.*=1
    criterion:
      debug: [ 0,1 ]

```

Видаліть директорію `out` та створіть новий файл `file.txt` в директорії `proto`. Запустіть побудову відладки:  

```
[user@user ~]$ will .build copy.debug
...
  Building copy.debug
   + reflect.copy. reflected 4 files /path_to_file/ : out/debug <- proto in 0.311s
  Built copy. in 0.358s

```

Якщо проглянемо директорію `out/release`, то знайдемо на один файл більше:  

```
[user@user ~]$ ls -a out/release/
.  ..  files  file.txt  proto.two

``` 

- Часові фільтри рефлектора формують діапазони вибірки файлів за часом створення (модифікації).  

[Повернутись до змісту](../README.md#tutorials)