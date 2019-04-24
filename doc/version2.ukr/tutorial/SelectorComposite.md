# Складні селектори

Використання складних селекторів для відбору ресурсів із підмодулів.

При побудові модуля може виникнути потреба використати ресурси іншого `will-файла`, для цього в `willbe` використовуються складні селектори. Складний селектор відрізняється від звичайного формою запису - вказує на обраний елемент як шлях до файла.   

### Використання складних селекторів  

<details>
  <summary><u>Структура модуля</u></summary>

```
complexSelector
        └── .will.yml

```

</details>

Для дослідження складних селекторів побудуйте приведену структуру файлів.  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : complexSelector
  description : 'To use complexSelector in will-file'
  version : 0.0.1

submodule : 
 
  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

path :

  in : '.'
  out : 'out'

step :

  exportSubmodule :
    export : submodule::*/exported::*=1/reflector::exportedFiles*=1
    tar : 0

build :

  export.from.submodule :
    criterion :
      default : 1
      export : 1
    steps :
      - submodules.download
      - step::exportSubmodule

```

</details>

Внесіть в файл `.will.yml` код.

В збірці `export.submodule` крок `exportSubmodule` використовує складний селектор `submodule::*/exported::*=1/reflector::exportedFiles*=1`. Селектор зчитується так: вибрати кожен ресурс секції `submodule`, перейти до секції `exported` та вибрати рефлектор `exportedFiles` для експорту файлів.  

<details>
  <summary><u>Вивід команди <code>will .export</code></u></summary>

```
[user@user ~]$ will .export
...
  Exporting module::complexSelector / build::export.submodule
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 13.710s
   + 1/1 submodule(s) of module::complexSelector were downloaded in 13.718s
   . Read : /path_to_file/out/complexSelector.out.will.yml
   . Read 1 will-files in 0.231s  
  
   + Write out will-file /path_to_file/out/complexSelector.out.will.yml
   + Exported export.submodule with 261 files in 3.741s
  Exported module::complexSelector / build::export.submodule in 3.895s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
.
├── .module
│     └── Tools
├── out
│     └── complexSelector.out.will.yml
│
└── .will.yml

```

</details>

Запустіть збірку експорту за замовчуванням (`will .export`).

Експортовано файли підмодуля `Tools`.  

### Підсумок 

- Складний селектор записується як шлях до ресурса. 
- Складні селектори використовують ресурси `will-файлів` підмодулів.  

[Повернутись до змісту](../README.md#tutorials)
