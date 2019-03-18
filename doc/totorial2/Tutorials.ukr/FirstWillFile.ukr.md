# Перший will-файл

В туторіалі описується створення першого will-файлу та першого модуля

### <a name="will-file-futures"></a> Властивості `will`-файла
Will-файл - конфігураційний файл для побудови модульної системи пакетом `willbe`.
Має наступні властивості:
- файли мають розширення 'yml', 'json', 'cson';
- документ складається з секцій, які описують поведінку модуля (about, path, step, reflector, build...).  

### <a name="will-file-creation"></a> Створення will-файла
Для створення першого will-файла виконайте наступні кроки:
- Cтворіть порожній файл з назвою `.will.yml` в новій директорії.
- Відкрийте його та скопіюйте приведений код:
```yaml
    about :
        name : first
        description : "First module"
        version : 0.0.1
        keywords :
            - willbe
```
- Збережіть файл.
Після цього перевірте конфігурацію виконавши з командного рядка `will .about.list` в кореневій директорії файлу.
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

Заповнення секції 'about' значно спрощує використання модуля іншими розробниками та адміністування системи в довготривалій перспективі.  

### <a name="first-modules"></a> Створення модуля  
Ми створили свій перший `will`-файл, який описує модуль, але не має функціоналу, тож, побудуємо робочий [`will`-модуль](Concepts.ukr.md#module) - базову одиницю пакету.  
Для початку використаємо готові рішення в вигляді підмодулів. Розмістимо ресурс з описом підмодуля в секції `submodule`:  

```yaml

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

Додайте її до попереднього файла:  

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

    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

</details>

<p> </p>

Тепер в `submodule` поміщений один ресурс з назвою _'Tools'_, який має _URL_-шлях _'git+https:///github.com/Wandalen/wTools.git/out/wTools#master'_. Опис шляху свідчить про використання підмодуля з _GitHub_-у.  
Скориставшись знайомою з попереднього туторіалу командою `will. submodules.list`, отримаємо такі рядки (тут і далі, текст лістинга команди, що не включено в туторіал позначений '...'):

```
[user@user ~]$ will .submodules.list
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```

Підмодуль уже відноситься до системи, але він не завантажений і неможливо зчитати інформацію про нього. 

- Ви можете використовувати [готові модулі](#first-modules) позначивши їх як підмодулі в секції `submodule`.

[Наступний туторіал](SubmodulesImporting.ukr.md)   
[Повернутись до змісту](../README.md#tutorials)
