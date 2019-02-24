# Створення will-модуля

Описані процедури створення will-модулів різного призначення

<a name="topics"></a>
Зміст   
- [Початок роботи](#start)
- [Базова конфігурація](#basic-configuration)
- [Експорт модуля](#module-export)
- [Іменований підмодуль](#named-module)
- [Імпорт підмодуля](#module-import)

<a name="start"></a>
### Початок роботи
Will-файл має наступні властивості:
- will-файли мають розширення 'yml', 'json', 'cson' (_в прикладах використовується формат YAML. Ви можете використовувати зручний для вас формат._);
- документ складається з секції, які описують функціональності модуля (about, path, step, reflector, build...);
- секція `about` обов'язкова.  

Першим кроком створіть порожній `will`-файл в обраній директорії. Стандартний (неіменований) файл має назву `.will.yml`.

```
.
├── .will.yml  

```

<a name="basic-configuration"></a>
### Базова конфігурація

В створений `.will.yml` внесіть інформацію в секцію `about`. Приклад іллюструє всі поля секції, ви можете використати окремі.:

```yaml
about :
    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe
    interpreters:
        - nodejs >= 6.0.0
```

_Починати роботу з заповнення секції `about` є доброю практикою, адже, ця інформація дозволяє іншим користувачам легко отримати загальні дані про систему, а також адміністувати її в довготривалій перспективі._  

Для створення робочого модуля в `.will.yml` потрібно додати секції, що описують файли модуля.  
Секція `submodule` дозволяє використовувати готові підмодулі полегшуючи компонування системи.
```yaml
submodule :

  Tools :
    description : "Downloading submodules from GitHub"
    path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
    criterion :
      default : 1
  #inherit : some inherit parameter
```
Приклад вище іллюструє використання всії полів секції. Щоб використовувати таку форму, вказуйте назву процедури, в данному випадку - назву підмодуля (Tools). Критерії (criterion) та наслідування (inherit, в прикладі закоментовано) розглянуті окремо. Також, якщо немає додаткових умов, цю секцію можливо записати в скороченій формі - назву підмодуля і шлях до нього:
```yaml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

Об'єднавши попередні секції в `.will.yml` вам стануть доступні операції з підмодулями.
<details>
  <summary><u>Файл `.will.yml` та лістинг `will .submodules.download`</u></summary>

```yaml

about :
    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe
    interpreters:
        - nodejs >= 6.0.0

submodule :

    Tools :
    #description : "Downloading submodules from GitHub"
      path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
      criterion :
        default : 1
    #inherit : some inherit parameter

```

<p> </p>

```
[user@user ~]$ will .submodules.download
Request ".submodules.download"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.068s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
 + 1/1 submodule(s) of module::first were downloaded in 12.365s
```

</details>

<p> </p>

Розглянемо секцію [`step`](WillFileStructure.ukr.md#step), яка описує процедури користувача для створення модулю.  
Приклад секції `step`:
```yaml
step :

  npm.install :
    criterion :
        debug : 1
    currentPath : '.'
    shell : npm install
```

[Повернутись до меню](Topics.ukr.md)
