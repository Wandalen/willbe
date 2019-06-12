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

Для запуску побудови збірки в директорії `вілфайла`, введіть в консолі фразу `will .build`. Порівняйте з приведеним вище виводом. Утиліта на знайшла сценарію побудови.

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

В попередньому виклику назву збірки вказано не було, тому, в цьому, вкажіть явно назву збірки. Введіть команду `will .build echo` та порівняйте з приведеним виводом. Збірку було побудовано за 0.089s. Вивід консолі показує, що було запущено збірку `echo`. Після виконання кроку `echo` в консолі з'явився рядок "Hello, World". Більш складні збірки можуть мати кроки із операціями над файлами.

### Сценарії збірки

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
       - echo.two

  echo.two:
    steps :
      - echo
      - echo.two

```

</details>

Замініть вміст `.will.yml` кодом вище.

В файл додано крок `echo.two`, який виводить фразу `Utility Willbe` в консоль. Було додано збірку `echo.two` із двома кроками.

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

  Building module::buildModuleWithCriterion / build::echo.two
 > echo "Hello, World"
"Hello, World"
 > echo "Utility Willbe"
"Utility Willbe"
  Built module::buildModuleWithCriterion / build::echo.two in 0.086s

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

Збірка `echo.two` містить додатковвий крок тому при її побудові після - "Hello, World" виводиться ще і "Utility Willbe". Проаналізувавши виводи команд `will .build echo` i `will .build echo.two`, можливо зробить висновок, що кроки в збірках виконуються послідовно.

### Підсумок

- Запуск збірки здійснюється командою `.build`.
- Запуск збірки можливо здійснити за її назвою. Для цього назва вказується аргументом команди `.build`.
- Кроки в сценарії збірки виконуються послідовно.
- Послідовність кроків визначається алгоритмом побудови модуля.
- Утиліта шукає `вілфайл` в поточній директорії.

[Наступний туторіал](StepSubmodules.md)  
[Повернутись до змісту](../README.md#tutorials)
