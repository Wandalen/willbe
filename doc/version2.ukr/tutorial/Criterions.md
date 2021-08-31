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

  print.one :
    shell : echo "Debug is done"
    currentPath : '.'
    criterion :
       debug : 1

  print.two :
    shell : echo "Operation is done"
    currentPath : '.'
    criterion :
       debug : 0

build :

  print.debug :
    criterion :
       debug : 1
    steps :
       - print.*

  print.test :
    criterion :
       debug : 1
    steps :
       - print.one
       - print.two
```

</details>

Помістіть в `вілфайл` приведений вище код.

В сценарії збірки `print.debug` крок указано з використанням ґлобу `*` ([детальніше про використання ґлобів](SelectorsWithGlob.md)). Ґлоб `*` означає, що крок повинен починатись зі слова `print.` та може мати будь-яке закінчення. Кроки `print.one` і `print.two` одночасно задовільняють умову пошуку. Тому, для відбору використовується порівняння мап критеріонів `debug` в збірці та кроках.

<details>
  <summary><u>Вивід команди <code>will .build print.debug</code></u></summary>

```
[user@user ~]$ will .build print.debug
...
Building print.debug
 > echo "Debug is done"
Debug is done
  Built print.debug in 0.062s

```

</details>

Запустіть побудову збірки відладки (`will .build print.debug`) та порівняйте з виводом.

Утиліта обрала крок `print.one` згідно критеріона `debug : 1`. Тому, в консолі з'явився рядок `Debug is done`. Збірка не виконує операцій з файлами тому структура модуля залишилась без змін.

<details>
    <summary><u>Збірка <code>print.debug</code> зі зміненим критеріоном <code>debug</code></u></summary>

```yaml
  print.debug :
    criterion :
       debug : 0
    steps :
       - print.*

```

</details>

Відкрийте файл `.will.yml` та змініть значення критеріона `debug` в збірці `print.debug` на `0` згідно приведеного коду.

<details>
    <summary><u>Вивід команди <code>will .build print.debug</code></u></summary>

```
[user@user ~]$ will .build print.debug
...
  Building print.debug
 > echo "Operation is done"
Operation is done
  Built print.debug in 0.102s

```

</details>

Повторно введіть команду `will .build print.debug`. Порівняйте результат з приведеним виводом.

Після зміни значення критеріона, утиліта вибрала крок `print.two`. Відповідно, в консолі з'явилась фраза "Operation is done".

<details>
  <summary><u>Вивід команди <code>will .build print.test</code></u></summary>

```
[user@user ~]$ will .build print.test
...
  Building print.test
 > echo "Debug is done"
Debug is done
 > echo "Operation is done"
Operation is done
  Built print.test in 0.132s

```

</details>

Виконайте побудову збірки `print.test`. Для цього використайте команду `will .build print.test`.

В збірці `print.test` утиліта проігнорувала значення критеріона і виконала кроки `print.one` i `print.two`. Це пов'язано з тим, що утиліта не порівнює мапи критеріонів, якщо посилання на ресурси не містять ґлобів.

### Підсумок

- Критеріони задають умови використання ресурса.
- Критеріони встановлюються в збірці та порівнюються з ресурсами інших секцій.
- Порівняння мап критеріонів проходить якщо посилання на ресурс використовує ґлоби.
- Прямі посилання на ресурс виконуються з ігноруванням критеріонів.

[Повернутись до змісту](../README.md#tutorials)
