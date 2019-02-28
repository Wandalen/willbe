# Поняття критеріонів в `will`-файлах

В туторіалі дається поняття про критеріони (criterion) та їх використання в `will`-файлах

В попередньому туторіалі ми згадали про критеріони в секції `submodule`. Критеріони - логічний (булевий) елемент пакету `willbe`, який відповідає за створення таблиці істинності обраного ресурсу. Критеріони приймають значення "0" та "1". 

Уявімо, що пакет `willbe` повинен після процедури відладки (`debug`) вивести в консолі фразу _'Debug is done'_, а після виконання іншої процедури, тобто, якщо не виконується `debug`, виводити _'Operation is done'_.  Іншими словами, ми маємо один критеріон (`debug`) та дві дії - вивід фраз.
Складемо таблицю істинності для цього випадку 

| Виконання `debug` | Вивід 'Debug is done' | Вивід 'Operation is done'       |
|-------------------|-----------------------|---------------------------------|
| true              | 1                     | 0                               |
| falce             | 0                     | 1                               |

Приклад іллюструє бінарний вибір на основі одного критеріону, проте ресурс може мати довільне число критеріонів для правильного виконання процедур програми. Якщо число критеріонів збільшується, то структура таблиці ускладнюється.

```yaml

build :

  submodules.download:
           criterion:
             debug : 1
           steps :
             - submodules.download

```

Ми встановили критеріон `debug` зі значенням "1". Тепер при виконанні `will .build submodules.debug` `willbe` повинен встановити лише підмодуль `WTools`. Видалимо директорію `.module` (в консолі `rm -Rf .module` або `will .submodules.clean`) та виконаємо білд.

```
[user@user ~]$ will .build submodules.debug
...
  Building submodules.debug
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.694s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 1.665s
   + 2/2 submodule(s) of module::buildModuleWithCriterion were downloaded in 14.367s
  Built submodules.debug in 14.409s
```


В [наступному туторіалі](ModuleCriation.ukr.md) з допомогою вказаних критеріонів ми створимо сценарій для виводу фраз в консоль операційної системи.

[Повернутись до меню](Topics.ukr.md)