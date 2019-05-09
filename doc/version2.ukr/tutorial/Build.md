# Побудова модуля командою <code>.build</code>

Побудова модуля через запуск однієї із його збірок.

Ресурси cекції `build` називаються збірками. Збірка - послідовність і умови виконання кроків для побудови модуля. Сценарій збірки - послідовність виконання кроків збірки.  

### Конфігурація

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

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

</details>
<details>
  <summary><u>Структура модуля</u></summary>

```
buildModule              
     └── .will.yml     

```

</details>

Створіть новий `вілфайл` в директорії `buildModule`. Внесіть в нього приведений вище код.  

Секція `step` об'єднує ресурси (кроки) користувача, які описують інструкції по створення модуля. В прикладі, крок під назвою `echo.hello` має два поля:
- `shell` для виконання команди в консолі операційної системи. В прикладі, команда `echo` виводить рядок `Hello, World!`;
- `currentPath` - директорія в якій виконується команда.    

Збірка `echo` в `вілфайлі` виконуватиме крок `echo.hello`. Для запуску збірок використовується [команда `.build`](../concept/Command.md#Таблиця-команд-утиліти-willbe).

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
Please specify exactly one build scenario, none satisfies passed arguments

```

</details>

Введіть фразу `will .build` в консолі з кореневої директорії `вілфайла`. Порівняйте з приведеним вище виводом.

Утиліта на знайшла сценарію побудови. Його потрібно указати явно тому, вкажіть назву збірки аргументом команди `.build`.

<details>
  <summary><u>Вивід команди <code>will .build echo</code></u></summary>

```
[user@user ~]$ will .build echo
Command ".build echo"
...
  Building echo
 > echo "Hello, World"
Hello, World
  Built echo.debug in 0.089s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
buildModule              
     └── .will.yml     

```

</details>

Введіть команду `will .build echo` та порівняйте з приведеним виводом.

Вивід консолі показує, що було запущено збірку `echo`. Після виконання кроку в консолі з'явився рядок "Hello, World".

### Побудова сценаріїв збірок

`Willbe` дозволяє створювати збірки побудови модуля комбінуючи кроки.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

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
       - echo.hello

```

</details>

Тому, замініть вміст `.will.yml` як в приведеному вище коді. 

В файл додано крок `echo.two`, який виводить фразу `It's Willbe` в консоль. Відповідно, було змінено і збірки секції `build`. Збірка `echo` включає два кроки, а додаткова збірка `echo.two` - один.   

<details>
  <summary><u>Вивід команди <code>will .build echo</code></u></summary>

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

</details>
<details>
  <summary><u>Вивід команди <code>will .build echo.two</code></u>


```
[user@user ~]$ will .build echo.two
...
  Building echo.two
 > echo "It's Willbe"
It's Willbe
 > echo "Hello, World"
Hello, World
  Built echo in 0.095s

```
</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
buildModule              
     └── .will.yml     

```

</details>

Запустіть побудову збірки `echo` командою `will .build echo` та збірку `echo.two` командою `will .build echo.two`. Порівняйте результати виводу.  

При побудові збірок вивід фраз здійснювався згідно послідовності кроків в сценарії збірки. Тому, при створенні збірок враховуйте послідовність виконання дій над модулем.

### Підсумок

- Запуск збірки здійснюється командою `.build`.
- Запуск збірки здійснюється за її назвою. Для цього назва вказується аргументом команди `.build`.
- Кроки в сценарії збірки виконуються послідовно.
- Послідовність кроків визначається алгоритмом побудови модуля.
- Утиліта шукає `вілфайл` в поточній директорії.

[Наступний туторіал](StepsPredefined.md)  
[Повернутись до змісту](../README.md#tutorials)
