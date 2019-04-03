# <a name="module-by-build"></a> Побудова модуля командою `.build`

Туторіал описує запуск окремих збірок побудови модуля

Ресурси cекції `build` називаються збірками. Збірка - послідовність і умови виконання кроків для побудови модуля. Сценарій збірки - послідовність виконання кроків збірки.  
Створіть новий `will-файл` в директорії `buildModule`:  

<details>
  <summary><u>Повний код файла <code>.will.yml</code>. Структура модуля</u></summary>

```yaml
about :

    name : buildModule
    description : "Using build command"
    version : 0.0.1
    keywords :
        - willbe
        
step :

  echo.hello :
    shell : echo "Hello, World!"
    currentPath : '.'
    
build :

  echo:
    steps :
       - echo.hello
    
```

<p>Структура модуля</p>

```
buildModule              
     └── .will.yml     
  
```

</details>


Секція `step` об'єднує ресурси (кроки) користувача, які описують процедури створення модульної системи. В прикладі, крок під назвою `echo.hello` має два поля - `shell` для використання консолі операційної системи (команда `echo` виводить рядок `Hello, World!`) та `currentPath` - директорія в якій виконується команда.  
Збірка `echo` виконуватиме крок `echo.hello`.  
Для запуску збірок використовується команда `.build` тому, введемо фразу `will .build` в консолі з кореневої директорії `will-файла`:

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build 
...
Please specify exactly one build scenario, none satisfies passed arguments

```

</details>


`Willbe` не знайшов сценарію побудови, тому, вкажемо назву збірки аргументом команди `.build`:

<details>
  <summary><u>Вивід команди <code>will .build echo</code></u></summary>

```
[user@user ~]$ will .build echo
Request ".build echo"
...
  Building echo
 > echo "Hello, World"
Hello, World
  Built echo.debug in 0.089s

```

<p>Структура модуля після побудови</p>

```
buildModule              
     └── .will.yml     
  
```

</details>

### Побудова сценаріїв збірок
`Willbe` дозволяє будувати збірки побудови модуля комбінуючи кроки. Тому, замініть вміст `.will.yml` як в приведеному коді:

<details>
  <summary><u>Повний лістинг файла <code>.will.yml</code></u></summary>

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

<p>Структура модуля</p>

```
buildModule              
     └── .will.yml     
  
```

</details>


В файл додано крок `echo.two`, який виводить фразу `It's Willbe` в консоль. Сценарій збірки `echo` включає два кроки, а збірка `echo.two` - один.  
Запустіть окремі збірки та порівняйте результати виводу:  

<details>
  <summary><u>Вивід команд <code>will .build echo</code> та <code>will .build echo.two</code></u></summary>
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

<p>Структура модуля після побудов</p>

```
buildModule              
     └── .will.yml     
  
```

</details>

### Підсумок
- `Willbe` [працює з командною оболонкою](#shell-resource) операційної системи.  
- Кроки в сценарії збірки виконуються згідно послідовності запису.  

[Наступний туторіал](PredefinedSteps.md)  
[Повернутись до змісту](../README.md#tutorials)