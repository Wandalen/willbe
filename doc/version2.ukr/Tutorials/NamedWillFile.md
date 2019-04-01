# Іменовані `will-файли`. Команда `.with`  

Дається поняття іменованих `will-файлів` та показано як користуватись командою `.with`

В туторіалі [Розділені will-файли (Split will-files)](SplitWillFile.md) зазначено, що `will`-файл можна розділити на декілька окремих файлів, але програма зчитує їх дані як в одному. При одночасній реалізації декількох модулів ці файли стануть менш зручними в використанні тому, якщо виникає потреба в розташуванні декількох модульних систем в одній директорії зручно застосувати іменовані  `will`-файли.  

Іменований `will`-файл - вид конфігураційного файлу, назва якого починається з буквенних або цифрових символів (імені). Кількість іменованих `will-файлів` в одній директорії необмежена саме тому, `willbe` потребує вводу назви файла для виконання команди.  
Для того, щоб `willbe` обробив операцію з іменованим файлом потрібно використовувати команду `.with`. Повний синтаксис цієї команди `will .with [file_name] [command] [argument]`, де `[file_name]` - назва іменованого файла; `[command]` - комнада для іменованого файла; `[argument]` - аргумент команди, якщо він необхідний.   
Створимо в новій директорії один іменований для завантаження підмодулів (_submodule.will.yml_) та один неіменований файл (_.will.yml_) для видалення завантаженого підмодуля.  

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

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
    <summary><u><em>Лістинг `submodule.will.yml`</em></u></summary>

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
_Порада. Якщо потрібно вказати унікальну назву файла або єдиний аргумент команди в консолі операційної системи, використовуйте ґлоби. Наприклад, фраза яка виконає збірку `nodefault`: `will .with s* .build n*`._

- Іменовані `will`-файли - удосконалений інструмент побудови модульної системи, що здатен керувати окремими модулями в системі будь-якої складності.

[Наступний туторіал](UsingEachCommand.md)  
[Повернутись до змісту](../README.md#tutorials)
