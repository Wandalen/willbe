# Критеріони

Як використовувати критеріони для відбору ресурсів.

Для отримання декількох варіантів побудови модуля в `вілфайлі` можна створити окремі збірки та додати відповідні кроки. Це призведе до збільшення об'єму і знизить зручність використання `вілфайла`. Є другий спосіб - будувати сценарій, котрий обирає ресурс згідно умови. І для цього в утиліті створено критеріон - елемент, який задає умови доступу до ресурсу.  

При побудові модуля ресурс може мати довільне число критеріонів, а критеріон може мати довільну кількість булевих і рядкових значень, що дозволяє створити унікальні умови доступу до ресурсу. Доступ відкривається при співпадінні мап критеріонів збірки і ресурсу.   

### Приклад побудова таблиці істинності 

Мапа критеріонів - асоціативний масив вигляду "ключ-значення", в якому немає двох однакових ключів. Таким чином, мапа критеріонів формує таблицю істинності для доступу до ресурса.  

Наприклад, утиліта `willbe`, після процедури відладки (`debug`), повинна вивести в консолі фразу `Debug is done`, а після виконання іншої процедури, виводити `Operation is done`.  Іншими словами, є один ключ-критеріон (`debug`) та дві дії - вивід фраз.  

Таблиця істинності виглядатиме так:  

| Критеріон `debug` | Вивід `Debug is done` | Вивід `Operation is done`       |
|-------------------|-----------------------|---------------------------------|
| 1                 | 1                     | 0                               |
| 0                 | 0                     | 1                               |

Приклад іллюструє вибір на основі одного критеріону `debug` зі значеннями `0` i `1`, а критеріон може мати як два, так і більше  довільних числових і рядкових значень. Наприклад, значення `0` i `1` можна замінити на `debug`, `release` і додати в нього інші значення за потреби.     

### Застосування критеріонів 

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
<details>
  <summary><u>Структура модуля</u></summary>

```
criterion
    └── .will.yml

```

</details>

Створіть нову директорію `criterion` з файлом `.will.yml`. Помістіть в `вілфайл` приведений вище код.

В сценарії збірки `echo.debug` крок указано з використанням ґлобу `*` ([детальніше про використання ґлобів](SelectorsWithGlob.md)). Символ `*` в назві кроку означає, що крок повинен починатись зі слова `echo.` та може мати будь-яке закінчення. Кроки `echo.one` і `echo.two` одночасно задовільняють умову пошуку, тому використовується порівняння мап критеріонів `debug` в збірці та кроках.  

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
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
criterion
    └── .will.yml

```

</details>

Запустіть побудову збірки відладки (`will .build echo.debug`) та порівняйте з виводом. 

Утиліта обрала крок `echo.one` згідно критеріона.  

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
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
criterion
    └── .will.yml

```

</details> 

Змініть значення критеріона `debug` в збірці `echo.debug` на `0` та запустіть побудову збірок `echo.debug` і `echo.test`.

В збірці `echo.test` утиліта проігнорувала значення критеріона, оскільки, посилання на ресурси були прямими.

### Підсумок

- Критеріони задають умови використання ресурса.  
- Критеріони встановлюються в збірці та порівнюються з ресурсами інших секцій.  
- Порівняння мап критеріонів проходить якщо посилання на ресурс використовує ґлоби.  
- Прямі посилання на ресурс виконуються з ігноруванням критеріонів.

[Наступний туторіал](CriterionDefault.md)
[Повернутись до змісту](../README.md#tutorials)
