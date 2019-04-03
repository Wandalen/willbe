# How to use `.submodules.fixate` and `.submodules.upgrade.refs` commands 

Перевірка і встановлення актуальних версій підмодулів 

Зазвичай, один програмний продукт залежить від багатьох сторонніх модулів, бібліотек, програм. Розробка програмного забезпечення динамічний процес і версії швидко змінюється. Для забезпечення  актуальності версій нерідко доводиться безпосередньо слідкувати за станом продукту в офіційних джерелах. Тим не менше, при значному об'ємі допоміжного програмного забезпечення, яке розміщується в різних джерелах, потрібне швидке і безпечне здійснення оновлень. Утиліта `willbe` дозволяє розробнику слідкувати за станом підмодулів, як допоміжного програмного забезпечення, з допомогою команд `.submodules.fixate` i `.submodules.upgrade.refs`.   

### Команда `.submodules.fixate`  
Команда `.submodules.fixate` призначена для пошуку оновлень для віддалених підмодулів та заміни значень в відповідних ресурсах секції `submodule`. Команда має опцію `dry`, яка відповідає за поведінку виконання команди. При `dry:0` (значення за замовчуванням) фраза `will .submodules.fixate dry:0` знайде останні оновлення в репозиторіях підмодулів і замінить URL-посилання на актуальні. При значенні `dry:1` команда виводить список доступних оновлень для підмодулів не змінюючи `will-файл`. Команда `.submodules.fixate` пропускає підмодулі URL-посилання яких містить указану версію підмодуля.  
Для дослідження команди створіть `will-файли` в директорії `submodulesVersions`. Внесіть в `.will.yml` та `svc.will.yml` код:  

<details>
  <summary><u>Повний код файлів, структура файлів</u></summary>

```yaml

about :

  name : versionControl
  description : "To test .submodules.fixate and .submodules.upgrade.refs commands"
    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
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

Файл `svc.will.yml` призначений для дослідження команди `.submodules.upgrade.refs`, буде використаний далі.  
Виконайте пошук оновлень для підмодулів, без їх завантаження (опція `dry:1`):  

<details>
  <summary><u>Вивід фрази <code>will .submodules.fixate dry:1</code></u></summary>

```
[user@user ~]$ will .export
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

