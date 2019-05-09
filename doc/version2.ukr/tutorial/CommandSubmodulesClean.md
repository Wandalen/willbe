# Команда <code>.submodules.clean</code>

Команда очищення модуля від тимчасових та завантажених підмодулів.

[Команда `.submodules.clean`](../concept/Command.md#Таблиця-команд-утиліти-willbe) використовується для видалення віддалених підмодулів з директорією `.module`.

### Структура файлів

<details>
  <summary><u>Файлова структура після видалення підмодулів</u></summary>

```
 submodulesClean
          └── .will.yml    

```

</details>

Для дослідження команди створіть структуру файлів вказану вище.  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.clean command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```
</details>

Внесіть код в `вілфайл`

### Використання команди `.submodules.clean`

<details>
  <summary><u>Вивід команди <code>will .submodules.download</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version 7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 was downloaded in 16.504s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 was downloaded in 5.986s

```

</details>
<details>
  <summary><u>Файлова структура після виконання команди <code>will .submodules.download</code></u></summary>

```
submodulesCommands
        ├── .module
        │      ├── PathFundamentals
        │      └── Tools
        └── .will.yml

```

</details>

Для використання команди `.submodulesClean` потрібно мати завантажені підмодулі. Завантажте підмодулі командою `will .submodules.download`. Після виконання побудови, перевірте зміни в директорії `submodulesClean`.

Утиліта створила директорію `.module`, яка містить завантажені віддалені підмодулі.    

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 551 file(s) in 1.753s

```

</details>
<details>
  <summary><u>Файлова структура після виконання команди <code>will .submodules.download</code></u></summary>

```
submodulesCommands
        └── .will.yml

```

</details>

Команда `.submodules.clean` видаляє всі завантажені підмодулі разом з директорією `.module`. Введіть команду та перевірте зміни в директорії `submodulesClean`.

Модуль повернувся до початкового стану. `Вілфайл` не змінився.

### Підсумок

- Команда `.submodules.clean` корисна при необхіності очищення модуля від завантажених підмодулів.
- Команда `.submodules.clean` не змінює `вілфайл`.

[Повернутись до змісту](../README.md#tutorials)
