# Поняття критеріонів в will-файлах та їх використання

В туторіалі дається поняття про критеріони (criterion) та їх використання в `will`-файлах

Ми створювали окремі збірки секції `build` та додавали кроки в секцію `step`, щоб виконати правильний сценарій. Але якщо для вибору ресурсів застосувати умову еквівалентності значень полів, то процес побудови модуля буде швидшим. Цю функцію виконує критеріон - логічний (булевий) елемент пакету `willbe`, який відповідає за створення таблиці істинності ресурсу. Критеріони приймають значення "0" та "1". 

Приклад. Пакет `willbe` після процедури відладки (`debug`) повинен вивести в консолі фразу _'Debug is done'_, а після виконання іншої процедури, тобто, якщо не виконується `debug`, виводити _'Operation is done'_.  Іншими словами, ми маємо один ключ-критеріон (`debug`) та дві дії - вивід фраз.
Складемо таблицю істинності:  

| Критеріон `debug` | Вивід 'Debug is done' | Вивід 'Operation is done'       |
|-------------------|-----------------------|---------------------------------|
| 1                 | 1                     | 0                               |
| 0                 | 0                     | 1                               |

Приклад іллюструє вибір на основі одного критеріону, але ресурс може мати довільне число критеріонів для створення унікальних умов доступу до ресурса. Якщо число критеріонів збільшується, то структура таблиці ускладнюється.

Розглянемо лістинг з критеріонами:
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
       - echo.one
       
  echo.op:
    criterion :
       debug : 0
    steps :
       - echo.two 
       
```

</details>

Таке рішення не має сенсу - ми навантажуємо файл додатковими критеріонами, а використовуємо прямі посилання на ресурси. Створіть новий `will`-файл, помістіть в нього лістинг змінивши секцію `build` на:

```yaml

build :

  echo.debug:
    criterion :
       debug : 1
    steps :
       - echo.*

```

Залишилась одна збірка з критеріоном `debug : 1` та змінилась назва кроку - додано '\*'. Знак '\*' свідчить про використання пакетом ґлобів оболонки операційної системи. Це означає, що крок повинен починатись зі слова _'echo.'_ та може мати будь-яке закінчення, включаючи відсутність знаків (у нас є `echo.one` та `echo.two`).  
Запустіть `will .build echo.debug` та порівняйте:

```
[user@user ~]$ will .build echo.debug
...
Building echo.debug
 > echo "Debug is done"
Debug is done
  Built echo.debug in 0.062s

```

Тепер змініть значення критеріону в `will`-файлі на "0" та запустіть повторно команду.

```
[user@user ~]$ will .build echo.debug
...
  Building echo.debug
 > echo "Operation is done"
Operation is done
  Built echo.debug in 0.102s
  
```

Перевіримо іншу збірку. Змініть секцію `.will.yml` до вигляду та запустіть `will .build echo.debug`:

```yaml

build :

  echo.debug:
    criterion :
       debug : 1
    steps :
       - echo.one
       - echo.two

```

```
[user@user ~]$ will .build echo.debug
...
  Building echo.debug
 > echo "Debug is done"
Debug is done
 > echo "Operation is done"
Operation is done
  Built echo.debug in 0.132s

```

- Посилання на ресурси без ґлобів - прямі вказівки на виконання дій з ігноруванням критеріонів.

В [наступному туторіалі](DefaultCriterionInWillFile.ukr.md) розглянемо як ще використовуються критеріони при побудові модуля.  
[Повернутись до змісту](../README.md#tutorials)