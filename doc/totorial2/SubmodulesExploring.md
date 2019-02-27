# Робота з підмодулями

В туторіалі продовжено опис імпортованих підмодулів, більш детально розглянуто їх адміністрування

В попередньому туторіалі йдеться про умовне [_"наслідування"_ ресурсами властивостей секції](ImportingSubmodules.md#resource-inheritation), тобто, ресурс має наслідувати структуру секції за замовчуванням, а для `submodule` вона включає чотири поля: `description`, `path`, `criterion`, `inherit`. Два останніх - предмет окремих туторіалів, з ними ознайомитесь пізніше, а поки що перепишемо попередній приклад:
<a name="short-form">
```yaml
submodule :

    WTools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

додавши до першого з підмодулів поля `path` та `description`:
<a name="full-form">
```yaml
submodule :

    WTools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

Введіть в консолі `will .submodules.list`:
```
...
submodule::WTools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  description : Import willbe tools
  isDownloaded : true
  Exported builds : [ 'proto.export' ]
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```  

<a name="submodules-cleaning">
    
Маємо один завантажений підмодуль з описом. Для завантаження другого введіть фразу `will .submodules.download`. Проте, якщо підмодулі посилаються на взаємні файли є ризик виникнення конфліктів в системі. Для запобігання таких випадків попередньо виконаємо `will .submodules.clean`, яка видалить директорію `.module`.

```
will .submodules.clean
Request ".submodules.clean"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.082s
 . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
 - Clean deleted 252 file(s) in 0.907s

```

Після `.submodules.download` структура модуля матиме вигляд:
```
.
├── .module
|   ├──WTools
|   └──PathFundamentals
└── .will.yml

```  

<a name="submodules-by-build">
    
При складанні власного модуля, де використовуються зовнішні підмодулі, зручніше внести в секцію `build` кроки операцій з підмодулями.  
Додайте в `.will.yml` наступний фрагмент:
    
```yaml

build :

  submodules.download:
           criterion :
             default : 1
           steps :
             - submodules.download

```

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    WTools :
      path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
      description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

build :

  submodules.download:
           criterion :
             default : 1
           steps :
             - submodules.download

```

</details>

Секція `build` має одну процедуру під назвою `submodules.download`, яка за замовчуванням завантажує підмодулі використовуючи `submodules.download`.  
Очистимо директорію ввівши `will .submodules.clean` та виконаємо `will .build`:

```
[user@user ~]$ will .build
Request ".build"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.063s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

  Building submodules.download
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.828s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 1.424s
   + 2/2 submodule(s) of module::first were downloaded in 14.259s
  Built submodules.download in 14.300s

```

Результат подібний до використання команди `will .submodules.download`, проте, далі ми можемо удосконалити модуль і така структура запису буде доречною.


### Підсумок
- Ресурс секції може мати [скорочену](#short-form) і [повну](#full-form) форму запису.
- Для запобігання виникнення конфліктів в підмодулях системи бажано попередньо [очистити директорію `.module`](#submodules-cleaning).
- Для роботи з підмодулями зручно використовувати секцію `build` та вбудовані функції `willbe`.

[Наступний туторіал](ShellUsingByWillbe.ukr.md)  
[Повернутись до меню](Topics.ukr.md)
