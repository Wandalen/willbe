# Мінімізація will-файлів

В туторіалі показано як мінімізувати величину `will`-файла та особливості секції `build` при використанні скороченої форми запису  

Ми вже бачили, що об'єм `will`-файла можливо зменшити використовуючи скорочену форму запису деяких ресурсів. Також, критеріони дозволяють будувати сценарії, які використовують дані секцій. Проте, коли ми використовували критеріони, то на кожну комбінацію значень створювали окремий ресурс в `will`-файлі. При цьому кількість комбінацій критеріонів, відповідно, кількість ресурсів які потенційно потрібно створити в одній секції визначається як '2 ^ (_n_)', де _n_ - число критеріонів в модулі. Тобто, якщо маємо один критеріон (`_n_ = 1`), то в одній секції є `2 ^ 1 = 2` потенційних ресурси, при `_n_ = 3` це число збільшується до 8-ми. Як бачите, користуватись такою формою запису незручно тому `willbe` має іншу.  
Для початку створимо модуль, який повинен видаляти окремий файл в директорії `files`:
<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

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

Після цього в кореневій директорії `.will.yml` створіть директорію `files` і помістіть файли назви яких будуть починатись на _'Debug'_ та _'Release'_ (можете створити по декілька файлів, оскільки в секції `path` використано ґлоб '\*'). 
Вбудований крок `predefined.delete` видаляє файли і директорії за вказаним в `filePath` шляхом. Тому запуск сценаріїв призведе до видалення відповідних файлів.