# Вбудовані рефлектори  

Використання вбудованих рефлекторів та побудова мультизбірок  

### <a name="predefined-reflectors-term"></a> Призначення вбудованих рефлекторів
Крім вбудованих кроків в утиліті є вбудовані рефлектори. Вбудовані рефлектори позбавляють необхідності прописувати налаштування фільтрів для стандартних операцій. Всього є три вбудованих рефлектора: `predefined.common`, `predefined.debug` i `predefined.release`.  
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
##### <a name="predefined-common"></a> Вбудований рефлектор `predefined.common`  
Рефлектор, який відфільтровує допоміжні файли проекта.   

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
Регулярний вираз `/(\W|^)node_modules(\W|$)/` фільтрує наступні комбінації назви файлів:   
\- `спеціальний символ (несловесний) + node_modules`;  
\- `спеціальний символ (несловесний) + node_modules + спеціальний символ (несловесний)`;  
\- `node_modules + спеціальний символ (несловесний)`;  
\- `node_modules`.  
Тобто, рефлектор `predefined.common` необхідний для виключення зі збірки допоміжних файлів для побудови модуля.  

##### <a name="predefined-debug"></a> Вбудований рефлектор `predefined.debug` 
Рефлектор для фільтрації файлів, призначених для релізу проекта.   

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


Вбудований рефлектор `predefined.debug` виключає зі збірки файли, які мають розширення `.release`, в назві яких є слово `.release.` і директорії з закінченням `.release`. Також, рефлектор використовує критеріон `debug : 1`, тобто, необхідно, щоб в збірці побудови був встановлений критеріон `debug`.  

##### <a name="predefined-release"></a> Вбудований рефлектор `predefined.release`  
Рефлектор, який фільтрує файли для підготовки до релізу - відладки, тестові, експериментальні.   

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
Рефлектор використовує критеріон `debug : 0`, тобто, необхідно, щоб в збірці побудови критеріон `debug` мав значення "0".  

### <a name="experiment-and-multiassembly"></a> Дослідження вбудованих рефлекторів. Мультизбірка
##### <a name="configuration"></a> Конфігурація 
Потрібно створити таку структуру, при якій кожен вбудований рефлектор буде фільтрувати визначені файли. Тому побудуйте таку конфігурацію в директорії `predefinedReflectors`:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

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

##### <a name="multiassembly"></a> Мультизбірка  
Щоб не виконувати окремі побудови використовуються мультизбірки - виконання декількох збірок побудов однією командою. Для створення мультизбірки в секції `build` потрібно вказати всі необхідні збірки модуля, а потім створити сценарій, який буде виконувати вказані збірки.   
Запишіть в `.will.yml` наступний код:  

<details>
  <summary><u>Повний код <code>.will.yml</code></u></summary>
    
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


Для використання рефлекторів `predefined.debug` i `predefined.release` використані збірки з мінімізацією кода під назвою `copy`, а для рефлектора `predefined.common` - збірка `copy.common` з простими селекторами.    
Також побудована мультизбірка, яка виконується за замовчуванням. В сценарії збірки `all.reflectors` вказані збірки секції `build` як кроки секції `step` - принцип побудови мультизбірок:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```yaml
  all.reflectors :
    criterion : 
      default : 1
    steps : 
      - build::copy.
      - build::copy.debug
      - build::copy.common

```

</details> 

##### <a name="building"></a> Побудова модуля 
Виконайте побудови (фраза `will .build`): 

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```
[user@user ~]$ will .build
...
  Building all
   + reflect.project. reflected 4 files /path_to_file/ : out.release <- proto in 0.343s
   + reflect.project.debug reflected 5 files /path_to_file/ : out.debug <- proto in 0.305s
   + reflect.copy.common reflected 8 files /path_to_file/ : out.common <- proto in 0.273s
  Built all in 1.078s
    
```

<p>Структура модуля після побудови</p>

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
- Вбудовані рефлектори використовуються для фільтрації допоміжних файлів проекту (`.git`, `.svn` та інші).  
- Вбудовані рефлектори `predefined.debug` i `predefined.release` здійснюють попередню фільтрацію файлів з допомогою рефлектора `predefined.common`.

[Повернутись до змісту](../README.md#tutorials)