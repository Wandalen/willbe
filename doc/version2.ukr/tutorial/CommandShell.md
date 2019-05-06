# Як користуватись командою <code>.shell</code>

Команда для виклику зовнішніх програм утилітою <code>willbe</code> для вибраних модулів.

Для роботи з модулем доводиться використовувати сторонні інструменти. Наприклад, вивести список файлів після побудови, запустити створений файл... Ці операції здійснюються з використанням операційної системи. `Willbe` має вбудований крок `predefined.shell` для використання консолі, та користуватись ними може бути ускладненим. Тому, утиліта має [команду `.shell`](../concept/Command.md#Таблиця-команд-утиліти-willbe), яка дозволяє виконувати команди в консолі по відношенню до модуля.  

### Використання команди

Команда `.shell` може використовуватись окремо, в вигляді `will .shell [command]`, де `[command]` - деяка команда операційної системи чи сторонньої програми. При такому способі різниця між запуском команди самостійно і разом з `will .shell` мінімальна.  
Для ефективного використання команди `.shell` застосовуйте її разом з командою `.each`. Команда `.each` виконує виконує вказану команду над групою `вілфайлів` в одній директорії або над окремими підмодулями поточного модуля. 

### Конфігурація модуля

<details>
  <summary><u>Структура модуля</u></summary>

```
shellCommand
    ├── module.test
    │        ├── one.will.yml
    │        └── two.will.yml
    └── .will.yml       

```

</details>

Побудуйте модуль згідно представленої структури.

<details>
  <summary><u>Код <code>.will.yml</code></u></summary>

```yaml
about :

  name : shellCommand
  description : "To use .shell command"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  One : module.test/one

build :

  download :
    criterion :
      default : 1
    steps :
      - submodules.download

```

</details>
<details>
  <summary><u>Код файлів <code>one.will.yml</code> і <code>two.will.yml</code></u></summary>

```yaml
about :

  name : noWorkedFile
  description : "Only example of will-file"

```

</details>

Внесіть в файли `.will.yml`, `one.will.yml` та `two.will.yml` приведений вище код.

### Використання команди `.shell`

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::shellCommand / build::download
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 12.011s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals version master was downloaded in 4.239s
   + 2/4 submodule(s) of module::shellCommand were downloaded in 16.262s
  Built module::shellCommand / build::download in 16.313s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
shellCommand
    ├── .module
    │      ├── Tools
    │      └── PathFundamentals
    ├── module.test
    │        ├── one.will.yml
    │        └── two.will.yml
    └── .will.yml       

```

</details>

Перед початком дослідження команди `.shell` завантажте віддалені підмодулі запустивши команду `will .build`. 

<details>
  <summary><u>Вивід команди <code>will .each submodule::* .shell ls -al</code></u></summary>

```
[user@user ~]$ will .each submodule::* .shell ls -al
...
Module at /path_to_file/.module/Tools/out/wTools.out.will.yml
> ls -al
total 232
drwxr-xr-x 3 user user   4096 Apr 17 11:16 .
drwxr-xr-x 9 user user   4096 Apr 17 11:16 ..
drwxr-xr-x 3 user user   4096 Apr 17 11:16 debug
-rw-r--r-- 1 user user   7526 Apr 17 11:16 wTools.out.will.yml
-rw-r--r-- 1 user user 215828 Apr 17 11:16 wTools.proto.export.out.tgs

Module at /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
> ls -al
total 20
drwxr-xr-x 3 user user 4096 Apr 17 11:16 .
drwxr-xr-x 6 user user 4096 Apr 17 11:16 ..
drwxr-xr-x 3 user user 4096 Apr 17 11:16 debug
-rw-r--r-- 1 user user 5970 Apr 17 11:16 wPathFundamentals.out.will.yml

Module at /path_to_file/module.test/one.will.yml
> ls -al
total 16
drwxr-xr-x 2 user user 4096 Apr  3 10:31 .
drwxr-xr-x 4 user user 4096 Apr 17 11:16 ..
-rw-r--r-- 1 user user   88 Apr  3 09:29 one.will.yml
-rw-r--r-- 1 user user   88 Apr  3 09:29 two.will.yml

```

</details>

З командою `.shell` можна виконати будь-які зовнішні операції над модулем. Для прикладу, виведіть повну інформацію про `вілфайли` підмодулів. Для цього використовуйте команду `.will .each submodule::* .shell ls -al`. 

Утиліта виконала команду `ls -al` для кожного з підмодулів. В директорії підмодуля `Tools` є два файла та директорія `debug`, в директорії підмодуля `PathFundamentals` один файл та одна директорія `debug`, а в директорії локального підмодуля `One` є два файла.  

<details>
  <summary><u>Вивід команди <code>will .each submodule::*s .shell git status</code></u></summary>

```
[user@user ~]$ will .each submodule::*s .shell git status
...
Module at /path_to_file/.module/Tools/out/wTools.out.will.yml
 > git status
On branch master
nothing to commit, working tree clean

Module at /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
 > git status
On branch master
nothing to commit, working tree clean   

```

</details>

Підмодулі `Tools` i `PathFundamentals` завантажені з Git-репозиторію. Для них можна виконувати git-команди. Дізнайтесь статус підмодулів командою `will .each submodule::*s .shell git status`. 

Утиліта перевірила статус підмодулів, та не знайшла змін `On branch master`, `nothing to commit, working tree clean`.

<details>
  <summary><u>Вивід команди <code>will .each module.test .shell ls</code></u></summary>

```
[user@user ~]$ will .each module.test .shell ls
...
Module at /path_to_file/module.test/one.will.yml
 . Read : /path_to_file/module.test/one.will.yml
 . Read 1 will-files in 0.344s

 > ls
one.will.yml
two.will.yml

Module at /path_to_file/module.test/two.will.yml
 . Read : /path_to_file/module.test/two.will.yml
 . Read 1 will-files in 0.265s

 > ls
one.will.yml
two.will.yml

```

</details>  

При роботі з окремими `вілфайлами` утиліта додатково виводить інформацію, про те, які файли зчитано. Перевірте список файлів в директорії `module.test` командою `will .each module.test .shell ls`. 

Отримано два однакових виводи, оскільки, команда зчитала і вивела дані відносно окремих модулів в директорії.

### Підсумок  

- Команда `.shell` виконує дії над файлами модуля.  
- Команда `.shell` ефективна в комбінації з командою `.each`. 
- Разом з командою `.each` команда `.shell` може запустити зовнішню команду для підмодулів `вілфайла` поточного модуля.
- Разом з командою `.each` команда `.shell` може запустити зовнішню команду для модулів в указаній директорії.

[Повернутись до змісту](../README.md#tutorials)
