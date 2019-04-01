# Наслідування ресурсами

В туторіалі показано як використовувати наслідування ресурсами `will-файла`

В об'єктно-орієнтованому програмуванні наслідування - це механізм утворення нових класів на основі використання існуючих. При цьому властивості та функціональність батьківського класу переходять до класу нащадка (дочірнього). Подібна концепція викорстовується при побудові `will-файлів` - ресурс, який визначений в одному з `will-файлів` може бути використаний (унаслідуваний) ресурсом в іншому `will-файлі` при цьому властивості ресурсів, що наслідуються, зберігаються. Також, в обмеженому діапазоні, ці ресурси можуть бути доповнені або змінені.  
Наслідування дозволяє повторно використовувати налаштування та спрощує компонування модуля. Для використання наслідування потрібно підключити підмодуль, як `will-файл` з якого будуть унаслідувані ресурси та вказати в полі `inherit` шлях до ресурса, який буде унаслідувано з підключеного `will-файла`. Наслідування можливе між ресурсами одного типу (однієї секції).   

### Використання готового `will-файла`
Побудуйте конфігурацію файлів, як приведено:

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```

inheritability
      ├── One
      │    └── one.will.yml
      └── .will.yml

```

</details>

В туторіалі буде використано наслідування як з локального підмодуля, так і з віддаленого. Запишіть в `.will.yml` i `one.will.yml` код:

<details>
  <summary><u>Код <code>.will.yml</code> i <code>one.will.yml</code></u></summary>
<p>Запишіть в <code>.will.yml</code></p>

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

<p>Запишіть в <code>one.will.yml</code></p>

```yaml
build :

  copy :
    criterion : 
      default : 1
      debug : [ 0,1 ]
    steps :
      - submodules.download
      - reflect.*=1
      
```

</details>

В файлі `.will.yml` використовується наслідування збірки побудови з локального підмодуля `One`. В полі `inherit` збірки `inherit.local` введено значення `submodule::One/build::c*=1` - складний селектор (туторіал ["Як використовувати складні селектори"](HowToUseComplexSelector.md)). Збірка `copy` завантажує віддалені підмодулі та виконує крок `reflect.*=1`. Для вибору кроку в збірці `inherit.local` передається критеріон `debug : 1`. Крок `reflect.copy` використовує рефлектор `inherit.remote`, який наслідує рефлектор від завантаженого підмодуля `Tools`. Шлях `submodule::T*/exported::*=1/reflector::exportedFiles*=1` свідчить про використання експотованого `.out.will.yml` оскільки є пункт `exported`, а рефлектор `exportedFiles*=1` вказує на експотовані файли підмодуля.