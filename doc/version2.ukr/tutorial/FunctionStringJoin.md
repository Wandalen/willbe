# Обробка масивів рядкових значень в <code>вілфайлі</code>

Як використовувати функцію об'єднання масивів рядкових значень в <code>вілфайлі</code>.

Використання масиву рядкових значень в ресурсах `вілфайла` робить його більш зручним в використанні. В такому вигляді його легше записувати і зчитувати. Наприклад, проглянувши сценарій збірки розробник може відразу дізнатись про її призначення і кінцевий результат побудови:

```yaml
build :

  reflect.to.module :
    steps :
      - submodules.download
      - reflect.submodules*=1
      - submodules.clean

```

Навіть не проглядаючи відповідні кроки збірки `reflect.to.module` видно:
- будуть завантажені віддалені підмодулі;
- скопійовано із них потрібні файли;
- очищено модуль від цих віддалених підмодулів.

Якщо вбудовані інструменти ефективно працюють з такими масивами, то зовнішнім функціям може знадобитись перетворення. Для перетворення масиву рядкових значень в один рядок використовується функція `strings.join`.

Функція записується через слеш після ресурсу з масивом рядкових значень: `{Section name::Resource name (string array)/f::strings.join}`. Даний запис означає: повернути рядок з елементів рядкового масиву. Елементи рядку, що повертається функцією, розділені пробілом. Повернене значення може використовуватись внутрішніми функціями утиліти, для передачі аргументів зовнішній команді, тощо. 

### Конфігурація  

<details>
  <summary><u>Структура файлів</u></summary>

```
stringsJoin
    └── .will.yml

```

</details>
<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : 'stringsJoin'
  description : 'Using of strings.join function to download dependencies'
  package.list :
    main :
      - wTools
      - wpathfundamentals
    optional :
      - wColor
      - wProto
  simple.list : 
    - one
    - two
    - three

step :

  install.dependencies.join :
    shell : npm install {about::package.list/f::strings.join}
    
  install.dependencies.nojoin :
    shell : npm install {about::package.list/main}

  echo.dependencies.join :
    shell : echo {about::package.list/f::strings.join}

  echo.dependencies.nojoin :
    shell : echo {about::package.list}
    
  echo.simple.list :
    shell : echo {about::simple.list}

build :

  echo.strings :
    criterion :
      default : 1
    steps :
      - echo.dependencies.join
      - echo.dependencies.nojoin
      - echo.simple.list
      
  install.strings : 
    steps: 
      - install.dependencies.join
      - install.dependencies.nojoin
      
```

</details>

Для дослідження функції `f::strings.join` створіть приведену вище структуру файлів та внесіть в `.will.yml` відповідний код.  

Зверніть увагу на секцію `about`. Крім стандартних полів опису (`name`, `description`, `version`), секція може мати будь-яку структуру із масивів та мап будь-якого рівня вкладеності. Дані із цієї секції можуть використовуватися кроками.  
Тому, в секції було поміщено двомірний рядковий масив `package.list` з назвами пакетів залежностей NodeJS та одномірний масив `simple.list`. Вони будуть використані для дослідження функції `f::strings.join`. 

Збірка `echo.strings` виконує:
- крок `echo.dependencies.join`. В цьому кроці виконується зовнішня команда `echo` для виводу рядка в консоль. Параметром виступає `{about::package.list/f::strings.join}`, який повертає рядок із об'єднаних значень масиву `package.list`;
- крок `echo.dependencies.nojoin`. Виводить значення з масиву `package.list` без функції об'єднання в рядок;
- крок `echo.simple.list`. Виводить значення з одномірного рядкового масиву `simple.list` без функції об'єднання в рядок.

Збірка `install.strings` виконує:
- крок `install.dependencies.join`, який завантажує залежності NodeJS з допомогою NPM. Аргументи для команди формуються з застосуванням функції `f::strings.join`;
- крок `install.dependencies.nojoin`, який завантажує залежності першого елементу масиву `package.list` з назвою `main`. Для доступу до елемента після назви масиву через слеш вказується назва елемента масива.

### Побудова модуля

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::stringsJoin / build::echo.strings
 > echo wTools wpathfundamentals
wTools wpathfundamentals

 > echo wColor wProto
wColor wProto

 > echo wTools,wpathfundamentals
wTools,wpathfundamentals

 > echo wColor,wProto
wColor,wProto

 > echo one
one

 > echo two
two

 > echo three
three

```

