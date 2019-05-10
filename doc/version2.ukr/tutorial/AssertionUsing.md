# Як користуватись ассертами

Як ассерти допомогають зменшити кількість помилок при розробці.

Лінійна збірка має встановлену послідовність, не використовує критеріони і, відповідно, виключає помилки вибору ресурсів. Одночасно, зі збільшенням числа умов зростає число ресурсів і погіршується читабельність `вілфайла`. Використання критеріонів та ґлобів вирішує питання пошуку і вибору ресурсів без забезпечення достовірності числа входжень, тому, потрібно ввести самодіагностику кількості ресурсів в вибірці. Для цього в утиліті `willbe` використовуються ассерти (assertions).  

Ассерт - спеціальна конструкція, яка дозволяє перевіряти кількість входжень в вибірку селектора. Ассерти в утиліті використовуються разом з ґлобами, оскільки останні є умовою вибору декількох ресурсів. Ассерт записуєтся після ґлобу та має вигляд `=n`, де `n` позначає кількість входжень. Для підтвердження вибору одного ресурса використовується ассерт `=1`.  

### Конфігурація 

<details>
  <summary><u>Структура файлів</u></summary>

```
shellCommand
    ├── fileDebug
    ├── fileDefault  
    ├── fileRelease         
    └── .will.yml       

```

</details>

Побудуйте структуру файлів приведену вище для дослідження роботи ассертів.  

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
    inherit : module.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 1

  export.release :
    inherit : module.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 0

  export.default :
    inherit : module.export
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

В `вілфайл` помістіть приведений код.

В `вілфайлі` є дві збірки для експорту окремих файлів. Згідно мапи критеріонів збірка `export.debug` повинна вибрати одноіменний крок. Збірка `export.release`, відповідно, обирає крок `export.release`.  

### Дослідження ассертів

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

Введіть команду `will .export export.debug` в директорії файла `.will.yml`.

Утиліта не знайшла крок `export.*`, хоча в секції `step` є три, які задовільняють ґлоб `*`. Відомо, що утиліта має знайти один крок згідно мапи критеріонів. Тому, додайте ассерт для вибору одного кроку в селектори збірок секції `build`. Для цього замініть вміст `вілфайла` на приведений нижче.

<details>
    <summary><u>Код файла <code>.will.yml</code> з ассертами в секції <code>build</code></u></summary>

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
    inherit : module.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 1

  export.release :
    inherit : module.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 0

  export.default :
    inherit : module.export
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

Повторіть ввід команди `will .export export.debug` та порівняйте результат з приведеним:

<details>
    <summary><u>Вивід консолі про помилку та <code>вілфайл</code></u></summary>

![SelectorWithAssert](../../images/selector.with.assert.png)

</details>

Інформація в консолі вказує, що допущена помилка в збірці `export.debug`. Утилітою знайдено два кроки: `Found : step::export.debug, step::export.default`, а очікувався один. Утиліта `willbe` зчитала крок `export.default` як дійсний за відсутністю критеріона `debug`. Тобто, ресурс, який не має критеріонів, при перевірці обирається, як дійсний, а не відкидається.  

В порівнянні з попереднім виводом консолі, отримано дані про помилку в визначених ресурсах, що спрощує корегування файла. Для того, щоб виправити помилку, потрібно зробити ресурс унікальним. Для цього можна змінити назву ресурса і додати додаткову збірку або ж змінити мапу критеріонів.    

<details>
    <summary><u>Зміни в секціях <code>step</code> i <code>build</code> <code>вілфайлa</code></u></summary>

```yaml
step  :
  export.debug :
    inherit : module.export
    export : path::fileToExport.*
    tar : 0
    criterion :
      debug : 1
      first : 1

  export.default :
    inherit : module.export
    export : path::fileToExport.default
    tar : 0
    criterion :
      debug : 1
      first : 0

build :

  export.debug:
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

Приведіть відповідні секції файла `.will.yml` згідно коду приведеного вище.

У вказані ресурси введено критеріон `first`, котрий змінив мапу критеріонів для доступу до кроку `export.default`. Згідно запису, кроки `export.debug` i `export.default` обираються утилітою, коли критеріон `debug` має значення `1`.  

<details>
    <summary><u>Вивід команди <code>will .export export.debug.first</code></u></summary>

```
[user@user ~]$ will .export export.debug
...
Exporting export.debug
   + Write out will-file /path_to_file/out/assertsTesting.out.will.yml
   + Exported export.debug.first with 1 files in 1.455s
  Exported export.debug.first in 1.513s

```

</details>

Запустіть команду `will .export export.debug.first`.

Після зміни мап критеріонів, кожен ресурс отримав унікальні умови доступу. Відповідно, збірка `export.debug` обирає тільки один крок і кількість входжень співпадає з ассертом.

### Підсумок  

- Ассерти перевіряють кількість входжень в вибірці ресурсів селектором з ґлобом.
- Ассерти дозволяють швидко локалізувати помилки в `вілфайлі`.

[Наступний туторіал](WillFileMinimization.md)  
[Повернутись до змісту](../README.md#tutorials)
