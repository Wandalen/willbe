# Minimization of <code>will-file</code>

How to minimize <code>will-file</code> with help of instantiation of sets of criterions.

Зручність роботи з `will-файлом` залежить від його об'єму - чим він менший, тим легше. Тому, використовується скорочена форма запису ресурсів, ґлоби, а також, критеріони. Скорочена форма запису ресурсів і ґлоби зменшують `will-файл`, а критеріони можуть навіть збільшити об'єм. Тож, час дізнатись як користуватись розгортанням ресурсів з критеріонами для мінімізації `will-файла`.   

### Розгортання критеріонами. Конфігурація
Створіть директорію `minimize` з наступною конфігурацією:  

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

Помістіть код в `will-файл`:

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : willFileMinimizing
  description : "To minimize will-file by short write form of criterions"
  version : 0.0.1

path :

  in : '.'
  out : 'out'
  fileToDelete.debug :
    criterion :
      debug : 1
    path : './files/Debug*'
  fileToDelete.release :
    criterion :
      debug : 0
    path : './files/Release*'

step  :

  delete.files :
    inherit : predefined.delete
    filePath : path::fileToDelete.*=1
    criterion :
      debug : [ 0,1 ]

build :

  delete :
    criterion :
      debug : [ 0,1 ]
    steps :
      - delete.*=1

```

</details>

Збірка `delete` в секції `build` та крок `delete.files` в секції `step` використовують функцію розгортання ресурсів з критеріонами. Для цього критеріону присвоюється значення в вигляді массиву, в даному випадку, `debug : [ 0,1 ]`. Утиліта, зчитуючи такий ресурс, розгортає його на копії, що відрізняються назвою і мають один критеріон. 
Перевірте, які ресурси в секціях `step` i `build` присутні:

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

Ресурси з множинними значеннями критеріонів розділені утилітою на окремі ресурси зі звичайним записом критеріонів, а також, відбулись зміни в назвах ресурсів: 
\- в ресурсі, згенерованому утилітою з критеріоном `debug : 0` до назви додано знак `.`;
\- в ресурсі з критеріоном `debug : 1` додано `.debug`, тобто, за назвою критеріона.  
В ресурсі може бути декілька критеріонів з множинним записом критеріонів, в такому випадку утиліта згенерує ресурси зі всіма можливими комбінаціями критеріонів.  

### Побудова збірок
При використанні розгортання критеріонів в збірках `will-файла` критеріон `default : 1` не працює, оскільки, утиліта не може визначити яка зі згенерованих збірок повинна виконуватись за замовчуванням.  
В приведеному `will-файлі` обидві збірки здійснюють видалення файлів з допомогою вбудованого кроку `predefined.delete`, що поміщений в крок `delete.files`.    
Введіть команду `will .build delete.debug` та перевірте зміни в директорії `files`:

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

Залишився файл з назвою `Release`. Відповідно, щоб видалити файл `Release.js`, введіть `will .build delete.`.  

<details>
  <summary><u>Вивід команди <code>will .builds.list</code></u></summary>

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

### Підсумок
- Зменшити об'єм `will-файла` можна з допомогою ґлобів, критеріонів та скороченої форми запису ресурсів.
- Розгортання ресурсів з множинним значенням критеріонів забезпечує автоматичне генерування ресурсів за комбінаціями критеріонів
- При застосуванні розгортання критеріонами назви згенерованих ресурсів автоматично доповнюються згідно назв критеріонів.

[Наступний туторіал](WillFileSplit.md)  
[Повернутись до змісту](../README.md#tutorials)
