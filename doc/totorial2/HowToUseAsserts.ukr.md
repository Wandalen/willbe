# Як використовувати ассерти в `will`-файлі

В туторіалі пояснюється призначення ассертів та приведено приклади їх застосування

`Willbe` - система структурування данних, адже, і `will`-файл, і сам модуль будується за визначеними правилами. Саме тому при побудові `will`-файла (і системи, відповідно) потрібно виключити логічні помилки, найпоширенішою з яких є одночасне співпадіння декількох варіантів ресурсів в вибірці селектора.  
Лінійний сценарій, як завантаження підмодуля або встановлення пакетів зовнішньою програмою, має чітку послідовнісь і виключає логічні помилки, але в попередніх прикладах ми бачили як зростає число ресурсів при додаванні нових умов. Критеріони допомагають створювати вибірки ресурсів, їх достатньо, щоб побудувати систему будь-якої конфігурації. Проте зі збільшенням числа сценаріїв в `will`-файлі бажано ввести перевірки достовірності вибірки ресурсів. Для цього в пакеті `willbe` використовуються ассерти (_asserts_) - перевірка на кількість входжень в вибірку селектора.  
Ассерти в пакеті використовуються разом з ґлобами, оскільки останні є умовою порівняння мапи критеріонів ресурсів. Ассерт записуєтся після ґлобу та має вигляд '=1', де 1 позначає одне входження.  

### Як працють ассерти
Змінимо попередній `will`-файл так, вибірка сценарію одночасно включала декілька варіантів:

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

```yaml

about :

  name : selectorWithGlob
  description : "Using selector with glob to choise path"
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



[Повернутись до змісту](Topics.ukr.md)