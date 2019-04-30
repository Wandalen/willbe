# Команда <code>.submodules.upgrade</code>

Команда апгрейду версій підмодулів автоматизовним перезаписом <code>вілфайла</code>.

<<<<<<< HEAD
Зазвичай, один програмний продукт залежить від багатьох сторонніх модулів, бібліотек, програм. Розробка програмного забезпечення - динамічний процес і їх версії постійно змінюються. Саме тому, потрібне швидке і безпечне оновлення допоміжного програмного забезпечення, в термінології `willbe`, підмодулів.
=======
Перед побудовою модуля використовується [фіксування версій](CommandSubmodulesFixate.md) віддалених підмодулів для забезпечення надійної роботи. Та з часом, виникає потреба оновити підмодулі до нових версій. І для цього використовується команда `.submodules.upgrade`.
>>>>>>> e9627f6e1dfbe150e062e2ddfe76733582d858e1

Команда призначена для автоматизованого перезапису URI-адрес віддалених підмодулів  в `вілфайлі` на URI найновіших версій підмодулів. При цьому завантаження файлів цих підмодулів автоматично не відбувається. 

<<<<<<< HEAD
### Команда `.submodules.fixate`

Команда `.submodules.fixate` призначена для автоматизованого запису (фіксації) поточної версії підмодуля в `вілфайл`. Фіксація проводиться для підмодулів, які не мають версії, тобто, посилання не містить вказаної версії програми чи коміту.

Команда має опцію `dry` для ввімкнення перезапису `вілфайла`. Опція `dry` приймає значення `0` i `1`. При `dry:0` (значення за замовчуванням) фраза замінить URI-посилання на актуальні. При значенні `dry:1` команда `will .submodules.fixate dry:1` виводить список доступних оновлень не змінюючи `вілфайл`. Команда `.submodules.fixate` пропускає підмодулі з вказаними версіями підмодуля або комміту.    
=======
Команда має опцію `dry` для ввімкнення перезапису `вілфайла`, яка приймає значення `0` i `1`. При `dry:0` команда здійснює перезапис URI-посилань. При значенні `dry:1` команда `will .submodules.fixate dry:1` виконує всі операцію, виводить список доступних оновлень не змінюючи, при цьому, `вілфайл`. Ззначення за замовчуванням `dry:0`.

### Структура файлів
>>>>>>> e9627f6e1dfbe150e062e2ddfe76733582d858e1

<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesUpgrade
          └── .will.yml

```

</details>

<<<<<<< HEAD
Для дослідження команди створіть приведену структуру файлів в директорії `submodulesCommands`.
=======
Для дослідження команди створіть структуру файлів вказану вище та внесіть код в `вілфайл`.  
>>>>>>> e9627f6e1dfbe150e062e2ddfe76733582d858e1

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.upgrade command"

<<<<<<< HEAD
```

</details>

Файл `.will.yml` в директорії `submodulesUpgrade` призначений для дослідження команди `.submodules.upgrade` тому, перейдіть в директорію `submodulesFixate` та виконайте пошук оновлень для підмодулів командою `.submodules.fixate` з опцією `dry:1` - без заміни значень.

Вивід з указанням `will be fixated` говорить про те, що при опції `dry:0` ресурс буде змінено.  

<details>
  <summary><u>Секція <code>submodule</code> зі змінами в підмодулі <code>Tools</code></u></summary>

