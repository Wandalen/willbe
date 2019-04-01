# Знайомство з вбудованими кроками

Як користуватись вбудованими кроками для роботи з віддаленими підмодулями

Для побудови модулів застосовуються операції, що повторюються - завантаження файлів, переміщення, копіювання, видалення... Реалізація вказаних операцій засобами операційної системи трудомістка тому, в утиліті `willbe` є вбудовані кроки для автоматизації основних операцій.    
В туторіалі ["Побудова модуля командою `.build`"](ModuleCreationByBuild.md) використовувався вбудований крок для запуску команд в консолі операційної системи, тут ознайомитесь з вбудованими кроками для управління підмодулями.  
Створіть новий `will-файл` в директорії `predefinedSteps` та додайте в нього приведений код:  

<details>
  <summary><u>Повний код файла <code>.will.yml</code></u></summary>

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

   upgrade :
       steps :
          - submodules.upgrade

   clean :
       steps :
          - submodules.clean
          
   clean.download :
       steps :
          - submodules.clean
          - submodules.download
          - echo
           
```

<p>Структура модуля</p>

```
predefinedSteps              
      └── .will.yml     
  
```

</details>


Вбудовані кроки управління підмодулями формулюються як команди в консолі операційної системи (для більшості команд утиліти `willbe` є вбудовані кроки). Кроки поміщені в поле `steps` секції `build`, оскільки, вони не мають додаткових полів опису. Порівняйте з повною формою запису:

<details>
  <summary><u>Повний форма запису вбудованого кроку <code>submodules.download</code></u></summary>

```yaml
step :
    
    download :
        inherit : submodules.download

build :

    download :
        steps :
           - download
           
```

</details>


Запис в повній формі вбудованих кроків, які не мають додаткових полів збільшує об'єм `will-файла` та знижує його читабельність.  
Виконайте побудови збірок (команди вводяться в кореневій директорії `will-файла`):

<details>
  <summary><u>Вивід фрази <code>will .build download</code> та структура модуля</u></summary>

```
[user@user ~]$ will .build download
...
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was downloaded in 12.741s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 4.903s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 17.652s
  Built download in 17.698s

```

<p>Структура модуля після побудови</p>

```
predefinedSteps
     ├── .module
     │      ├── Tools
     │      └── PathFundamentals
     └── .will.yml

```

</details>

<details>
  <summary><u>Вивід фрази <code>will .build clean</code> та структура модуля</u></summary>

```
[user@user ~]$ will .build clean
  Building clean
  ...
   - Clean deleted 346 file(s) in 1.159s
  Built clean in 1.207s
  
```

<p>Структура модуля після побудови</p>

```
predefinedSteps
     └── .will.yml

```

</details>

<details>
  <summary><u>Вивід фрази <code>will .build upgrade</code> та структура модуля</u></summary>

```
[user@user ~]$ will .build upgrade
...
  Building upgrade
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was upgraded in 17.024s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was upgraded in 4.256s
   + 2/2 submodule(s) of module::predefinedSteps were upgraded in 21.288s
  Built upgrade in 21.330s

  ```

<p>Структура модуля після побудови</p>

```
predefinedSteps
     ├── .module
     │      ├── Tools
     │      └── PathFundamentals
     └── .will.yml

```

</details>

<details>
  <summary><u>Вивід фрази <code>will .build clean.download</code> та структура модуля</u></summary>

```
[user@user ~]$ will .build clean.download
...
  Building clean.download
   - Clean deleted 344 file(s) in 1.205s
     + module::Tools was downloaded in 13.699s
     + module::PathFundamentals was downloaded in 2.903s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 16.610s
 > echo "Done"
Done
  Built clean.download in 17.907s

```

<p>Структура модуля після побудови</p>

```
predefinedSteps
     ├── .module
     │      ├── Tools
     │      └── PathFundamentals
     └── .will.yml

```

</details>

  
Послідовність виконання дій показує, що фраза `will .build upgrade` при відсутності підмодулів також виконує завантаження. Тому, якщо ви видалите підмодуль, утиліта його завантажить при наступному оновленні. Для повного видалення підмодуля відредагуйте секцію `submodule` `will-файлa`.  

### Підсумок  
- Вбудовані кроки спрощують створення модульної системи.  
- Вбудовані кроки можуть поміщатись в секцію `step` i секцію `build`.

[Наступний туторіал](CriterionsInWillFile.md)  
[Повернутись до змісту](../README.md#tutorials)