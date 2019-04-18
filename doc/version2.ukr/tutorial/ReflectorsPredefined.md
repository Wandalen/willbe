# Predefined reflectors 

How to use predefined reflectors to split debug and release files and how to build a multibuild.

### Призначення вбудованих рефлекторів
Крім вбудованих кроків в утиліті є вбудовані рефлектори, які мають налаштовані файлові фільтри для стандартних операцій. Всього є три вбудованих рефлектора: `predefined.common`, `predefined.debug` i `predefined.release`.  
Для використання вбудованих рефлекторів в ресурсі потрібно вказати поле `inherit` з обраним рефлектором.  
Наприклад, для рефлектора `predefined.common` в рефлекторі `use.predefined.reflector`:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```yaml
reflector :

    use.predefined.reflector :
        inherit : predefined.common

```

</details>

Запис потрібно доповнити інформацією щодо директорій, файли яких будуть фільтруватись, критеріонами за необхідністю, додатковими фільтрами, тощо.  

### Властивості вбудованих рефлекторів
##### Вбудований рефлектор `predefined.common`  
Рефлектор для фільтрування допоміжних файлів проекта.   

<details>
  <summary><u>Налаштування рефлектора <code>predefined.common</code></u></summary>

```yaml
    src :
      maskAll :
        excludeAny :
          - !!js/regex '/(\W|^)node_modules(\W|$)/'
          - !!js/regex '/\.unique$/'
          - !!js/regex '/\.git$/'
          - !!js/regex '/\.svn$/'
          - !!js/regex '/\.hg$/'
          - !!js/regex '/\.DS_Store$/'
          - !!js/regex '/(^|\/)-/'

```

</details>


Вбудований рефлектор `predefined.common` виключає зі збірки файли, які мають розширення `.unique`, `,git`, `.svn`, `.hg`, `.DS_Store`, а також файли які починаються зі знаків `/` або `-`.  
Регулярний вираз `/(\W|^)node_modules(\W|$)/` фільтрує наступні комбінації у назвах файлів:   
\- `спеціальний символ (несловесний) + node_modules`;  
\- `спеціальний символ (несловесний) + node_modules + спеціальний символ (несловесний)`;  
\- `node_modules + спеціальний символ (несловесний)`;  
\- `node_modules`.    

##### Вбудований рефлектор `predefined.debug`
Рефлектор для фільтрації файлів, призначених для релізу проекта. Рефлектор має дві версії з назвами `predefined.debug.v1` i `predefined.debug.v2`. Перша версія приймає критеріон `debug` зі значенням `1`, a друга зі значенням `debug`.  

<details>
  <summary><u>Налаштування рефлектора <code>predefined.debug</code></u></summary>

```yaml
     src :
       maskAll :
         excludeAny :
           - !!js/regex '/\.release($|\.|\/)/i'
     criterion :
       debug : 1

```

</details>

Вбудований рефлектор `predefined.debug` виключає зі збірки файли, які мають розширення `.release`, в назві яких є слово `.release.` і директорії з закінченням `.release`. Для використання рефлектора потрібно встановити в збірці побудови критеріон `debug` зі значенням `1` або `debug`.  

##### Вбудований рефлектор `predefined.release`  
Рефлектор, який фільтрує файли підготовки до релізу - відладки, тестові, експериментальні. Рефлектор має дві версії з назвами `predefined.release.v1` i `predefined.release.v2`. Перша версія приймає критеріон `debug` зі значенням `0`, a друга зі значенням `release`.  

<details>
  <summary><u>Налаштування рефлектора <code>predefined.release</code></u></summary>

```yaml
     src :
       maskAll :
         excludeAny :
           - !!js/regex '/\.debug($|\.|\/)/i'
           - !!js/regex '/\.test($|\.|\/)/i'
           - !!js/regex '/\.experiment($|\.|\/)/i'
     criterion :
       debug : 0

```

</details>


Вбудований рефлектор `predefined.release` виключає зі збірки файли:
\- які мають розширення `.debug`, `.test`, `.experiment`;  
\- в назві яких є слово `.debug.`, `.test.`, `.experiment.`;  
\- директорії з закінченням `.debug`, `.test`, `.experiment`.   
Для використання рефлектора потрібно встановити в збірці побудови критеріон `debug` зі значенням `0` або `release`.  

### Дослідження вбудованих рефлекторів. Мультизбірка
##### Конфігурація
Для дослідження вбудованих критеріонів потрібно створити таку структуру, при якій кожен вбудований рефлектор буде фільтрувати визначені файли. Створіть наступну конфігурацію в директорії `predefinedReflectors`:  

<details>
  <summary><u>Структура модуля</u></summary>

