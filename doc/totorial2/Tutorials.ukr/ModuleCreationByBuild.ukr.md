# Використання команди '.build' для побудови модуля

Туторіал описує збірки побудови модуля в `will`-файлі

<a name="module-by-build">  
    
Для запису збірок побудови модуля використовується [cекція `build`](CompositionOfWillFile.ukr.md#build). Збірка секції `build` - послідовності і умови виконання процедур побудови модуля.  

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
    shell : echo "Hello, World"
    currentPath : '.'
    
```

Секція [`step`](WillFileStructure.ukr.md#step) описує визначені користувачем дії, які можуть використовуватись пакетом для створення модульної системи. В прикладі, крок під назвою `echo` має два поля - використання командної оболонки  операційної системи `shell` де виводиться рядок _"Hello, World"_ (працюють всі команди системи) та директорія в якій ця команда виконується `currentPath`.  
Перейдемо до секції `build`:
    
```yaml

build :

  echo:
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
    shell : echo "Hello, World"
    currentPath : '.'
    
build :

  echo:
    steps :
       - echo

```

</details>

В секцію поміщена збірка `echo`, яка викликає крок `echo`. 
Тепер введемо фразу `will .build` в консолі з кореневої директорії файла:

```
...
Please specify exactly one build scenario, none satisfies passed arguments

```

`Willbe` не знайшов ні однієї вказаної збірки. Ми маємо одну, перевіримо, використавши команду, яка виводить список доступних білдів:

```
[user@user ~]$ will .builds.list
Request ".builds.list"
...
build::echo.debug
  steps : 
    echo

```

Збірка є. Тепер введемо її назву як аргумент команди:

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

  echo.two :
    shell : echo "It's Willbe"
    currentPath : '.'
        
```

Можемо додати крок в збірку `echo`, але тоді буде виконано обидва кроки або створити ще одну збірку для запуску окремого кроку. Створимо збірку. 

```yaml

build :

  echo.two:
    steps :
       - echo.two

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
    shell : echo "Hello, World"
    currentPath : '.'
        
  echo.two :
    shell : echo "It's Willbe"
    currentPath : '.'    

build :

  echo:
    steps :
       - echo
       
  echo.two:
    steps :
       - echo.two       

```

</details>

> `Willbe` може [використовувати командну оболонку](#shell-resource) операційної системи для управління модулями

> Головний недолік створення окремих збірок полягає в тому, що зі збільшенням числа умов необхідно ускладнювати структуру `will`-файла.  

[Наступний туторіал](PrefinedSteps.ukr.md)  
[Повернутись до змісту](Topics.ukr.md)