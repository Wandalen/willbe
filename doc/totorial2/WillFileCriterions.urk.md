# Критеріони (criterion) в `will`-файлах

В керівництві користувача дано визначення поняття критеріонів та приведено приклади їх використання при створенні модулів

Критеріон - логічний (булевий) елемент пакету `willbe`, який відповідає за створення таблиці істинності використання обраного ресурсу. Критеріони приймають значення "0" та "1".

Побудова таблиці істинності. Пакет `willbe` повинен після процедури відладки (`debug`), вивести в консолі фразу _'Debug is done'_, а якщо `debug` не виконується, виводити _'Operation is done'_.  Іншими словами, ми маємо один ключ-критеріон (`debug`) та дві дії - вивід фраз.
Таблиця істинності для цього випадку має вигляд:

| Виконання `debug` | Вивід 'Debug is done' | Вивід 'Operation is done'       |
|-------------------|-----------------------|---------------------------------|
| true              | 1                     | 0                               |
| falce             | 0                     | 1                               |

Приклад іллюструє бінарний вибір на основі одного критеріону, проте ресурс може мати довільне число критеріонів для правильного виконання процедур програми. Якщо число критеріонів збільшується, то структура таблиці ускладнюється.

### Правила використання
Критеріони в `will`-файлі повинні розташовуватись в кожному ресурсі, який виконується згідно критеріону.  
Ресурс без зазначеного критеріону приймає всі встановлені значення критеріону.
Порівняння мап критеріонів проходить, коли здійснюється вибір по ґлобу. Якщо на ресурс використовується пряме посилання, то критеріони ігноруються.

### Приклад використання
Створимо `will`-файл:
<details>
  <summary><u>Лістинг файла `.will.yml`</u></summary>

```yaml

about :

    name : buildModuleWithCriterion
    description : "Output of various phrases using criterions"
    version : 0.0.1
    keywords :
        - willbe

step :

  echo :
    shell : echo "Debug is done"
    currentPath : '.'
    criterion :
       debug : 1

  echo.op :
    shell : echo "Operation is done"
    currentPath : '.'
    criterion :
       debug : 0

build :

  echo.debug:
    criterion :
       debug : 1
    steps :
       - echo*

  echo.op:
    criterion :
       debug : 0
    steps :
       - echo*

```

</details>

Два сценарії створено для зручності використання файла. Тепер в кореневій директорії файла запустіть побудову `will .build echo.debug`, а потім `will .build echo.op`:
```
...
Building echo.debug
 > echo "Debug is done"
Debug is done
  Built echo.debug in 0.062s

...
Building echo.op
 > echo "Operation is done"
Operation is done
  Built echo.op in 0.051s

```

Змінимо секцію `build` так, щоб сценарій використовував прямимі посилання:

```yaml

build :

  build :

  echo.debug:
    criterion :
       debug : 1
    steps :
       - echo
       - echo.op

```

```
  Building echo.debug
 > echo "Debug is done"
Debug is done
 > echo "Operation is done"
Operation is done
  Built echo.debug in 0.132s

```

> Кроки без ґлобів - прямі вказівки на виконання дій з ігноруванням критеріонів.

[Повернутись до змісту](Topics.ukr.md)
