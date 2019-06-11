# Критеріони

Як використовувати критеріони для відбору ресурсів.

При створенні `вілмодуля` зручніше використовувати сценарії, які будуть вибирати ресурси згідно заданої умови. Для створення таких сценаріїв в утиліті використовуются критеріони. 

Критеріон - це елемент порівняння для відбору ресурсів. Ресурс може мати довільне число критеріонів, а кожен з критеріонів ресурса мати одне булеве або рядкове значеня. Набір критеріонів ресурса формує асоціативний масив вигляду "ключ-значення", який називається мапою критеріонів. Мапа критеріонів дозволяє обрати із множини ресурсів якусь підмножину. Умовою включення ресурса в множину є співпадіння значень визначених критеріонів.

### Застосування критеріонів

<details>
  <summary><u>Структура файлів</u></summary>

```
criterion
    └── .will.yml

```

</details>

Для дослідження роботи критеріонів створіть директорію `criterion` з файлом `.will.yml`.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

    name : buildModuleWithCriterion
    description : "Output of various phrases using criterions"
    version : 0.0.1

step :

  echo.one :
    shell : echo "Debug is done"
    currentPath : '.'
    criterion :
       debug : 1

  echo.two :
    shell : echo "Operation is done"
    currentPath : '.'
    criterion :
       debug : 0

build :

  echo.debug:
    criterion :
       debug : 1
    steps :
       - echo.*

  echo.test:
    criterion :
       debug : 1
    steps :
       - echo.one
       - echo.two

```

</details>

Помістіть в `вілфайл` приведений вище код.

В сценарії збірки `echo.debug` крок указано з використанням ґлобу `*` ([детальніше про використання ґлобів](SelectorsWithGlob.md)). Ґлоб `*` означає, що крок повинен починатись зі слова `echo.` та може мати будь-яке закінчення. Кроки `echo.one` і `echo.two` одночасно задовільняють умову пошуку. Тому, для відбору використовується порівняння мап критеріонів `debug` в збірці та кроках.  

<details>
  <summary><u>Вивід команди <code>will .build echo.debug</code></u></summary>

```
[user@user ~]$ will .build echo.debug
...
Building echo.debug
 > echo "Debug is done"
Debug is done
  Built echo.debug in 0.062s

```

</details>

Запустіть побудову збірки відладки (`will .build echo.debug`) та порівняйте з виводом.

Утиліта обрала крок `echo.one` згідно критеріона `debug : 1`. Тому, в консолі з'явився рядок `Debug is done`. Збірка не виконує операцій з файлами тому структура модуля залишилась без змін.

<details>
    <summary><u>Збірка <code>echo.debug</code> зі зміненим критеріоном <code>debug</code></u></summary>

```yaml
  echo.debug :
    criterion :
       debug : 0
    steps :
       - echo.*

```

</details>

Відкрийте файл `.will.yml` та змініть значення критеріона `debug` в збірці `echo.debug` на `0` згідно приведеного коду.

<details>
    <summary><u>Вивід команди <code>will .build echo.debug</code></u></summary>

```
[user@user ~]$ will .build echo.debug
...
  Building echo.debug
 > echo "Operation is done"
Operation is done
  Built echo.debug in 0.102s

```

</details>

Повторно введіть команду `will .build echo.debug`. Порівняйте результат з приведеним виводом.

Після зміни значення критеріона, утиліта вибрала крок `echo.two`. Відповідно, в консолі з'явилась фраза "Operation is done".

<details>
  <summary><u>Вивід команди <code>will .build echo.test</code></u></summary>

```
[user@user ~]$ will .build echo.test
...
  Building echo.test
 > echo "Debug is done"
Debug is done
 > echo "Operation is done"
Operation is done
  Built echo.test in 0.132s

```

</details>

Виконайте побудову збірки `echo.test`. Для цього використайте команду `will .build echo.test`. 

В збірці `echo.test` утиліта проігнорувала значення критеріона і виконала кроки `echo.one` i `echo.two`. Це пов'язано з тим, що утиліта не порівнює мапи критеріонів, якщо посилання на ресурси не містять ґлобів.

### Підсумок

- Критеріони задають умови використання ресурса.  
- Критеріони встановлюються в збірці та порівнюються з ресурсами інших секцій.  
- Порівняння мап критеріонів проходить якщо посилання на ресурс використовує ґлоби.  
- Прямі посилання на ресурс виконуються з ігноруванням критеріонів.

[Повернутись до змісту](../README.md#tutorials)
