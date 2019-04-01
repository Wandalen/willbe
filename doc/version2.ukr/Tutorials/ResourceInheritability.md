# Наслідування ресурсами

Як користуватись наслідуванням ресурсів

В об'єктно-орієнтованому програмуванні наслідування - це механізм утворення нових класів на основі використання існуючих. При цьому властивості та функціональність батьківського класу переходять до класу нащадка (дочірнього). Подібна концепція викорстовується при побудові `will-файлів` - ресурс, який визначений в одному з `will-файлів` може бути використаний (унаслідуваний) ресурсом в іншому `will-файлі` при цьому властивості ресурсів, що наслідуються, зберігаються. Також, в обмеженому діапазоні, ці ресурси можуть бути доповнені або змінені.  
Наслідування дозволяє повторно використовувати налаштування та спрощує компонування модуля. Для використання наслідування потрібно підключити підмодуль, як `will-файл` з якого будуть унаслідувані ресурси та вказати в полі `inherit` шлях до ресурса, який буде унаслідувано з підключеного `will-файла`. Наслідування можливе між ресурсами одного типу (однієї секції).   

### Побудова модуля з використанням наслідування 
Для дослідження наслідування ресурсами, побудуйте конфігурацію файлів, як зображено:

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```

inheritability
      ├── one
      │    └── one.will.yml
      └── .will.yml

```

</details>

В туторіалі буде використано наслідування як з локального підмодуля, так і з віддаленого. Запишіть в `.will.yml` i `one.will.yml` код:

<details>
  <summary><u>Код <code>.will.yml</code> i <code>one.will.yml</code></u></summary>
<p>Помістіть в <code>.will.yml</code></p>

```yaml
about :

  name : inheritability
  description : "To use resources inheritability"
  version : 0.0.1

path :

  out : 'out'

submodule :

   One : ./one/one.will.yml
   Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

reflector :

  inherit.remote:
    inherit : submodule::T*/exported::*=1/reflector::exportedFiles*=1
    dst:
      filePath: path::out
    criterion:
      debug: [ 0,1 ]

step :

  reflect.copy :
    inherit : predefined.reflect
    reflector : reflector::inherit.*
    criterion :
       debug : [ 0,1 ]

build :

  inherit.local :
    inherit: submodule::One/build::c*=1
    criterion :
      default : 1 
      debug : 1

```

<p>Помістіть в <code>one.will.yml</code></p>

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

В полі `inherit` збірки `inherit.local` введено значення `submodule::One/build::c*=1` - складний селектор (туторіал ["Як використовувати складні селектори"](HowToUseComplexSelector.md)), який вказує на послідовність вибору: перейти до секції `submodule` -> обрати підмодуль `One` -> прочитати `will-файл` підмодуля -> вибрати секцію `build` з ресурсом який починаєтсья на `c`, тобто, збірку `copy`. Збірка завантажує віддалені підмодулі та виконує крок `reflect.*=1`. Для вибору кроку в збірці `inherit.local` передається критеріон `debug : 1`.  
Крок `reflect.copy` використовує рефлектор `inherit.remote` для копіювання файлів в директорію `out`. Рефлектор `inherit.remote` наслідує рефлектор від завантаженого підмодуля `Tools`. Шлях `submodule::T*/exported::*=1/reflector::exportedFiles*=1` свідчить про використання експотованого `.out.will.yml`, оскільки, є пункт `exported`, а рефлектор `exportedFiles*=1` вказує на експотовані файли підмодуля. Таким чином після побудови в диреторію `out` скопіюються файли експортованого підмодуля.  
Виконайте побудову модуля:  

<details>
  <summary><u>Вивід фрази <code>will .build</code> і структура модуля після побудови</u></summary>
    
```
[user@user ~]$ will .build
...
  Building inherit.local
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was downloaded in 13.797s
   + 1/2 submodule(s) of module::inherit were downloaded in 13.803s
   + reflect.copy.debug reflected 56 files /path_to_file/ : out <- .module/Tools/proto in 1.809s
  Built inherit.local in 15.695s
  
```

<p>Структура модуля після експорту</p>

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
- Наслідування ресурсами доволяє повторно використовувати `will-файли`, побудовані користувачем і згенеровані при експорті модуля.

[Повернутись до змісту](../README.md#tutorials)