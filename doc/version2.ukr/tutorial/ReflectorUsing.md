# Копіювання файлів за допомогою рефлектора

Копіювання файлів за допомогою рефлектора, поле <code>recursive</code> рефлектора.

Основними функціями ресурсів секції `reflector` є файлові операції, в тому числі, двосторонні. Прикладом операцій рефлектора є вибір файлів (термінальних і директорій), переміщення, копіювання.  

### Конфігурація 

<details>
  <summary><u>Структура файлів</u></summary>

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

Створіть приведену структуру файлів для дослідження копіювання файлів рефлектором. 

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
    inherit : files.reflect
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

Для виклику рефлектора використовується вбудований крок `files.reflect`. В `вілфайлі` крок `reflect` посилається на рефлектор `reflect.copy`. В рефлекторі використовує поле `filePath` для копіювання файлів з однієї директорії в іншу. В полі `filePath` через двокрапку вказується два значення: `source_path` - шлях до директорії з файлами для копіювання і `destination_path` - директорія в яку файли скопіюються. Відповідно, запис вигляду

```yaml
    filePath :
      path::proto : path::out.*=1
      
```

означає скопіювати файли з директорії `proto` в директорію, яка починаються на `out.`. Ассерт вказаний для підтвердження вибору однієї директорії призначення.  

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

Запустіть реліз-побудову командою `will .build copy.`. Порівняйте результати виконання.

Вивід свідчить, що використовувався рефлектор `reflect.copy.` та відбулось копіювання файлів з каталогу `proto` в `out/release`.  

Структура файлів після виконання копіювання відображена нижче.

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

### Опція `recursive`

Будуючи модулі, часом, потрібно обмежити пошук окремими файлами, чи директоріями. Для цього в рефлекторах є поле `recursive`, яке визначає глибину зчитування структури директорії для відбору файлів. 

Поле `recursive` приймає три значення:  
`0` - зчитується файл (директорія) вказана в шляху;  
`1` - зчитується файли (директорії), що поміщені в директорії за вказаним шляхом (вміст директорій не зчитується);  
`2` - зчитуються файли і директорії на всіх рівнях, що нижче від вказаного в шляху.  
За замовчуванням поле `recursive` має значення `2` - копіювання всієї структури.

### Побудова з `recursive : 1`

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

Змініть ресурс `reflect.copy` в файлі `.will.yml` як приведено вище.    

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

Виконайте побудову збірки командою `will .build copy.debug`, перевірте результати.

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

З `recursive : 1` рефлектор скопіював директорію `proto.two` без її вмісту. Тобто, лише ті файли, які поміщені в директорії `proto`.

Структура файлів після виконання побудови має відповідати привденій нижче.

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

Якщо в рефлекторі змінити поле `recursive` до значення `0`, то буде скопійовано саму директорію `proto` без додаткових файлів. 

### Підсумок

- Рефлектори виконують операції з файлами, в тому числі двосторонні.  
- Скопіювати файли рефлектором можна використавши поле `filePath`. Для цього в полі вказується директорія з якої буде скопійовано файли і директорія призначення.   
- Полем `recursive` можна обмежити рівні зчитування файлової системи відносно вказаного шляху.

[Повернутись до змісту](../README.md#tutorials)
