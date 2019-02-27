# Створення модуля з використанням критеріонів

Туторіал описує сценарії створення модуля в секції `build` з використанням критеріонів 

<a name="submodules-by-build">
    
В [cекцію `build`](WillFileComposition.ukr.md#build) записуються послідовності і умови виконання процедур створення модуля - сценарії.  
В попередньому туторіалі ви дізнались як використовуються критеріони при створенні модуля. Приступимо до побудови сценарію, який би міг задовольнити вказані умови.

Створіть новий файл `.will.yml`:

```yaml
about :

    name : buildModuleWithCriterion
    description : "Using criterion to make different modules"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    WTools :
      path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
      criterion :
         debug : 1
    PathFundamentals :
      path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
      criterion :
         debug : 0

```

Якщо запустити команду `.submodules.download`, то `willbe` завантажить всі модулі, а ми хочемо щоб ці підмодулі завантажувались окремо. Створимо сценарій завантаження `submodules.debug` в секції `build`:
    
```yaml

build :

  submodules.download:
           steps :
             - submodules.download

```

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

    name : buildModuleWithCriterion
    description : "Using criterion to make different modules"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    WTools :
      path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
      criterion :
        debug : 1
    PathFundamentals :
      path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
      criterion :
        debug : 0

build :
    submodules.debug :
       steps :
          - submodules.download

```

</details>

Сценарій використовує один вбудований крок `submodules.download`, який завантажує підмодулі (детальніше про вбудовані функції в окремому туторіалі).  
Введемо фразу `will .build` в консолі з кореневої директорії файла:

```
...
Please specify exactly one build scenario, none satisfies passed arguments

```

`Willbe` не знайшов ні одного чітко вказаного сценарію. Ми маємо один визначений, введемо його назву як аргумент команди:

```
[user@user ~]$ will .build submodules.debug
...
  Building submodules.debug
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.694s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 1.665s
   + 2/2 submodule(s) of module::buildModuleWithCriterion were downloaded in 14.367s
  Built submodules.debug in 14.409s

```

Такий підхід не вирішує питання тому, що завантажує обидва модулі. В `submodules.debug` потрібно явно вказати на критеріон та встановити його значення. Змінимо секцію `build` в `.will.yml`:

```yaml

build :

  submodules.download:
           criterion:
             debug : 1
           steps :
             - submodules.download

```

Ми встановили критеріон `debug` зі значенням "1". Тепер при виконанні `will .build submodules.debug` `willbe` повинен встановити лише підмодуль `WTools`. Видалимо директорію `.module` (в консолі `rm -Rf .module` або `will .submodules.clean`) та виконаємо білд.

```
[user@user ~]$ will .build submodules.debug
...
  Building submodules.debug
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.694s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 1.665s
   + 2/2 submodule(s) of module::buildModuleWithCriterion were downloaded in 14.367s
  Built submodules.debug in 14.409s

```


Секція `build` має одну процедуру під назвою `submodules.download`, яка за замовчуванням завантажує підмодулі використовуючи `submodules.download`.  
Очистимо директорію ввівши `will .submodules.clean` та виконаємо `will .build`:

```
[user@user ~]$ will .build
Request ".build"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.063s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

  Building submodules.download
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.828s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 1.424s
   + 2/2 submodule(s) of module::first were downloaded in 14.259s
  Built submodules.download in 14.300s

```

Результат подібний до використання команди `will .submodules.download`, проте, далі ми можемо удосконалити модуль і така структура запису буде доречною.