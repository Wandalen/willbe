# Вбудовані кроки

Як користуватись вбудованими кроками для роботи з віддаленими підмодулями.

Утиліта `willbe` дає розробнику ряд інструментів для побудови модуля, які називаються вбудованими кроками. Ці інструменти призначені для автоматизації основних операція побудови модульної системи як то, завантаження підмодулів, копіювання і видалення файлів, запуск зовнішніх програм, тощо.

В цьому туторіалі ви ознайомитесь з вбудованими кроками для управління підмодулями.  

### Стартова конфігурація

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : predefinedSteps
  description : "To use predefined submodule control steps"
  version : 0.0.1

submodule :
  
  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

step :

  echo :
    shell : echo "Done"
    currentPath : '.'
build :

  download :
    steps :
      - submodules.download

  update :
    steps :
      - submodules.update

  clean :
    steps :
      - submodules.clean
          
  clean.download :
    steps :
      - submodules.clean
      - submodules.reload
      - submodules.download
      - echo
           
```

</details>
<details>
  <summary><u>Структура модуля</u></summary>

```
predefinedSteps              
      └── .will.yml     
  
```

</details>

Створіть новий `will-файл` в директорії `predefinedSteps`. Додайте в нього приведений вище код.  

Проглянувши збірки в приведеному `will-файлі` помітно, що вбудовані кроки управління підмодулями формулюються як команди в консолі операційної системи. 

При введенні команди в консолі операційної системи утиліта зчитує стан підмодулів, а потім виконує команду. Якщо виконуються операції над підмодулями при побудові збірки, то потрібно оновити їх статус перед наступною дією. Для цього використовується вбудований крок `submodules.reload`, який здійснює динамічне оновлення статусу підмодулів після виконання над ними операції. В збірці `clean.download` він оновлює статус підмодулів після їх очищення.  

Також, ці кроки поміщені в поле `steps` збірок секції `build`, оскільки, вони не мають додаткових полів опису. Запис в повній формі вбудованих кроків, котрі не мають додаткових полів збільшує об'єм `will-файла` та знижує його читабельність.  

Вказані особливості покращують роботу з утилітою та полегшують створення `will-файла`. 

### Побудова модуля

Виконайте побудову кожної збірки (команди вводяться в кореневій директорії `will-файла`).

<details>
  <summary><u>Вивід команди <code>will .build download</code></u></summary>

```
[user@user ~]$ will .build download
...
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was downloaded in 12.741s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 4.903s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 17.652s
  Built module::first / build::download in 17.698s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
predefinedSteps
     ├── .module
     │      ├── Tools
     │      └── PathFundamentals
     └── .will.yml

```

</details>
<details>
  <summary><u>Вивід команди <code>will .build clean</code></u></summary>

```
[user@user ~]$ will .build clean
  Building clean
  ...
   - Clean deleted 346 file(s) in 1.159s
  Built module::first / build::clean in 1.207s
  
```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
predefinedSteps
     └── .will.yml

```

</details>
<details>
  <summary><u>Вивід команди <code>will .build update</code></u></summary>

```
[user@user ~]$ will .build update
...
  Building module::first / build::upgrade
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was updated in 13.922s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals version master was updated in 3.553s
   + 2/2 submodule(s) of module::first were updated in 17.484s
  Built module::first / build::update in 17.538s


  ```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
predefinedSteps
     ├── .module
     │      ├── Tools
     │      └── PathFundamentals
     └── .will.yml

```

</details>
<details>
  <summary><u>Вивід команди <code>will .build clean.download</code></u></summary>

```
[user@user ~]$ will .build clean.download
...
  Building module::predefinedSteps / build::clean.download
   - Clean deleted 344 file(s) in 1.155s
   . Reloading submodules..
     + module::Tools was downloaded in 13.699s
     + module::PathFundamentals was downloaded in 2.903s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 16.610s
 > echo "Done"
Done
  Built module::predefinedSteps / build::clean.download in 1.411s


```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
predefinedSteps
     ├── .module
     │      ├── Tools
     │      └── PathFundamentals
     └── .will.yml

```

</details>
  
Вбудований крок `submodules update` при відсутності підмодулів також виконує завантаження. Тому, якщо файли віддаленого підмодуля видалені з директорії `.module`, а ресурс в `will-файлі` - ні, то утиліта його завантажить при наступному оновленні. Для повного видалення підмодуля відредагуйте секцію `submodule` `will-файлa`.  

### Підсумок  

- Вбудовані кроки спрощують створення модульної системи.  
- Вбудовані кроки можуть поміщатись в секцію `step` i секцію `build`.
- Перед виконанням операції над підмодулями при побудові модуля, потрібно оновити їх статус.
- Вбудований крок `submodules.update` завантажує підмодулі, що відсутні на локальній машині.

[Наступний туторіал](CriterionsInWillFile.md)  
[Повернутись до змісту](../README.md#tutorials)