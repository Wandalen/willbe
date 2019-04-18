# Copying of files with help of reflectors

How to copy files with help of reflectors, field <code>recursive</code> of reflector.

Основними функціями ресурсів секції `reflector` є файлові операції, в тому числі, двосторонні (вибір файлів (директорій), переміщення, копіювання та інші).  

### Конфігурація модуля. Копіювання рефлектором
Створіть наступну структуру файлів для дослідження копіювання файлів рефлектором:  

<details>
  <summary><u>Структура модуля</u></summary>

```
copy
  ├── proto
  │     ├── proto.two
  │     │     └── file.js
  │     ├── fileOne.js
  │     └── fileTwo.json   
  └── .will.yml       

```

</details>

В файл `will.yml` внесіть код:

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

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

  reflect :
    inherit : predefined.reflect
    reflector : reflect.*
    criterion :
       debug : [ 0,1 ]

build :

  copy :
    criterion :
      debug : [ 0,1 ]
    steps :
      - reflect*

```

</details>

Для виклику рефлектора використовується вбудований крок `predefined.reflect`. В `will-файлі` крок `reflect` посилається на рефлектор `reflect.copy`, котрий для копіювання файлів з однієї директорії в іншу, використовує поле `filePath`. В полі через двокрапку вказується два значення: `source_path` - шлях до директорії з файлами для копіювання і `destination_path` - директорія в яку файли скопіюються. Відповідно, запис вигляду

```yaml
    filePath :
      path::proto : path::out.*=1

```

означає скопіювати файли з директорії `proto` в директорію, яка починаються на `out.`. Ассерт вказаний для підтвердження вибору однієї директорії призначення.  
Запустіть реліз-побудову:  

<details>
  <summary><u>Вивід команди <code>will .build copy.</code></u></summary>

```
[user@user ~]$ will .build copy.
...
  Building module::copyByReflector / build::copy.
   + reflect.. reflected 5 files /path_to_file/ : out/release <- proto in 0.596s
   + reflect.copy. reflected 5 files /path_to_file/ : out/release <- proto in 0.469s
  Built module::copyByReflector / build::copy. in 1.187s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
copy
  ├── proto
  │     ├── proto.two
  │     │     └── file.js
  │     ├── fileOne.js
  │     └── fileTwo.json   
  ├── out
  │     └── release
  │            ├── proto.two
  │            │     └── file.js
  │            ├── fileOne.js
  │            └── fileTwo.json 
  └── .will.yml       

```

</details>

Вивід свідчить, що використовувався рефлектор `+ reflect.copy.` та відбулось копіювання файлів з одного каталогу в інший `out/release <- proto`.  

### Опція `recursive`
Будуючи модулі потрібно обирати як каталог з якого буде скопійовано файли, так і окремі файли в ньому. Так, ґлоби ефективні при виборі файлів з однотипними назвами на рівні однієї директорії, наприклад, якщо потрібно скопіювати файли `fileOne` i `fileTwo`, то в шляху `proto` можна вказати селектор: `proto : ./proto/file*`. При цьому, якщо створити каталог `./proto/files`  та помістити в нього файли, то селектор з ґлобом скопіює каталог без його вмісту.  
Тому, в рефлекторі передбачена опція `recursive`, яка визначає рівень зчитування структури директорії. Поле `recursive` приймає три значення:  
"0" - зчитується файл (директорія) вказана в шляху;  
"1" - зчитується файли (директорії), що поміщені в директорії за вказаним шляхом (вміст директорій не зчитується);  
"2" - зчитуються файли і директорії на всіх рівнях, що нижче від вказаного в шляху.  
За замовчуванням поле `recursive` має значення "2" - копіювання всієї структури.
Змініть ресурс `reflect.copy` до вигляду:  

<details>
  <summary><u>Рефлектор <code>reflect.copy</code> зі змінами</u></summary>

```yaml
  reflect.copy :
    recursive : 1
    filePath :
      path::proto : path::out.*
    criterion :
       debug : [ 0,1 ]

```

</details>

Виконайте побудову з критеріоном `debug : 1`:  

<details>
  <summary><u>Вивід команди <code>will .build copy.debug</code></u></summary>

```
[user@user ~]$ will .build copy.debug
...
  Building module::copyByReflector / build::copy.debug
   + reflect..debug reflected 4 files /path_to_file/ : out/debug <- proto in 0.565s
   + reflect.copy.debug reflected 4 files /path_to_file/ : out/debug <- proto in 0.465s
  Built module::copyByReflector / build::copy.debug in 1.151s

```

</details>

Скопійовано на один файл менше. Прогляньте  вміст в `./out/debug`:  

<details>
  <summary><u>Вивід команд <code>ls -a out/debug/</code>, <code>ls -a out/debug/proto.two/</code></u></summary>

```
[user@user ~]$ ls -a out/debug/
.  ..  fileOne.js  fileTwo.json  proto.two

[user@user ~]$ ls -a out/debug/proto.two/
.  ..

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
copy
  ├── proto
  │     ├── proto.two
  │     │     └── file.js
  │     ├── fileOne.js
  │     └── fileTwo.json   
  ├── out
  │     ├── release
  │     │      ├── proto.two
  │     │      │     └── file.js
  │     │      ├── fileOne.js
  │     │      └── fileTwo.json 
  │     └── debug
  │            ├── proto.two
  │            ├── fileOne.js
  │            └── fileTwo.json
  └── .will.yml       

```

</details>

Якщо змінити в рефлекторі на `recursive : 0` буде скопійовано саму директорію `proto`. 

### Підсумок
- Рефлектори виконують операції з файлами, в тому числі двосторонні.  
- Для копіювання файлів з допомогою поля `filePath` потрібно вказати директорію з якої буде скопійовано файли і директорію призначення.   
- В рефлекторах встановлюються рівні зчитування файлової системи відносно вказаного шляху.

[Повернутись до змісту](../README.md#tutorials)
