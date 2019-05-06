# Команда <code>.submodules.upgrade</code>

Команда апгрейду версій підмодулів автоматизовним перезаписом <code>вілфайла</code>.

Перед побудовою модуля використовується [фіксування версій](CommandSubmodulesFixate.md) віддалених підмодулів для забезпечення надійної роботи. Та з часом, виникає потреба оновити підмодулі до нових версій. І для цього використовується [команда `.submodules.upgrade`](../concept/Command.md#Таблиця-команд-утиліти-willbe).

Команда призначена для автоматизованого перезапису URI-адрес віддалених підмодулів  в `вілфайлі` на URI найновіших версій підмодулів. При цьому завантаження файлів цих підмодулів автоматично не відбувається. 

Команда має опцію `dry` для ввімкнення перезапису `вілфайла`, яка приймає значення `0` i `1`. При `dry:0` команда здійснює перезапис URI-посилань. При значенні `dry:1` команда `will .submodules.fixate dry:1` виконує всі операцію, виводить список доступних оновлень не змінюючи, при цьому, `вілфайл`. Ззначення за замовчуванням `dry:0`.

### Структура файлів

<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesUpgrade
          └── .will.yml

```

</details>

Для дослідження команди створіть структуру файлів вказану вище та внесіть код в `вілфайл`.  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.upgrade command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

Підмодуль `Tools` має версію коміта для дослідження поведінки команди `.submodules.upgrade` з ресурсами з указаною версією.

### Використання команди `.submodules.upgrade`

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
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#075ce0ca21af083bc879b0d1a4091a29ed4a16d2 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

Здійсніть оновлення URI-посилань підмодулів командою `will .submodules.upgrade`.

Вивід свідчить, що команда `.submodules.upgrade` оновила всі три URI-посилання підмодулів до найновіших (на момент виконання). Не зважаючи на вказану версію підмодуля `Tools`, команда замінила підмодуль `Tools`. 

Команда `.submodules.upgrade` корисна для здійснення безпечного оновлення підмодулів до найновіших версій. Команда переписує виключно `вілфайл` і не завантажує файли підмодулів. Тому, розробник має змогу завантажити оновлення підмодулів в зручний момент [командою `.submodules.update`](CommandSubmodulesUpdate.md).

### Підсумок

- Команда `.submodules.upgrade` автоматично змінює вміст `вілфайла` для розробника;
- Команда `.submodules.upgrade` не здійснює завантаження файлів підмодулів;
- Команда `.submodules.upgrade` дозволяє розробнику забезпечити стабільність роботи модуля і безпечне оновлення віддалених підмодулів в потрібний момент (з допомогою [команди `.submodules.update`](CommandSubmodulesUpdate.md)).

[Повернутись до змісту](../README.md#tutorials)