</details>

Запустіть побудову збірки `echo.strings` виконавши команду `will .build`.

Проаналізувавши вивід, можна побачити, що функція `f::strings.join` об'єднує елементи останнього порядку масивів. В прикладі це другий порядок і виведено два рядки: `wTools wpathfundamentals` з елементу `main`; `wColor wProto` з елементу `optional`.  
Вивід без функції `f::strings.join` відрізняється в залежності від порядку масива. Якщо використовується одномірний масив, то команда застосовується до кожного окремого рядка. В виводі це команди `echo one`, `echo two`, `echo three`. Поведінка команди буде такою ж, якщо вказати елемент останнього порядку масиву. Якщо використовуються рядкові масиви вищих порядків, то утиліта виводить вкладені значення елементів першого порядку, які розділені комою. В виводі це два значення - `wTools,wpathfundamentals` з елементу першого порядку `main` i `wColor,wProto` в елементы `optional`.

<details>
  <summary><u>Вивід команди <code>will .build install.strings</code></u></summary>

```
[user@user ~]$ will .build install.strings
...
  Building module::stringsJoin / build::install.strings
 > npm install wTools wpathfundamentals
...
+ wTools@0.8.450
+ wpathfundamentals@0.6.173
added 1 package from 2 contributors, updated 1 package and audited 5 packages in 3.276s
found 0 vulnerabilities
...

 > npm install wColor wProto
npm
 ...

+ wProto@0.4.147
+ wColor@0.3.105
added 1 package from 2 contributors, updated 1 package and audited 7 packages in 1.389s
found 0 vulnerabilities
 ...

 > npm install wTools
npm
...
+ wTools@0.8.450
updated 1 package and audited 7 packages in 0.72s
found 0 vulnerabilities
...

 > npm install wpathfundamentals
npm
...
+ wpathfundamentals@0.6.173
updated 1 package and audited 7 packages in 0.716s
found 0 vulnerabilities
...
  Built module::stringsJoin / build::install.strings in 10.612s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
defaultBuild
     ├── node_modules
     │         ├── wColor
     │         ├── wpathfundamentals
     │         ├── wProto
     │         └── wTools
     ├── package-lock.json
     └── .will.yml

```

</details>

Запустіть побудову в збірці `install.strings` виконавши команду `will .build install.strings`.

Виключивши з виводу консолі попередження видно, що при застосуванні функції `f::strings.join` утиліта запускала пакетний менеджер NPM з парами аргументів. 

В кроці `install.dependencies.nojoin` використовувався елемент `main`. Утиліта по черзі завантажила пакети згідно його вмісту. Якщо використати шлях `{about::package.list}` замість `{about::package.list/main}`, то переданий аргумент буде незрозумілим для команди `npm.install` і побудова завершиться з помилкою.

Для функції `f::strings.join` не важливо, з якого ресурсу використовуються рядкові значення, головне передати їх за правильним шляхом. Наприклад, ви можете використати масив шляхів вказавши `{path::some_path/f::strings.join}`.

### Підсумок

- Функція `f::strings.join` використовується для об'єднання масиву рядкових значень в один рядок.
- Елементи рядка, який повертає функція, розділені пробілом.
- Для об'єднання можуть використовуватись рядкові масиви з будь-якого ресурса `вілфайла` або з секції `about`.

[Повернутись до змісту](../README.md#tutorials)