```
predefinedReflectors
        ├── proto
        │     ├── files.debug
        │     │     ├── debug.DS_Store
        │     │     └── debug.js
        │     ├── files.release
        │     │     └── release.test
        │     ├── node_modules              #  directory    
        │     ├── other
        │     │     └── other.experiment
        │     ├── -files.yml
        │     └── one.release.file.yml
        │
        └── .will.yml       

```

</details>

##### Мультизбірка  
Щоб не виконувати окремі побудови використовуються мультизбірки - виконання декількох збірок побудов однією командою. Для створення мультизбірки в секції `build` потрібно вказати всі необхідні збірки модуля, а потім створити сценарій, який буде виконувати вказані збірки.   
Запишіть в `.will.yml` наступний код:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : predefinedReflectors
  description : "To use predefined reflectors"
  version : 0.0.1

path :

  out.debug :
    path : out.debug
    criterion :
      debug : 1

  out.release :
    path : out.release
    criterion :
      debug : 0

reflector :

  reflect.project:
    inherit: predefined.*
    src:
      filePath:
        proto : 1
    dst:
      filePath: path::out.*=1
    criterion :
      debug : [ 0,1 ]

  reflect.copy.common:
    inherit: predefined.common
    src:
      filePath:
        proto : 1
    dst:
      filePath: out.common

step :

  reflect.project :
    inherit : predefined.reflect
    reflector : reflect.project*=1
    criterion :
      debug : [ 0,1 ]

  reflect.copy.common :
    inherit : predefined.reflect
    reflector : reflect.copy.common

build :

  copy :
    criterion :
      debug : [ 0,1 ]
    steps :
      - reflect.project*=1

  copy.common :
    steps :
      - reflect.copy.common

  all.reflectors :
    criterion :
      default : 1
    steps :
      - build::copy.
      - build::copy.debug
      - build::copy.common

```

</details>

Для використання рефлекторів `predefined.debug` i `predefined.release` використана збірка з мінімізацією кода під назвою `copy`, а для рефлектора `predefined.common` - збірка `copy.common` з простими селекторами.    
Також побудована мультизбірка `all.reflectors`, яка виконується за замовчуванням. В сценарії збірки `all.reflectors` вказані збірки секції `build` як кроки секції `step` - принцип побудови мультизбірок. 

##### Побудова модуля
Виконайте побудову (фраза `will .build`):

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::predefinedReflectors / build::all.reflectors
   + reflect.project. reflected 4 files /path_to_file/ : out.release <- proto in 1.548s
   + reflect.project.debug reflected 5 files /path_to_file/ : out.debug <- proto in 1.219s
   + reflect.copy.common reflected 8 files /path_to_file/ : out.common <- proto in 0.918s
  Built module::predefinedReflectors / build::all.reflectors in 3.967s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
predefinedReflectors
        ├── out.common
        │     ├── ... (look at the table)
        ├── out.debug
        │     ├── ... (look at the table)
        ├── out.release
        │     ├── ... (look at the table)
        ├── proto
        │     ├── ... (start configuration)
        │
        └── .will.yml       

```

</details>

Прогляньте створені пакетом директорії `out.common`, `out.debug` i `out.release`. Порівняйте вміст з даними в таблиці.

| Директорія    | Вбудований рефлектор | Файли в директорії після побудови |
|---------------|----------------------|-----------------------------------|
| `out.common`  | `predefined.common`  | Директорія `files.debug` з файлом `debug.js`; директорія `files.release` з файлом `release.test`; директорія `other` з файлом `other.experiment.js`; файл `one.release.file.yml` |
| `out.debug`   | `predefined.debug`   | Директорія `files.debug` з файлом `debug.js`; директорія `other` з файлом `other.experiment.js`        |
| `out.release` | `predefined.release` | Директорія `files.release`; директорія `other`; файл `one.release.file.yml` |

По результатам копіювання очевидно, що вбудовані рефлектори `predefined.debug` i `predefined.release` використовують попередню фільтрацію файлів з допомогою рефлектора `predefined.common` оскільки після побудови в директоріях  `out.debug` і `out.release` відсутні файли, які фільтруються рефлектором `predefined.common`.

### Підсумок  
- Вбудовані рефлектори мають налаштовані фільтри для побудови модуля.
- Вбудований рефлектор `predefined.common` використовується для фільтрації допоміжних файлів проекту (розширення `.git`, `.svn` та інші).  
- Рефлектор `predefined.debug` - фільтрує файли призначені для релізу, а `predefined.release` - файли відладки, тестові, експериментальні.
- Для використання рефлектора `predefined.debug` в збірці необхідно встановити критеріон `debug : 1` або `debug : 'debug'`, а для `predefined.release` - `debug : 0` або `debug : 'release'`.
- Вбудовані рефлектори `predefined.debug` i `predefined.release` здійснюють попередню фільтрацію файлів з допомогою рефлектора `predefined.common`.

[Повернутись до змісту](../README.md#tutorials)
