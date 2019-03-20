# Фільтри рефлектора

В туторіалі дається поняття простих фільтрів і масок рефлектора та показано як вони застосовуються  

### <a name="full-form-reflector"></a> Повна форма запису рефлектора  
Запис операції копіювання в скороченій формі зручний, але тоді вибірка елементів проходить лише за іменем файлів. Якщо потрібно точно відібрати файли необхідно записати повну форму рефлектора.  
Запишемо рефлектор копіювання файлів з попереднього прикладу в повній формі:


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
Трансформація полягає в розділенні ресурсів на джерело для копіювання `src` та місце призначення `dst`, де будуть поміщені скопійовані файли. Поле `filePath` внесено в ресурси полів `src` і `dst` відповідно.

### <a name="configuration"></a> Початкова конфігурація модуля  
Почнемо знайомство з фільтрами з останньої конфігурації системи модифікувавши назви файлів:  

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

### <a name="reflector-simple-filters"></a> Прості фільтри рефлектора  
Ґлоби зручні в використанні, але при такій структурі файлів і каталогів доведеться створювати по декілька процедур, щоб вибрати необхідні файли. Ми використаємо функції рефлектора для фільтрування вибірки файлів.  
Почнемо з використання пристих фільтрів - це фільтри, які використовуються для сортування файлів за назвою та розширенням. До простих фільтрів відносяться:  
`begins` - включає в вибірку всі файли в директорії, назва яких починається з указаного в фільтрі слова.  
`ends` - включає в вибірку всі файли, назва яких закінчується на вказане в фільтрі слово.  
`hasExtension` - якщо розширення файла співпадає з вказаним в фільтрі, то файл буде включений в вибірку. Розширення файла може бути складним і пакет `willbe` зчитує його, починаючи з першої крапки в назві файла. Наприклад, файл `somefile.txt.md` має два розширення - `txt` i `md`.  
Фільтри рефлектора поміщаються в поле `src`.  

##### <a name="begins-filter"></a> Фільтр 'begins'
Для вибору файлів, які починаються на `pac` та `file`, помістіть в `.will.yml` конфіг:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

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
      default : 1
      debug : [ 0,1 ]
    steps :
      - reflect.*

```

</details>

Запустіть реліз-побудову:  

```
[user@user ~]$ will .build copy.
...
 Building copy.
   + reflect.copy. reflected 5 files /path_to_file/ : out/release <- proto in 0.416s
  Built copy. in 0.463s

```

Переглянемо файли, які були скопійовані:  

```
[user@user ~]$ ls -a out/release/
.  ..  files  package.json

[user@user ~]$ ls -a out/release/files 
.  ..  manual.md  tutorial.md

``` 

Є розбіжність - ми знайшли три файла і один каталог в директорії `release`, а не п'ять файлів. Зверніть увагу, рефлектор пакета `willbe` враховує директорію, де поміщаються файли, в даному випадку, директорію `release`. Також, при використанні фільтра `begins` рефлектор копіює внутрішню структуру в вибраних директоріях.   

##### <a name="ends-filter"></a> Фільтр 'ends'
Щоб використати відбір за закінченням назви файла змініть в рефлекторі фільтр `begins` на `ends`:  

```yaml
      ends: 'js'

```

Фільтр згідно опції `recursive` буде шукати всі файли, які закінчуються на `js`. При цьому, не важливо, чи це буде розширення, чи закінчення назви директорії `nodejs`.  
Запустіть побудову відладки та прогляньте зміни в директоріях `out/`:  

```
[user@user ~]$ will .build copy.debug
...
 Building copy.debug
   + reflect.copy. reflected 4 files /path_to_file/ : out/debug <- proto in 0.316s
  Built copy. in 0.463s

```

```
[user@user ~]$ ls -a out/debug/
.  ..  build.txt.js  proto.two

[user@user ~]$ ls -a out/debug/proto.two
.  ..  script.js

```

##### <a name="hasExtension-filter"></a> Фільтр 'hasExtension'  
Фільтр `hasExtension`, на відміну від попередніх, зчитує частини розширення файла починаючи від першої крапки в назві. Переважно, він використовується для файлів зі складними розширеннями, адже, розширення в середині файла вказує додаткові особливості. Наприклад, сторінка на якій знаходитесь формується з файла з назвою `ReflectorFilters.ukr.md`, де перше розширення `.ukr` вказує на українську мову, при перекладі на англійську файл мав би розширення `.eng.md`.  
В створеній директорії є файл `build.txt.js`. Створимо вибірку елементів з розширеннями `.txt` i `.two` - змініть фільтр `ends` на `hasExtension`:  

```yaml
      hasExtension: 
         - 'js'
         - 'two'

```

Запустіть реліз-збірку та перевірте вміст в директорії `out/release`:  

```
[user@user ~]$ will .build copy.debug
...
 Building copy.
   + reflect.copy. reflected 4 files /path_to_file/ : out/release <- proto in 0.342s
  Built copy. in 0.384s


```

```
[user@user ~]$ ls -a out/release/
.  ..  build.txt.js  proto.two

[user@user ~]$ ls -a out/release/proto.two
.  ..  script.js

```

В файлах знаходимо `script.js`, який не входить в вибірку - він скопіювався як внутрішня структура директорії `proto.two`.  
> Прості фільтри не комбінуються між собою, тому вказуйте ті, які виключають помилки в вибірці.

### <a name="reflector-masks"></a> Маски рефлектора
Маски рефлектора - фільтрування файлових операцій за місцем виконання.  
Пакет `willbe` здатен фільтрувати операції в консолі операційної системи (поле `maskTerminal`), в директоріях (поле `maskDirectory`) та одночасно в консолі і директоріях (поле `maskAll`).  
Кожне з зазначених полів вибірково включає ресурси:   
`includeAny` - включити в вибірку будь-який елемент з вказаним параметром;  
`includeAll` - включити в вибірку всі знайдені елементи з вказаним параметром;  
`excludeAny` - виключити з вибірки будь-який елемент з вказаним параметром;  
`excludeAll` - виключити з вибірки всі елементи з вказаним параметром.  
Правила для вибірки формуються з застосуванням регулярних виразів JavaScript. Для корректного виконання збірки в фільтрі маски вказується фраза `!!js/regexp` перед регулярним виразом.   
Використаємо маски замість простих фільтрів.  
Якщо потрібно включити всі файли з розширенням '.js' та виключити документи з розширенням '.md', то потрібно додати маску в поле `src`:  

```yaml
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

```
 
Повний лістинг файла `.will.yml`:

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

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
      default : 1
      debug : [ 0,1 ]
    steps :
      - reflect.*

```
</details>

</br>
Запустимо реліз-побудову, та перевіримо структуру файлів:  

```
[user@user ~]$ will .build copy.
...
 Building copy.
   + reflect.copy. reflected 4 files /path_to_file/ : out/release <- proto in 0.390s
  Built copy. in 0.440s

```

```
[user@user ~]$ ls -a out/release/
.  ..  build.js  proto.two

[user@user ~]$ ls -a out/release/proto.two  
.  ..  script.js

``` 

- При [повній формі запису](#full-form-reflector) вносьте ресурси фільтрів в поле `src` рефлектора.   
- Прості фільтри вибирають файли за [початком назви](#begins-filter) файла, [закінченням назви](#ends-filter) і [розширеннями](#hasExtension-filter). Вони не комбінуються між собою.  
- [Маски рефлектора](#reflector-masks) використовують регулярні вирази JavaScript для побудови правил фільтрування.  

[Повернутись до змісту](../README.md#tutorials)