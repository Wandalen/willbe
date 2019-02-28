# Створення модуля з використанням команди `.build`

Туторіал описує сценарії побудови модуля в `will`-файлі

<a name="module-by-build">  
    
Для запису сценаріїв побудови модуля використовується [cекція `build`](WillFileComposition.ukr.md#build). Сценарій секції `build` - послідовності і умови виконання процедур побудови модуля.  

Створимо новий `will`-файл:

```yaml
about :

    name : buildModule
    description : "Using build command"
    version : 0.0.1
    keywords :
        - willbe
        
step :

  echo :
    shell : echo "Debug is done"
    currentPath : '.'
    
```

Секція [`step`](WillFileStructure.ukr.md#step) описує визначені користувачем дії, які можуть використовуватись пакетом для створення модульної системи. В прикладі, крок під назвою `echo` має два поля - використання командної оболонки  операційної системи `shell`, де виводиться рядок в консоль (працюють всі команди системи) та директорія в якій ця команда виконується `currentPath`.  
Перейдемо до секції `build`:
    
```yaml

build :

  echo.debug:
    steps :
       - echo

```

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

    name : buildModule
    description : "Using build command"
    version : 0.0.1
    keywords :
        - willbe
        
step :

  echo :
    shell : echo "Debug is done"
    currentPath : '.'
    
build :

  echo.debug:
    steps :
       - echo

```

</details>

В секцію поміщений сценарій `echo.debug`, який викликає крок `echo`. 
Тепер введемо фразу `will .build` в консолі з кореневої директорії файла:

```
...
Please specify exactly one build scenario, none satisfies passed arguments

```

`Willbe` не знайшов ні одного чітко вказаного сценарію. Ми маємо один, перевіримо, використавши команду, яка виводить список доступних білдів:

```
[user@user ~]$ will .builds.list
Request ".builds.list"
...
build::echo.debug
  steps : 
    echo

```

Ми не помилились, сценарій є. Тепер введемо його назву як аргумент команди:

```
[user@user ~]$ will .build echo.debug
Request ".build echo.debug"
...
  Building echo.debug
 > echo "Debug is done"
Debug is done
  Built echo.debug in 0.089s

```

Створимо другий крок:

```yaml

  echo.op :
    shell : echo "Operation is done"
    currentPath : '.'
        
```

Можемо додати крок в `echo.debug`, але тоді буде виконано обидва кроки або створити ще один сценарій для запуску окремого кроку. Створимо сценарій. 

```yaml

build :

  echo.op:
    steps :
       - echo.op

```

Перегляньте створений файл.
<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

    name : buildModuleWithCriterion
    description : "Output of various phrases using criterions"
    version : 0.0.1
    keywords :
        - willbe
        
step :

  echo :
    shell : echo "Debug is done"
    currentPath : '.'
        
  echo.op :
    shell : echo "Operation is done"
    currentPath : '.'    

build :

  echo.debug:
    steps :
       - echo
       
  echo.op:
    steps :
       - echo.op       

```

</details>

> `Willbe` може [використовувати командну оболонку](#shell-resource) операційної системи для управління модулями

> Головний недолік створення окремих сценаріїв полягає в тому, що зі збільшенням числа умов необхідно ускладнювати структуру `will`-файла.  

Наступний туторіал ["Поняття критеріонів в `will`-файлах та їх використання"](CriterionsInWillFile.ukr.md)  
[Повернутись до меню](Topics.ukr.md)