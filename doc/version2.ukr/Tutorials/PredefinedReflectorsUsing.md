# Використання вбудованих рефлекторів willbe

В туторіалі показано як використовувати вбудовані рефлектори утиліти `willbe` та побудова мультизбірок

### Призначення вбудованих рефлекторів
Крім вбудованих кроків утиліта `willbe` має вбудовані рефлектори з налаштованими фільтрами. Використання вбудованих рефлекторів позбавляє необхідності прописувати налаштування для стандартних операцій. Всього є три вбудованих рефлектора: `predefined.common`, `predefined.debug` i `predefined.release`.  
Для використання вбудованих рефлекторів в ресурсі потрібно вказати поле `inherit` з обраним рефлектором. Наприклад, щоб підставити фільтри рефлектора `predefined.common` в рефлектор `use.predefined.reflector` запишіть:  

```yaml
reflector : 
    
    use.predefined.reflector :
        inherit : predefined.common

```

Запис потрібно доповнити інформацією щодо директорій, файли яких будуть фільтруватись, критеріонами за необхідністю, додатковими фільтрами, тощо.  

### Властивості вбудованих рефлекторів
Розглянемо властивості вбудованих рефлекторів.
##### Вбудований рефлектор `predefined.common`
Налаштування вбудованого рефлектора:  

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

Вбудований рефлектор `predefined.common` виключає зі збірки файли, які мають розширення `.unique`, `,git`, `.svn`, `.hg`, `.DS_Store`, а також файли які починаються зі знаків '/' або '-'. Регулярний вираз '/(\W|^)node_modules(\W|$)/' фільтрує наступні комбінації назви файлів:  
\- 'спеціальний символ (несловесний)' + 'node_modules';
\- 'спеціальний символ (несловесний)' + 'node_modules' + 'спеціальний символ (несловесний)';
\- 'node_modules' + 'спеціальний символ (несловесний)';
\- 'node_modules'.
Тобто, рефлектор `predefined.common` необхідний для виключення зі збірки допоміжних файлів для побудови модуля.

##### Вбудований рефлектор `predefined.debug`
Налаштування вбудованого рефлектора:  

```yaml
     src :
       maskAll :
         excludeAny : 
           - !!js/regex '/\.release($|\.|\/)/i' 
     criterion :
       debug : 1
    
```

Вбудований рефлектор `predefined.debug` виключає зі збірки файли, які мають розширення `.release`, в назві яких є слово `.release.` і директорії з закінченням `.release`. Також, рефлектор використовує критеріон `debug : 1`, тобто, при вибірці рефлектора за ґлобом, необхідно, щоб в збірці також був встановлений критеріон `debug`.  

##### Вбудований рефлектор `predefined.release`
Налаштування вбудованого рефлектора:  

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
    
Вбудований рефлектор `predefined.release` виключає зі збірки файли:
\- які мають розширення `.debug`, `.test`, `.experiment`;
\- в назві яких є слово `.debug.`, `.test.`, `.experiment.`;
\- директорії з закінченням `.debug`, `.test`, `.experiment`.  
Рефлектор використовує критеріон `debug : 0`, тобто, при вибірці рефлектора за ґлобом, необхідно, щоб в збірці критеріон `debug` мав значення "0".  

### Дослідження вбудованих рефлекторів. Мультизбірка
Потрібно створити таку структуру, при якій кожен вбудований рефлектор буде фільтрувати визначені файли. Тому побудуйте таку конфігурацію:  

```
.
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

Щоб не виконувати окремі побудови, навчимось використовувати мультизбірки - виконання багатьох збірок побудов однією командою. Для створення мультизбірки в секції `build` потрібно вказати всі необхідні збірки модуля, а потім створити сценарій, який буде виконувати декілька збірок.  
Якщо прийняти, що для використання рефлекторів `predefined.debug` i `predefined.release` будуть використані збірки з мінімізацією кода з назвою `copy`, а для рефлектора `predefined.common` - збірка `copy.common` з простими селекторами, то секція `build` матиме вигляд:  

```yaml
build :

  copy :
    criterion : 
      debug : [ 0,1 ]
    steps :
      - reflect.project*=1

  copy.common :
    steps :
      - reflect.copy.common

```

Також додамо мультизбірку, яка буде виконуватись за замовчуванням:  

```yaml
  all.reflectors :
    criterion : 
      default : 1
    steps : 
      - build::copy.
      - build::copy.debug
      - build::copy.common

```

В останній збірці в сценарії вказані не кроки секції `step`, а збірки секції `build`.  
Запишіть в файл `.will.yml` наступний конфіг:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>
    
```yaml
about :
  name : predefinedReflector
  description : "To use predefined reflector"
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

Виконаємо всі побудови, для цього введіть `will .build`: 

```
[user@user ~]$ will .build
...
  Building all
   + reflect.project. reflected 4 files /path_to_file/ : out.release <- proto in 0.343s
   + reflect.project.debug reflected 5 files /path_to_file/ : out.debug <- proto in 0.305s
   + reflect.copy.common reflected 8 files /path_to_file/ : out.common <- proto in 0.273s
  Built all in 1.078s
    
```

Прогляньте створені пакетом директорії `out.common`, `out.debug` i `out.release`. Порівняйте вміст з даними в таблиці.

| Директорія        | Вбудований рефлектор | Файли в директорії після побудови |
|-------------------|----------------------|-----------------------------------|
| out.common        | reflector.common     | |