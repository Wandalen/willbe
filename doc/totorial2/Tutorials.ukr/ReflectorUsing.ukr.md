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

