# Використання команди '.build' для побудови модуля

Туторіал описує запуск окремих збірок побудови модуля в `will`-файлі

<a name="module-by-build">  
    
Ресурси [cекції `build`](CompositionOfWillFile.ukr.md#build) називаються збірками. Збірка - послідовності і умови виконання процедур побудови модуля. В збірках окремо виділено сценарій збірки - послідовність виконання кроків в ресурсі.  

Створимо новий `will`-файл:

```yaml
about :

    name : buildModule
    description : "Using build command"
    version : 0.0.1
    keywords :
        - willbe
        
step :

  echo.hello :
    shell : echo "Hello, World"
    currentPath : '.'
    
```

Секція [`step`](CompositionOfWillFile.ukr.md#step) включає процедури користувача (кроки) для створення модульної системи. В прикладі, крок під назвою `echo.hello` має два поля - `shell` для використання консолі операційної системи (команда `echo` виводить рядок _"Hello, World"_) та `currentPath` - директорія в якій виконується команда.  
Перейдемо до секції `build`:
    
```yaml

build :

  echo:
    steps :
       - echo.hello

```

Збірка `echo` виконує один крок `echo.hello`. Об'єднайте секції в одному файлі:

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

  echo.hello :
    shell : echo "Hello, World"
    currentPath : '.'
    
build :

  echo:
    steps :
       - echo.hello

```

</details>

Для запуску збірок необхідно використати команду `.build` тому, введемо фразу `will .build` в консолі з кореневої директорії `will`-файла:

```
[user@user ~]$ will .build 
...
Please specify exactly one build scenario, none satisfies passed arguments

```

`Willbe` не знайшов ні однієї вказаної збірки. Ми маємо одну, перевіримо, використавши команду, яка виводить список доступних білдів:

```
[user@user ~]$ will .builds.list
Request ".builds.list"
...
build::echo
  steps : 
    echo.hello

```

Збірка є. Тепер введемо її назву як аргумент команди:

```
[user@user ~]$ will .build echo
Request ".build echo"
...
  Building echo
 > echo "Hello, World"
Hello, World
  Built echo.debug in 0.089s

```

Створимо другий крок:

```yaml

  echo.two :
    shell : echo "It's Willbe"
    currentPath : '.'
        
```

Додамо крок `echo.two` в збірку `echo`, щоб пакет виконав обидва кроки, а також створимо збірку для запуску другого кроку. Додайте в секцію `build` наступні ресурси: 

```yaml
  echo :
    steps :
       - echo.hello
       - echo.two
       
  echo.two :
    steps :
       - echo.two

```

Перевірте створений файл.

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

  echo.hello :
    shell : echo "Hello, World"
    currentPath : '.'
        
  echo.two :
    shell : echo "It's Willbe"
    currentPath : '.'    

build :

  echo:
    steps :
       - echo.hello
       - echo.two
       
  echo.two:
    steps :
       - echo.two      

```

</details>

Запустіть окремі збірки та порівняйте результати виводу:

<details>
  <summary><u>Лістинги виводу команд</u></summary>
    <p>Збірка 'echo'</p>

```
[user@user ~]$ will .build echo
...
  Building echo
 > echo "Hello, World"
Hello, World
 > echo "It's Willbe"
It's Willbe
  Built echo in 0.275s

``` 

<p>Збірка `echo.two`</p>

```
[user@user ~]$ will .build echo.two
...
  Building echo.two
 > echo "It's Willbe"
It's Willbe
  Built echo in 0.095s

``` 

</details>

</br>
- `Willbe` може [використовувати командну оболонку](#shell-resource) операційної системи.  
- Головний недолік створення окремих збірок полягає в тому, що зі збільшенням числа умов необхідно збільшувати об'єм `will`-файла і ускладнювати структуру.  

[Наступний туторіал](PredefinedSteps.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)