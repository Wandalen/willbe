# Перелік ресурсів через командний рядок

Як дізнатись інформацію про модуль з командного рядка

В туторілі ["Як користуватися інтерфейсом командного рядка `willbe`"](HowToUseCommandLineInterfaceOfWill.md) команди групи `*.list` були приведені як приклад простих команд утиліти. Насправді, їх функціонал ширше - команди здатні здійснювати вивід інформацію про ресурси за назвою ресурса (за ґлобом) та за критеріонами.  
Побудуйте модуль з `will-файлом`:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```yaml
path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug :
    path : './out/debug'
    criterion :
      debug : 1
  out.release :
    path : './out/release'
    criterion :
      debug : 0

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