# Робота з підмодулями

В цьому туторіалі продовжено опис імпортованих підмодулів, більш детально розглянуто адміністування підмодулів

В попередньому туторіалі йдеться про умовне [_"наслідування"_ ресурсами властивостей секції](ImportingSubmodules.md#resource-inheritation). Якщо ствердження правильне, то ресурс має наслідувати структуру секції за замовчуванням, а для `submodule` вона включає чотири поля: `description`, `path`, `criterion`, `inherit`. Два останніх - предмет окремих туторіалів, з ними ознайомитесь пізніше, а поки що перепишемо попередній приклад:
```
submodule :

    WTools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

додавши до першого з підмодулів шлях та опис:
```
submodule :

    WTools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

Як змінилась інформація про підмодулі (`will .submodules.list`):
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
