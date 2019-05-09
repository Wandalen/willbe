# Вбудовані кроки для підмодулів

Як користуватись вбудованими кроками для роботи з віддаленими підмодулями.

Для побудови модуля утиліта `willbe` дає розробнику такі інструменти як вбудованими кроками. Ці інструменти призначені для автоматизації основних операція побудови модульної системи. Наприклад, завантаження підмодулів, копіювання і видалення файлів, запуск зовнішніх програм, тощо.

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

Створіть новий `вілфайл` в директорії `predefinedSteps`. Додайте в нього приведений вище код.  

Проглянувши збірки в приведеному `вілфайлі` помітно, що вбудовані кроки управління підмодулями формулюються як команди в консолі операційної системи:   
- `submodules.download` - для завантаження віддалених підмодулів;
- `submodules.update` - для оновлення віддалених підомодулів;
- `submodules.clean` - для видалення віддалених підмодулів разом з директорією `.module`.

При введенні команди в консолі операційної системи утиліта зчитує стан підмодулів, а потім виконує вказану операцію. Якщо ж виконуються операції над підмодулями при побудові збірки, то потрібно оновити їх статус перед наступною дією. Для цього використовується вбудований крок `submodules.reload`, котрий здійснює динамічне оновлення статусу підмодулів після виконання над ними деякої операції. В збірці `clean.download` він оновлює статус підмодулів після їх очищення.  

Також, вбудовані кроки з управління підмодулями одразу поміщені в поле `steps` збірок секції `build`. Це пов'язано з тим, що вони не мають додаткових полів опису. Запис в повній формі вбудованих кроків, котрі не мають додаткових полів збільшує об'єм `вілфайла` та знижує його читабельність.  

Вказані особливості покращують роботу з утилітою та полегшують створення `вілфайла`.

### Побудова модуля

Для дослідження вбудованих кроків роботи з підмодулями виконайте побудову кожної збірки. Команди вводяться в кореневій директорії `вілфайла`.

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

Побудуйте збірку `download` командою `will .build download`.

В процесі побудови утиліта завантажила підмодулі. В директорію `.module` поміщено два віддалених підмодуля - `Tools` i `PathFundamentals`.  

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

Здійсніть очищення модуля від підмодулів виконавши побудову збірки `clean`. Порівняйте вивід консолі і структуру файлів після побудови.

Вивід свідчить, що було видалено 346 файлів. Після побудови з директорії було видалено директорія `.module` з поміщеними в неї підмодулями.

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

Здійсніть апдейт підмодулів побудувавши збірку `update`. Для цього скористуйтесь командою `will .build update`. Порівняйте результати з приведеними вище.

Вбудований крок `submodules update` при відсутності підмодулів також виконує завантаження. Тому, якщо файли віддаленого підмодуля видалені з директорії `.module`, а ресурс в `вілфайлі` - ні, то утиліта його завантажить при наступному оновленні. Для повного видалення підмодуля відредагуйте секцію `submodule` `вілфайлa`.  

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

Для побудови збірки `clean.download` скористайтесь командою `will .build clean.download`. Порівняйте результати побудови з приведеними.

Спочатку, утиліта зчитала та записала в оперативну память статус підмодулів - завантажені. Першим кроком збірки видалила ці модулі. Завдяки кроку `submodules.reload` збірка `clean.download` завантажила підмодулі у кроці `submodules.download`. Якщо б крок `submodules.reload` був відсутній, то утиліта зчитала статус підмодулів як завантажені і пропустила б крок `submodules.download`.

### Підсумок  

- Вбудовані кроки спрощують створення модульної системи.  
- Вбудовані кроки можуть поміщатись в секцію `step` i секцію `build`.
- В секцію `build` поміщаються кроки, які не мають додаткових полів опису.
- Якщо над файлами підмодуля була виконана операція, то перед виконанням наступної операції над підмодулями, потрібно оновити їх статус.
- Вбудований крок `submodules.update` завантажує підмодулі, що відсутні на локальній машині.

[Наступний туторіал](CriterionsInWillFile.md)  
[Повернутись до змісту](../README.md#tutorials)
