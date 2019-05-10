# Вбудовані кроки для підмодулів

Як користуватись вбудованими кроками для роботи з віддаленими підмодулями.

Для побудови модуля утиліта `willbe` дає розробнику такі інструменти як вбудовані кроки. Ці інструменти призначені для автоматизації основних операція побудови модульної системи. Наприклад, завантаження підмодулів, копіювання і видалення файлів, запуск зовнішніх програм, тощо.

В цьому туторіалі ви ознайомитесь з вбудованими кроками для управління підмодулями.  

### Стартова конфігурація

<details>
  <summary><u>Структура модуля</u></summary>

```
predefinedSteps              
      └── .will.yml     

```

</details>

Для дослідження вбудованих кроків для підмодулів, створіть структуру файлів вказану вище та внесіть код в `вілфайл`.

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
      - submodules.download
      - echo

```

</details>

Проглянувши збірки `download`, `update` i `clean` в приведеному `вілфайлі` помітно, що вбудовані кроки для управління підмодулями формулюються як команди в консолі операційної системи:   
- `submodules.download` - для завантаження віддалених підмодулів;
- `submodules.update` - для оновлення віддалених підомодулів;
- `submodules.clean` - для видалення віддалених підмодулів разом з директорією `.module`.

Окремо створено зібрку `clean.download` для чистого завантаження підмодулів. Збірка очищає модуль від застарілих підмодулів, а потім завантажує їх з допомогою кроку `submodules.download`. В кінці побудови в консоль виводиться повідомлення "Done".

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

Вивід свідчить, що було видалено 346 файлів. Після побудови з директорії було видалено директорію `.module` з поміщеними в неї підмодулями.

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

Вбудований крок `submodules update` також виконав завантаження. Тому, якщо файли віддаленого підмодуля видалені з директорії `.module`, а ресурс в `вілфайлі` - ні, то утиліта його завантажить при наступному оновленні. Для повного видалення підмодуля відредагуйте секцію `submodule` в `вілфайлі`.  

<details>
  <summary><u>Вивід команди <code>will .build clean.download</code></u></summary>

```
[user@user ~]$ will .build clean.download
...
  Building module::predefinedSteps / build::clean.download
   - Clean deleted 285 file(s) in 1.267s
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was downloaded version master in 24.888s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded version master in 3.783s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 28.700s
 > echo "Done"
Done
  Built module::predefinedSteps / build::clean.download in 30.093s

```

</details>

Для побудови збірки `clean.download` скористайтесь командою `will .build clean.download`. 

Таким чином виконується чисте завантаження підмодулів. Після побудови модуля структура файлів не змінилась.

### Підсумок  

- Вбудовані кроки спрощують створення модульної системи.  
- Вбудовані кроки можуть поміщатись в секцію `step` i секцію `build`.
- В секцію `build` поміщаються кроки, які не мають додаткових полів опису.
- Якщо над файлами підмодуля була виконана операція, то перед виконанням наступної операції над підмодулями, потрібно оновити їх статус.
- Вбудований крок `submodules.update` завантажує підмодулі, що відсутні на локальній машині.

[Наступний туторіал](CriterionsInWillFile.md)  
[Повернутись до змісту](../README.md#tutorials)
