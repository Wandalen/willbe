# Неформальні підмодулі

Імпортування неформальних підмодулів.

Виникаються ситуації, коли підмодуль необхідний для функціонування вашого проекту, розроблений стороннім розробником. Утиліта може використовувати його файли безпосереднім копіюванням. Та є кращий спосіб - побудова неформального підмодуля. Під поняттям неформального підмодуля розуміється те, що підмодуль створено без використання утиліти `willbe`. Для підключення такого підмодуля потрібно створити його експортну конфігурації і помістити посилання на локальний експортований файл в секцію `submodule`.  

### Побудова неформального підмодуля. Конфігурація  

<details>
  <summary><u>Файлова структура</u></summary>

```
informalModule
        ├── module
        │     └── Color.informal.will.yml
        └── .will.yml

```

</details>

Створіть конфігурацію файлів, як приведено вище.  

В структурі розділено конфігураційний файл модуля `.will.yml` i файл для створення неформального підмодуля `Color.informal.will.yml`.  

<details>
  <summary><u>Код файла <code>Color.informal.will.yml</code></u></summary>

```yaml
about :

  name : Color.informal
  version : 0.0.1

path :

  in : '..'
  out : 'out'
  remote : 'git+https:///github.com/Wandalen/wColor.git'
  local : './.module/Color'
  export : '{path::local}/proto'

reflector :

  download.informal :
    src : path::remote
    dst : path::local

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

Запишіть в `Color.informal.will.yml` приведений код.

В збірці `export.informal` є два кроки. Перший - `download.informal` - використовується для завантаження підмодуля з Git-репозиторію `https://github.com/Wandalen/wColor.git`. Завантажені файли поміщаються в директорію `./.module/Color`.  
В кроці `export.informal` використовуються вбудовані шляхи:
- `remote` - шлях для віддалених ресурсів
- `local` - шлях, за яким завантажуються віддалені ресурси. 
Крок `download.informal` не вказаний в `вілфайлі`, його генерує утиліта в оперативну пам'ять за назвою рефлектора. 

Другий крок - `export.module` - створює експорт модуля за шляхом `{path::local}/proto`, тобто, `./.module/Color/proto`.   

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

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
    currentPath : path::module.dir
    shell : 'will .each module .export'

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

В конфігураційний файл модуля внесіть приведений вище код.

Збірка `make.informal` містить чотири кроки:
- перший - завантаження віддалених підмодулів;
- другий - запуск побудови збірки експорту для кожного `вілфайла` в директорії `module`, тобто, директорії з файлом `Color.informal.will.yml`;
- третій крок - вбудований крок, який перезавантажує підмодулі (оновлює статус);
- четвертий - `reflect.submodules`, з допомогою одноіменного рефлектора копіює експортовані файли підмодулів в директорію `./out/module.debug` (за критеріоном `debug : 1`).

### Виконання побудови

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

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
 > will .each module .export
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
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
informalModule
        ├── .module
        │     ├── Tools
        │     └── Color
        ├── module
        │     └── Color.informal.will.yml
        ├── out
        │    ├── module.debug
        │    │           └── dwtools
        │    └── Color.informal.out.will.yml
        └── .will.yml

```

</details>

В директорії файла `.will.yml` виконайте команду `will .build`, перевірте результати виводу.

В виводі команди спочатку приводиться інформація провіддалені підмодулі `! Failed to read submodule`, а далі починається побудова.   
Відповідно до сценарію, завантажуються віддалені підмодулі. Слідом, команда `will .each module .export` запускає побудову в `вілфайлах` директорії `module`. Після створення експорту неформального підмодуля `Color` утиліта перезавантажує статус підмодулів, додаючи неформальний `. Read : /path_to_file/out/Color.informal.out.will.yml`. Без цього кроку неможливо скопіювати дані з підмодуля `Color` так, як утиліта не знає про зміну стану цього підмодуля після початку побудови. Після цього утиліта успішно копіює файли підмодулів в директорію `out/module.debug`.   

Перевагою такого способу використання віддалених підмодулів, розроблених без використання утиліти `willbe`, в автоматизації впровадження підмодуля і простоті його оновлення. В тому числі, утиліта допомагає [слідкувати за версіями (станом розробки)](CommandsSubmodules.md) неформального підмодуля.

### Підсумок

- Утиліта `willbe` для побудови модуля використовує як формальні підмодулі, так і неформальні підмодулі. Неформальний підмодуль - група файлів, яка не росповсюджується з `вілфайлом`. Його можна імпортувати побудувавши локальний підмодуль.  
- Використання неформальних підмодулів автоматизує впровадження сторонніх розробок з можливістю контролю версій.

[Повернутись до змісту](../README.md#tutorials)
