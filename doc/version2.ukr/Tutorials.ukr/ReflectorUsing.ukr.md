# Поняття рефлекторів. Копіювання файлів

В туторіалі описуються рефлектори, дається приклад копіювання файлів рефлектором, пояснюється як користуватись полем `recursive`  

<a name="reflector-term"></a> Основними функціями ресурсів [секції `reflector`](CompositionOfWillFile.ukr.md#reflector) є файлові операції, в тому числі, двосторонні (вибір файлів (директорій), переміщення, копіювання і т.д.).  
Почнемо вивчення функціоналу з операції копіювання. Створіть наступну структуру файлів:

```
.
├── proto
│     ├── proto.two
│     │     └── file.js
│     │
│     ├── fileOne.js 
│     └── fileTwo.json   
│
└── .will.yml       

```

В `will.yml` внесіть код:

<details>
  <summary><u>Лістинг файла `.will.yml`</u></summary>

```yaml
about :
  name : copyByReflector
  description : "To copy files by reflector using"

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

  reflect.copy :
    filePath :
      path::proto : path::out.*=1
    criterion :
       debug : [ 0,1 ]

step :

  reflect. :
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

<a name="copy-by-reflector"></a> Крок `reflect.` використовує вбудований крок `predefined.reflect`, в якого аргументом є поле `reflector` з посиланням на ресурс секції `reflector`.  
В секції `reflector` поміщений ресурс з назвою `reflect.copy`. Для копіювання файлів з однієї директорії в іншу без додаткових умов (фільтрів) в полі `filePath` ресурса вказується два значення: `source_path : destination_path`, де `source_path` - шлях до директорії з файлами для копіювання, `destination_path` - директорія в яку файли скопіюються.  
Відповідно, запис

```yaml
    filePath :
      path::proto : path::out.*=1

```

означає скопіювати файли з директорії `proto` в одну з директорій, які починаються на `out`, згідно мапи критеріонів та додатково вказаний ассерт для виключення помилки вибору.  
Запустимо реліз-побудову:

```
[user@user ~]$ will .build copy.
...
  Building copy.
   + reflect.copy. reflected 5 files /path_to_file/ : out/release <- proto in 0.352s
  Built copy. in 0.406s
  
```

Вивід логу, також свідчить, що використовувався рефлектор `+ reflect.copy.` та відбулось копіювання файлів з одного каталогу в інший `out/release <- proto`.  
Проглянемо зміни в структурі каталогів:  

```
[user@user ~]$ ls -a
.  ..  out  proto  .will.yml
  
```

```
[user@user ~]$ ls -a out/release/
.  ..  fileOne.js  fileTwo.json  proto.two

[user@user ~]$ ls -a out/release/proto.two/
.  ..  file.js
  
```

### <a name="recursive-reflector"></a> Опція `recursive` 
Рефлектор скопіював всі файли з директорії `proto`, але адмініструючи модулі потрібно буде обирати як каталог з якого буде скопійовано файли, так і окремі файли в ному. Так, знайомі нам ґлоби ефективні при виборі файлів з однотипними назвами на рівні однієї директорії, наприклад, якщо потрібно скопіювати файли `fileOne` i `fileTwo` то в шляху `proto` можемо вказати наступний селектор: `proto : ./proto/file*`. При цьому, якщо створити каталог `proto/files`  та помістити в нього файли, то селектор з ґлобом скопіює каталог, але не його вміст.  
Тому в рефлекторі передбачена опція `recursive`, яка визначає рівень зчитування структури директорії. Поле `recursive` приймає три значення:  
"0" - зчитується файл (директорія) вказана в шляху;  
"1" - зчитується файли (директорії), що поміщені за вказаним шляхом (вміст директорій не зчитується);  
"2" - зчитуються файли і директорії на всіх рівнях, що нижче від вказаного в шляху.  
Тобто, якщо проходить копіювання за рефлектором без зазначеного поля `recursive`, то за замовчуванням його значення "2" - копіювання всієї структури, а якщо використовуєтся вибірка за ґлобом, то, умовно, поле `recursive` має значення "1", прямі посилання на файл чи папку - `recursive : 0`.
Змініть ресурс `reflect.copy` до вигляду:  

```yaml
  reflect.copy :
    recursive : 1
    filePath :
      path::proto : path::out.*
    criterion :
       debug : [ 0,1 ]

```

та виконайте побудову зі значенням критеріона `debug : 1`:  

```
[user@user ~]$ will .build copy.debug
...
  Building copy.debug
   + reflect.copy. reflected 4 files /path_to_file/ : out/debug <- proto in 0.322s
  Built copy. in 0.376s
  
```

Скопійовано на один файл менше. Проглянемо  вміст в _'./out/debug'_:

```
[user@user ~]$ ls -a out/debug/
.  ..  fileOne.js  fileTwo.json  proto.two

[user@user ~]$ ls -a out/release/proto.two/
.  ..
  
```

Тому, якщо змінити поле рефлектора на `recursive : 0` буде скопійовано саму директорію `proto`. Змініть шлях `proto : ./proto/fileOne.js` при значенні `recursive : 0` та запустіть команду реліз-побудови:  

```
[user@user ~]$ will .build copy.
...
  Building copy.
   + reflect.copy. reflected 1 files /path_to_file/ : out/release <- proto/fileOne.js in 0.325s
  Built copy. in 0.378s
  
```

Якщо поле `recursive` має значення "0", то потрібно вказувати шляхи до кожного файла в рефлекторі.

- [Рефлектори](#reflector-term) виконують операції з файлами, в тому числі двосторонні.  
- [Для копіювання файлів](#copy-by-reflector) потрібно вказати директорію з якої буде скопійовано файли і директорію призначення.   
- В рефлекторах встановлюються [рівні зчитування файлової системи](#recursive-reflector) відносно вказаного шляху.

[Повернутись до змісту](../README.md#tutorials)