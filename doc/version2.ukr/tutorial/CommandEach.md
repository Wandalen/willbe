# Command <code>.each</code>

How to use command <code>.each</code> for executing same operation for each module or submodule.

Для роботи з декількома модулями, використовуйте команду `.each`, котра виконує вказану фразу для кожного `will-файла` в зазначеній директорії. Для вводу команди використовуйте синтаксис `will .each [dir] [command] [argument]`, де `[dir]` - директорія з `will-файлами`; `[command]` - команда для файлів в директорії; `[argument]` - аргумент команди, якщо він необхідний (для всіх `will-файлів` має бути один аргумент або використовуватись ґлоб).
Побудуйте структуру файлів і внесіть відповідний код в них:

<details>
  <summary><u>Структура файлів</u></summary>

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

Збірка `delete.out` в файлі `.will.yml` видаляє директорію `out`, збірка `export` в файлі `export.will.yml` експортує файли із директорії `proto`, а в файлі `submodules.will.yml` збірка `download` виконує завантаження підмодулів.  
Введіть фразу `will .each . .build` для виконання побудов в директорії з файлами: 

<details>
  <summary><u>Вивід команди <code>will .each . .build</code></u></summary>

```
[user@user ~]$ will .each . .build
...
Module at /path_to_file/.will.yml
 . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.924s 

    Building module::deleteOut / build::delete.submodule
     - filesDelete 0 files at /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract/CommandEach/out in 0.002s
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

Команда `.each` запускає `will-файли` згідно алфавітного порядку тому, якщо вам потрібно послідовно виконати декілька дій над спільними файлами модулів, прослідкуйте за чергуванням `will-файлів`.  

### Підсумок  
- Команда `.each` працює з масивом `will-файлів`.
- Послідовність запуску `will-файлів` командою `.each` відповідає алфавітному порядку.

[Повернутись до змісту](../README.md#tutorials)
