# Перелік ресурсів застосовуючи фільтри та ґлоби

Як побудувати запит до утиліти та отримати перелік ресурсів застосовуючи фільтри та ґлоби.

В туторілі ["Інтерфейс командного рядка"](CLI.md) [команди групи `*.list`](../concept/Command.md#Таблиця-команд-утиліти-willbe) приведені як приклад простих команд утиліти. Насправді, їх функціонал ширше - команди здатні виводити інформацію про ресурси модуля за назвою (з ґлобом) та за критеріонами.  

### Використання пошуку за фільтрами і ґлобами   

<details>
  <summary><u>Структура модуля</u></summary>

```
list
  └── .will.yml  

```

</details>

Створіть директорію `list` з приведеною конфігурацією.

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
    inherit : files.reflect
    reflector :
      reflector::reflect.proto.*=1
    criterion :
      debug : [ 0,1 ]
      proto : 1

  reflect.submodules :
    inherit : files.reflect
    reflector :
      reflector::reflect.submodules*=1
    criterion :
      debug : 1
      proto : 0

  delete.out.debug :
    inherit : files.delete
    filePath : path::out.debug
    criterion :
      debug : 1

  submodules.export :
    currentPath : path::dirPath
    shell : 'will .each ./module .export'

```

</details>

Внесіть приведений вище код в файл `.will.yml`.

`Вілфайл` включає дві секції `path` i `step` з переліком ресурсів. Він призначений для дослідження команд утиліти і не виконує побудов. Окремі ресурси мають схожі назви та використовують декілька комбінацій критеріонів, що дає змогу дослідити можливості пошуку за критеріонами.  

<details>
  <summary><u>Вивід команди <code>will .resources.list</code></u></summary>

```
[user@user ~]$ will .resources.list
...
About
  enabled : 1 
  values : 
    enabled : 1 
    name : null


path::module.willfiles
  path : .will.yml 
  criterion : 
    predefined : 1

path::module.original.willfiles
  criterion : 
    predefined : 1

path::module.dir
  path : . 
  criterion : 
    predefined : 1

path::local
  criterion : 
    predefined : 1

path::remote
  criterion : 
    predefined : 1

path::current.remote
  criterion : 
    predefined : 1

path::will
  path : ../../../../../../../../usr/lib/node_modules/willbe/proto/wtools/atop/will/Exec 
  criterion : 
    predefined : 1

path::proto
  path : ./proto

path::in
  path : .

path::out
  path : out

path::out.debug
  path : ./out/debug 
  criterion : 
    debug : 1 
    proto : 1

path::out.release
  path : ./out/release 
  criterion : 
    debug : 0 
    proto : 0

reflector::predefined.common
  ...
  ...

step::reflect.proto.
  criterion : 
    debug : 0 
    proto : 1 
  opts : 
    reflector : reflector::reflect.proto.*=1 
  inherit : 
    files.reflect

step::reflect.proto.debug
  criterion : 
    debug : 1 
    proto : 1 
  opts : 
    reflector : reflector::reflect.proto.*=1 
  inherit : 
    files.reflect

step::reflect.submodules
  criterion : 
    debug : 1 
    proto : 0 
  opts : 
    reflector : reflector::reflect.submodules*=1 
  inherit : 
    files.reflect

step::delete.out.debug
  criterion : 
    debug : 1 
  opts : 
    filePath : path::out.debug 
  inherit : 
    files.delete

step::submodules.informal.export
  opts : 
    currentPath : path::dirPath 
    shell : will .each ./module .export 
  inherit : 
    shell.run

```

</details>

Введіть команду `will .resources.list` для виводу переліку всіх ресурсів.

При вводі команди утиліта виводить список доступних ресурсів. Цей список включає значну кількість вбудованих ресурсів. Наприклад, в секції `path` утиліта додатково вказує на шляхи до виконуваних файлів: 

- `will` - шлях до виконуваного файла утиліти;  
- `module.willfiles` - `вілфайл` поточного модуля (або спліт-файли);  
- `module.dir` - шлях до директорії `вілфайла` поточного модуля.  

### Аргументи в командах групи `*.list`

Для вибору ресурсів за назвою вказуйте ключові слова з ґлобом як аргумент команди. 

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

Для виводу шляхів, які починаються на `o`, введіть команду `will .paths.list о*`. 

Згідно ресурсів секції, утиліта вивела список із трьох шляхів: `out`, `out.debug`, `out.release`.

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

Ресурс також обирається за назвою і критеріоном. Для виводу шляхів, які починаються на `o` та мають критеріон `proto:1`, введіть команду `will .paths.list о* proto:1`.

В виводі команди присутні два шляхи - `out` i `out.debug`. Це пов'язано з тим, що шлях `out` не має критеріонів, а тому утиліта його не відкидає при порівнянні мап критеріонів.

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
    files.reflect

step::submodules.export
  opts :
    currentPath : path::dirPath
    shell : will .each ./module .export
  inherit :
    shell.run

```

</details>

Також, вибір ресурсів може здійснюватись за комбінацією критеріонів. Наприклад, введіть команду `will .steps.list *s* proto:0 debug:1`.

Крок `submodules.export` включений в вибірку тому, що не має критеріонів і ресурс автоматично приймає значення будь-якого критеріона.  

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
    files.reflect

step::submodules.export
  opts :
    currentPath : path::dirPath
    shell : will .each ./module .export
  inherit :
    shell.run

```

</details>

Умовою правильного вибору ресурсів за критеріонами є перебір за іменами. Для відбору ресурсів лише за критеріонами використовуйте ґлоб `*`, який дає утиліті вказівку шукати серед імен усіх ресурсів. Таким чином для вибору кроків за критеріоном `debug:0` потрібно ввести команду `will .steps.list * debug:0`. Результат виконання команди приведений вище.

Утиліта вивела два ресурси - `reflector.proto.` i `submodules.export`. Другий ресурс обрано через відсутність критеріонів.

### Підсумок   

- Команди групи `.list` здатні виводити обмежену вибірку ресурсів.  
- При сортуванні за іменем використовуються ґлоби.  
- Утиліта виводить перелік ресурсів за комбінацією критеріонів.
- Для виводу списка ресурсів за визначеним критеріоном, критеріон вводиться після ґлобу `*`.

[Повернутись до змісту](../README.md#tutorials)
