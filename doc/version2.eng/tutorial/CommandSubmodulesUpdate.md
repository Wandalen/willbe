# Команда <code>.submodules.update</code>

Команда оновлення файлів віддалених підмодулів.

Команди [`.submodules.fixate`](CommandSubmodulesFixate.md) і [`.submodules.upgrade`](CommandSubmodulesUpgrade.md) здійснюють лише заміну URI-посилань в `відфайлі`. Вони потрібні для контролю версій віддалених підмодулів і дають змогу розробнику встановити оновлення в зручний момент. Для завантаження оновлень використовується команда [`.submodules.update`](../concept/Command.md#Таблиця-команд-утиліти-willbe).

Команда має опцію `dry` для ввімкнення оновлення підмодулів, яка приймає значення `0` i `1`. При `dry:0` команда здійснює оновлення. При значенні `dry:1` команда `will .submodules.update dry:1` виводить список підмодулів, що будуть оновлені, без їх завантаженння. Значення за замовчуванням `dry:0`.

### Структура файлів

<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesUpdate
          └── .will.yml

```

</details>

Для дослідження команди створіть структуру файлів вказану вище та внесіть код в `вілфайл`.  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.update command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```
</details>

Підмодуль `Tools` має версію коміта для дослідження поведінки команди `.submodules.update` з ресурсами з указаною версією.

### Команда `.submodules.update`

<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
  Remote path of module::submodulesCommands / module::Tools will be fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 <- .#ec60e39ded1669e27abaa6fc2798ee13804c400a
  in /path_to_file/submodulesUpgrade/.will.yml
  Remote path of module::submodulesCommands / module::PathFundamentals will be fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 <- .#master

```

</details>

Для того, щоб дослідити команду `.submodules.update`, дізнайтесь, які найновіші оновлення підмодулів наявні. Для цього використайте команду `will .submodules.upgrade dry:1`. Опція `dry:1` вказує, що `вілфайл` не буде переписано.

Вивід показує (на момент створення туторіалу):
- можливу заміну версії `#ec60e39ded1669e27abaa6fc2798ee13804c400a` на `#7db7bd21ac76fc495aae44cc8b1c4474ce5012a4` в підмодулі `Tools`;
- можливу заміну версії `#master` на `#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7` в підмодулі `PathFundamentals`.

<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
  . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version ec60e39ded1669e27abaa6fc2798ee13804c400a was updated in 13.440s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version master was updated in 5.047s

   + 2/2 submodule(s) of module::submodulesCommands were updated in 18.487s

```

</details>
<details>
  <summary><u>Файлова структура після оновлення підмодулів</u></summary>

```
submodulesUpdate
        ├── .module
        └── .will.yml

```

</details>

Виконайте оновлення файлів віддалених підмодулів командою `will .submodules.update`. Знайдіть в виводі версії завантажених підмодулів.

Утиліта завантажила оновлення для обох підмодулів згідно встановлених версій: `#master` для підмодуля `PathFundamentals` i `#ec60e39ded1669e27abaa6fc2798ee13804c400a` для підмодуля `Tools`. Тобто, у випадку відсутності підмодуля, команда `.submodules.update` його завантажить.

У підмодуля `Tools` встановлено застарілу версію. Здійсніть його оновлення.

<details>
  <summary><u>Вивід команди <code>will .submodules.upgrade</code></u></summary>

```
[user@user ~]$ will .submodules.upgrade
...
Module at /path_to_file/.will.yml
...
  Remote path of module::submodulesCommands / module::Tools fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 <- .#ec60e39ded1669e27abaa6fc2798ee13804c400a
  in /path_to_file/submodulesUpgrade/.will.yml
Remote path of module::submodulesCommands / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

Для оновлення підмодуля `Tools` потрібно змінити його URI-посилання в `вілфайлі`. Використайте команду `will .submodules.upgrade`.

<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
  . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version 7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 was updated in 11.320s

  + 1/2 submodule(s) of module::submodulesCommands were updated in 11.420s


```

</details>
<details>
  <summary><u>Файлова структура після оновлення підмодулів</u></summary>

```
submodulesUpdate
        ├── .module
        └── .will.yml

```

</details>

Після виконання команди `.submodules.upgrade` підмодуль `Tools` змінив версію на актуальну. Тому команда `.submodules.update` змогла завантажити оновлену версію. Підмодуль `PathFundamentals` не оновився тому, що версія вітки `master` є актуальною.

### Підсумок

- Команда `.submodules.update` здійснює завантаження файлів підмодулів згідно встановлених версій.
- Команда `.submodules.update` не переписує `вілфайл`, для цього використовуються команди [`.submodules.fixate`](CommandSubmodulesFixate.md) і [`.submodules.upgrade`](CommandSubmodulesUpgrade.md).
- Розділення функцій перезапису `вілфайла` і завантаження оновлень командою `.submodules.update` запобігає виникненню збоїв в роботі модуля через зміни в підмодулях. Це дає можливість розробнику оновити віддалені підмодулі в зручний момент.

[Повернутись до змісту](../README.md#tutorials)
