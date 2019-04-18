# Command <code>.set</code>

How to use command <code>.set</code> to change state of the utility, for example to change level of verbosity.

Працюючи з програмним забезпеченням розробники ставлять перед ним вимоги, які базуються на досвіді та конкретній задачі. При цьому налаштування програми за замовчуванням не завжди влаштовують ці вимоги.  
Утиліта `willbe` призначена для побудови модульних систем, а взаємодія з нею здійснюється через командний рядок системи. До цього моменту ви бачили ввід в консолі та результат, а внутрішні процеси були приховані. З командою `.set` можливо прослідкувати і за ними.  
`Willbe` може встановити параметр `verbosity`, який відповідає за вивід сервісної інформації виконання команди. Для використання введіть `will .set verbosity:[n] ; [command] [argument]` (в деяких bash-терміналах з лапками - `will ".set verbosity:[n] ; [command] [argument]"`), де `verbosity` - відповідно, деталізація логу; `[n]` - число від 0 до 8 яке встановлює ступінь деталізації, 8 - найвищий ступінь; `[command]` - команда для якої виводиться лог; `[argument]` - аргумент команди, якщо він необхідний.  
Створіть наступну конфігурацію файлів для дослідження параметру `verbosity`:  

<details>
  <summary><u>Структура модуля</u></summary>

```
setCommand
     └── .will.yml

```

</details>

Помістіть в файл `.will.yml` код:  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : setVerbosity
  description : "To use .set command"
  version : 0.0.1

submodule :
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

path :

  out : 'out'
  submodule.pathfundamental :
    criterion :
      debug : 1
    path : '.module/PathFundamentals'

step  :

  export.submodule :
    criterion :
      debug : 1
    export : path::submodule.*

build :

  submodules.download :
    criterion :
      default : 1
    steps :
      - submodules.download

  submodules.export :
    criterion :
      export : 1
      default : 1
    steps :
      - export.*

```

</details>

Запустіть побудову завантаження підмодулів з найвищим рівнем вербальності (`will .set verbosity:8 ; .build`):

<details>
    <summary><u>Вивід команди <code>will .set verbosity:8 ; .build</code></u></summary>

```
[user@user ~]$ will ".set verbosity:8 ; .build"
Command ".set ; .build"
 s module::/path_to_module/UsingSetCommand preformed 1
 s module::/path_to_module/UsingSetCommand preformed 2
 s module::/path_to_module/UsingSetCommand preformed 3
 s module::/path_to_module/UsingSetCommand willFilesFound 1
 s module::/path_to_module/UsingSetCommand willFilesFound 2
Trying to open /path_to_module/UsingSetCommand.will
Trying to open /path_to_module/UsingSetCommand.im.will
Trying to open /path_to_module/UsingSetCommand.ex.will
Trying to open /path_to_module/UsingSetCommand/.will
Trying to open /path_to_module/UsingSetCommand/.im.will
Trying to open /path_to_module/UsingSetCommand/.ex.will
 s module::/path_to_module/UsingSetCommand willFilesFound 3
 s module::/path_to_module/UsingSetCommand willFilesOpened 1
 s module::/path_to_module/UsingSetCommand willFilesOpened 2
   . Read : /path_to_module/UsingSetCommand/.will.yml
 . Read 1 will-files in 0.081s
 s module::setVerbosity willFilesOpened 3
 s module::setVerbosity submodulesFormed 1
 s module::setVerbosity submodulesFormed 2
 s module::PathFundamentals preformed 1
 s module::PathFundamentals preformed 2
 s module::PathFundamentals preformed 3
 s module::PathFundamentals willFilesFound 1
 s module::PathFundamentals willFilesFound 2
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.im.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.ex.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals/.out.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals/.out.im.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals/.out.ex.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.im.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.ex.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals/.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals/.im.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals/.ex.will
 !s module::PathFundamentals willFilesFound failed
 s module::PathFundamentals willFilesOpened 1
 !s module::PathFundamentals willFilesOpened failed
 s module::PathFundamentals submodulesFormed 1
 !s module::PathFundamentals 3 failed
 s module::PathFundamentals resourcesFormed 1
 !s module::PathFundamentals resourcesFormed failed
 s module::setVerbosity resourcesFormed 1
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
Failed to open submodule::PathFundamentals at "/path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals"
Found no .out.will file for module::setVerbosity at "/path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals"             
 s module::setVerbosity submodulesFormed 3
 s module::setVerbosity resourcesFormed 2
 s module::setVerbosity resourcesFormed 3

  Building submodules.download
     - filesDelete 1 files at /path_to_module/UsingSetCommand/.module/PathFundamentals in 0.017s
 > git clone https://github.com/Wandalen/wPathFundamentals.git/ .
