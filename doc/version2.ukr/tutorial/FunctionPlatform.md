# Побудова платформозалежних модулів

Використання функції визначення операційної системи для побудови платформозалежних модулів.




### Конфігурація

<details>
  <summary><u>Структура модуля</u></summary>

```
platformChoice
        ├── proto
        │     └── file.js
        └── .will.yml

```

</details>

Створіть структуру файлів приведену вище для дослідження

<details>
  <summary><u>Код файла <code>Color.download.will.yml</code></u></summary>

```yaml
about :

  name : 'platformChoice'
  description : 'Building a module that depends on platform'

path :

  proto : proto
  out : out
  windows.os :
    path : '{path::out}/windows'
    criterion :
      os : 'windows'
  posix.os :
    path : '{path::out}/posix'
    criterion :
      os : 'posix'
  osx.os :
    path : '{path::out}/osx'
    criterion :
      os : 'osx'

reflector :

  copy :
    criterion :
      os : 'f::os'
    filePath :
      'path::proto' : 'path::*.os'

build :

  build :
    criterion :
      default : 1
    steps :
      - step::copy
      
```

</details>

