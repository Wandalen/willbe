# Мінімізація <code>вілфайлa</code>

Як мінімізувати <code>вілфайл</code> за допомогою розгортання критеріонами із множинними значеннями.

Зручність роботи з `вілфайлом` залежить від його об'єму - чим він менший, тим легше. Тому, використовується скорочена форма запису ресурсів, а також, критеріони. Скорочена форма запису ресурсів зменшує `вілфайл`, а критеріони можуть навіть збільшити його об'єм. Тож, час дізнатись як користуватись розгортанням ресурсів з критеріонами для мінімізації `вілфайла`.   

### Розгортання критеріонами. Конфігурація 

<details>
  <summary><u>Структура модуля</u></summary>

```
minimize
    ├── files
    │     ├── Debug.txt
    │     └── Release.js
    └── .will.yml

```

</details>

Для дослідження розгортання критеріонами створіть директорію `minimize` з приведеною конфігурацією.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : willFileMinimizing
  description : "To minimize will-file by short write form of criterions"
  version : 0.0.1

path :

  fileToDelete.debug :
    criterion :
      debug : 1
    path : './files/Debug.js'
  fileToDelete.release :
    criterion :
      debug : 0
    path : './files/Release.js'

step  :

  delete.files :
    inherit : predefined.delete
    filePath : path::fileToDelete.*
    criterion :
      debug : [ 0,1 ]

build :

  delete :
    criterion :
      debug : [ 0,1 ]
    steps :
      - delete.*

```

</details>

Помістіть приведений вище код в `вілфайл`.

В кроці `delete.files` здійснюється видалення файлів з допомогою вбудованого кроку `predefined.delete`. Для видалення потрібних файлів в полі `filePath` вказується шлях до файлів. Всі шляхи модуля поміщаються в секції `path`, котра призначена для швидкого орієнтування в його структурі.  
Секція `path` має два шляхи: 
- `fileToDelete.debug` використовується якщо критеріон `debug` має значення `1`;
- `fileToDelete.release` використовується якщо критеріон `debug` має значення `0`;

Збірка `delete` в секції `build` та крок `delete.files` в секції `step` використовують функцію розгортання ресурсів з критеріонами. Для цього критеріону присвоюється векторне значення, в даному випадку, `debug : [ 0,1 ]`. Утиліта, зчитуючи такий ресурс, розгортає його на копії, що відрізняються назвою і мають по одному критеріону зі скалярним значенням. 

<details>
  <summary><u>Вивід команди <code>will .steps.list</code></u></summary>

```
[user@user ~]$ will .steps.list
...
step::delete.files.
  criterion :
    debug : 0
  opts :
    filePath : path::fileToDelete.*=1
  inherit :
    predefined.delete

step::delete.files.debug
  criterion :
    debug : 1
  opts :
    filePath : path::fileToDelete.*=1
  inherit :
    predefined.delete

```

</details>

Перевірте, які ресурси наявні в секції `step`, для цього використайте команду `will .steps.list`.

Утиліта розгорнула ресурс на два. Один з назвою `delete.files.` та критеріоном `debug : 0`, а другий з назвою `delete.files.debug` та критеріоном `debug : 1`.

<details>
  <summary><u>Вивід команди <code>will .builds.list</code></u></summary>

```
[user@user ~]$ will .builds.list
...
build::delete.
  criterion :
    debug : 0
  steps :
    delete.*=1

build::delete.debug
  criterion :
    debug : 1
  steps :
    delete.*=1

```

</details>

Аналогічно до попереднього перевірте ресурси в секції `build` (команда `will .builds.list`). 

Як в попередньому виводі, утиліта згенерувала два ресурси. Перший з назвою `delete.` i критеріоном `debug : 0` та другий `delete.debug` з критеріоном `debug : 1`.

Таким чином, утиліта розділяє ресурси з множинними значеннями критеріонів на окремі ресурси зі звичайним записом критеріонів. А в назву кожного із розділених ресурсів додається постфікс згідно назви і значення критеріона. В ресурсі може бути декілька критеріонів з векторним значенням, в такому випадку утиліта згенерує ресурси зі всіма можливими комбінаціями критеріонів. Використовуйте команди `*.list`, щоб дізнатись назви згенерованих ресурсів з потрібним критеріоном. 

### Побудова збірок

При використанні розгортання критеріонів в збірках `вілфайла` критеріон `default : 1` не працює. Якщо його застосувати, то утиліта не зможе визначити, яка зі згенерованих збірок повинна виконуватись за замовчуванням.   

<details>
  <summary><u>Вивід команди <code>will .build delete.debug</code></u></summary>

```
[user@user ~]$ will .build delete.debug
...
  Building module::willFileMinimizing / build::delete.debug
   - filesDelete 1 files at /path_to_file/files in 0.028s
  Built module::willFileMinimizing / build::delete.debug in 0.029s

```

</details>

Введіть команду `will .build delete.debug`.

<details>
  <summary><u>Вивід команди <code>ls -l files/</code></u></summary>

```
[user@user ~]$ ls -l files/
-rw-r--r-- 1 user user 301 Mar 17 08:33 Release

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
minimize
    ├── files
    │     └── Release.js
    └── .will.yml

```

</details>

Перевірте зміни в директорії `files` використовуючи команду `ls -l`.  

Файл `Debug.js` видалено і залишився файл з назвою `Release.js`. Відповідно, щоб видалити файл `Release.js`, введіть `will .build delete.`.  

<details>
  <summary><u>Вивід команди <code>will .build delete.</code></u></summary>

```
[user@user ~]$ will .build delete.
...
  Building module::willFileMinimizing / build::delete.
   - filesDelete 1 files at /path_to_file/files in 0.028s
  Built module::willFileMinimizing / build::delete. in 0.030s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
minimize
    ├── files
    └── .will.yml

```

</details>

Файл `Release.js` видалено відповідно до сценарію збірки `delete.`.

Розгортання критеріонами - зручний інструмент побудови `вілфайла`. Він дозволяє зменшити об'єм документа і збільшити швидкість його створення.  

### Підсумок

- Зменшити об'єм `вілфайла` можна з допомогою ґлобів, критеріонів та скороченої форми запису ресурсів.
- Розгортання ресурсів з множинним значенням критеріонів забезпечує автоматичне генерування ресурсів за комбінаціями критеріонів.
- При застосуванні розгортання критеріонами назви згенерованих ресурсів автоматично доповнюються згідно назв критеріонів.

[Наступний туторіал](WillFileSplit.md)  
[Повернутись до змісту](../README.md#tutorials)