Клонирование в «.»…
 > git checkout master
Уже на «master»
Ваша ветка обновлена в соответствии с «origin/master».
 > git merge
Уже обновлено.
     + Reflect 92 files /path_to_module/UsingSetCommand/.module/PathFundamentals <- git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master in 3.612s
 s module::PathFundamentals willFilesFound 1
 s module::PathFundamentals willFilesFound 2
    Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.will
    Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.im.will
    Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.ex.will
 s module::PathFundamentals willFilesFound 3
 s module::PathFundamentals willFilesOpened 1
 s module::PathFundamentals willFilesOpened 2
     . Read : /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
 s module::PathFundamentals willFilesOpened 3
 s module::PathFundamentals submodulesFormed 1
 s module::PathFundamentals submodulesFormed 2
 s module::PathFundamentals submodulesFormed 3
 s module::PathFundamentals resourcesFormed 1
 s module::PathFundamentals resourcesFormed 2
 s module::PathFundamentals resourcesFormed 3
     + module::PathFundamentals was downloaded in 4.276s
   + 1/1 submodule(s) of module::setVerbosity were downloaded in 4.282s
  Built submodules.download in 4.326s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
setCommand
     ├── .module
     └── .will.yml

```

</details>

Експортуйте модуль зі значенням `verbosity:4`:

<details>
    <summary><u>Вивід команди <code>will .set verbosity:4 ; .export</code></u></summary>

```
[user@user ~]$ will .set verbosity:4 ; .export
Command ".set ; .export"
Trying to open /path_to_module/UsingSetCommand.will
Trying to open /path_to_module/UsingSetCommand.im.will
Trying to open /path_to_module/UsingSetCommand.ex.will
Trying to open /path_to_module/UsingSetCommand/.will
Trying to open /path_to_module/UsingSetCommand/.im.will
Trying to open /path_to_module/UsingSetCommand/.ex.will
   . Read : /path_to_module/UsingSetCommand/.will.yml
 . Read 1 will-files in 0.104s
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.im.will
Trying to open /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.ex.will
 . Read : /path_to_module/UsingSetCommand/.module/PathFundamentals/out/wPathFundamentals.out.will.yml

  Exporting submodules.export
     . Read : /path_to_module/UsingSetCommand/out/setVerbosity.out.will.yml
   . Read 1 will-files in 0.195s
   + Write out archive /path_to_module/UsingSetCommand/ : out/setVerbosity.out.tgs <- .module/PathFundamentals
   + Write out will-file /path_to_module/UsingSetCommand/out/setVerbosity.out.will.yml
   + Exported submodules.export with 46 files in 2.423s
  Exported submodules.export in 2.467s

```

</details>
<details>
  <summary><u>Структура модуля після експорту</u></summary>

```
setCommand
     ├── out
     ├── .module
     └── .will.yml

```

</details>

Видаліть підмодулі (`will .submodules.clean`) та завантажте з встановленим `verbosity:0`:

<details>
    <summary><u>Вивід команди <code>will .set verbosity:0 ; .build</code></u></summary>

```
[user@user ~]$ will .set verbosity:0 ; .build
Command ".set ; .build"
 . Read 1 will-files in 0.082s

```

</details>
<details>
  <summary><u>Структура модуля після вводу <code>will .submodules.clean</code></u></summary>

```
setCommand
     ├── out
     └── .will.yml

```

</details>
<details>
  <summary><u>Структура модуля після вводу <code>will .set verbosity:0 ; .build</code></u></summary>

```
setCommand
     ├── out
     ├── .module
     └── .will.yml

```

</details>

### Підсумок
- Параметр `verbosity` встановлює рівень вербальності команди - кількість виводу сервісної інформації про виконання команди. Найвищий рівень вербальності - "8", а найнижчий - "0".
- Встановлення параметра `verbosity` корисне при відладці модулів.
  
[Повернутись до змісту](../README.md#tutorials)