```yaml    
=======
>>>>>>> e9627f6e1dfbe150e062e2ddfe76733582d858e1
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

<<<<<<< HEAD
Перевірте, які підмодулі потребують оновлення в `вілфайлі` директорії `submodulesUpgrade`.

Вивід свідчить, що команда `.submodules.upgrade.refs` оновить всі застарілі посилання не зважаючи на те, що в підмодулі `Tools` вказаний комміт - застарілий комміт, який не змінювала команда `.submodules.fixate`.   

### Команда `.submodules.update`

Команди `.submodules.fixate` i `.submodules.upgrade.refs` переписують ресурси `вілфайла` не виконуючи оновлення. Це дозволяє розробнику вибрати зручний момент для оновлення і забезпечити надійне функціонування модуля.  

Для завантаження і встановлення оновлень використовуйте команду `.submodules.update`.  

<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
   . Read : /path_to_file/submodulesFixate/.module/Tools/out/wTools.out.will.yml
   + module::Tools version ec60e39ded1669e27abaa6fc2798ee13804c400a was downloaded in 14.897s
   . Read : /path_to_file/submodulesFixate/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version 84dd78771fd257bf8599dafe3cc37a9407a29896 was downloaded in 3.464s
   . Read : /path_to_file/submodulesFixate/.module/Files/out/wFiles.out.will.yml
   + module::Files version 5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 was downloaded in 10.199s
 + 3/3 submodule(s) of module::submodulesCommands were downloaded in 28.569s

```

</details>
<details>
  <summary><u>Файлова структура після оновлення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           ├── .module
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

Введіть команду `will .submodules.update` в директорії `submodulesFixate`.

Утиліта завантажила підмодулі згідно версій указаних в `вілфайлі`. Тобто, якщо модуль має незавантажені підмодулі, наприклад, додані після побудови, то команда `.submodules.update` їх завантажить.  

<details>
  <summary><u>Вивід команди <code>will .submodules.upgrade</code></u></summary>

```
[user@user ~]$ will .submodules.upgrade
...
Remote path of module::submodulesCommands / module::Tools fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#ec60e39ded1669e27abaa6fc2798ee13804c400a
  in /path_to_file/submodulesFixate/.will.yml

```

</details>
<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
   . Read : /path_to_file/submodulesFixate/.module/Tools/out/wTools.out.will.yml
   + module::Tools version 56afe924c2680301078ccb8ad24a9e7be7008485 was updated in 15.177s
   . Read : /path_to_file/submodulesFixate/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version 84dd78771fd257bf8599dafe3cc37a9407a29896 was updated in 3.489s
   . Read : /path_to_file/submodulesFixate/.module/Files/out/wFiles.out.will.yml
   + module::Files version 5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 was updated in 11.897s
 + 3/3 submodule(s) of module::submodulesCommands were updated in 30.574s

```

</details>
<details>
  <summary><u>Файлова структура після оновлення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           ├── .module
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

Зробіть апґрейд ресурсів та повторіть апдейт віддалених підмодулів в директорії `submodulesFixate`.  

Було оновлено застарілу версію підмодуля `Tools` та встановлено оновлення підмодулів.

### Команда `.submodules.clean`    

Для видалення підмодулів з директорією `.module` використовуйте команду `will .submodules.clean`.

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 551 file(s) in 1.753s

```

</details>

<details>
  <summary><u>Файлова структура після видалення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml    

```

</details>
=======
Здійсніть оновлення URI-посилань підмодулів командою `will .submodules.upgrade`.

Вивід свідчить, що команда `.submodules.upgrade` оновила всі три URI-посилання підмодулів до найновіших (на момент виконання). Не зважаючи на вказану версію підмодуля `Tools`, команда замінила підмодуль `Tools`. 
>>>>>>> e9627f6e1dfbe150e062e2ddfe76733582d858e1

Команда `.submodules.upgrade` корисна для здійснення безпечного оновлення підмодулів до найновіших версій. Команда переписує виключно `вілфайл` і не завантажує файли підмодулів. Тому, розробник має змогу завантажити оновлення підмодулів в зручний момент [командою `.submodules.update`](CommandSubmodulesUpdate.md).

### Підсумок

- Команда `.submodules.upgrade` автоматично змінює вміст `вілфайла` для розробника;
- Команда `.submodules.upgrade` не здійснює завантаження файлів підмодулів;
- Команда `.submodules.upgrade` дозволяє розробнику забезпечити стабільність роботи модуля і безпечне оновлення віддалених підмодулів в потрібний момент (з допомогою [команди `.submodules.update`](CommandSubmodulesUpdate.md)).

[Повернутись до змісту](../README.md#tutorials)
