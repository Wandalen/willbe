# Як користуватись командою <code>.shell</code>

Команда для виклику зовнішніх програм утилітою <code>willbe</code> для вибраних модулів.

Для роботи з модулем доводиться використовувати сторонні інструменти. Наприклад, вивести список файлів після побудови, запустити створений файл... Ці операції здійснюються з використанням операційної системи. `Willbe` має вбудований крок `shell.run` для використання консолі, та користування ним може бути ускладненим. Тому, утиліта має [команду `.shell`](../concept/Command.md#Таблиця-команд-утиліти-willbe), яка дозволяє виконувати команди в консолі по відношенню до модуля.  

### Використання команди

Команда `.shell` може використовуватись окремо, в вигляді `will .shell [command]`, де `[command]` - деяка команда операційної системи чи сторонньої програми. При такому способі різниця між запуском команди самостійно і разом з `will .shell` мінімальна.  

Для ефективного використання команди `.shell` застосовуйте її разом з командою `.each`. В комбінації з командою `.each` зовнішня команда буде виконана над групою `вілфайлів` в одній директорії або над окремими підмодулями поточного модуля. 

### Конфігурація модуля

<details>
  <summary><u>Структура модуля</u></summary>

```
shellCommand
    ├── module.test
    │        ├── one.ex.will.yml
    │        ├── one.im.will.yml
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

Помістіть в файл `.will.yml` приведений вище код.

Модуль складається з двох віддалених підмодулів і одного локального. Приведена збірка `download` виконує завантаження віддалених підмодулів `Tools`, `PathFundamentals`. 

<details>
  <summary><u>Код файлів <code>one.ex.will.yml</code>, <code>one.im.will.yml</code> і <code>two.will.yml</code></u></summary>

```yaml
about :

  name : noWorkedFile
  description : "Only example of will-file"

```

</details>

Внесіть в файли `one.ex.will.yml`, `one.im.will.yml` та `two.will.yml` приведений вище код. Для дослідження команди достатньо, щоб в указаних файлах була поміщена довідкова інформація.

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

Перед початком дослідження команди `.shell` завантажте віддалені підмодулі запустивши команду `will .build`. 

<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
shellCommand
    ├── .module
    │      ├── Tools
    │      └── PathFundamentals
    ├── module.test
    │        ├── one.ex.will.yml
    │        ├── one.im.will.yml
    │        └── two.will.yml
    └── .will.yml       

```

</details>

Після побудови в директорії `.module` завантажено два підмодуля.

<details>
  <summary><u>Вивід команди <code>will .each submodule::* .shell ls -al</code></u></summary>

```
[user@user ~]$ will .each submodule::* .shell ls -al
...
Module at /path_to_file/.module/Tools/out/wTools.out
 > ls -al
total 32
drwxr-xr-x 2 user user  4096 May 30 19:48 .
drwxr-xr-x 8 user user  4096 May 30 19:48 ..
-rw-r--r-- 1 user user 21642 May 30 19:48 wTools.out.will.yml

Module at /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out
 > ls -al
total 20
drwxr-xr-x 3 user user 4096 May 30 19:48 .
drwxr-xr-x 6 user user 4096 May 30 19:48 ..
drwxr-xr-x 3 user user 4096 May 30 19:48 debug
-rw-r--r-- 1 user user 7762 May 30 19:48 wPathFundamentals.out.will.yml

Module at /path_to_file/module.test/one
 > ls -al
total 16
drwxr-xr-x 2 user user 4096 May 30 19:45 .
drwxr-xr-x 4 user user 4096 May 30 19:47 ..
-rw-r--r-- 1 user user   88 Apr  3 09:29 one.ex.will.yml
-rw-r--r-- 1 user user   88 Apr  3 09:29 one.im.will.yml
-rw-r--r-- 1 user user   88 Apr  3 09:29 two.will.yml

```

</details>

З командою `.shell` можна виконати будь-які зовнішні операції над модулем. Для прикладу, виведіть інформацію про вміст директорій, в яких поміщені `вілфайли` підмодулів. Для цього використовуйте команду `.will .each submodule::* .shell ls -al`. 

Утиліта виконала команду `ls -al` для кожного з підмодулів. В директорії підмодуля `Tools` є два файла та директорія `debug`, в директорії підмодуля `PathFundamentals` один файл та одна директорія `debug`, а в директорії локального підмодуля `One` знаходяться три `вілфайла`.  

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

Утиліта перевірила статус підмодулів `Tools` i `PathFundamentals` тому, що їх назви закінчуються на `s` (селектор `submodule::*s`). В указаних модулях ніяких змін не було - `On branch master`, `nothing to commit, working tree clean`.

<details>
  <summary><u>Вивід команди <code>will .each module.test .shell ls</code></u></summary>

```
[user@user ~]$ will .each module.test .shell ls
...
Module at /path_to_file/module.test/one
 . Read : /path_to_file/module.test/one.im.will.yml
 . Read : /path_to_file/module.test/one.ex.will.yml
 . Read 2 willfiles in 0.218s 

 > ls
one.ex.will.yml
one.im.will.yml
two.will.yml

Module at /path_to_file/module.test/two
 . Read : /path_to_file/module.test/two.will.yml
 . Read 1 willfiles in 0.141s 

 > ls
one.ex.will.yml
one.im.will.yml
two.will.yml

```

</details>  

Якщо команда виконується по відношенню до файлів в директорії, то утиліта виводить інформацію, про те, які файли зчитано. Перевірте список файлів в директорії `module.test` командою `will .each module.test .shell ls`. 

Вивід показує, що перед виконанням команди утиліта зчитує інформацію з окремого модуля `Module at /path_to_file/module.test/one`. Модуль `one` розділений між двома файлами, тому утиліта по черзі їх зчитала - `Read : /path_to_file/module.test/one.im.will.yml` i ` Read : /path_to_file/module.test/one.ex.will.yml`. Модуль `two` складається з одного файла `two.will.yml`.

Команда `ls` видала однаковий результат так, як файли розташовані в одній директорії.

### Підсумок  

- Команда `.shell` виконує дії над файлами модуля.  
- Команда `.shell` ефективна в комбінації з командою `.each`. 
- Разом з командою `.each` команда `.shell` може запустити зовнішню команду для підмодулів `вілфайла`.
- Разом з командою `.each` команда `.shell` може запустити зовнішню команду для модулів в указаній директорії.

[Повернутись до змісту](../README.md#tutorials)
