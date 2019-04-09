# Як користуватись командами `.submodules.fixate` і `.submodules.upgrade.refs` 

Перевірка і встановлення актуальних версій підмодулів 

Зазвичай, один програмний продукт залежить від багатьох сторонніх модулів, бібліотек, програм. Розробка програмного забезпечення динамічний процес і версії швидко змінюється. Для забезпечення  актуальності версій нерідко доводиться безпосередньо слідкувати за станом продукту в офіційних джерелах. Тим не менше, при значному об'ємі допоміжного програмного забезпечення, яке розміщується в різних джерелах, потрібне швидке і безпечне здійснення оновлень. Утиліта `willbe` дозволяє розробнику слідкувати за станом підмодулів як допоміжного програмного забезпечення, з допомогою команд `.submodules.fixate` i `.submodules.upgrade.refs`.   

### Команда `.submodules.fixate`  
Команда `.submodules.fixate` призначена для пошуку оновлень для віддалених підмодулів та перезапису посилань в відповідних ресурсах секції `submodule`. Команда має опцію `dry`, яка відповідає за поведінку виконання команди. При `dry:0` (значення за замовчуванням) фраза `will .submodules.fixate dry:0` знайде останні оновлення в репозиторіях підмодулів і замінить URL-посилання на актуальні. При значенні `dry:1` команда виводить список доступних оновлень для підмодулів не змінюючи `will-файл`. Команда `.submodules.fixate` пропускає підмодулі URL-посилання яких містить указану версію підмодуля або комміт.  
Для дослідження команди створіть `will-файли` в директорії `submodulesVersions`:   

<details>
  <summary><u>Структура файлів</u></summary>

```
submodulesVersions
        ├── svc.will.yml
        └── .will.yml

```

</details>

Внесіть в `.will.yml` та `svc.will.yml` приведений код:  

<details>
  <summary><u>Повний код файлів <code>.will.yml</code> i <code>svc.will.yml</code></u></summary>

```yaml
about :

  name : versionControl
  description : "To test .submodules.fixate and .submodules.upgrade.refs commands"
    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

Файл `svc.will.yml` призначений для дослідження команди `.submodules.upgrade.refs`, буде використаний далі.  
Виконайте пошук оновлень для підмодулів, без їх заміни (опція `dry:1`):  

<details>
  <summary><u>Вивід фрази <code>will .submodules.fixate dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.fixate dry:1
...
Remote path of module::versionControl / module::Tools will be fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#master
  in /path_to_file/.will.yml
Remote path of module::versionControl / module::PathFundamentals will be fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#5f6be76c9e6bf832919827c34bc4eaa0c3fee0dd <- .#master
  in /path_to_file/.will.yml
Remote path of module::versionControl / module::Files will be fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#7de48ed4c9134854d7083bd8edbd2f0acf0de6d5 <- .#master
  in /path_to_file/.will.yml

```

</details>

Вивід з указанням `will be fixated` говорить про те, що при опції `dry:0` ресурс буде змінено. Відкрийте файл `.will.yml` i `svc.will.yml` та змініть ресурс `Tools` в секції `submodule`:  

<details>
  <summary><u>Зміни в секції <code>submodule</code></u></summary>

```yaml    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```

<p>Структура модуля</p>

```
submodulesVersions
        ├── svc.will.yml
        └── .will.yml

```

</details>

В підмодуль `Tools` внесене указання комміта. Оновіть підмодулі, змінивши посилання на підмодулі командою `.submodules.fixate`:

<details>
  <summary><u>Вивід фраз <code>will .submodules.fixate</code> i <code>will .submodules.update</code></u></summary>
<p>Вивід фрази <code>will .submodules.fixate</code></p>


```
[user@user ~]$ will .submodules.fixate
...
Remote path of module::versionControl / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#5f6be76c9e6bf832919827c34bc4eaa0c3fee0dd <- .#master
  in /path_to_file/.will.yml
Remote path of module::versionControl / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#7de48ed4c9134854d7083bd8edbd2f0acf0de6d5 <- .#master
  in /path_to_file/.will.yml

```

<p>Вивід фрази <code>will .submodules.update</code></p>

```
[user@user ~]$ will .submodules.update
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version ec60e39ded1669e27abaa6fc2798ee13804c400a was updated in 13.746s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version 5f6be76c9e6bf832919827c34bc4eaa0c3fee0dd was updated in 4.557s
   . Read : /path_to_file/.module/Files/out/wFiles.out.will.yml
   + module::Files version 7de48ed4c9134854d7083bd8edbd2f0acf0de6d5 was updated in 11.205s
 + 3/3 submodule(s) of module::versionControl were updated in 29.518s

```

</details>

Утиліта завантажила підмодулі згідно версій комітів на які було змінено ресурси секції `submodule` в файлі `.will.yml`. Повторне введення команди `.submodules.fixate` не змінить файл, оскільки, у всіх ресурсах вказано версію коміта.  
Розділення етапів оновлення посилань і завантаження підмодулів потрібне для того, щоб розробник міг безпечно оновити підмодулі в зручний час, наприклад, після бекапу даних модуля. 

### Команда `.submodules.upgrade.refs` 
Команда `.submodules.upgrade.refs`, аналогічно до `.submodules.fixate`, призначена для пошуку оновлень для віддалених підмодулів та перезапису посилань в відповідних ресурсах секції `submodule`, має опцію `dry`. При `dry:0` (значення за замовчуванням) утиліта знайде останні оновлення в репозиторіях підмодулів і замінить URL-посилання на актуальні. При значенні `dry:1` команда виводить список доступних оновлень для підмодулів не змінюючи `will-файл`. Команда `.submodules.upgrade.refs` шукає і замінює всі URL-посилання на підмодулі.  
Перевірте, які підмодулі потребують оновлення версії в кожному з `will-файлів`:  

<details>
  <summary><u>Вивід фрази <code>will .each . .submodules.upgrade.refs dry:1</code></u></summary>
    
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

### Підсумок
- Команди `.submodules.fixate` i `.submodules.upgrade.refs` дозволяють слідкувати за станом розробки підмодулів.  
- Використання команд `.submodules.fixate` i `.submodules.upgrade.refs` розділяє оновлення підмодулів на два етапи - оновлення посилань і завантаження підмодулів, що забезпечує безпечне оновлення підмодулів і надійність роботи модуля.

[Повернутись до змісту](../README.md#tutorials)