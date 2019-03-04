# Як використовувати ассерти в `will`-файлі

В туторіалі пояснюється призначення ассертів та приведено приклади їх застосування

<a name="assert-term"></a>

`Willbe` - система структурування данних, адже, і `will`-файл, і сам модуль будується за визначеними правилами. Саме тому при побудові `will`-файла (і системи, відповідно) потрібно виключити логічні помилки, найпоширенішою з яких є одночасне співпадання декількох ресурсів в вибірці селектора.  
Лінійний сценарій, як завантаження підмодуля або встановлення пакетів зовнішньою програмою, має чітку послідовнісь і виключає логічні помилки, але в попередніх прикладах ми бачили як зростає число ресурсів при додаванні нових умов. Критеріони допомагають створювати вибірки ресурсів, їх достатньо, щоб побудувати систему будь-якої конфігурації. Проте зі збільшенням числа сценаріїв в `will`-файлі бажано ввести перевірку селектора ресурсів. Для цього в пакеті `willbe` використовуються ассерти (_asserts_) - перевірка на кількість входжень в вибірку селектора.  
Ассерти в пакеті використовуються разом з ґлобами, оскільки останні є умовою порівняння мапи критеріонів. Ассерт записуєтся після ґлобу та має вигляд _'=n'_, де _'n'_ позначає кількість входженнь. Для ресурсів в `will`-файлах використовується ассерт '=1' для підтвердження вибору одного доступного ресурса.  

### <a name="how-assert-works"></a> Як працють ассерти
Змінимо попередній `will`-файл так, щоб вибірка сценарію одночасно включала декілька варіантів:

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

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
    path : './fileDebug'

  fileToExport.release :
    criterion :
       debug : 0
    path : './fileRelease'
    
  fileToExport.default :
    path : './fileDefault'    

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

Введемо фразу `will .export export.debug` в кореневій директорії файла `.will.yml`:

```
...
  Exporting export.debug
 * Message
Cant find step export.*   

 * Condensed calls stack
...
(Error message)

```

`Willbe` не знайшов ні одного кроку, хоча маємо три. Додамо в сценарій `export.debug` ассерт до кроку та повторимо ввід команди:

```yaml
build :

  export.debug :
      criterion :
          export : 1
          debug : 1
      steps :
          - export.*=1

```

```
[user@user ~]$ will .export export.debug
...
  Exporting export.debug
 * Message
Failed to resolve "export.*=1" for build::export.debug in module::assertsTesting 
Found : step::export.debug, step::export.default 
Select constraint "export.*=1" failed, got 2 elements in selector "export.*=1"
Path : "/" 
ErrorLooking 
...
(Error message)

```

<a name="assert-failure-information"></a>

Ця інформація вказує на те, що допущена помилка в сценарії `export.debug` - знайдено два кроки `Found : step::export.debug, step::export.default` і її потрібно виправити. Тобто, якщо критеріон в ресурсі не зазначений, то ресурс приймає всі критеріони тому пакет зчитує крок `export.default` також.  
В порівнянні з попереднім логом, ми маємо дані про помилку в визначених ресурсах, що спрощує корегування файла. Для того, щоб виправити помилку необхідно зробити ресурс унікальним - змінити назву і додати відповідний сценарій або ж змінити мапу критеріонів.
Раніше ми створювали окремі сценарії, тепер використаємо критеріони. Уявімо, що крок `export.default` виконується зі встановленим критеріоном `debug` і додатково повинен мати критеріон `first`. Приведіть відповідні секції і ресурси до вигляду:

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

```

Створіть файл `fileDefault` та запустіть `will .export export.debug.first`

```
[user@user ~]$ will .export export.debug.first
...
Exporting export.debug.first
   + Write out will-file /path_to_file/out/assertsTesting.out.will.yml
   + Exported export.debug.first with 1 files in 1.455s
  Exported export.debug.first in 1.513s


```

> Отже, ассерти потрібні для підтвердження правильності виконання програми, а також вони дозволяють [швидко знаходити помилки в `will`-файлі](#assert-failure-information)

[Наступний туторіал]()  
[Повернутись до змісту](Topics.ukr.md)