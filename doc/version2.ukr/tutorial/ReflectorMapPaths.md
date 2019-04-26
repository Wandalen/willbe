# Мапа шляхів. Використання глобів для фільтрування файлів

Як формуються шляхи в рефлекторах та як використовувати мапу шляхів для фільтрування файлів і директорій.

Важливою складовою рефлекторів є управління доступом до файлів та файловою адресацією. Управління доступом до файлів розширює можливості розробника в налаштуванні фільтрування файлів, а управління файловою адресацією забезпечує зручність побудови шляхів. 

Для формування шляхів в рефлекторах передбачені поля `filePath`, `basePath` та `prefixPath`.  
Поле `basePath` - вказує базову, початкову директорію, зазвичай, кореневу директорію файла - `.`. Поле `filePath` - шлях до файлів вибірки. Поле `prefixPath` - відносний шлях, який додається до шляхів `filePath` і `basePath`.  

### Початкова конфігурація    

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
    inherit : predefined.reflect
    reflector : reflect.*

build :

  copy :
    criterion : 
      default : 1
    steps :
      - reflect.*
      
```

</details>

Помістіть в `will-файл` приведений код. 

В рефлекторі `reflect.copy` використовується повна форма запису. Відмінність від скороченої полягає в розділенні ресурсу на фільтр джерела файлів `src` та фільтр директорії призначення `dst`. 

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
     └── .will.yml       

```

</details> 

Запустіть побудову командою `will .build`.  

Як було вказано в рефлекторі, після побудови в директорії `files` з'явилась директорія `files.two` з файлом `proto.js`.

### Мапа шляхів для виконання множинних файлових операцій

Для збільшення кількості файлових операцій можна додати кроки в сценарій побудови, що збільшить об'єм `will-файла` за рахунок дублювання інформації в ресурсах. Тому, краще використовувати мапу шляхів.

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
    inherit : predefined.reflect
    reflector : reflect.*

build :

  copy :
    criterion : 
      default : 1
    steps :
      - reflect.*
      
```

</details>

Замініть вміст `will-файла` кодом, приведеним вище, щоб провести дві операції копіювання. Перша копіює файли з директорії `files` в директорію `out1`, а друга - з директорії `proto` в `out2`. Це зручна форма запису, яка дозволяє виконувати декілька операцій копіювання за одну побудову збірки.   

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
     ├── out1
     │     ├── files.two
     │     │      └── proto.js
     │     ├── text.md
     │     └── files.js
     ├── out2
     │     └── proto.two
     │            └── proto.js
     └── .will.yml       

```

</details>

Запустіть побудову модуля та перевірте зміни в структурі модуля.

Рефлектор скопіював файли в відповідні директорії, що позбавило необхідності створювати додаткові кроки в сценарії збірки.

Можлива ситуація, коли потрібно скопіювати файли з різних джерел в одну директорію призначення. В такому випадку карта шляхів поля `filePath` розділяється між фільтрами `src` i `dst`. Запис відрізняється тим, що шляхи з яких зчитуються файли вказуються зі значеннями: 
- `0` або (`false`) - не виконувати операцію над файлами;
- `1` або (`true`) - виконати операцію над файлами.  

<details>
  <summary><u>Секція <code>reflector</code> зі змінами</u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath:
        files/files.two : 1
        proto : 1
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
     │     │      └── proto.js
     │     └── proto.js
     └── .will.yml       

```

</details>

Видаліть каталоги `out1` i `out2` (`rm -Rf out1/ out2/`) та запустіть побудову. Перевірте вміст згенерованої директорії `out`.

В директорію `out` скопійовано вказані файли. Вимкніть копіювання з директорії `proto`, змінивши рефлектор до вигляду:  

<details>
  <summary><u>Секція <code>reflector</code> з вимкненим копіюванням директорії <code>proto</code></u></summary>

```yaml
reflector :

  reflect.copy.:
    recursive: 2
    src:
      filePath:
        files/files.two : 1
        proto : false
    dst:
      filePath: out

```

</details>

Видаліть директорію `out` (`rm -Rf out/`) та запустіть побудову:  

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
     │     └── proto.js
     └── .will.yml       

```

</details>

Файли з директорії `proto` не скопіювались. З допомогою управління доступом до директорій розширюються можливості розробника в налаштуванні модуля.

### Мапа шляхів і використання глобів для фільтрування файлів

Крім керування директоріями, мапа шляхів може задавати безліч умов виключення файлів із вибірки з допомогою ґлобів. Умови виключення виконують: 
- виключення файлів із вибірки, що співпадають із ґлобом через `false` чи `0`;
- виключення файлів із вибірки, що не співпадають із ґлобом через `true` чи `1`.

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
        proto : null
    dst:
      filePath: out 

```

</details>

Запис зчитується так: переглянути файли в директоріях `files` i `proto`, виключити всі файли які маються розширення `.js`, включити файли з розширенням `.md`. Скопійовані файли помістити в директорію `out`.

Змініть секцію `reflector` як в приведеному прикладі. Запустіть побудову модуля:

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::reflectorPaths / build::copy
   + reflect.copy reflected 3 files /path_to_file/ : out <- files/files.two in 0.400s
   + reflect.copy. reflected 3 files /path_to_file/ : out <- files/files.two in 0.330s
  Built module::reflectorPaths / build::copy in 0.832s

```

</details>
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
     │     └── text.md
     └── .will.yml       

```

</details>

Провівши пошук в директоріях `files` i `proto` утиліта знайшла лише файл `text.md`, а JavaScript файли виключила з вибірки. 

### Підсумок

- Шлях рефлектора складається з частин - `basePath`, `filePath` i `prefixPath`. Їх можна використовувати самостійно або комбінувати.  
- З допомогою мапи шляхів рефлектори можуть виконувати за одну побудову декілька файлових операцій.  
- В мапі шляхів можна керувати доступом до директорії та здійснювати фільтрування файлів за ґлобами. 
- При комбінації фільтрів з управлінням доступом до директорій збільшуються можливості по відбору файлів рефлектором.  

[Повернутись до змісту](../README.md#tutorials)
