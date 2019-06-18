# Мапа шляхів. Використання ґлобів для фільтрування файлів

Як формуються шляхи в рефлекторах та як використовувати мапу шляхів для фільтрування файлів і директорій.

Важливою складовою рефлекторів є управління доступом до файлів та файловою адресацією. Управління доступом до файлів розширює можливості розробника в налаштуванні фільтрування файлів, а управління файловою адресацією забезпечує зручність побудови модуля. 

Для формування шляхів в рефлекторах передбачені поля `filePath`, `basePath` та `prefixPath`.   
Поле `basePath` - вказує базову, початкову директорію, зазвичай, директорію файла - `.`.  
Поле `filePath` - шлях до файлів вибірки.  
Поле `prefixPath` - відносний шлях, який додається до шляхів `filePath` і `basePath`.  

### Структура модуля   

<details>
  <summary><u>Структура модуля</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.js
     ├── files
     │     ├── text.md
     │     └── files.js
     └── .will.yml        

```

</details>

Для дослідження формування шляхів в рефлекторі створіть структуру файлів як приведено вище.

### Використання полів `basePath`, `filePath` i `prefixPath`  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : reflectorPaths
  description : "To use reflector path constructor"
  version : 0.0.1

reflector :

  reflect.copy :
    recursive : 2
    src :
      filePath : proto.two
      prefixPath : proto
    dst :
      basePath : .
      prefixPath : files/files.two

step :

  reflect.copy :
    inherit : files.reflect
    reflector : reflect.*

build :

  copy :
    criterion : 
      default : 1
    steps :
      - reflect.*
      
```

</details>

Помістіть в `вілфайл` приведений код. 

В рефлекторі `reflect.copy` використовується розділення ресурсу на фільтр джерела файлів `src` та фільтр директорії призначення `dst`. 

Поля `basePath`, `filePath` i `prefixPath` можуть використовуватись самостійно, а також в поєднанні. В прикладі, кожен шлях рефлектора складається з двох частин - `prefixPath + filePath` і `prefixPath + basePath`. Згідно запису, рефлектор буде копіювати файл з директорії `proto/proto.two` в диреторію `files/files.two`.   

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
 Building module::reflectorPaths / build::copy
   + reflect.copy reflected 2 files /path_to_file/ : files/files.two <- proto/proto.two in 0.807s
  Built module::reflectorPaths / build::copy in 0.889s

```

</details>

Запустіть побудову командою `will .build`.  

Як було вказано в рефлекторі, після побудови в директорії `files` з'явилась директорія `files.two` з файлом `proto.js`. Перегляньте зміни і порівняйте з приведеною нижче структурою.

<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.md
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     ├── text.md
     │     └── files.js
     └── .will.yml       

```

</details> 

### Мапа шляхів для виконання множинних файлових операцій

Для збільшення кількості файлових операцій можна додати кроки в сценарій побудови, що збільшить об'єм `вілфайла` за рахунок дублювання інформації в ресурсах. Тому, краще використовувати мапу шляхів.

Мапа шляхів - це поле рефлектора та спосіб опису множини файлів, котрий дозволяє включити в неї безліч файлів і виключити із неї не потрібні файли за допомогою умов виключення та ґлобів. Мапа шляхів може задаватися в полі `filePath` або в полі `src.filePath` чи `dst.filePath` рефлектора. При наслідуванні рефлектором успадковуються ті умови виключення, котрі мають значення `0`, `1`, `false`, `true`, а директорії (шляхи, які мають в значенні `null`, прості шляхи), в яких ведеться пошук, переписуються останнім предком або безпосередньо нащадком.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : reflectorPaths
  description : "To use reflector map of paths"
  version : 0.0.1

reflector :

  reflect.copy :
    filePath :
      files : out1
      proto : out2

step :

  reflect.copy :
    inherit : files.reflect
    reflector : reflect.*

build :

  copy :
    criterion : 
      default : 1
    steps :
      - reflect.*
      
```

</details>

Замініть вміст `вілфайла` кодом, приведеним вище, щоб провести дві операції копіювання. Перша копіює файли з директорії `files` в директорію `out1`, а друга - з директорії `proto` в `out2`. Це зручна форма запису, яка дозволяє виконувати декілька операцій копіювання за одну побудову збірки.   

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 8 files /path_to_file/ : . <- . in 0.533s
  Built module::reflectorPaths / build::copy in 0.596s


```

