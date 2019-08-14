# Команда <code>.submodules.upgrade</code>

Команда апгрейду версій підмодулів автоматизовним перезаписом <code>вілфайла</code>.

Підмодулі можуть бути [зафіксовані](CommandSubmodulesFixate.md) на версіях доступних в момент експортування. Команда `.submodules.upgrade` дозволяє зафіксувати підмодулі на новіших версіях.

Команда призначена для автоматизованого перезапису URI-адрес віддалених підмодулів  в `вілфайлі` на URI найновіших версій підмодулів. При цьому завантаження файлів цих підмодулів автоматично не відбувається.

Для того щоб отримати іфнормацію про можливість апгрейду підмодулів без внесення змін використовуйте опцію `dry`. При значенні `dry:1` команда `will .submodules.upgrade dry:1` виконує всі операції, виводить список доступних оновлень не змінюючи, при цьому, жодного файла. Значення за замовчуванням `dry:0`.

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
  PathBasic : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

Для підмодуля `Tools` вказана версія.

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
Remote path of module::submodulesCommands / module::PathBasic fixated
  git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic : .#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#075ce0ca21af083bc879b0d1a4091a29ed4a16d2 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

Оновіть URI-посилань підмодулів командою `will .submodules.upgrade`.

Вивід свідчить, що команда `.submodules.upgrade` оновила всі три URI-посилання підмодулів до найновіших (на момент виконання). Попри те, що для підмодуля `Tools` вказано версію підмодуля його теж було апгрейднуто.

Команда `.submodules.upgrade` здійснює перезапис версій в [неформальних підмодулях](SubmoduleInformal.md), якщо вони присутні в `вілфайлі`.

Команда `.submodules.upgrade` корисна для здійснення автоматичного оновлення підмодулів до найновіших версій. Команда лише переписує `вілфайли`. Команда не здійснює завантаження файлів підмодулів. Для завантаження файлів підмодулів використайте [команду `.submodules.update`](CommandSubmodulesUpdate.md).

### Підсумок

- Команда `.submodules.upgrade` переписує вміст `вілфайлів` апгрейдячи версії підмодулів;
- Команда `.submodules.upgrade` не здійснює завантаження файлів підмодулів;
- Команда `.submodules.upgrade` дозволяє розробнику забезпечити стабільність роботи модуля оновлюючи підмодулі лише в потрібний момент.

[Повернутись до змісту](../README.md#tutorials)
