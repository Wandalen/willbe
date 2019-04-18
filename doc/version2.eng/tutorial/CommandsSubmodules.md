# Commands of updating, upgrading and cleaning of submodules

Commands of updating files of submodules, upgrading submodules rewriting <code>will-file</code> automatically and cleaning of submodules removing downloaded files.

Зазвичай, один програмний продукт залежить від багатьох сторонніх модулів, бібліотек, програм. Розробка програмного забезпечення динамічний процес і версії швидко змінюються. Для забезпечення  актуальності версій нерідко доводиться слідкувати за станом продукту в офіційних джерелах. Тим не менше, при значному об'ємі допоміжного програмного забезпечення, яке розміщується в різних джерелах, потрібне швидке і безпечне здійснення оновлень. Утиліта `willbe` дозволяє розробнику слідкувати за станом розробки віддалених підмодулів з допомогою команд `.submodules.fixate` i `.submodules.upgrade.refs`, оновлювати підмодулі з командою `.submodules.update` i видаляти командою `.submodules.clean`.   

### Команда `.submodules.fixate`  
Команда `.submodules.fixate` призначена для фіксації версії підмодуля - в підмодулях, які не мають версії проводиться пошук оновлень та перезапис значень в відповідних ресурсах секції `submodule`. Команда має опцію `dry`, яка відповідає за поведінку виконання команди. При `dry:0` (значення за замовчуванням) фраза `will .submodules.fixate dry:0` знайде останні версії в репозиторіях підмодулів і замінить URL-посилання на актуальні. При значенні `dry:1` команда виводить список доступних оновлень не змінюючи `will-файл`. Команда `.submodules.fixate` пропускає підмодулі, URL-посилання яких містить указану версію підмодуля або комміт.  
Для дослідження команди створіть наступну структуру файлів в директорії `submodulesCommands`:   

<details>
  <summary><u>Структура файлів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

Внесіть в файли `.will.yml` приведений код:  

<details>
  <summary><u>Код файлів <code>.will.yml</code> в директоріях <code>submodulesFixate</code> і <code>submodulesUpgrade</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test submodule control commands"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

Файл `.will.yml` в директорії `submodulesUpgrade` призначений для дослідження команди `.submodules.upgrade.refs` тому, перейдіть в директорію `submodulesFixate` та виконайте пошук оновлень для підмодулів командою `.submodules.fixate` з опцією `dry:1` - без заміни значень:  

<details>
  <summary><u>Вивід команди <code>will .submodules.fixate dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.fixate dry:1
...
Remote path of module::submodulesCommands / module::Tools will be fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::PathFundamentals will be fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::Files will be fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/.will.yml

```

</details>

Вивід з указанням `will be fixated` говорить про те, що при опції `dry:0` ресурс буде змінено. Відкрийте файли `.will.yml` в директоріях `submodulesFixate` і `submodulesUpgrade` та змініть ресурс `Tools` в секції `submodule` на приведений:  

<details>
  <summary><u>Секція <code>submodule</code> зі змінами в підмодулі <code>Tools</code></u></summary>

```yaml    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```

</details>
<details>
  <summary><u>Структура файлів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

В підмодуль `Tools` внесене указання комміта. Застосуйте команду `.submodules.fixate` без аргументів:

<details>
  <summary><u>Вивід команди <code>will .submodules.fixate</code></u></summary>

```
[user@user ~]$ will .submodules.fixate
...
Remote path of module::submodulesCommands / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/submodulesFixate/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/submodulesFixate/.will.yml

```

</details>

Утиліта змінила ресурси в секції `submodule` `will-файлa` згідно останніх коммітів на віддаленому сервері. При цьому команда `.submodules.fixate` не змінила ресурс `Tools`, в якому вказано версію.  

### Команда `.submodules.upgrade.refs`
Команда `.submodules.upgrade.refs`, аналогічно до `.submodules.fixate`, здійснює пошук оновлень для віддалених підмодулів та перезапис значень в відповідних ресурсах секції `submodule`, має опцію `dry`. Відмінність в тому, що ресурси секції `submodule` замінюються незалежно від наявності вказаної версії підмодуля.  
Перевірте, які підмодулі потребують оновлення в `will-файлі` директорії `submodulesUpgrade`:  

<details>
  <summary><u>Вивід команди <code>will .submodules.upgrade.refs dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.upgrade.refs dry:1
...
Module at /path_to_file/.will.yml
...
  Remote path of module::submodulesCommands / module::Tools will be fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml
Remote path of module::submodulesCommands / module::PathFundamentals will be fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml
Remote path of module::submodulesCommands / module::Files will be fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

Таким чином, команда `.submodules.upgrade.refs` оновить всі застарілі посилання не зважаючи на те, що в підмодулі `Tools` вказаний комміт - застарілий комміт, який не змінювала команда `.submodules.fixate`.   

### Команда `.submodules.update` 
Команди `.submodules.fixate` i `.submodules.upgrade.refs` змінюють ресурси `will-файла` модуля, не завантажуючи оновлень. Для завантаження оновлень використовуйте команду `.submodules.update`.  
Введіть команду `will .submodules.update` в директорії `submodulesFixate`:

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
  <summary><u>Структура файлів після оновлення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           ├── .module
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

Утиліта завантажила підмодулі згідно версій указаних в `will-файлі`, тобто, в випадку відсутності віддалених підмодулів, команда `.submodules.update` їх завантажує. Зробіть апґрейд ресурсів та повторіть апдейт віддалених підмодулів в директорії `submodulesFixate`:  

<details>
  <summary><u>Вивід команди <code>will .submodules.upgrade.refs</code></u></summary>

```
[user@user ~]$ will .submodules.upgrade.refs
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
  <summary><u>Структура файлів після оновлення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           ├── .module
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

Розділення етапів оновлення ресурсів в  `will-файлі` і завантаження оновлень віддалених підмодулів забезпечує безпеку функціонування модуля.  

### Команда `.submodules.clean`    
Для видалення підмодулів з директорією `.module` використовуйте команду `will .submodules.clean`. Введіть в директорії `submodulesFixate` команду `will .submodules.clean`:

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 551 file(s) in 1.753s

```

</details>

<details>
  <summary><u>Структура файлів після видалення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml    

```

</details>

### Підсумок
- `Willbe` виконує операції з віддаленими підмодулями з командної оболонки системи.  
- Команда `.submodules.fixate` -  фіксує версію віддаленого підмодуля, а команда `.submodules.upgrade.refs` оновлює ресурси `will-файла` до останньої версії віддаленого підмодуля.  
- Використання команд `.submodules.fixate` i `.submodules.upgrade.refs` разом з командою `.submodules.update`, розділяє оновлення підмодулів на два етапи - оновлення посилань і завантаження підмодулів, що забезпечує безпечне оновлення підмодулів і надійність роботи модуля.   
- Команда `.submodules.clean` очищає модуль від завантажених підмодулів разом з директорією `.module`.

[Повернутись до змісту](../README.md#tutorials)
