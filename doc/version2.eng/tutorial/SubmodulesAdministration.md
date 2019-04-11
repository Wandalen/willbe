# Оновлення та видалення підмодулів

Команди оновлення підмодулів завантаженням файлів, апгрейду підмодулів автоматизовним перезаписом <code>will-файлу</code> та команда очищення підмодулів видаленням завантажених файлів.

### Kos : bad name of file

Окремі ресурси секцій можуть мати повну і скорочену форму запису. В [попередньому туторіалі](FirstWillFile.md#first-modules), в секції `submodule`, підмодулі записувались в скороченій формі: `Назва ресурса : Значення ресурса`, а повна форма може включати чотири поля: `description`, `path`, `criterion`, `inherit`.   
Створіть новий `will-файл` в директорії `second` і помістіть в нього код зі [скороченою формою](#short-form) та [повною формою](#full-form) запису підмодулів:

<details>
  <summary><u>Код файла<code>.will.yml</code></u></summary>

```yaml
about :

    name : upgradeAndClean
    description : "Upgrade and clean modules"
    version : 0.0.1

submodule :

    Tools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master  # повна (розширена) форма запису
       description : 'Import willbe tools'                                    
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master  # скорочена форма запису

```

</details>

<details>
  <summary><u>Структура файлів</u></summary>

```
second              
   └── .will.yml     

```

</details>

Завантажте підмодулі та перевірте інформацію фразою `will .submodules.list`:

<details>
  <summary><u>Вивід команди <code>will .submodules.download</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 15.421s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals was downloaded in 3.606s
 + 2/2 submodule(s) of module::upgradeAndClean were downloaded in 19.035s

```  
</details>

<details>
  <summary><u>Структура модуля після завантаження підмодулів</u></summary>

```
second
   ├── .module
   │      ├── Tools
   │      └── PathFundamentals
   └── .will.yml

```

</details>

<details>
  <summary><u>Вивід команди <code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  description : Import willbe tools
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```

</details>

Вивід інформації по підмодулю `Tools` відрізняється полем `description`. Додаткові поля потрібні для точного опису ресурсу, а скорочена дає загальне поняття.

### <a name="submodules-update"></a> Команда `.submodules.update`    
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

### Команда `.submodules.upgrade.refs`  
Команда `.submodules.upgrade.refs` призначена для пошуку оновлень віддалених підмодулів та перезапису посилань в відповідних ресурсах секції `submodule`. На відміну від `.submodules.update` команда не виконує оновлень підмодулів, а дає можливість слідкувати за змінами в віддалених ресурсами. Детальніше з командою `.submodules.upgrade.refs` можна ознайомитись в туторіалі ["Як користуватись командами `.submodules.fixate` і `.submodules.upgrade.refs`"](SubmodulesVersionControl.md).

### <a name="submodules-cleaning"></a> Команда `.submodules.clean`    
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
- Утиліта здатна слідкувати за оновленнями віддалених підмодулів без їх завантаження.

[Наступний туторіал](Build.md)  
[Повернутись до змісту](../README.md#tutorials)
