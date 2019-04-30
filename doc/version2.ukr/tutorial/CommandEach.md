# Як користуватись командою <code>.each</code>

Команда <code>.each</code> для виконання одної дії для багатьох модулів чи підмодулів.

Для роботи з декількома модулями, використовуйте команду `.each`, котра виконує вказану фразу для кожного `вілфайла` в зазначеній директорії. Для вводу команди використовуйте синтаксис `will .each [dir] [command] [argument]`, де `[dir]` - директорія з `вілфайлами`; `[command]` - команда для файлів в директорії; `[argument]` - аргумент команди, якщо він необхідний (для всіх `вілфайлів` має бути один аргумент або використовуватись ґлоб). 

### Використання команди `.each`. Конфігурація

<details>
  <summary><u>Файлова структура</u></summary>

```  
named 
  ├── proto
  │     └── file.txt
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>
<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : deleteOut
  description : "To test .each command"

path :

  fileToDelete :
    path : 'out'

step  :

  delete.out :
    inherit : predefined.delete
    filePath : path::fileToDelete

build :

  delete.out :
    criterion :
      default : 1
    steps :
      - delete.*

```

</details>
<details>
    <summary><u>Код <code>submodule.will.yml</code></u></summary>

```yaml
about :

  name : submodules
  description : "To test .each command"
  version : 0.0.1

submodule :

  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  
build : 
  
  download : 
    criterion :
      default : 1
    steps : 
      - submodules.download

```

</details>
<details>
    <summary><u>Код <code>export.will.yml</code></u></summary>

```yaml
about :

  name : export
  description : "To test .each command"
  version : 0.0.1

path : 

  out : 'out'
  proto : 'proto'
  
step : 

  export : 
    inherit : predefined.export
    export : path::proto
  
build : 

  export : 
    criterion : 
      default : 1
    steps :
      - step::export
   
```

</details>

Побудуйте структуру файлів і внесіть відповідний код в них.

Збірка `delete.out` в файлі `.will.yml` видаляє директорію `out`, збірка `export` в файлі `export.will.yml` експортує файли із директорії `proto`, а в файлі `submodules.will.yml` збірка `download` виконує завантаження підмодулів.  

### Виконання побудов

<details>
  <summary><u>Вивід команди <code>will .each . .build</code></u></summary>

```
[user@user ~]$ will .each . .build
...
Module at /path_to_file/.will.yml
 . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.924s 

    Building module::deleteOut / build::delete.submodule
     - filesDelete 0 files at /path_to_file/out in 0.002s
    Built module::deleteOut / build::delete.submodule in 0.108s

...

    Building module::export / build::export
     + Write out archive /path_to_file/ : out/export.out.tgs <- proto
     + Write out will-file /path_to_file/out/export.out.will.yml
     + Exported export with 2 files in 2.311s
    Built module::export / build::export in 2.363s
    
...

    Building module::submodules / build::download
       . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
       + module::PathFundamentals version master was downloaded in 5.974s
     + 1/1 submodule(s) of module::submodules were downloaded in 5.981s
    Built module::submodules / build::download in 6.019s

```
</details>
<details>
  <summary><u>Файлова структура після побудов</u></summary>

```  
named 
  ├── .module
  │     └── PathFundamentals
  ├── proto
  │     └── file.txt
  ├── out
  │     └── export.out.will.yml
  ├── submodule.will.yml
  ├── export.will.yml
  └── .will.yml       

```

</details>

Введіть фразу `will .each . .build` для виконання побудов в директорії з файлами.

Першою збіркою видалялась директорія `out`, яка ще не існувала, потім було здійснено експорт з файла `export` і в кінці завантажено підмодулі. Тобто, команда `.each` запускає `вілфайли` згідно алфавітного порядку. Тому, якщо вам потрібно послідовно виконати декілька дій над спільними файлами модулів, прослідкуйте за чергуванням назв іменованих `вілфайлів`.  

### Підсумок  

- Команда `.each` працює з групою `вілфайлів`.
- Послідовність запуску `вілфайлів` командою `.each` відповідає алфавітному порядку.

[Повернутись до змісту](../README.md#tutorials)
