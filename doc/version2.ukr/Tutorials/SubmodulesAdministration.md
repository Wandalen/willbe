# Оновлення та видалення підмодулів

Продовжено опис віддалених підмодулів, розглянуто команди оновлення та видалення

Окремі ресурси секцій можуть мати повну і скорочену форму запису. В попередньому туторіалі: ["Модуль "Hello, World!"](FirstWillFile.md#first-modules) в секції `submodule` ми записували підмодулі в скороченій формі: `Назва ресурса : Значення ресурса`, а повна форма включає чотири поля: `description`, `path`, `criterion`, `inherit`. Два останніх поля - предмет окремих туторіалів, з ними ознайомитесь пізніше, а поки що, створіть новий `will-файл` в директорії `second` і помістіть в нього код зі [скороченою формою](#short-form) та [повною формою](#full-form) запису підмодулів:

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary> 
  
```yaml
about :

    name : upgradeAndClean
    description : "Upgrade and clean modules"
    version : 0.0.1
        
submodule :

    Tools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

<p>Структура модуля</p>

```
second              
   └── .will.yml     
  
```

</details>


Завантажте підмодулі та перевірте інформацію фразою `will .submodules.list`:

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>
    <p>Вивід команди <code>will .submodules.download</code></p>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 15.421s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals was downloaded in 3.606s
 + 2/2 submodule(s) of module::upgradeAndClean were downloaded in 19.035s

```  

<p>Структура модуля після завантаження підмодулів</p>

```
second
   ├── .module
   │      ├── Tools
   │      └── PathFundamentals
   └── .will.yml

```

<p>Вивід команди <code>will .submodules.list</code></p>

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

### <a name="submodules-upgrade"></a> Команда `.submodules.upgrade`    
З часом з'являється нові версії підмодулів і виникає потреба їх встановити, тому, для оновлення підмодулів використовуйте команду `.submodules.upgrade`, яка зчитує дані про підмодулі та порівнює їх з віддаленими версіями і, при наявності нової версії встановить її.  
Введіть фразу `will .submodules.upgrade` 

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```
[user@user ~]$ will .submodules.upgrade
...
 + 0/2 submodule(s) of module::first were upgraded in 3.121s

```

<p>Структура модуля після оновлення підмодулів</p>

```
.
├── .module
│      ├── Tools
│      └── PathFundamentals
└── .will.yml

```

</details>

### <a name="submodules-cleaning"></a> Команда `.submodules.clean`    
Для видалення підмодулів з директорією `.module` використовуйте фразу `will .submodules.clean`. Введіть в кореневій директорії `will-файла`:

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 252 file(s) in 0.907s

```

<p>Структура модуля після очищення підмодулів</p>

```
second              
   └── .will.yml     
  
```

</details>

### Підсумок
- Ресурс секції може мати [скорочену](#short-form) і [повну](#full-form) форму запису.
- `Willbe` виконує операції з віддаленими підмодулями з командної оболонки системи.

[Наступний туторіал](ModuleCreationByBuild.md)  
[Повернутись до змісту](../README.md#tutorials)
