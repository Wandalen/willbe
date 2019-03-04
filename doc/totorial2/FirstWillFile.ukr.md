# Перший will-файл

В цьому туторіалі описується створення першого will-файлу

### <a name="will-file-futures"></a> Властивості `will`-файла
Will-файл - конфігураційний файл для побудови модульної системи пакетом `willbe`.
Має наступні властивості:
- файли мають розширення 'yml', 'json', 'cson';
- документ складається з секцій, які описують поведінку модуля (about, path, step, reflector, build...);
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

Заповнення секції 'about' необов'язкове, проте значно спрощує використання модуля іншими розробниками та адміністування системи в довготривалій перспективі.  

[Наступний туторіал](SubmodulesImporting.ukr.md)   
[Повернутись до змісту](Topics.ukr.md)
