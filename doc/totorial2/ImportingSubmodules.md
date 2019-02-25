# Перший will-файл

В цьому туторіалі описується створення will-файлу та робота з зовнішніми підмодулями

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

### <a name="will-module-creation"></a> Створення модуля
[`Will`-модуль](Concepts.ukr.md#module) є базовою одиницею пакету. Він поєднує `will`-файл та описані в ньому файли.  

Перш ніж створювати власні сценарії, навчимось використовувати готові рішення в вигляді підмодулів. Для цього запишемо в секцію `submodule`
```yaml

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

В секцію поміщений один ресурс з назвою _'Tools'_, який має шлях _'git+https:///github.com/Wandalen/wTools.git/out/wTools#master'_. Даний запис свідчить про використання підмодуля з _GitHub_-у.  
Скориставшись знайомою з попереднього туторіалу командою `will. submodules.list`, отримаємо знайомі рядки:
```
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```
Тепер, скориставшись допомогою `will. submodules.download`
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

Бачимо, що `willbe` завантажив один модуль. Порівняємо вивід команди `will. submodules.list`:
```
...
 . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
...
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```
