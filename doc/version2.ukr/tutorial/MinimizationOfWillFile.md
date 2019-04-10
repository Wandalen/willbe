# Мінімізація `will-файлa`

Як мінімізувати об'єм `will-файла` за допомогою розгортання критеріонами із множинними значеннями  

Об'єм `will-файла` можливо зменшити, використовуючи скорочену форму запису деяких ресурсів, записуючи масиви з допомогою ґлобів, а також з допомогою критеріонів. Перші два способи зменшують `will-файл`, а критеріони можуть навіть збільшити об'єм. Тож, час дізнатись як користуватись розгортанням ресурсів з критеріонами.   

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

Збірка `delete` в секції `build` та крок `delete.files` в секції `step` використовують функцію розгортання ресурсів з критеріонами. Для цього критеріону присвоюється значення в вигляді массиву, в даному випадку, `debug : [ 0,1 ]`.
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

Ресурси зі скороченою формою запису критеріонів були згенеровані утилітою `willbe` в оперативну пам'ять як окремі ресурси зі звичайним записом критеріонів і ідентичним функціоналом. Крім цього, назви ресурсів змінились: при `debug : 0` до назви ресурса додано знак `.`, a при `debug : 1` - `.debug`, тобто, за назвою критеріона.  
В ресурсі може бути декілька критеріонів зі скороченою формою запису, в такому випадку утиліта згенерує ресурси зі всіма можливими комбінаціями критеріонів.  

### Побудова збірок
Вбудований крок `predefined.delete` видаляє файли і директорії за вказаним в `filePath` шляхом. 
`Willbe` на основі критеріона `debug : [ 0,1 ]` створив два кроки: `delete.debug.` з критеріоном `debug : 0` та `delete.debug.debug` з критеріоном `debug : 1`, тобто при значенні `debug : 0` утиліта до назви процедури додає знак `.`, а якщо встановлено `1`, то використовується приставка `.[criterion_name]`.  
Введіть фразу `will .build delete.debug`:

```
[user@user ~]$ will .build delete.debug
...
  Building delete.debug
   - filesDelete 1 files at /path_to_file/files in 0.028s
  Built delete.debug in 0.154s

```

Після чого перевірте вміст директорії `files` (`ls -l files/` в терміналі):
```
[user@user ~]$ ls -l files/
-rw-r--r-- 1 user user 301 Mar 17 08:33 Release

```

Залишився файл з назвою `Release`. Програма працює правильно.  

Мінімізуємо секцію `build`, адже, подібно секції `step` збірки відрізняються назвами і критеріонами:

```yaml
build :

  delete :
      criterion :
          debug : [ 0,1 ]
      steps :
          - delete.*

```



Відповідно, щоб видалити файл `Release`, введіть `will .build delete.`.

```
[user@user ~]$ will .build delete.
...
  Building delete.
   - filesDelete 1 files at /path_to_file/files in 0.028s
  Built delete. in 0.149s

```

```
[user@user ~]$ ls files/
итого 0

```

- Зменшити об'єм `will-файла` можна з допомогою скороченої форми запису ресурсів, ґлобів та критеріонів. Останній має ряд переваг: автоматичне розділення ресурсів по критеріонам, автодоповнення назв, простота запису.

[Наступний туторіал](SplitWillFile.md)  
[Повернутись до змісту](../README.md#tutorials)
