# List of resources with filter and glob

How to request for list of resources which satisfy filter and glob.

В туторілі ["Інтерфейс командного рядка"](CLI.md) команди групи `*.list` приведені як приклад простих команд утиліти. Насправді, їх функціонал ширше - команди здатні виводити інформацію про ресурси модуля за назвою (з ґлобом) та за критеріонами.  
Створіть директорію `list` з `will-файлом`:  

<details>
  <summary><u>Структура модуля</u></summary>

```
list
  └── .will.yml  

```

</details>
<details>
  <summary><u>Код <code>.will.yml</code></u></summary>

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
    shell : 'will .each ./module .export'

```

</details>

`Will-файл` призначений для дослідження команд утиліти і не виконує побудов.  
Введіть команду для виводу переліку всіх ресурсів:  

<details>
  <summary><u>Вивід команди <code>will .resources.list</code></u></summary>

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
    shell : will .each ./module .export
  inherit :
    predefined.shell

```

</details>

В секціх `path` утиліта додатково вказує на шляхи до виконуваних файлів:  
- `predefined.willbe` - шлях до файла утиліти, який виконується;  
- `predefined.will.files` - `will-файл`, який виконується (або спліт-файли);  
- `predefined.dir` - шлях до директорії `will-файла`, який виконується.  

### Аргументи в командах групи `*.list`
Для вибору ресурсів за назвою вказуйте ключові слова з глобом як аргумент команди. Наприклад, для виводу шляхів, які починаються на `o`, введіть команду `will .paths.list о*`:  

<details>
  <summary><u>Вивід команди <code>will .paths.list о*</code></u></summary>

```
[user@user ~]$ will .paths.list o*
...
Paths
  out : 'out'
  out.debug : './out/debug'
  out.release : './out/release'

```

</details>

Ресурс також обирається за назвою і критеріоном. Для виводу шляхів, які починаються на `o` та мають критеріон `proto:1`, введіть команду `will .paths.list о* proto:1`:  

<details>
  <summary><u>Вивід команди <code>will .paths.list о* proto:1</code></u></summary>

```
[user@user ~]$ will .paths.list o* proto:1
...
Paths
  out : 'out'
  out.debug : './out/debug'

```

</details>

Вибірка ресурсів за комбінацією критеріонів:

<details>
  <summary><u>Вивід команди <code>will .steps.list *s* proto:0 debug:1</code></u></summary>

```
[user@user ~]$ will .steps.list *s* proto:0 debug:1
...
step::reflect.submodules
  criterion :
    debug : 1
    proto : 0
  opts :
    reflector : reflector::reflect.submodules*=1
  inherit :
    predefined.reflect

step::submodules.informal.export
  opts :
    currentPath : path::dirPath
    shell : will .each ./module .export
  inherit :
    predefined.shell

```

</details>

Крок `submodules.informal.export` включений в вибірку тому, що не має критеріонів і ресурс автоматично приймає значення будь-якого критеріона.  
Умовою правильного вибору ресурсів за критеріонами є перебір за іменами. Для перебору лише за критеріонами використовуйте ґлоб `*`, який включає всі ресурси. Таким чином для вибору кроків за критеріоном `debug:0` Введіть команду `will .steps.list * debug:0`:

<details>
  <summary><u>Вивід команди <code>will .steps.list * debug:0</code></u></summary>

```
[user@user ~]$ will .steps.list * debug:0
...
step::reflect.proto.
  criterion :
    debug : 0
    proto : 1
  opts :
    reflector : reflector::reflect.proto.*=1
  inherit :
    predefined.reflect

step::submodules.informal.export
  opts :
    currentPath : path::dirPath
    shell : will .each ./module .export
  inherit :
    predefined.shell

```

</details>

### Підсумок   
- Команди групи `.list` здатні виводити обмежену вибірку ресурсів.  
- При сортуванні за іменем використовуються ґлоби.  
- Утиліта виводить перелік ресурсів за комбінацією критеріонів.
- Для виводу ресурсів за визначеним критеріоном, критеріон вводиться після ґлобу `*`.

[Повернутись до змісту](../README.md#tutorials)
