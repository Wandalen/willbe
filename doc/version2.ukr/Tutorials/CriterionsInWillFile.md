# Критеріони в `will-файлах`

Як використовуються критеріони

В попердньому туторіалі ["Знайомство з вбудованими кроками системи"](PredefinedSteps.md) будувались окремі збірки та додавались кроки в секцію `step` щоб виконати необхідний сценарій. Є другий спосіб - обирати ресурс згідно умови закладеної в алгоритм побудови. Цю функцію виконує критеріон - логічний (булевий) елемент утиліти `willbe`, який відповідає за створення таблиці істинності ресурсу. Критеріони приймають значення "0" та "1".  
Приклад побудови таблиці істинності. Утиліта `willbe` після процедури відладки (`debug`) повинна вивести в консолі фразу `Debug is done`, а після виконання іншої процедури (якщо `debug` не виконується), виводити `Operation is done`.  Іншими словами, є один ключ-критеріон (`debug`) та дві дії - вивід фраз.
Таблиця істинності:  

| Критеріон `debug` | Вивід `Debug is done` | Вивід `Operation is done`       |
|-------------------|-----------------------|---------------------------------|
| 1                 | 1                     | 0                               |
| 0                 | 0                     | 1                               |

Приклад іллюструє вибір на основі одного критеріону, а ресурс може мати довільне число критеріонів для створення унікальних умов доступу до ресурса. Якщо число критеріонів збільшується, то структура таблиці ускладнюється.  

### Застосування критеріонів
Створіть нову директорію `criterion` з файлом `.will.yml`. Помістіть в `will-файл` код:  

<details>
  <summary><u>Повний код файла <code>.will.yml</code></u></summary>

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

<p>Структура модуля</p>

```
criterion
    └── .will.yml

```

</details>

В сценарії збірки `echo.debug` крок указано з використанням ґлобу `*` (детальніше про ґлоби в туторіалі ["Використання селекторів з ґлобами"](HowToUseSelectorsWithGlob.md)). Символ `*` в назві кроку означає, що крок повинен починатись зі слова `echo.` та може мати будь-яке закінчення, включаючи відсутність знаків. Кроки `echo.one` і `echo.two` одночасно задовільняють умову пошуку, тому використовується порівняння критеріонів `debug` в збірці та кроках.  
Критеріон `debug` в збірці `echo.debug` має значення "1". Запустіть побудову збірки та порівняйте:  

<details>
  <summary><u>Вивід фрази <code>will .build echo.debug</code></u></summary>

```
[user@user ~]$ will .build echo.debug
...
Building echo.debug
 > echo "Debug is done"
Debug is done
  Built echo.debug in 0.062s

```

<p>Структура модуля після побудови</p>

```
criterion
    └── .will.yml

```

</details>

Збірка обрала крок `echo.one` згідно критеріона. Змініть значення критеріона `debug` в збірці `echo.debug` на "0" та запустіть побудову збірок `echo.debug` і `echo.test`:

<details>
  <summary><u>Виводи побудов</u></summary>
<p>Вивід фрази <code>will .build echo.debug</code></p>

```
[user@user ~]$ will .build echo.debug
...
  Building echo.debug
 > echo "Operation is done"
Operation is done
  Built echo.debug in 0.102s

```

<p>Вивід фрази <code>will .build echo.debug</code></p>

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

<p>Структура модуля після побудов</p>

```
criterion
    └── .will.yml

```

</details>

В збірці `echo.test` утиліта проігнорувала значення критеріона, оскільки, посилання на ресурси були прямими.

### Підсумок
- Критеріони задають умови використання ресурса.  
- Критеріони встановлюються в збірці та порівнюються з ресурсами інших секцій.  
- Порівняння мап критеріонів проходить якщо посилання на ресурс використовує ґлоби.  
- Прямі посилання на ресурс ігнорують критеріони.

[Наступний туторіал](DefaultCriterionInWillFile.md) 
[Повернутись до змісту](../README.md#tutorials)
