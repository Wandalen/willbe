# Перелік ресурсів через командний рядок

Як дізнатись інформацію про модуль з командного рядка

В туторілі ["Як користуватися інтерфейсом командного рядка `willbe`"](HowToUseCommandLineInterfaceOfWill.md) команди групи `*.list` були приведені як приклад простих команд утиліти. Насправді, їх функціонал ширше - команди здатні здійснювати вивід інформацію про ресурси за назвою ресурса (за ґлобом) та за критеріонами.  
Побудуйте модуль з `will-файлом`:  

<details>
  <summary><u>Код <code>.will.yml</code> та структура файлів</u></summary>

```yaml
path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug :
    path : './out/debug'
    criterion :
      debug : 1
      proto : 1
  out.release :
    path : './out/release'
    criterion :
      debug : 0
      proto : 0

step :

  reflect.proto :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.proto.*=1
    criterion :
      debug : [ 0,1 ]
      proto : 1

  reflect.submodules :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.submodules*=1
    criterion :
      debug : 1
      proto : 0

  delete.out.debug :
    inherit : predefined.delete
    filePath : path::out.debug
    criterion :
      debug : 1

  submodules.informal.export :
    currentPath : path::dirPath
    shell : 'node {path::willPath} .each ./module .export'

```

<p>Структура модуля</p>

```
list
  └── .will.yml  

```

</details>

`Will-файл` призначений для дослідження команд утиліти і не виконує побудов.  
Введіть фразу для виводу переліку всіх ресурсів:  

<details>
  <summary><u>Вивід фрази <code>will .resources.list</code></u></summary>

```
[user@user ~]$ will .resources.list
...
About
  enabled : 1

Paths
  predefined.willbe : '/usr/lib/node_modules/willbe/proto/dwtools/atop/will/Exec' 
  predefined.will.files : '/path_to_file/.will.yml' 
  predefined.dir : '/path_to_file' 
  proto : './proto' 
  in : '.' 
  out : 'out' 
  out.debug : './out/debug' 
  out.release : './out/release'

step::reflect.proto.
  criterion : 
    debug : 0 
    proto : 1 
  opts : 
    reflector : reflector::reflect.proto.*=1 
  inherit : 
    predefined.reflect

step::reflect.proto.debug
  criterion : 
    debug : 1 
    proto : 1 
  opts : 
    reflector : reflector::reflect.proto.*=1 
  inherit : 
    predefined.reflect

step::reflect.submodules
  criterion : 
    debug : 1 
    proto : 0 
  opts : 
    reflector : reflector::reflect.submodules*=1 
  inherit : 
    predefined.reflect

step::delete.out.debug
  criterion : 
    debug : 1 
  opts : 
    filePath : path::out.debug 
  inherit : 
    predefined.delete

step::submodules.informal.export
  opts : 
    currentPath : path::dirPath 
    shell : node {path::willPath} .each ./module .export 
  inherit : 
    predefined.shell


```

</details>

В секціх `path` утиліта додатково вказує на шляхи до виконуваних файлів:  
- `predefined.willbe` - шлях до файла утиліти, який виконується (для контролю версій);  
- `predefined.will.files` - `will-файл`, який виконується (або спліт-файли);  
- `predefined.dir` - шлях до `will-файла`, який виконується.  
Виберемо в списку шляхів назви ресурсів, які починаються на `o`, для цього аргументом в фразі додамо початок назви з ґлобом:  

<details>
  <summary><u>Вивід фрази <code>will .paths.list о*</code></u></summary>

```
[user@user ~]$ will .paths.list o*
...
Paths
  out : 'out' 
  out.debug : './out/debug' 
  out.release : './out/release'

```

</details>

