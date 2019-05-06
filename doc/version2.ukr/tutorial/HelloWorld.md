# Модуль "Hello, World!"

Створення модуля "Hello, World!". Завантаження віддаленого підмодуля.

### Властивості `вілфайла`

`вілфайл` - конфігураційний файл для побудови модульної системи утилітою `willbe`. Має ряд [властивостей](<../concept/WillFile.md>).

### Перший модуль

Створення першого модуль.

<details>
  <summary><u>Файлова структура</u></summary>

```
first               # директорія, назва довільна
  └── .will.yml     # конфігураційний файл

```

</details>

Для створення першого модуля створіть порожню директорію `first`. В новоствореній директорії `first` створіть порожній файл з назвою `.will.yml`.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

    name : helloWorld
    description : 'Hello, World!'
    version : '0.0.1'
    keywords :
        - key
        - word
```

</details>

В файл `.will.yml` скопіюйте приведений код.

<details>
  <summary><u>Вивід команди <code>will .about.list</code></u></summary>

  ```
[user@user ~]$ will .about.list
Command ".about.list"
  . Read : /path_to_file/.will.yml
. Read 1 will-files in 0.109s
About
 name : 'helloWorld'
 description : 'Hello, World!'
 version : '0.0.1'
 enabled : 1
 keywords :
   'willbe'

```

</details>

Переконайтеся, що модуль створився, виконавши команду `will .about.list` в директорії `first`.

Секції `about` містить описову інформацію, її наявність потрібна для експортування даного модуля і використання його іншими модулями та розробинками.  

### Перша побудова

Перша побудова модуля.

<details>
  <summary><u>Файлова структура</u></summary>

```
first              
  └── .will.yml     

```

</details>
<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

    name : helloWorld
    description : 'Hello, World!'
    version : 0.0.1
    keywords :
        - willbe

submodule :

    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

</details>

Додайте готовий підмодуль. Використайте віддалений модуль `git+https:///github.com/Wandalen/wTools.git/out/wTools`. Додайте його в секцію `submodule` `вілфайла`.

<details>
  <summary><u>Вивід команди <code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.list
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```

</details>

Скористайтесь фразою `will. submodules.list` для отримання інформації про підмодулі.  

<details>
  <summary><u>Вивід команди <code>will .submodules.download</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
 + 1/1 submodule(s) of module::helloWorld were downloaded in 12.365s

```

</details>

Введіть [команду `will .submodules.download`](../concept/Command.md#Таблиця-команд-утиліти-willbe) в директорії `first`.

<details>
  <summary><u>Вивід команди <code>ls -al</code></u></summary>

```
[user@user ~]$ ls -al
...
drwxr-xr-x 4 user user 4096 Мар 12 07:20 .module
-rw-r--r-- 1 user user  306 Мар  1 11:20 .will.yml

```

```
[user@user ~]$ ls -al module/
...
drwxr-xr-x 4 user user 4096 Мар 12 07:20 Tools

```

</details>
<details>
  <summary><u>Файлова структура, що відповідає виводу команд <code>ls -al</code></u></summary>

```
first
  ├── .module
  │       └── Tools
  └── .will.yml

```

</details>

Перевірте зміни в директорії модуля, використовуючи команду `ls`. В директорії для завантажених підмодулів `.module` утиліта `willbe` помістила підмодуль `Tools`.

<details>
  <summary><u>Вивід команди <code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.list
...
 . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
...
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```

</details>

Перевірте статус підмодуля після завантаження.

Зверніть увагу на рядок, який позначає підмодуль секції - `submodule::Tools`. Вивід у формі `Назва секції :: Назва ресурса`.

<details>
  <summary><u>Вивід команди <code>will .about.list</code></u></summary>

```
[user@user ~]$ will .about.list
...
About
  name : 'helloWorld'
  description : 'Hello, World!'
  ...

```

</details>
Секція `about`, має простішу форму запису

### Підсумок

- Можливо використовувати готові модулі підключаючи їх як підмодулі в секції `submodule`.
- Вивід інформації про ресурси секції в консоль має вигляд `Тип ресурса :: Назва ресурса`.
- Секція `about` містить описову інформацію.

[Наступний туторіал](CommandsSubmodules.md)   
[Повернутись до змісту](../README.md#tutorials)
