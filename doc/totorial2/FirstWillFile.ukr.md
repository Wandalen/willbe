# Перший will-файл

В цьому туторіалі описується створення will-файлу

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

Заповнення секції 'about' необов'язкове, проте значно спрощує використання модуля іншими розробниками та адміністування системи в довготривалій перспективі.  

### <a name="will-module-creation"></a> Створення модуля
Основним поняттям в пакеті `willbe` є поняття [модулю](Concepts.ukr.md#module). Модуль поєднує `will`-файл та файли, описані в ньому.  
Для створення модуля в `.will.yml` потрібно додати декілька секції. Використаємо [`step`](WillFileStructure.ukr.md#step) і [`build`](WillFileStructure.ukr.md#build). Перший з них описує всі можливі процедури для створення модулю, а другий, основуючись на даних попередніх секцій `.will.yml` створює послідовність виконання дій пакетом `willbe`.  
Додамо до створеного файлу:

```yaml

step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  debug:
    criterion :
      default : 1
    steps :
      - npm.install

```

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

  name : first
  description : "First module"
  version : 0.0.1
  keywords :
      - willbe

step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  debug:
    criterion :
      default : 1
    steps :
      - npm.install

```

</details>

<p></p>

В блоці `step` описана процедура з назвою `npm.install`, яка виконується в поточній директорії (`currentPath : '.'`) та використовує команду `npm install` в інтерфейсі командного рядка.  
Секція `build` створює модуль з допомогою вбудованої функції `debug`. Вона має критерій (criterion) - умову виконання зі значенням за замовчуванням "1", тобто, ввімкнена. Процедура `debug` використовує крок `npm.install` описаний секцією `step`.

Щоб протестувати роботу `.will.yml` створимо зовнішній конфігураційний файл `package.json` та помістимо його в директорію файла `.will.yml`:

``` json
{
  "name": "first",
  "dependencies": {
    "express": ""
  }
}

```

Тепер, ваша директорія має такий вигляд:

```
.
├── package.json
├── .will.yml

```

Запустіть в консолі команду `will .build` в кореневій директорії файла `.will.yml` і `willbe` створить готовий модуль з NodeJS-пакетом "express".  
В консолі отримаєте такий лог, що свідчить про правильне виконання скрипту:
```
[user@user ~]$ will .build
Request ".build"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.079s

  Building debug
 > npm install

added 48 packages from 36 contributors and audited 121 packages in 4.863s
found 0 vulnerabilities

  Built debug in 16.456s

```

### Підсумок
- Заповнення [секції `about` `will`-файла](#will-file-futures) є гарною практикою створення `will`-документів.  
- Пакет `willbe` дозволяє [працювати з конфігураційними фалами NodeJS](#will-module-creation).

[Повернутись до меню](Topics.ukr.md)
