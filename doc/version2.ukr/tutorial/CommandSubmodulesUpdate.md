# Команда <code>.submodules.update</code>

Команда оновлення файлів віддалених підмодулів.

Команди [`.submodules.fixate`](CommandSubmodulesFixate.md) і [`.submodules.upgrade`](CommandSubmodulesUpgrade.md) здійснюють заміну URI-посилань в `вілфайл`, але не здійснюють завантаження файлів цих підмодулів. Вони потрібні для контролю версій віддалених підмодулів і дають змогу розробнику встановити і зафіксувати оновлення в зручний момент. Для завантаження оновлень використовується команда [`.submodules.update`](../concept/Command.md#Таблиця-команд-утиліти-willbe).

Для того щоб отримати іфнормацію про можливість оновлення файлів підмодулів без фактичного оновлення використовуйте опцію `dry`. При значенні `dry:1` команда `will .submodules.update dry:1` виконує всі операції, виводить список доступних оновлень не змінюючи, при цьому, жодного файла. Значення за замовчуванням `dry:0`.

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
  PathBasic : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master

```

</details>

Для підмодуля `Tools` вказана версія.

### Команда `.submodules.update`

<details>
  <summary><u>Вивід команди <code>will .submodules.update dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.update dry:1
...
  + module::Tools will be updated to version ec60e39ded1669e27abaa6fc2798ee13804c400a
  + module::PathBasic will be updated to version aa4b10e291c0cb0e79961b6ece128da544f00568

```

</details>

Використайте команду `will .submodules.update dry:1` щоб дізнатися до яких версій можна оновити підмодулі. Опція `dry:1` щоб файли підмодулів не завантажувалися.

Вивід показує (на момент створення туторіалу):
- для підмодуля `Tools` буде здійснено оновлення до вказаної версії коміту `#ec60e39ded1669e27abaa6fc2798ee13804c400a`;
- в підмодулі `PathBasic` буде здійснено оновлення до версії `#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7`.

<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
  . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version ec60e39ded1669e27abaa6fc2798ee13804c400a was updated in 13.440s
   . Read : /path_to_file/.module/PathBasic/out/wPathBasic.out.will.yml
   + module::PathBasic version master was updated in 5.047s

   + 2/2 submodule(s) of module::submodulesCommands were updated in 18.487s

```

</details>

Виконайте оновлення файлів віддалених підмодулів командою `will .submodules.update`. Знайдіть в виводі версії завантажених підмодулів.


<details>
  <summary><u>Файлова структура після оновлення підмодулів</u></summary>

```
submodulesUpdate
        ├── .module
        └── .will.yml

```

</details>

З'явилася директорія для підмодулів `.module`.

Утиліта завантажила оновлення для обох підмодулів згідно встановлених версій: `#master` для підмодуля `PathBasic` i `#ec60e39ded1669e27abaa6fc2798ee13804c400a` для підмодуля `Tools`.  

Версія підмодуля `Tools` застаріла. Здійсніть його оновлення.

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
Remote path of module::submodulesCommands / module::PathBasic fixated
  git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic : .#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

Для оновлення підмодуля `Tools` потрібно змінити його URI-посилання в `вілфайлі`. Команду `will .submodules.upgrade` робить це автоматично.


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

Після виконання команди `.submodules.upgrade` підмодуль `Tools` змінив версію на новішу `7db7bd21ac76fc495aae44cc8b1c4474ce5012a4`. Тому, виклик команди `.submodules.update` завантажив цю оновлену версію. Порівняйте з приведеним вище виводом.

### Підсумок

- Команда `.submodules.update` здійснює завантаження файлів підмодулів.
- Команда `.submodules.update` не переписує `вілфайли`, для цього використовуються команди [`.submodules.fixate`](CommandSubmodulesFixate.md) і [`.submodules.upgrade`](CommandSubmodulesUpgrade.md).
- Розділення функцій перезапису `вілфайла` і завантаження оновлень командою `.submodules.update` запобігає виникненню збоїв в процесі зрозробки через зміни в підмодулях. Це дає можливість розробнику оновити віддалені підмодулі в зручний момент.

[Повернутись до змісту](../README.md#tutorials)
