# Модуль "Hello, World!"

Створення модуля "Hello, World!" з утилітою `willbe`. Завантаження віддаленого підмодуля

### <a name="will-file-futures"></a> Властивості `will-файла`
`Will-файл` - конфігураційний файл для побудови модульної системи утилітою `willbe`.  
Має наступні властивості:  
\- `will-файл` описує файли модуля;  
\- документ складається з секцій та ресурсів;  
\- секція - вища структурна одиниця `will-файлa`;  
\- є шість секцій для побудови модуля користувачем: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка генерується утилітою `willbe` при експорті модуля - секція `exported`;  
\- секції об'єднують ресурси одного типу;  
\- ресурси описують функціональності модуля.  

### <a name="will-file-creation"></a> Створення `will-файла`  
Для створення першого `will-файла` виконайте наступні кроки:  
\- Cтворіть порожній файл з назвою `.will.yml` в новій директорії.  
\- Відкрийте його та скопіюйте приведений нижче код. В секції `about`   

<details>
  <summary><u>Відкрийте, щоб проглянути структуру директорії та код в файлі <code>.will.yml</code></u></summary> 
    
```
first               # директорія, назва довільна
  └── .will.yml     # конфігураційний файл
  
```

<p>Код в файлі <code>.will.yml</code></p>
    
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
\- Перевірте конфігурацію виконавши з командного рядка `will .about.list` в кореневій директорії файлa:

<details>
  <summary><u>Вивід фрази <code>will .about.list</code></u></summary>

  ```
[user@user ~]$ will .about.list
Request ".about.list"
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


Заповнення секції `about` спрощує використання модуля іншими розробниками та управління ним в довготривалій перспективі.  

### <a name="first-modules"></a> Побудова модуля  
Перший `will-файл` створено. Він лише описує модуль, тож, додамо функціональність в модуль.  
Для початку використаємо готові рішення в вигляді віддалених підмодулів. Для цього помістіть ресурс з описом підмодуля в секції `submodule` - замініть вміст файла `.will.yml`:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary> 

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

<p>Структура директорії</p>

```
first              
  └── .will.yml     
  
```

</details>


В секції `submodule` поміщено ресурс з назвою `Tools`, який має _URL_-шлях `git+https:///github.com/Wandalen/wTools.git/out/wTools#master`. Запис шляху свідчить про використання підмодуля з _GitHub_-у.  
Скориставшись знайомою з попереднього туторіалу ["Як користуватися інтерфейсом командного рядка `willbe`"](HowToUseCommandLineInterfaceOfWill.md#list-commands) фразою `will. submodules.list`, отримаємо такий вивід (тут і далі, текст виводу консолі, що не включено в туторіал позначений `...`):  

<details>
  <summary><u>Вивід фрази <code>will .submodules.list</code></u></summary> 

```
[user@user ~]$ will .submodules.list
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```

</details>


Зробіть наступний крок для побудови модуля - введіть фразу `will. submodules.download` в кореневій директорії `will-файла`:

<details>
  <summary><u>Вивід фрази <code>will .submodules.download</code></u></summary> 

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
 + 1/1 submodule(s) of module::helloWorld were downloaded in 12.365s

```

</details>


Перевіримо зміни в директорії модуля, використовуючи команду `ls`:

<details>
  <summary><u>Вивід фрази <code>ls -al</code></u></summary> 

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
  <summary><u>Вивід фрази <code>will .submodules.list</code></u></summary> 

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


Зверніть увагу на рядок, який позначає підмодуль секції - `submodule::Tools`. Вивід у формі 'Назва секції :: Назва ресурса', свідчить про те, що секція має необмежену кількість ресурсів. Секція `about`, має єдину форму запису:  

<details>
  <summary><u>Вивід фрази <code>will .about.list</code></u></summary> 

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
- Вивід інформації про ресурси секції в консоль має вигляд 'Назва секції :: Назва ресурса'.

[Наступний туторіал](SubmodulesAdministration.md)   
[Повернутись до змісту](../README.md#tutorials)
