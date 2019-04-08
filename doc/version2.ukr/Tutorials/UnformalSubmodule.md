# Неформальний підмодуль

Створення неформального підмодуля

Якщо підмодуль, який потрібен для функціонування вашого додатку, розроблений сторонньою оргранізацією (програмістами) без застосування утиліти `willbe`, то є можливість його непрямого імпорту в проект - створення неформального підмодуля. Неформальний підмодуль - підмодуль, завантажений з віддаленого джерела, експортований і підключений як локальний.  

### Побудова неформального підмодуля. Конфігурація  
Створіть конфігурацію, що приведена нижче:  

<details>
  <summary><u>Структура файлів</u></summary>

```
informalModule
        ├── module
        │     └── Color.informal.will.yml
        └── .will.yml

```

</details>

В структурі розділено конфігураційний файл модуля `.will.yml` i файл для створення  підмодуля `Color.informal.will.yml`. Запишіть в `Color.informal.will.yml` код:  

<details>
  <summary><u>Повний код <code>Color.informal.will.yml</code></u></summary>

```yaml
about :

  name : Color.informal
  version : 0.0.1

path :

  in : '..'
  out : 'out'
  predefined.remote : 'git+https:///github.com/Wandalen/wColor.git'
  predefined.local : './.module/Color'
  export : '{path::predefined.local}/proto'

reflector :

  download.informal :
    src : path::predefined.remote
    dst : path::predefined.local

step :

  export.module :
    export : path::export
    tar : 0

build :

  export.informal :
    criterion :
      default : 1
      export : 1
    steps :
      - step::download.informal
      - step::export.module
      
```

</details>

В збірці `export.informal` є два кроки. Перший - `download.informal` для завантаження підмодуля з Git-репозиторію `https://github.com/Wandalen/wColor.git` в локальну директорію `./.module/Color` - директорію для віддалених підмодулів `.module`. Крок не вказаний в `will-файлі`, його генерує утиліта в оперативну пам'ять за назвою рефлектора. Другий крок - `export.module` створює експорт модуля за шляхом `{path::predefined.local}/proto`, тобто, `./.module/Color/proto`.  

<details>
  <summary><u>Повний код <code>.will.yml</code></u></summary>

```yaml
about :
  name : informalSubmodule
  description : "To make submodule from Git-repository"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  Color : out/Color.informal.out

path :

  in : '.'
  out : 'out'
  proto : './proto'
  out.debug : 
    path : './out/module.debug'
    criterion :
      debug : 1
  out.release : 
    path : './out/module.release'
    criterion :
      debug : 0

reflector :

  reflect.submodules :
    inherit : submodule::*/exported::*=1/reflector::exportedFiles*=1
    dst :
      basePath : .
      prefixPath : path::out.*=1
    criterion :
      debug : 1

step :

  submodules.informal.export :
    currentPath : path::predefined.dir
    shell : 'node {path::predefined.willbe} .each module .export'

build :

  make.informal :
    criterion :
      default : 1
      debug : 1
    steps :
      - submodules.download
      - submodules.informal.export
      - submodules.reload
      - reflect.submodules*=1
      
```

</details>

Збірка `make.informal` містить чотири кроки. Перший - завантаження віддалених підмодулів, другий - запуск побудови збірки експорту для кожного `will-файла` в директорії `module`, тобто, директорії з файлом `Color.informal.will.yml`. Третій крок - вбудований крок, що перезавантажує статус підмодулів. Четвертий - `reflect.submodules`, з допомогою одноіменного рефлектора копіює експортовані файли підмодулів в директорію `./out/module.debug` (за критеріоном `debug : 1`).

### Виконання побудови
В директорії файла `.will.yml` виконайте фразу `will .build`: 

<details>
  <summary><u>Вивід фрази <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
Command ".build"
 . Read : /path_to_file/.will.yml
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even .clean it before downloading
 ! Failed to read submodule::Color, try to download it with .submodules.download or even .clean it before downloading
 . Read 1 will-files in 1.987s 

  Building module::informalSubmodule / build::make.informal
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 15.715s
   + 1/2 submodule(s) of module::informalSubmodule were downloaded in 15.722s
 > node /usr/lib/node_modules/willbe/proto/dwtools/atop/will/Exec .each module .export
Command ".each module .export"

Module at /path_to_file/module/Color.informal.will.yml
 . Read : /path_to_file/module/Color.informal.will.yml
 . Read 1 will-files in 0.566s 

    Exporting module::Color.informal / build::export
     + download.informal reflected 71 files :/// : path_to_file/.module/Color <- git+https://github.com/Wandalen/wColor.git in 3.652s
     + Write out will-file /path_to_file/out/Color.informal.out.will.yml
     + Exported export with 8 files in 1.524s
    Exported module::Color.informal / build::export in 5.243s

   . Reloading submodules..
   . Read : /path_to_file/out/Color.informal.out.will.yml
   + reflect.submodules.debug reflected 64 files /path_to_file/ : out/module.debug <- .module in 2.211s
  Built module::informalSubmodule / build::make.informal in 28.494s
  
```

</details>