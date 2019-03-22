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
Навчимось використовувати мультизбірки - виконання багатьох збірок побудов однією командою.  
Потрібно створити таку структуру, при якій кожен вбудований рефлектор буде фільтрувати визначені файли. Тому побудуйте таку конфігурацію:  

```
.
├── proto
│     ├── files.debug
│     │     ├── manual.md
│     │     └── tutorial.md
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

Повний лістинг файла `.will.yml`

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
      default : 1
      debug : [ 0,1 ]
    steps :
      - reflect.project*=1

  copy.common :
    criterion : 
      default : 1
    steps :
      - reflect.copy.common

```

</details>