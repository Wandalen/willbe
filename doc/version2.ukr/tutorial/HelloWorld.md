# Модуль "Hello, World!"

Створення модуля "Hello, World!". Завантаження віддаленого підмодуля.

### Властивості `will-файла`
`Will-файл` - конфігураційний файл для побудови модульної системи утилітою `willbe`.  
Має наступні властивості:  
\- `will-файл` описує файли модуля;  
\- документ складається з секцій та ресурсів;  
\- секція - вища структурна одиниця `will-файлa`;  
\- є шість секцій для побудови модуля користувачем: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка генерується утилітою `willbe` при експорті модуля - секція `exported`;  
\- секції об'єднують ресурси одного типу;  
\- ресурси описують функціональності модуля.  

### Створення `will-файла`  
Для створення першого `will-файла` виконайте наступні кроки:  
\- Cтворіть порожній файл з назвою `.will.yml` в новій директорії.  
\- Відкрийте його та скопіюйте приведений нижче код. В секції `about`   

<details>
  <summary><u>Структура файлів</u></summary>

```
first               # директорія, назва довільна
  └── .will.yml     # конфігураційний файл

```

</details>

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

    name : helloWorld
    description : "First module like 'Hello, World!' application"
    version : 0.0.1
    keywords :
        - willbe
```

</details>


\- Збережіть файл.  
\- Перевірте конфігурацію, виконавши команду `will .about.list` в кореневій директорії файлa:

<details>
  <summary><u>Вивід команди <code>will .about.list</code></u></summary>

  ```
[user@user ~]$ will .about.list
Command ".about.list"
  . Read : /path_to_file/.will.yml
. Read 1 will-files in 0.109s
About
 name : 'helloWorld'
 description : 'First module like 'Hello, World!' application'
 version : '0.0.1'
 enabled : 1
 keywords :
   'willbe'

```

</details>

Заповнення секції `about` спрощує використання та управління модулем в довготривалій перспективі.  

### Побудова модуля  
Для побудови робочого модуля потрібно додати в нього функціональність.  
Почніть з використання віддалених підмодулів - готових модулів, які знаходяться на віддаленому сервері. Для цього в секцію `submodule` `will-файла` помістіть ресурс з описом підмодуля. Замініть вміст файла `.will.yml`:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

    name : helloWorld
    description : "First module like 'Hello, World!' application"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

</details>

<details>
  <summary><u>Структура файлів</u></summary>

```
first              
  └── .will.yml     

```

</details>


В секції `submodule` поміщено ресурс з назвою `Tools`, який має _URL_-шлях `git+https:///github.com/Wandalen/wTools.git/out/wTools#master`. Запис шляху свідчить про використання підмодуля з _GitHub_-у.  
Скористайтесь фразою `will. submodules.list` з  [попереднього туторіалу](CLI.md#Команда-list) (тут і далі, текст виводу консолі, що не включено в туторіал позначений `...`):  

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


Зробіть наступний крок для побудови модуля - Введіть команду `will. submodules.download` в кореневій директорії `will-файла`:

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


Перевірте зміни в директорії модуля, використовуючи команду `ls`:

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
  <summary><u>Структура файлів, що відповідає виводу команд <code>ls -al</code></u></summary>
<p>Що відповідає структурі каталогів:</p>

```
first
  ├── .module
  │       └── Tools
  └── .will.yml

```

</details>


В директорії для завантажених підмодулів `.module` утиліта `willbe` помістила підмодуль `Tools` . Перевірте статус підмодуля після завантаження:  

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


Зверніть увагу на рядок, який позначає підмодуль секції - `submodule::Tools`. Вивід у формі `Назва секції :: Назва ресурса`, свідчить про те, що секція має необмежену кількість ресурсів. Секція `about`, має єдину форму запису:  

<details>
  <summary><u>Вивід команди <code>will .about.list</code></u></summary>

```
[user@user ~]$ will .about.list
...
About
  name : 'helloWorld'
  description : 'First module like 'Hello, World!' application'
  ...

```

</details>

### Підсумок
- Ви можете використовувати [готові модулі](#first-modules) позначивши їх як підмодулі в секції `submodule`.
- Вивід інформації про ресурси секції в консоль має вигляд `Тип ресурса :: Назва ресурса`.

[Наступний туторіал](SubmodulesCommands.md)   
[Повернутись до змісту](../README.md#tutorials)
