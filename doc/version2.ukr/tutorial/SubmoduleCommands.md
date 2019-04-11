# Команди оновлення, апгрейду та очищення підмодулів

Команди оновлення підмодулів, апгрейду підмодулів автоматизовним перезаписом <code>will-файла</code> та очищення модуля.

Зазвичай, один програмний продукт залежить від багатьох сторонніх модулів, бібліотек, програм. Розробка програмного забезпечення динамічний процес і версії швидко змінюються. Для забезпечення  актуальності версій нерідко доводиться безпосередньо слідкувати за станом продукту в офіційних джерелах. Тим не менше, при значному об'ємі допоміжного програмного забезпечення, яке розміщується в різних джерелах, потрібне швидке і безпечне здійснення оновлень. Утиліта `willbe` дозволяє розробнику слідкувати за станом розробки віддалених підмодулів з допомогою команд `.submodules.fixate` i `.submodules.upgrade.refs`, оновлювати підмодулі з командою `.submodules.update` i видаляти командою `.submodules.clean`.   

### Команда `.submodules.fixate`  
Команда `.submodules.fixate` призначена для пошуку оновлень для віддалених підмодулів та перезапису посилань в відповідних ресурсах секції `submodule`. Команда має опцію `dry`, яка відповідає за поведінку виконання команди. При `dry:0` (значення за замовчуванням) фраза `will .submodules.fixate dry:0` знайде останні оновлення в репозиторіях підмодулів і замінить URL-посилання на актуальні. При значенні `dry:1` команда виводить список доступних оновлень для підмодулів не змінюючи `will-файл`. Команда `.submodules.fixate` пропускає підмодулі URL-посилання яких містить указану версію підмодуля або комміт.  
Для дослідження команди створіть `will-файли` в директорії `submodulesCommands`:   

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
  <summary><u>Повний код файлів <code>.will.yml</code></u></summary>

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

Файл `.will.yml` в директорії `submodulesUpgrade` призначений для дослідження команди `.submodules.upgrade.refs`, перейдіть в директорію `submodulesFixate` та виконайте пошук оновлень для підмодулів командою `.submodules.fixate` без їх заміни (опція `dry:1`):  

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

Вивід з указанням `will be fixated` говорить про те, що при опції `dry:0` ресурс буде змінено. Відкрийте файли `.will.yml` в директоріях `submodulesFixate` і `submodulesUpgrade` та змініть ресурс `Tools` в секції `submodule`:  

<details>
  <summary><u>Секція <code>submodule</code> зі змінами</u></summary>

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
  <summary><u>Вивід фрази <code>will .submodules.fixate</code></u></summary>

```
[user@user ~]$ will .submodules.fixate
...
Remote path of module::submodulesCommands / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/.will.yml

```

</details>

Утиліта змінила ресурси в секції `submodule` `will-файлa` згідно останніх комітів на віддаленому сервері. При цьому команда `.submodules.fixate` не змінює ресурси в яких вказано версію.  
Розділення етапів оновлення посилань і завантаження підмодулів потрібне для того, щоб розробник міг безпечно оновити підмодулі в зручний час, наприклад, після бекапу даних модуля.

### Команда `.submodules.upgrade.refs`
Команда `.submodules.upgrade.refs`, аналогічно до `.submodules.fixate`, призначена для пошуку оновлень для віддалених підмодулів та перезапису посилань в відповідних ресурсах секції `submodule`, має опцію `dry`. При `dry:0` (значення за замовчуванням) утиліта знайде останні оновлення в репозиторіях підмодулів і замінить URL-посилання на актуальні. При значенні `dry:1` команда виводить список доступних оновлень для підмодулів не змінюючи `will-файл`. Команда `.submodules.upgrade.refs` шукає і замінює всі URL-посилання на підмодулі.  
Перевірте, які підмодулі потребують оновлення версії в кожному з `will-файлів`:  

<details>
  <summary><u>Вивід команди <code>will .each . .submodules.upgrade.refs dry:1</code></u></summary>

```
[user@user ~]$ will .each . .submodules.upgrade.refs dry:1
...
Module at /path_to_file/.will.yml
...
 . Read 4 will-files in 2.914s

  Remote path of module::versionControl / module::Tools will be fixated
    git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#ec60e39ded1669e27abaa6fc2798ee13804c400a
    in /path_to_file/.will.yml

Module at /path_to_file/svc.will.yml
...
 . Read 4 will-files in 2.645s

  Remote path of module::versionControl / module::Tools will be fixated
    git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#ec60e39ded1669e27abaa6fc2798ee13804c400a
    in /path_to_file/svc.will.yml
  Remote path of module::versionControl / module::PathFundamentals will be fixated
    git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#5f6be76c9e6bf832919827c34bc4eaa0c3fee0dd <- .#master
    in /path_to_file/svc.will.yml
  Remote path of module::versionControl / module::Files will be fixated
    git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#7de48ed4c9134854d7083bd8edbd2f0acf0de6d5 <- .#master
    in /path_to_file/svc.will.yml

```

</details>

Таким чином, команда `.submodules.upgrade.refs` оновить всі застарілі посилання не зважаючи на те, що в підмодулі `Tools` вказаний комміт - застарілий комміт, який не оновлювала команда `.submodules.fixate`. В файлі `.will.yml` буде оновлено посилання на ресурс `Tools` - команда `.submodules.fixate` оновила посилання на `Files` i `PathFundamentals`, а в файлі `svc.will.yml` буде оновлено всі посилання.  

### Команда `.submodules.update`    
З часом з'являється нові версії підмодулів і виникає потреба їх оновити. За оновлення підмодулів в утиліті `willbe` відповідає команда `.submodules.update`, яка зчитує дані про кожен завантажений підмодуль, порівнює їх з віддаленими версіями і, при наявності нової версії, встановить її.  
Введіть команду `will .submodules.update`

<details>
  <summary><u>Вивід команди <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
 + 0/2 submodule(s) of module::first were upgraded in 3.121s

```

</details>

<details>
  <summary><u>Структура модуля після оновлення підмодулів</u></summary>

```
.
├── .module
│      ├── Tools
│      └── PathFundamentals
└── .will.yml

```

</details>

Оновлення не відбулось, так як завантажені підмодулі мають актуальні версії. В випадку відсутності підмодуля команда його завантажує.  

### Команда `.submodules.clean`    
Для видалення підмодулів з директорією `.module` використовуйте фразу `will .submodules.clean`. Введіть в кореневій директорії `will-файла`:

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 252 file(s) in 0.907s

```

</details>

<details>
  <summary><u>Структура модуля після очищення підмодулів</u></summary>

```
second              
   └── .will.yml     

```

</details>

### Підсумок
- `Willbe` виконує операції з віддаленими підмодулями з командної оболонки системи.  
- Команди `.submodules.fixate` i `.submodules.upgrade.refs` дозволяють слідкувати за станом розробки підмодулів.  
- Використання команд `.submodules.fixate` i `.submodules.upgrade.refs` розділяє оновлення підмодулів на два етапи - оновлення посилань і завантаження підмодулів, що забезпечує безпечне оновлення підмодулів і надійність роботи модуля.

[Повернутись до змісту](../README.md#tutorials)
