# Команда <code>.with</code> та іменований <code>вілфайл</code>

Як використовувати команду <code>.with</code>? Що таке іменований <code>вілфайл</code>?

У розробника може виникнути потреба помістити `вілфайли` декількох модулів в одній директорії. Через коллізію імен в директорії одночасно може знаходитись тільки один неіменований або розділений `вілфайл`. Тому, в утиліті `willbe` використовуються іменовані `вілфайли`. 

```
.will.yml                  # Неіменований `вілфайл` 
version1.will.yml          # Іменований `вілфайл` з іменем `version1`
debug.out.will.yml         # Іменований `out-вілфайл` з іменем `debug`

```

Іменований `вілфайл` - вид `вілфайла`, що має не стандартне ім'я файлу, тобто, починається з буквенних або числових символів. В прикладі вище приведені два іменованих файла - `version1.will.yml` i `debug.out.will.yml`.

Для того, щоб `willbe` виколнала операцію з іменованим `вілфайлом` використовується команда `.with`. Повний синтаксис цієї команди `will .with [file_name] [command] [argument]`, де `[file_name]` - назва `вілфайла`; `[command]` - комнада для іменованого файла; `[argument]` - аргумент команди, якщо він необхідний.   

### Модуль з іменованим `вілфайлом`  

<details>
  <summary><u>Файлова структура</u></summary>

```
named 
  ├── proto
  │     └── file.txt
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>

Для дослідження іменованих `вілфайлів` створіть директорію `named` з приведеною вище конфігурацією. Скопіюйте вказаний нижче код в відповідні файли.

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
    inherit : files.delete
    filePath : path::fileToDelete

build :

  delete.out :
    criterion :
      default : 1
    steps :
      - delete.*

```

</details>

Файл `.will.yml` призначений для видалення файлів з директорії `out`. Для видалення використовується вбудований крок `files.delete`.

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

В файлі `submodules.will.yml` містяться URI-посилання на віддалений підмодуль `PathFundamentals`. 

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
    inherit : module.export
    export : path::proto
  
build : 

  proto.export : 
    criterion : 
      export : 1
    steps :
      - step::export
      
```

</details>

В файлі `export.will.yml` описується експорт файлів з директорії `proto` з допомогою вбудованого кроку `module.export`.

### Побудова модуля  

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

Завантажте віддалений підмодуль використовуючи файл `submodule.will.yml`. Для цього введіть команду `will .with submodule .submodules.download`.

<details>
  <summary><u>Файлова структура після завантаження підмодулів</u></summary>

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

Виконавши команду, утиліта завантажила підмодуль `PathFundamentals` в директорію `.module` за 4.756s.

<details>
  <summary><u>Вивід команди <code>will .with export.will.yml .export export</code></u></summary>

```
[user@user ~]$ will .with export.will.yml .export proto.export
...
  Exporting module::export / build::proto.export
   + Write out archive /path_to_file/ : out/export.out.tgs <- proto
   + Write out will-file /path_to_file/out/export.out.will.yml
   + Exported export with 2 files in 2.762s
  Exported module::export / build::proto.export in 2.819s

```

</details>

Виконайте експорт з допомогою файла `export.will.yml`. Введіть команду з використанням повного імені файла - `will .with export.will.yml .export proto.export`.

Утиліта успішно експортувала файл з директорії `proto`. Це свідчить про те, що для запуску команди над іменованим `вілфайлом` ви можете використовувати як назву `вілфайла` до розширення, так і повну назву файла. 

<details>
  <summary><u>Файлова структура після експорту модуля</u></summary>

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

Після виконання побудови в структурі модуля з'явилась директорія `out` з файлами експорту.

<details>
  <summary><u>Вивід команди <code>will .with .will.yml .build</code></u></summary>

```
[user@user ~]$ will .with .will.yml .build
...
  Building module::deleteOut / build::delete.submodule
   - filesDelete 3 files at /path_to_file/out in 0.034s
  Built module::deleteOut / build::delete.submodule in 0.159s

```

</details>

Видаліть директорію `out` запустивши збірку побудови за замовчуванням з неіменованого `вілфайла`. Використайте команду `.with` указавши повну назву неіменованого `вілфайла`.   

<details>
  <summary><u>Файлова структура після видалення <code>out</code>-директорії</u></summary>

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

Після побудови збірки директорія `out` була видалена. Тобто, команда `.with` працює з неіменованими файлами. Для використання неіменованого файла аргументом команди `.with` вводиться його повне ім'я. А також, замість імені можна вказати поточну директорію - `will .with . .build`. Проте, скорочена форма запису простіша і зручніша в використанні - `will .build`.  

### Підсумок  

- Іменовані `вілфайли` - удосконалений інструмент побудови модульної системи.  
- В одній директорії може бути поміщено необмежена кількість іменованих `вілфайлів`.
- Для роботи з іменованими `вілфайлами` використовується команда `.with`. 
- Команда `.with` приймає аргументом назву `вілфайла` до першої крапки, або повну назву файла з розширенням.
 
[Повернутись до змісту](../README.md#tutorials)
