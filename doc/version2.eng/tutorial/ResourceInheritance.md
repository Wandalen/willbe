# Resources inheritance 

How to use resource inheritance to reuse data.

В об'єктно-орієнтованому програмуванні наслідування - це механізм утворення нових класів на основі використання існуючих. При цьому властивості та функціональність батьківського класу переходять до класу нащадка (дочірнього). Подібна концепція викорстовується при побудові `will-файлів` - ресурс може наслідувати (використовувати) поля ресурса визначеного в секції `will-файла` або наслідувати ресурси з стороннього `will-файла`, підключеного як підмодуль. При наслідуванні, поля ресурсів, що наслідуються, зберігаються - ці поля можуть бути доповнені або змінені.  
Наслідування дозволяє повторно використовувати налаштування ресурсів та спрощує компонування модуля. Для використання наслідування з `will-файла` підмодуля, вкажіть відповідний ресурс в секції `submodule`, а в полі `inherit` шлях до ресурса в підключеному `will-файлі`. При наслідуванні всередині секції, в полі `inherit` вказується назва ресурса секції, поля якого будуть унаслідувані (наслідування можливе між ресурсами одного типу).   

### Побудова модуля з використанням наслідування
Для дослідження наслідування ресурсами, побудуйте конфігурацію файлів, як зображено:

<details>
  <summary><u>Конфігурація модуля</u></summary>

```
inheritability
      ├── one
      │    └── one.will.yml
      └── .will.yml

```

</details>

Запишіть в `.will.yml` i `one.will.yml` код:

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : inheritability
  description : "To use resources inheritability"
  version : 0.0.1

path :

  out : 'out'

submodule :

   One : './one/one.will.yml'
   Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

reflector :

  inherit.remote:
    inherit : submodule::T*/exported::*=1/reflector::exportedFiles*=1
    dst:
      filePath: path::out
    criterion:
      debug: [ 0,1 ]

step :

  copy.all :
    inherit : predefined.reflect
    reflector : reflector::reflect.*
    criterion:
      debug: [ 0,1 ]

  reflect.copy :
    inherit : step::copy*
    reflector : reflector::inherit.*=1
    criterion:
      debug: 1

build :

  inherit.local :
    inherit: submodule::One/build::c*=1
    criterion :
      default : 1
      debug : 1

```

</details>

<details>
  <summary><u>Код файла <code>one.will.yml</code></u></summary>

```yaml
build :

  copy :
    criterion :
      debug : [ 0,1 ]
    steps :
      - submodules.download
      - reflect.*=1

```

</details>

В полі `inherit` збірки `inherit.local` введено значення `submodule::One/build::c*=1` - [складний селектор](SelectorComplex.md), який вказує на послідовність вибору: перейти до секції `submodule` >> обрати підмодуль `One` >> прочитати `will-файл` підмодуля >> вибрати секцію `build` з ресурсом, назва якого починаєтсья на `c`, тобто, збірку `copy`. Збірка завантажує віддалені підмодулі та виконує крок `reflect.*=1`. Для вибору кроку в збірці `inherit.local` передається критеріон `debug : 1`.  
Крок `reflect.copy` наслідує крок секції `copy.all` та перевизначає рефлектор на `inherit.remote` - копіювання файлів в директорію `out`.  
Рефлектор `inherit.remote` наслідує рефлектор від завантаженого підмодуля `Tools`. Шлях зчитується так: в ресурсах секції `submodule` вибрати підмодуль з назвою, яка починається на `T` >> перейти до секції `exported` >> вибрати поле, що вказує на рефлектор експортованих файлів `reflector::exportedFiles*=1`. Таким чином, після побудови в диреторію `out` скопіюються файли експортованого підмодуля.  
Виконайте побудову модуля:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::inheritability / build::inherit.local
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 21.597s
   + 1/2 submodule(s) of module::inheritability were downloaded in 21.605s
   + reflect.copy reflected 56 files /path_to_file/ : out <- .module/Tools/proto in 1.895s
  Built module::inheritability / build::inherit.local in 23.595s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
inheritability
      ├── .module
      │       └── Tools
      ├── one
      │    └── one.will.yml
      ├── out
      │    └── dwtools
      └── .will.yml

```

</details>

### Підсумок  
- Наслідування доволяє повторно використовувати ресурси `will-файлa`.
- Наслідуються внутрішні ресурси секцій, а також ресурси зовнішніх `will-файлів`, підключених як підмодулі.

[Повернутись до змісту](../README.md#tutorials)
