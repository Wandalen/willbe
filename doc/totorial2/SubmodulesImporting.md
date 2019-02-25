# Перший will-файл

В цьому туторіалі описується створення will-файлу та робота з імпортованими підмодулями

### <a name="will-file-futures"></a> Визначення та властивості `will`-файла
Will-файл - конфігураційний файл для побудови модульної системи пакетом `willbe`.
Will-файл має наступні властивості:
- конфігураційні will-файли мають розширення 'yml', 'json', 'cson';
- документ складається з секції, які описують поведінку модуля (about, path, step, reflector, build...);
- секція `about` обов'язкова.  

### <a name="will-file-creation"></a> Створення will-файла
Для створення першого will-файла виконайте наступні кроки:
- В директорії, де бажаете помістити модуль, створіть порожній файл з назвою `.will.yml`.
- Скопіюйте в нього приведений код:
```yaml
    about :

        name : first
        description : "First module"
        version : 0.0.1
        keywords :
            - willbe
```
- Додатково можнете заповнити поле interpreters - список інтерпретаторів модуля.
Після збереження файлу, перевірте конфігурацію виконавши з командного рядка `will .about.list` в кореневій директорії файлу.
<details>
  <summary><u>Лістинг `will .about.list`</u></summary>

  ```
[user@user ~]$ will .about.list
Request ".about.list"
  . Read : /path_to_file/.will.yml
. Read 1 will-files in 0.109s
About
 name : 'first'
 description : 'First module'
 version : '0.0.1'
 enabled : 1
 keywords :
   'willbe'

```

</details>

Заповнення секції _'about'_ необов'язкове, проте значно спрощує використання модуля іншими розробниками та адміністування системи в довготривалій перспективі.  

### <a name="importing-submodules"></a> Використання зовнішніх підмодулів
[`Will`-модуль](Concepts.ukr.md#module) є базовою одиницею пакету. Він поєднує `will`-файл та описані в ньому файли.  

Перш ніж створювати власні сценарії, навчимось використовувати готові рішення в вигляді підмодулів. Для цього запишемо в секцію `submodule`

```yaml

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

Об'єднавши її з попередньою секцією матимемо доступ до операцій з підмодулями.  

<details>  
  <summary><u>Файл `.will.yml`</u></summary>

```yaml

about :

    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    WTools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

</details>

<p> </p>
Тепер в `submodule` поміщений один ресурс з назвою _'WTools'_, який має шлях _'git+https:///github.com/Wandalen/wTools.git/out/wTools#master'_. Опис шляху свідчить про використання підмодуля з _GitHub_-у.  
Скориставшись знайомою з попереднього туторіалу командою `will. submodules.list`, отримаємо знайомі рядки (тут і далі, текст лістинга команди, що не включено в туторіал позначений '...'):

```
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```
Тепер, скористуємось фразою `will. submodules.download`:

```
[user@user ~]$ will .submodules.download
Request ".submodules.download"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.068s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
   . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
   + module::WTools was downloaded in 12.360s
 + 1/1 submodule(s) of module::first were downloaded in 12.365s

```

`Willbe` завантажив один підмодуль. Перевіримо вивід команди `.submodules.list`:

```
...
 . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
...
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```

В кореневій директорії файла `.will.yml` має з'явитись каталог з назвою `.module`. Відкривши його ви знайдете підмодуль `WTools` з його власними файлами.  
Додамо ще один підмодуль в `.will.yml` та знову виконаємо `will .submodules.list`:

```
PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

```
...
submodule::WTools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```

<a name="resource-inheritation"> Зверніть увагу на рядки, які позначають окремі підмодулі - _'submodule::WTools'_ i _'submodule::PathFundamentals'_. В порівнянні з виводом інформації секції `about` (фраза `will .about.list`).

```
...
About
  name : 'first'
  description : 'First module'
  ...

```

Запис вигляду _'секція::ресурс'_ використовує синтаксис наслідування класів в мовах програмування. Тобто, якщо ресурс вважати похідним класом, то він наслідує властивості секції, як базового класу.
Секція `about`, в такому випадку, не наслідується і має єдиний _"екземпляр класа"_.

### Підсумок
- Заповнення [секції `about` `will`-файла](#will-file-futures) є гарною практикою створення `will`-документів.  
- Пакет `willbe` дозволяє ефективно [працювати з готовими підмодулями](#will-module-creation).
- Якщо прийняти, що [ресурси _"наслідують"_ властивості секцій](#resource-inheritation), то секція `about` не наслідується і має єдиний _"екземпляр класа"_.

[Наступний туторіал](SubmodulesExploring.md)  
[Повернутись до меню](Topics.ukr.md)
