# Мінімізація will-файлів

В туторіалі показано, як мінімізувати величину `will`-файла та властивості ресурсів при використанні скороченої форми запису критеріонів  

Ми вже бачили, що об'єм `will`-файла можливо зменшити, використовуючи скорочену форму запису деяких ресурсів, записуючи масиви з допомогою ґлобів, а також з допомогою критеріонів. Перші два способи суттєво зменшують `will`-файл, проте, коли ми використовували критеріони, то на кожну комбінацію значень створюється окремий ресурс, що навпаки збільшує об'єм. При цьому, кількість комбінацій критеріонів, відповідно, кількість ресурсів, які потенційно потрібно створити в одній секції визначається як `2 ^ (n)`, де `n` - число критеріонів в модулі. Тобто, якщо маємо один критеріон (`n = 1`), то в одній секції є `2 ^ 1 = 2` потенційних ресурси, при `n = 3` це число збільшується до 8-ми. Як бачите, користуватись такою формою запису незручно, тому, `willbe` має іншу.  
Для початку створимо модуль для видалення файлів в директорії `files`:

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

```yaml

about :

  name : willFileMinimizing
  description : "To minimize will-file by short write form of criterions"
  version : 0.0.1

path :

  fileToDelete.debug :
    criterion :
       debug : 1
    path : './files/Debug*'

  fileToDelete.release :
    criterion :
       debug : 0
    path : './files/Release*'

step  :

  delete.debug :
      inherit : predefined.delete
      filePath : path::fileToDelete.*
      criterion :
         debug : 1

  delete.release :
      inherit : predefined.delete
      filePath : path::fileToDelete.*
      criterion :
         debug : 0

build :

  delete.debug :
      criterion :
          debug : 1
      steps :
          - delete.*

  delete.release :
      criterion :
          debug : 0
      steps :
          - delete.*

```

</details>

Після цього в кореневій директорії `.will.yml` створіть директорію `files` і помістіть файли назви яких будуть починатись на _'Debug'_ та _'Release'_ (можете створити по декілька файлів, оскільки в секції `path` використано ґлоб '\*', тоді лістинги будуть відрізнятись кількістю файлів).
Вбудований крок `predefined.delete` видаляє файли і директорії за вказаним в `filePath` шляхом. Тому запуск збірок призведе до видалення відповідних файлів. Але для початку зменшимо кількість кроків.
Проаналізуємо секцію `path`: є два ресурси які починаються на `fileToDelete`, але продовження назви, критеріони і шляхи відрізняються. Якщо ми об'єднаємо ці ресурси, то не зможемо розділити шляхи до файлів. Тому, секція `path` залишається без змін.
Аналіз кроків `delete.debug` i `delete.release`, показує, що функціонал (в даному випадку процедура видалення) у них однаковий, але є відмінності в назвах та критеріонах. Саме при таких умовах використовується мінімізація за рахунок об'єднання критеріонів. Змініть секцію `step` до вигляду:

```yaml
step  :

  delete.debug :
      inherit : predefined.delete
      filePath : path::fileToDelete.*
      criterion :
         debug : [ 0,1 ]

```

Залишився один крок, а обидва значення критеріона заключено в квадратні дужки та введено через кому, як при позначенні массивів в мовах програмування.
Перевіримо які кроки є в файлі:

```
[user@user ~]$ will .steps.list
...
step::delete.debug.
  criterion :
    debug : 0
  opts :
    filePath : path::fileToDelete.*
  inherit :
    predefined.delete

step::delete.debug.debug
  criterion :
    debug : 1
  opts :
    filePath : path::fileToDelete.*
  inherit :
    predefined.delete


```

`Willbe` на основі критеріона `debug : [ 0,1 ]` створив два кроки: `delete.debug.` з критеріоном `debug : 0` та `delete.debug.debug` з критеріоном `debug : 1`, тобто при значенні `debug : 0` пакет до назви процедури додає знак '.', а якщо встановлено '1', то використовується приставка _'.[criterion_name]'_.  
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

Залишився файл з назвою _'Release'_. Програма працює правильно.  

Мінімізуємо секцію `build`, адже, подібно секції `step` збірки відрізняються назвами і критеріонами:

```yaml
build :

  delete :
      criterion :
          debug : [ 0,1 ]
      steps :
          - delete.*

```

Оскільки використання скороченої форми запису критеріонів змінює назви ресурсів, спочатку перевіримо, які у нас є збірки:

```
[user@user ~]$ will .builds.list
...
build::delete.
  criterion :
    debug : 0
  steps :
    delete.*

build::delete.debug
  criterion :
    debug : 1
  steps :
    delete.*

```

Відповідно, щоб видалити файл _'Release'_ введемо `will .build delete.`.

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

- Зменшити об'єм `will`-файла можна з допомогою скороченої форми запису ресурсів, ґлобів та критеріонів. Останній має ряд переваг: автоматичне розділення ресурсів по критеріонам, автодоповнення назв, простота запису.

[Наступний туторіал](SplitWillFile.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)
