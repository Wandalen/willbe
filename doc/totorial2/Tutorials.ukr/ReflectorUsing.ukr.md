# Призначення та використання рефлекторів (`reflector`)

В туторіалі дається поняття про рефлектори `will`-файла та приведено приклади їх використання

Основними функціями ресурсів [секції `reflector`](CompositionOfWillFile.ukr.md#reflector) є файлові операції (вибір файлів (директорій), переміщення, копіювання і т.д.).  
Почнемо вивчення функціоналу з операції копіювання. Створіть наступну структуру файлів:

```
.
├── proto
│     ├── proto.two
│     │     └── file
│     │
│     ├── fileOne.js 
│     └── fileTwo.json   
│
└── .will.yml       

```

В `will.yml` внесіть код:

<details>
  <summary><u>Лістинг файла `.will.yml`</u></summary>

```yaml
about :
  name : copyByReflector
  description : "To copy files by reflector using"

path :

  in : '.'
  out : 'out'
  proto : './proto'
  out.debug : 
    path : './out/debug'
    criterion :
      debug : 1
  out.release : 
    path : './out/release'
    criterion :
      debug : 0

reflector :

  reflect.copy :
    filePath :
      path::proto : path::out.*
    criterion :
       debug : [ 0,1 ]

step :

  reflect.copy :
    inherit : predefined.reflect
    reflector : reflect.*
    criterion :
       debug : [ 0,1 ]

build :

  copy :
    criterion : 
      default : 1
      debug : [ 0,1 ]
    steps :
      - reflect.*

```
    
</details>

Крок `step` використовує вбудований крок `predefined.reflect` в якого аргументом є поле `reflector` 
з посиланням на ресурс секції `reflector`.  
В секції `reflector` поміщений один ресурс з назвою `reflect.copy`. Якщо рефлектор повинен скопіювати файли з однієї директорії в іншу без додаткових умов (фільтрів) то в полі `filePath` записується два значення: `source_path : destination_path`, де `source_path` - шлях до директорії з файлами для копіювання, `destination_path` - директорія в яку файли скопіюються.  
Відповідно, запис

```yaml
    filePath :
      path::proto : path::out.*

```

означає скопіювати файли з директорії `proto` в одну з директорій які починаються на `out` відповідно мапи критеріонів.  
Запустимо реліз-побудову:

```
[user@user ~]$ will .build copy.
...
  Building copy.
   + reflect.copy. reflected 5 files /path_to_file/ : out/release <- proto in 0.352s
  Built copy. in 0.406s
  
```

Вивід логу також свідчить що використовувався рефлектор `+ reflect.copy.` та відбулось копіювання файлів з одного каталогу в інший `out/release <- proto`.  
Проглянемо зміни в структурі каталогів:  
