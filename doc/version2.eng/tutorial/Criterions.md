# Criterions

How to use criterions for resource selection.

Для отримання декількох варіантів побудови модуля в `will-файлі` можна створити окремі збірки та додати відповідні кроки, що призведе до збільшення об'єму і знизить зручність використання `will-файла`. Є другий спосіб - будувати сценарій, котрий обирає ресурс згідно умови. І для цього в утиліті створено критеріон - елемент, який задає умови доступу до ресурсу. При побудові модуля ресурс може мати довільне число критеріонів, а критеріон може мати довільне число числових і рядкових значень, що дозволяє створити унікальні умови доступу до ресурсу. Доступ відкривається при співпадінні мап критеріонів збірки і ресурсу.   
Приклад використання критеріонів (побудова таблиці істинності). Утиліта `willbe`, після процедури відладки (`debug`), повинна вивести в консолі фразу `Debug is done`, а після виконання іншої процедури, виводити `Operation is done`.  Іншими словами, є один ключ-критеріон (`debug`) та дві дії - вивід фраз.
Таблиця істинності виглядатиме так:  

| Критеріон `debug` | Вивід `Debug is done` | Вивід `Operation is done`       |
|-------------------|-----------------------|---------------------------------|
| 1                 | 1                     | 0                               |
| 0                 | 0                     | 1                               |

Приклад іллюструє простий вибір на основі одного критеріону `debug` зі значеннями `0` i `1`, а критеріон може мати як два, так і більше  довільних числових і рядкових значень. Наприклад, значення `0` i `1` можна замінити на `debug`, `release` і додати в ньго значення за потреби.     

### Застосування критеріонів
Створіть нову директорію `criterion` з файлом `.will.yml`. Помістіть в `will-файл` код:  

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

В сценарії збірки `echo.debug` крок указано з використанням ґлобу `*` (детальніше про ґлоби в туторіалі ["Селектори із ґлобами"](SelectorsWithGlob.md)). Символ `*` в назві кроку означає, що крок повинен починатись зі слова `echo.` та може мати будь-яке закінчення, включаючи відсутність знаків. Кроки `echo.one` і `echo.two` одночасно задовільняють умову пошуку, тому використовується порівняння мап критеріонів `debug` в збірці та кроках.  
Критеріон `debug` в збірці `echo.debug` має значення `1`. Запустіть побудову збірки та порівняйте:  

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

Утиліта обрала крок `echo.one` згідно критеріона. Змініть значення критеріона `debug` в збірці `echo.debug` на `0` та запустіть побудову збірок `echo.debug` і `echo.test`:

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

В збірці `echo.test` утиліта проігнорувала значення критеріона, оскільки, посилання на ресурси були прямими.

### Підсумок
- Критеріони задають умови використання ресурса.  
- Критеріони встановлюються в збірці та порівнюються з ресурсами інших секцій.  
- Порівняння мап критеріонів проходить якщо посилання на ресурс використовує ґлоби.  
- Прямі посилання на ресурс ігнорують критеріони.

[Наступний туторіал](CriterionDefault.md)
[Повернутись до змісту](../README.md#tutorials)
