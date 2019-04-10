# Команда `.with` та іменований `will-файл`

Як використовувати команду `.with`? Що таке іменований `will-файл`?

["Розділені `will-файли`"](SplitWillFile.md) дозволяють розділити `will-файл` на декілька окремих файлів описуючи один модуль, а у розробника може виникнути потреба помістити `will-файли` декількох модулів в одній директорії - в цьому випадку зручно застосувати іменовані  `will`-файли.  
Іменований `will-файл` - вид `will-файла`, що має не стандартне ім'я файлу, тобто, починається з буквенних або числових символів. В директорії одночасно може знаходитись один неіменований `will-файл` та необмежена кількість іменованих, саме тому, `willbe` потребує вводу назви файла для виконання команди.  
Для того, щоб `willbe` обробив операцію з іменованим файлом потрібно використовувати команду `.with`. Повний синтаксис цієї команди `will .with [file_name] [command] [argument]`, де `[file_name]` - назва іменованого файла; `[command]` - комнада для іменованого файла; `[argument]` - аргумент команди, якщо він необхідний.   
Створіть в новій директорії один іменований для завантаження підмодулів (`submodule.will.yml`) та один неіменований файл (`.will.yml`) для видалення завантаженого підмодуля.  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : deleteSubmodule
  description : "To test named will-files"

path :

  fileToDelete :
      path : './.module/PathFundamentals'

step  :

  delete.submodule :
      inherit : predefined.delete
      filePath : path::fileToDelete*


build :

  delete.submodule :
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

    name : namedWillFile
    description : "To test named will-files"
    version : 0.0.1

submodule :

    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

build :

    download :        
      steps :
        - submodules.download
      criterion :
        default : 1

    nodefault :     
      steps :
        - submodules.download

```

</details>

Після виконання вказаних дій директорія повинна мати вигляд:  

```
.
├── submodule.will.yml
├── .will.yml

```

Завантажимо підмодулі за дефолтною збіркою (`will .with submodule .build`):

```
[user@user ~]$ will .with submodule .build
...
  Building download
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 3.710s
     + 1/1 submodule(s) of module::namedWillFile were downloaded in 3.720s
   Built download in 3.765s

```

Команда `.with` працює і з неіменованими файлами. Для цього треба ввести повну назву неіменованого файла `will .with .will.yml .build` або замість імені вказати поточну директорію `.` - `will .with . .build`:  

```
[user@user ~]$ will .with . .build
...
  Building delete.submodule
   - filesDelete 92 files at /path_to_file/.module/PathFundamentals in 0.361s
  Built delete.submodule in 0.449s

```
Проте, робота зі скороченою формою запису більш комфортна - `will .build`.  
Виконаємо завантаження підмодулів командою з аргументом:

```
[user@user ~]$ will .with submodule .build nodefault
...
  Building download
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 3.710s
     + 1/1 submodule(s) of module::namedWillFile were downloaded in 3.840s
    Built nodefault in 3.885s

```

Ще одна особливість використання утилітою `will-файлів` полягає в тому, що `willbe` зчитує закінчення `.will.[розширення]` як повне розширення, що слугує захистом від випадкових дій зі сторонніми файлами. Скажімо, якщо ви перейменуєте `submodule.will.yml` в `submodule.yml`, то запуск `will .with submodule .build` не знайде потрібний файл:

```
[user@user ~]$ will .with submodule .build
...
Found no will-file at "/path_to_file/submodule"           
Unhandled error caught by Consequence
... (error message)

```

Щоб виправити помилку вказуйте повну назву файла `submodule.yml` або використовуйте ґлоби.  
Порада. Якщо потрібно вказати унікальну назву файла або єдиний аргумент команди в консолі операційної системи, використовуйте ґлоби. Наприклад, фраза яка виконає збірку `nodefault`: `will .with s* .build n*`.

### Підсумок  
- Іменовані `will`-файли - удосконалений інструмент побудови модульної системи, що здатен керувати окремими модулями в системі будь-якої складності.

[Наступний туторіал](UsingEachCommand.md)  
[Повернутись до змісту](../README.md#tutorials)
