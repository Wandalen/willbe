# Побудова модуля командою <code>.build</code>

Побудова модуля через запуск однієї із його збірок.

Ресурси cекції `build` називаються збірками. Збірка - послідовність і умови виконання кроків для побудови модуля. Сценарій збірки - послідовність виконання кроків збірки.  

### Запуск команди

<details>
  <summary><u>Структура модуля</u></summary>

```
buildModule              
     └── .will.yml     

```

</details>

Створіть новий `вілфайл` в директорії `buildModule`.

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

  echo :
    shell : echo "Hello, World!"

build :

  echo:
    steps :
       - echo

```

</details>

Внесіть в нього приведений вище код.  

Секція `step` перераховує кроки, які описують інструкції по створення модуля. В прикладі можна бачити один крок `echo`. Цей крок має поле `shell` для виконання команди в консолі операційної системи.

Також `вілфайл` має збірку `echo`. Ця збірка містить крок `echo`.

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
Please specify exactly one build scenario, none satisfies passed arguments

```

</details>

Для запуску побудови збірки з директорії `вілфайла`, введіть в консолі фразу `will .build`. Порівняйте з приведеним вище виводом.

Утиліта на знайшла сценарію побудови. Його потрібно указати явно тому, вкажіть назву збірки.

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

Введіть команду `will .build echo` та порівняйте з приведеним виводом. Збірку було побудовано за 0.089s. Вивід консолі показує, що було запущено збірку `echo`. Після виконання кроку `echo` в консолі з'явився рядок "Hello, World".

### Сценарії збірки `steps`

Комбінуючи кроки можливо створити сценарій, що складається із декількох кроків.

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

  echo :
    shell : echo "Hello, World"

  echo.two :
    shell : echo "Utility Willbe"

build :

  echo:
    steps :
       - echo
       - echo.two

  echo.two:
    steps :
       - echo.two

```

</details>

Замініть вміст `.will.yml` кодом вище.

В файл додано крок `echo.two`, який виводить фразу `Utility Willbe` в консоль. Відповідно, було змінено і збірки секції `build`. Збірка `echo` включає два кроки, а додаткова збірка `echo.two` - один.   

<details>
  <summary><u>Вивід команди <code>will .build echo</code></u></summary>

```
[user@user ~]$ will .build echo
...
  Building echo
 > echo "Hello, World"
Hello, World
 > echo "Utility Willbe"
Utility Willbe
  Built echo in 0.175s

```

</details>

Введіть команду `will .build echo` та порівняйте з виводом приведеним вище.

На виконання двох кроків було використано 0.175s. Утиліта спочатку вивела фразу "Hello, World", а потім "Utility Willbe". 

<details>
  <summary><u>Вивід команди <code>will .build echo.two</code></u>


```
[user@user ~]$ will .build echo.two
...
  Building echo.two
 > echo "Utility Willbe"
Utility Willbe
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

Запустіть побудову збірки `echo.two` виконавши команду `will .build echo.two`. Порівняйте результати виводу з приведеними вище.  

В консолі першою виведено фразу "Utility Willbe", а після - "Hello, World". Час виконання менше - 0.095s. В кожній із збірок `echo` i `echo.two` виконуються кроки `echo` i `echo.two`. Тому, можна стверджувати, що час виконання побудови залежить від завантаженості операційної системи та потужності машини.

Проаналізувавши виводи команд `will .build echo` i `will .build echo.two`, очевидно, що кроки в збірках виконуються послідовно.

### Підсумок

- Запуск збірки здійснюється командою `.build`.
- Запуск збірки здійснюється за її назвою. Для цього назва вказується аргументом команди `.build`.
- Кроки в сценарії збірки виконуються послідовно.
- Послідовність кроків визначається алгоритмом побудови модуля.
- Утиліта шукає `вілфайл` в поточній директорії.

[Наступний туторіал](StepSubmodules.md)  
[Повернутись до змісту](../README.md#tutorials)