</details>

Запустіть побудову модуля та перевірте зміни в структурі модуля.


Рефлектор скопіював файли в відповідні директорії, що позбавило необхідності створювати додаткові кроки в сценарії збірки. 

<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.md
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     ├── text.md
     │     └── files.js
     ├── out1
     │     ├── files.two
     │     │      └── proto.js
     │     ├── text.md
     │     └── files.js
     ├── out2
     │     └── proto.two
     │            └── proto.md
     └── .will.yml       

```

</details>

Відповідно до виводу, директорія модуля має конфігурацію, що привденена вище.

Можлива ситуація, коли потрібно скопіювати файли з різних джерел в одну директорію призначення. В такому випадку мапа шляхів поля `filePath` розділяється між фільтрами `src` i `dst`. Запис відрізняється тим, що шляхи з яких зчитуються файли вказуються зі значеннями `null`.
 

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath:
        files/files.two : null
        proto : null
    dst:
      filePath: out

```

</details>

Змініть секцію `reflector` як на приведеному прикладі. 

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 5 files /path_to_file/ : out <- . in 0.617s
   + reflect.copy. reflected 5 files /path_to_file/ : out <- . in 0.352s
  Built module::reflectorPaths / build::copy in 1.068s

```

</details>

Видаліть каталоги `out1` i `out2` (`rm -Rf out1/ out2/`) та запустіть побудову. 

Перевірте вміст згенерованої директорії `out` і порівняйте з приведеним нижче.

<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.js
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     ├── text.md
     │     └── files.js
     ├── out
     │     ├── proto.two
     │     │      └── proto.md
     │     └── proto.js
     └── .will.yml       

```

</details>

### Мапа шляхів і використання глобів для фільтрування файлів

Мапа шляхів може задавати безліч умов виключення файлів із вибірки з допомогою ґлобів та управління доступом до директорій.  
Умови виключення виконують: 
- виключення файлів із вибірки, що співпадають із ґлобом через `false` чи `0`;
- виключення файлів із вибірки, що не співпадають із ґлобом через `true` чи `1`.  
Управління доступом до директорій здійснюється заміною значення `null`:  
- на `0` чи `false` - утиліта не проводить операцію з директорією;
- на `1` чи `true` - утиліта виконує операцію з директорією.

<details>
  <summary><u>Секція <code>reflector</code> з умовами виключення в мапі шляхів</u></summary>

```yaml
reflector :

  reflect.copy.:
    src:
      filePath:
        '*.js' : 0
        '*.md' : 1
        files : null
        proto : false
    dst:
      filePath: out 

```

</details>

Приведений вище ресурс зчитується так: переглянути файли в директорії `files`, в директорії `proto` виключити пошук. З вибірки виключити всі файли, які маються розширення `.js` та включити файли з розширенням `.md`. Скопійовані файли помістити в директорію `out`.

Змініть секцію `reflector` як в приведеному прикладі. 

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 2 files /path_to_file/ : out <- files/files.two in 0.400s
   + reflect.copy. reflected 2 files /path_to_file/ : out <- files/files.two in 0.330s
  Built module::reflectorPaths / build::copy in 0.832s

```

</details>

Запустіть побудову модуля виконавши команду `will .build`. 

<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
fileControl
     ├── proto
     │     └── proto.two
     │            └── proto.md
     ├── files
     │     ├── files.two
     │     │      └── proto.js
     │     ├── text.md
     │     └── files.js
     ├── out
     │     └── text.md
     └── .will.yml       

```

</details>

Провівши пошук в директоріях `files` утиліта знайшла лише файл `text.md` в директорії `files`, файл `proto.md` з директорії `proto` не було включено. `JavaScript` файли в директорії `files` утиліта пропустила згідно налаштованого фільтра. 

### Підсумок

- Шлях рефлектора складається з частин - `basePath`, `filePath` i `prefixPath`. Їх можна використовувати самостійно або комбінувати.  
- З допомогою мапи шляхів рефлектори можуть виконувати за одну побудову декілька файлових операцій.  
- В мапі шляхів можна керувати доступом до директорії та здійснювати фільтрування файлів за ґлобами. 
- При комбінації фільтрів з управлінням доступом до директорій збільшуються можливості по відбору файлів рефлектором.  

[Повернутись до змісту](../README.md#tutorials)
