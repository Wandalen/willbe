# Формування шляхів в рефлекторі. Управління файловими операціями

В туторіалі показано як формуються шляхи рефлекторів та як управляти кількістю файлових операцій 

Крім порівняння властивостей файлів з заданими в фільтрах, рефлектори здатні управляти файловою адресацією та окремими директоріями вибірки. Для цього в рефлекторах передбачені поля `filePath` та `prefixPath`.  
Поле `filePath` - шлях до файлів вибірки, вказується в рефлекторі як самостійне поле або як ресурс поля `src` i `dst`. Керує доступом до окремих директорій вказаних в ньому.   
Поле `prefixPath` - відносний шлях, який додається до шляху `filePath`.  

### Початкова конфігурація  
Створіть структуру файлів як на рисунку:

```
.
├── proto
│     └── proto.two
│            └── proto.js
├── files
│     └── files.js
│
└── .will.yml       

```

### Використання полів `filePath` i `prefixPath`  
Cтворимо рефлектор, який буде копіювати файл з директорії `proto/proto.two` в диреторію `files/files.two`:  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto/proto.two
    dst:
      prefixPath: ./files/files.two

```

Поля `filePath` i `prefixPath` використовуються як самостійно, так і в поєднанні тому, така форма запису шляхів можлива. `prefixPath` i `filePath` починають відлік від кореневого каталога `will`-файла - '.' . 
<details>
  <summary><u>Відкрийте, щоб проглянути повний лістинг файла</u></summary>

```yaml

about :
  name : reflectorPaths
  description : "To use reflector path constructor"
  version : 0.0.1

reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto/proto.two
    dst:
      prefixPath: ./files/files.two

step :

  reflect.copy :
    inherit : predefined.reflect
    reflector : reflect.*

build :

  copy :
    criterion : 
      default : 1
    steps :
      - reflect.*

```

</details>

Запустіть побудову: 

```
[user@user ~]$ will .build
...
 Building copy
   + reflect.copy reflected 2 files /path_to_file/ : files/files.two <- proto/proto.two in 0.329s
  Built copy in 0.379s

```

Перевіримо вміст директорії `files/files.two`:

```
[user@user ~]$ ls -a files/files.two/
.  ..  proto.js

``` 

Змінимо шляхи в рефлекторі, щоб вони складались з двох частин (замініть в файлі `.will.yml`):  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: ./proto.two
      prefixPath: ./proto
    dst:
      filePath: ./files.two
      prefixPath: ./files

```

Тобто, кожен шлях складається двох частин `prefixPath + filePath`. Видаліть створену директорію `files.two` та повторіть побудову:  

```
[user@user ~]$ will .build
...
 Building copy
   + reflect.copy reflected 2 files /path_to_file/ : files/files.two <- proto/proto.two in 0.329s
  Built copy in 0.379s

```

Префікси зручно виносити при великій довжині шляху - файл стає зручним для зчитування.  

### Керування ресурсами в рефлекторі  
До цього часу ми створювали по одному потоку файлових операцій за одну побудову модуля. Для збільшення кількості операцій можна додати кроки в сценарій побудови, що збільшить об'єм `will`-файла за рахунок дублювання інформації в ресурсах. Тому, краще використовувати поля рефлекторів, які дозволяють працювати з декількома потоками файлів одночасно, а саме поле `filePath`.  
Змінимо секцію рефлекторів, щоб провести дві операції копіювання - з директорії `files` в директорію `out1` та з директорії `proto` в `out2`.  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: 
        files : out1
        proto : out2

```

Зручна форма запису, яка дозволяє виконувати одночасно декілька операцій копіювання за різними шляхами.  
Запустіть побудову модуля та перевірте вміст кореневої директорії:  

```
[user@user ~]$ will .build
...
  Building copy
   + reflect.copy reflected 7 files /path_to_file/ : . <- . in 0.431s
  Built copy in 0.480s

```

```
[user@user ~]$ ls -a
.  ..  files  out1  out2  proto  .will.yml

[user@user ~]$ ls -a
.  ..  files.js  files.two

[user@user ~]$ ls -a
.  ..  proto.two

``` 

Видаліть зайві каталоги, щоб структура файлів була як на рисунку:

```
.
├── proto
│     └── proto.two
│            └── proto.js
├── files
│     ├── files.two
│     │      └── proto.js
│     └── files.js
│
└── .will.yml       

```

Тепер скопіюємо каталоги в одну директорію. Змініть рефлектор до вигляду:  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: 
        files/files.two : 1
        proto : 1
    dst:
      filePath: out3

```

Запис відрізняється тим, що вказуючи значення "0" (false) і "1" (true) ми вибираємо директорії з яких будуть копіюватись файли. Щоб перевірити роботу рефлектора, запустіть побудову і перевірте вміст згенерованої директорії `out3':  

```
[user@user ~]$ will .build
...
  Building copy
   + reflect.copy reflected 5 files /path_to_file/ : out3 <- . in 0.307s
  Built copy in 0.355s

```

```
[user@user ~]$ ls -a out3/
.  ..  proto.js  proto.two

[user@user ~]$ ls -a out3/proto.two/
.  ..  proto.js

``` 

Вимкнемо копіювання з директорії `proto`. Змініть рефлектор до вигляду:  

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath: 
        files/files.two : 1
        proto : false
    dst:
      filePath: out4

```

Запустіть побудову та перевірте вміст директорії `out4`:

```
[user@user ~]$ will .build
...
  Building copy
   + reflect.copy reflected 2 files /path_to_file/ : out3 <- files/files.two in 0.301s
  Built copy in 0.349s

```

```
[user@user ~]$ ls -a out4/
.  ..  proto.js

``` 

Файли з директорії `proto` не скопіювались.  
Комбінюючи управління директоріями і налаштуванням фільтрів розширюються можливості рефлекторів по вибірці файлів.  

- Шлях рефлектора складається з частин. Їх можна використовувати самостійно або комбінувати.  
- Рефлектори можуть виконувати за одну побудову декілька файлових операцій.  
- Поле `filePath` вказує як на тип операції, так і на доступ до зчитування директорії. При комбінації фільтрів з управлінням доступом до зчитування директорій покращується селективність вибірки файлів.  

[Повернутись до змісту](../README.md#tutorials)