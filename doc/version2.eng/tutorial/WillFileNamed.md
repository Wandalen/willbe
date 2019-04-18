# Command <code>.with</code> and named <code>will-file</code>

How to use command <code>.with</code>? What is named <code>will-file</code>?

[Розділені `will-файли`](WillFileSplit.md) складаються з двох `will-файлів` і описують один модуль, а у розробника може виникнути потреба помістити `will-файли` декількох модулів в одній директорії - для цього використовуються іменовані  `will-файли`.  
Іменований `will-файл` - вид `will-файла`, що має не стандартне ім'я файлу, тобто, починається з буквенних або числових символів. В директорії одночасно може знаходитись один неіменований `will-файл` та необмежена кількість іменованих.   
Для того, щоб `willbe` виконав операцію з іменованим `will-файлом` використовується команда `.with`. Повний синтаксис цієї команди `will .with [file_name] [command] [argument]`, де `[file_name]` - назва `will-файла`; `[command]` - комнада для іменованого файла; `[argument]` - аргумент команди, якщо він необхідний.   

### Використання іменованих `will-файлів`
Створіть директорію `named` з наступною конфігурацією:  

<details>
  <summary><u>Структура файлів</u></summary>

```
named 
  ├── proto
  │     └── file.txt
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>

Скопіюйте код в кожен з файлів:  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : deleteOut
  description : "To test named will-files"

path :

  fileToDelete :
    path : 'out'

step  :

  delete.out :
    inherit : predefined.delete
    filePath : path::fileToDelete

build :

  delete.out :
    criterion :
      default : 1
    steps :
      - delete.*

```

</details>
<details>
    <summary><u>Код <code>submodule.will.yml</code></u></summary>

```yaml
about :

  name : submodules
  description : "To test named will-files"
  version : 0.0.1

submodule :

  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

</details>
<details>
    <summary><u>Код <code>export.will.yml</code></u></summary>

```yaml
about :

  name : export
  description : "To test named will-files"
  version : 0.0.1

path : 

  out : 'out'
  proto : 'proto'
  
step : 

  export : 
    inherit : predefined.export
    export : path::proto
  
build : 

  export : 
    criterion : 
      export : 1
    steps :
      - step::export
      
```

</details>

Завантажте підмодулі використовуючи файл `submodule.will.yml`:  

<details>
  <summary><u>Вивід команди <code>will .with submodule .submodules.download</code></u></summary>

```
[user@user ~]$ will .with submodule .submodules.download
...
 . Read : /path_to_file/submodule.will.yml
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even .clean it before downloading
 . Read 1 will-files in 1.152s 

   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version master was downloaded in 4.748s
 + 1/1 submodule(s) of module::submodules were downloaded in 4.756s

```

</details>
<details>
  <summary><u>Структура файлів після завантаження підмодулів</u></summary>

```
named 
  ├── .module
  │     └── PathFundamentals
  ├── proto
  │     └── file.txt
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>

Виконайте експорт з допомогою файла `export.will.yml`:  

<details>
  <summary><u>Вивід команди <code>will .with export.will.yml .export export</code></u></summary>

```
[user@user ~]$ will .with export.will.yml .export export
...
  Exporting module::export / build::export
   + Write out archive /path_to_file/ : out/export.out.tgs <- proto
   + Write out will-file /path_to_file/out/export.out.will.yml
   + Exported export with 2 files in 2.762s
  Exported module::export / build::export in 2.819s

```

</details>
<details>
  <summary><u>Структура файлів після експорту модуля</u></summary>

```
named 
  ├── .module
  │     └── PathFundamentals
  ├── out
  │    ├── export.out.tgs
  │    └── export.out.will.yml
  ├── proto
  │     └── file.txt
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>

Видаліть директорію `out` запустивши збірку побудови за замовчуванням з неіменованого `will-файла`:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::deleteOut / build::delete.submodule
   - filesDelete 3 files at /path_to_file/out in 0.034s
  Built module::deleteOut / build::delete.submodule in 0.159s

```

</details>
<details>
  <summary><u>Структура файлів після видалення <code>out</code>-директорії</u></summary>

```
named 
  ├── .module
  │     └── PathFundamentals
  ├── proto
  │     └── file.txt
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>

Робота з іменованими `will-файлами` відрізняється від неіменованих використанням команди `.with`, її аргументом може бути як повна назва файла, так і назва до розширення `.will.yml`.  
Також, команда `.with` працює з неіменованими файлами. Для цього треба ввести повну назву неіменованого файла `will .with .will.yml .build` або замість імені вказати поточну директорію `.` - `will .with . .build`, але скорочена форма запису простіша - `will .build`.  

### Підсумок  
- Іменовані `will-файли` - удосконалений інструмент побудови модульної системи.  
- В одній директорії може бути поміщено необмежена кількість іменованих `will-файлів`.
- Для роботи з іменованими `will-файлами` використовується команда `.with`.  

[Наступний туторіал](CommandEach.md)  
[Повернутись до змісту](../README.md#tutorials)
