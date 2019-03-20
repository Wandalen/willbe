# Управління вибіркою файлів і директорій в рефлекторі

В туторіалі показано як з допомогою рефлекторів можна управляти шляхами і файлами  

Крім порівняння властивостей файлів з заданими в фільтрах рефлектори здатні управляти файловою адресацією та істинністю ресурсів. Для цього в рефлекторах передбачені поля `filePath` та `prefixPath`.  
Поле `filePath` - шлях до файлів для вибірки. Може бути самостійним полем або вказуєтись як ресурс поля `src` i `dst`. Керує доступом до окремих елементів масиву файлів та директорій вказаних в ньому.   
Поле `prefixPath` - відносний шлях, який додається до шляху `filePath`.  

### Початкова конфігурація  
Створіть структуру файлів як на рисунку:

```
.
├── proto
│     └── proto.two
│           └── proto.js
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


