# How to use assertions

How assertions help to avoid errors during development.

Утиліта `willbe` - система структурування даних, адже,`will-файл` дає розробнику чітке уявлення про структуру і призначення модуля завдяки зручному формату і формі запису. Тому, при побудові `will-файла` (і модуля, відповідно) потрібно виключити логічні помилки, найпоширенішою з яких є одночасне співпадання декількох ресурсів в вибірці селектора.  
Лінійна збірка має встановлену послідовність, не використовує критеріони і, відповідно, виключає логічні помилки, одночасно, зі збільшенням умов зростає число ресурсів і погіршується читабельність `will-файла`. Використання критеріонів та ґлобів вирішує питання пошуку і вибору ресурсів без забезпечення достовірності числа входжень, тому, потрібно ввести самодіагностику кількості входжень. Для цього в утиліті `willbe` використовуються ассерти (asserts).   
Ассерт - спеціальна конструкція, яка дозволяє перевіряти кількість входжень в вибірку селектора. Ассерти в утиліті використовуються разом з ґлобами, оскільки останні є умовою вибору декількох ресурсів. Ассерт записуєтся після ґлобу та має вигляд `=n`, де `n` позначає кількість входжень. Для підтвердження вибору одного ресурса використовується ассерт `=1`.  

### Як працють ассерти  
Побудуйте структуру файлів для дослідження роботи ассертів:  

<details>
  <summary><u>Структура модуля</u></summary>

```
shellCommand
    ├── fileDebug
    ├── fileDefault  
    ├── fileRelease         
    └── .will.yml       

```

</details>

В `will-файл` помістіть наступний код:

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : assertsTesting
  description : "To test asserts"
  version : 0.0.1

path :

  in : '.'
  out : 'out'
  fileToExport.debug :
    criterion :
      debug : 1
    path : 'fileDebug'

  fileToExport.release :
    criterion :
      debug : 0
    path : 'fileRelease'

  fileToExport.default :
    path : 'fileDefault'    

step  :
  export.debug :
    inherit : predefined.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 1

  export.release :
    inherit : predefined.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 0

  export.default :
    inherit : predefined.export
    export : path::fileToExport.default
    tar : 0

build :

  export.debug :
    criterion :
      export : 1
      debug : 1
    steps :
      - export.*

  export.release :
    criterion :
      export : 1
      debug : 0
    steps :
      - export.*

```

</details>

Модуль здійснює експорт файлів.  
Введіть команду `will .export export.debug` в кореневій директорії файла `.will.yml`:

<details>
  <summary><u>Вивід команди <code>will .export export.debug</code></u></summary>

```
[user@user ~]$ will .export export.debug
...
  Exporting export.debug
 * Message
Cant find step export.*   

 * Condensed calls stack
...
(Error message)

```

</details>

Утиліта не знайшла крок `export.*`, хоча є три. Додайте ассерт для вибору одного файла в селектор `export.*` збірок секції `build` та повторіть ввід команди:

<details>
    <summary><u>Код файла <code>.will.yml</code> зі змінами</u></summary>

```yaml
about :

  name : assertsTesting
  description : "To test asserts"
  version : 0.0.1

path :

  in : '.'
  out : 'out'
  fileToExport.debug :
    criterion :
      debug : 1
    path : 'fileDebug'

  fileToExport.release :
    criterion :
      debug : 0
    path : 'fileRelease'

  fileToExport.default :
    path : 'fileDefault'    

step  :
  export.debug :
    inherit : predefined.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 1

  export.release :
    inherit : predefined.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 0

  export.default :
    inherit : predefined.export
    export : path::fileToExport.default
    tar : 0

build :

  export.debug :
    criterion :
      export : 1
      debug : 1
    steps :
      - export.*=1

  export.release :
    criterion :
      export : 1
      debug : 0
    steps :
      - export.*=1

```

</details>
<details>
    <summary><u>Лог помилки та <code>will-файл</code></u></summary>

![SelectorWithAssert](./Images/selector.with.assert.png)

</details>

Інформація в консолі вказує, що допущена помилка в збірці `export.debug` - знайдено два кроки `Found : step::export.debug, step::export.default`, а очікувався один. Тобто, ресурс підтверджує істинність критеріонів, які не вказані в ньому тому, утиліта `willbe` зчитала крок `export.default` як дійсний за відсутністю критеріона `debug`.   
В порівнянні з попереднім виводом консолі, отримано дані про помилку в визначених ресурсах, що спрощує корегування файла. Для того, щоб виправити помилку потрібно зробити ресурс унікальним - змінити назву і додати відповідну збірку або ж змінити мапу критеріонів.   
Приведіть відповідні секції і ресурси до вигляду:  

<details>
    <summary><u>Зміни в секціях <code>step</code> i <code>build</code> <code>will-файлa</code></u></summary>

```yaml
step  :
  export.debug :
    inherit : predefined.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 1
      first : 0

  export.default :
    inherit : predefined.export
    export : path::fileToExport.default
    tar : 0
    criterion :
      debug : 1
      first : 1

build :

  export.debug.first :
    criterion :
      export : 1
      debug : 1
      first : 1
    steps :
      - export.*=1

  export.release :
    criterion :
      export : 1
      debug : 0
      first : 0
    steps :
      - export.*=1

```

</details>

У вказані ресурси введено критеріон `first`, котрий змінив мапу критеріонів для доступу до кроку `export.default`. 
Запустіть команду `will .export export.debug.first`:  

<details>
    <summary><u>Вивід команди <code>will .export export.debug.first</code></u></summary>

```
[user@user ~]$ will .export export.debug.first
...
Exporting export.debug.first
   + Write out will-file /path_to_file/out/assertsTesting.out.will.yml
   + Exported export.debug.first with 1 files in 1.455s
  Exported export.debug.first in 1.513s

```

</details>

### Підсумок  
- Ассерти потрібні для підтвердження правильності вибору ресурсів.
- Ассерти дозволяють швидко локалізувати помилки в `will-файлі`.

[Наступний туторіал](WillFileMinimization.md)  
[Повернутись до змісту](../README.md#tutorials)
