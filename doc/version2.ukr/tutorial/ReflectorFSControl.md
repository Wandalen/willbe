# Формування шляхів в рефлекторі. Управління файлами

Як формуються шляхи рефлекторів та як управляти файлами і директоріями в рефлекторі

Крім порівняння властивостей файлів з заданими в фільтрах, рефлектори здатні управляти файловою адресацією та окремими директоріями вибірки. Для цього в рефлекторах передбачені поля `filePath`, `basePath` та `prefixPath`.  
Поле `filePath` - шлях до файлів вибірки, вказується в рефлекторі як самостійне поле або як ресурс поля `src` i `dst`. Керує доступом до окремих директорій вказаних в ньому. Поле `basePath` - вказує базову, початкову директорію, зазвичай, кореневу - `.`. Поле `prefixPath` - відносний шлях, який додається до шляху `filePath` і `basePath`.  

### Початкова конфігурація  
Створіть структуру файлів:  

<details>
  <summary><u>Структура модуля</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.js
     ├── files
     │     └── files.js
     └── .will.yml        

```

</details>

### Використання полів `filePath` i `prefixPath`  
Створіть `will-файл`, рефлектор якого буде копіювати файл з директорії `proto/proto.two` в диреторію `files/files.two`:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : reflectorPaths
  description : "To use reflector path constructor"
  version : 0.0.1

reflector :

  reflect.copy :
    recursive : 2
    src :
      filePath : proto.two
      prefixPath : proto
    dst :
      basePath : .
      prefixPath : files/files.two

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

Поля `filePath` i `prefixPath` використовуються як самостійно i починають відлік від кореневого каталога `will-файла` або від базового. Кожен шлях в рефлекторі `will-файла` складається двох частин - `prefixPath + filePath` або `prefixPath + basePath`.    
Запустіть побудову:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
 Building module::reflectorPaths / build::copy
   + reflect.copy reflected 2 files /path_to_file/ : files/files.two <- proto/proto.two in 0.807s
  Built module::reflectorPaths / build::copy in 0.889s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.js
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     └── files.js
     └── .will.yml       

```

</details>

Префікси зручно виносити при великій довжині шляху - файл стає зручним для зчитування.  

### Керування ресурсами в рефлекторі  
Для збільшення кількості операцій можна додати кроки в сценарій побудови, що збільшить об'єм `will-файла` за рахунок дублювання інформації в ресурсах. Тому, краще використовувати поля рефлекторів, які дозволяють створити декілька потоків файлів. Для створення множинних файлових операцій в рефлекторі використовується поле `filePath`.  
Замініть вміст `will-файла` приведеним нижче, щоб провести дві операції копіювання - з директорії `files` в директорію `out1`, з директорії `proto` в `out2`:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : reflectorPaths
  description : "To use reflector path constructor"
  version : 0.0.1

reflector :

  reflect.copy :
    filePath :
      files : out1
      proto : out2

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

Зручна форма запису, яка дозволяє виконувати одночасно декілька операцій копіювання за різними шляхами.  
Запустіть побудову модуля та перевірте вміст кореневої директорії:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 7 files /path_to_file/ : . <- . in 0.533s
  Built module::reflectorPaths / build::copy in 0.596s


```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.js
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     └── files.js
     ├── out1
     │     ├── files.two
     │     │      └── proto.js
     │     └── files.js
     ├── out2
     │     └── proto.two
     │            └── proto.js
     └── .will.yml       

```

</details>

Видаліть каталоги `out1` i `out2` (`rm -Rf out1/ out2/`). Змініть рефлектор в `will-файлі` для копіювання файлів з двох джерел в одну директорію:  

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath:
        files/files.two : 1
        proto : 1
    dst:
      filePath: out

```

</details>

Запис відрізняється тим, що вказуючи значення `0` або (`false`) і `1` або (`true`) здійснюється управління директоріями (файлами), які буде скопійовано. Щоб перевірити роботу рефлектора, запустіть побудову і перевірте вміст згенерованої директорії `out`:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 5 files /path_to_file/ : out <- . in 0.617s
   + reflect.copy. reflected 5 files /path_to_file/ : out <- . in 0.352s
  Built module::reflectorPaths / build::copy in 1.068s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.js
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     └── files.js
     ├── out
     │     ├── proto.two
     │     │      └── proto.js
     │     └── proto.js
     └── .will.yml       

```

</details>

Вимкніть копіювання з директорії `proto`, змінивши рефлектор до вигляду:  

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath:
        files/files.two : 1
        proto : false
    dst:
      filePath: out

```

</details>

Видаліть директорію `out` (`rm -Rf out/`) та запустіть побудову:  



```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 2 files /path_to_file/ : out <- files/files.two in 0.400s
   + reflect.copy. reflected 2 files /path_to_file/ : out <- files/files.two in 0.330s
  Built module::reflectorPaths / build::copy in 0.832s


```

```
[user@user ~]$ ls -a out4/
.  ..  proto.js

```

Файли з директорії `proto` не скопіювались.  
Комбінюючи управління директоріями і налаштуванням фільтрів розширюються можливості рефлекторів по вибірці файлів.  

### Підсумок
- Шлях рефлектора складається з частин. Їх можна використовувати самостійно або комбінувати.  
- Рефлектори можуть виконувати за одну побудову декілька файлових операцій.  
- Поле `filePath` вказує як на тип операції, так і на доступ до зчитування директорії. При комбінації фільтрів з управлінням доступом до зчитування директорій покращується селективність вибірки файлів.  

[Повернутись до змісту](../README.md#tutorials)
