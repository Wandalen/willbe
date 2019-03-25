# Модуль "Hello, World!"

Створення модуля "Hello, World" з утилітою `willbe`

### <a name="will-file-futures"></a> Властивості `will`-файла
`Will-файл` - конфігураційний файл для побудови модульної системи утилітою `willbe`.  
Має наступні властивості:  
\- `will-файл` описує файли модуля;  
\- документ складається з секцій - верхньої структурної одиницi `will-файл` та ресурсів;  
\- є шість секцій для побудови модуля користувачем: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка генерується утилітою `willbe` при експорті модуля - секція `exported`;  
\- секції об'єднують ресурси одного типу;  
\- ресурси описують функціональності модуля.

### <a name="will-file-creation"></a> Створення will-файла  
Для створення першого will-файла виконайте наступні кроки:  
\- Cтворіть порожній файл з назвою `.will.yml` в новій директорії.  
\- Відкрийте його та скопіюйте приведений код:  

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

</br>
\- Збережіть файл.  
Після цього перевірте конфігурацію виконавши з командного рядка `will .about.list` в кореневій директорії файлу.

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

</br>
Заповнення секції `about` спрощує використання модуля іншими розробниками та управління ним в довготривалій перспективі.  

### <a name="first-modules"></a> Побудова модуля  
Перший `will-файл` створено. Він лише описує модуль, тож, додамо до нього функціональність.  
Для початку використаємо готові рішення в вигляді віддалених підмодулів. Розмістимо ресурс з описом підмодуля в секції `submodule`. Замініть вміст файла `.will.yml`:  

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

</br>
Тепер в секцію `submodule` поміщено один ресурс з назвою `Tools`, який має _URL_-шлях `git+https:///github.com/Wandalen/wTools.git/out/wTools#master`. Запис шляху свідчить про використання підмодуля з _GitHub_-у.  
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

</br>
Підмодуль не завантажений і неможливо зчитати інформацію про нього.

### Підсумок
- Ви можете використовувати [готові модулі](#first-modules) позначивши їх як підмодулі в секції `submodule`.

[Наступний туторіал](SubmodulesImporting.md)   
[Повернутись до змісту](../README.md#tutorials)
