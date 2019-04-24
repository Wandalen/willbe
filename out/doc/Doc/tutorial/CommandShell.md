# Command <code>.shell</code>

A command to call external application by utility <code>willbe</code> for chosen modules or submodules.

Для роботи з модулем доводиться використовувати сторонні інструменти - командну оболонку операційної системи чи зовнішні програми. Наприклад, вивести список файлів після побудови, запустити створений файл... Якщо працюєте з готовим модулем, то вносити зміни в `will-файл` незручно тому, є команда `.shell`, яка дозволяє виконувати команди сторонніх програм в терміналі операційної системи разом з іншими командами утиліти.  

### Використання команди
Команда `.shell` може використовуватись окремо в вигляді `will .shell [command]`, де `[command]` - команда операційної системи чи сторонньої програми. При такому способі різниця між запуском команди самостійно і разом з `will .shell` мінімальна. Для ефективного використання команди `.shell` застосовуйте її разом з командою `.each`, котра виконує команди як над групою `will-файлів`, так і над окремими ресурсами модуля.  
Побудуйте модуль згідно представленої структури:  

<details>
  <summary><u>Структура модуля</u></summary>

```
shellCommand
    ├── module.test
    │        ├── one.will.yml
    │        └── two.will.yml
    │
    └── .will.yml       

```

</details>

В файл `.will.yml`, `one.will.yml` та `two.will.yml` внесіть код:

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

Запустіть побудову:

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
    │
    └── .will.yml       

```

</details>

З командою `.shell` можна виконати будь-які зовнішні операції над модулем. Для прикладу, виведіть повну інформацію про `will-файли` підмодулів. Для цього використовуйте команду `.each`:  

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

Підмодулі `Tools` i `PathFundamentals` завантажені з Git-репозиторію. Для них можна виконувати git-команди. Наприклад, дізнайтесь статус підмодулів командою `git status`:

<details>
  <summary><u>Вивід команди <code>will .each submodule::*s .shell git status</code></u></summary>

```
[user@user ~]$ will .each submodule::*s .shell git status
...
Module at /path_to_file/.module/Tools/out/wTools.out.will.yml
 > git status
На ветке master
Ваша ветка обновлена в соответствии с «origin/master».
нечего коммитить, нет изменений в рабочем каталоге

Module at /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
 > git status
На ветке master
Ваша ветка обновлена в соответствии с «origin/master».
нечего коммитить, нет изменений в рабочем каталоге     

```

</details>

При роботі з окремими `will-файлами` утиліта додатково виводить інформацію, про те, які файли зчитано. Перевірте список файлів в директорії `module.test`:  

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

Команда зчитала і вивела дані відносно окремих модулів в директорії.

### Підсумок  
- Команда `.shell` виконує дії над файлами модуля.  
- Команда `.shell` ефективна в комбінації з командою `.each` - запускає операції в командній оболонці системи для підмодулів `will-файла`, а також, для модулів в указаній директорії.

[Повернутись до змісту](../README.md#tutorials)
