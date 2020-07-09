# Наслідування ресурсів

Як користуватись наслідуванням ресурсів для перевикористання даних.

Наслідування - це концепція об'єктно-орієнтованого програмування згідно якої новий тип даних (дочірній) може використовувати дані і функціональності іншого існуючого типу даних (батьківського). Подібна концепція використовується при побудові `вілфайлів`. В утиліті `willbe` ресурс може наслідувати (використовувати) ресурс визначений в секції поточного `вілфайла` або наслідувати ресурси з іншого `вілфайла`, підключеного як підмодуль. При наслідуванні, значення полів ресурса, що наслідується, зберігаються. Ці поля можуть бути доповнені або змінені.  

Наслідування дозволяє повторно використовувати налаштування ресурсів та спрощує компонування модуля. Для використання наслідування з `вілфайла` підмодуля, вкажіть відповідний ресурс в секції `submodule`. В полі `inherit` ресурса, що наслідує, вкажіть шлях до батьківського ресурса з допомогою [складних селекторів](SelectorComposite.md). При наслідуванні всередині секції, в полі `inherit` вказується назва батьківського ресурса (наслідування можливе між ресурсами одного типу).   

### Побудова модуля з використанням наслідування

<details>
  <summary><u>Структура файлів</u></summary>

```
inheritability
      ├── one
      │    └── one.will.yml
      └── .will.yml

```

</details>

Для дослідження наслідування ресурсами, побудуйте конфігурацію файлів, як зображено вище.

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
    inherit : files.reflect
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

Внесіть в `.will.yml` приведений код.

В полі `inherit` збірки `inherit.local` введено значення `submodule::One/build::c*=1`. Це [складний селектор](SelectorComposite.md), який вказує на послідовність вибору: 
- перейти до секції `submodule`;
- обрати підмодуль `One`;
- прочитати `вілфайл` підмодуля;
- вибрати секцію `build` з ресурсом, назва якого починаєтсья на `c`. 

Крок `reflect.copy` наслідує крок секції `copy.all` поточного `вілфайла`. Наслідуючи, крок змінив рефлектор на `inherit.remote` для копіювання файлів в директорію `out`.  

Рефлектор `inherit.remote` наслідує рефлектор від завантаженого підмодуля `Tools`. Шлях зчитується так: - в ресурсах секції `submodule` вибрати підмодуль з назвою, яка починається на `T`;
- перейти до секції `exported`;
- вибрати рефлектор експортованих файлів `reflector::exportedFiles*=1`.  
Таким чином, після побудови в диреторію `out` скопіюються файли експортованого підмодуля. 

В файл `one.will.yml` помістіть вказаний нижче код.

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

Збірка завантажує віддалені підмодулі та виконує крок `reflect.*=1`. Для вибору кроку в збірці `inherit.local` використовується критеріон `debug : 1`.    

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

Виконайте побудову модуля командою `will .build`.

<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
inheritability
      ├── .module
      │       └── Tools
      ├── one
      │    └── one.will.yml
      ├── out
      │    └── wtools
      └── .will.yml

```

</details>

Після побудови в директорії `out` з'явилась директорія `wtools` з файлами, що описані в `out-вілфайлі` підмодуля `Tools`. 

### Підсумок  

- Наслідування доволяє повторно використовувати ресурси `вілфайлів`.
- Наслідуються ресурси одного типу.
- Наслідуються ресурси як поточного `вілфайла`, так і зовнішніх `вілфайлів`, що підключені як підмодулі.
- Ресурс, що наслідує може доповнювати і змінювати ресурси, що наслідуються.

[Повернутись до змісту](../README.md#tutorials)
