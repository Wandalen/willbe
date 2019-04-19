# Секція <code>submodule</code>

Секції містить інформацію про підмодулі.

Підмодуль - окремий модуль з власним конфігураційним <code>will-файлом</code>, який підпорядковується іншому модулю.  

### Приклад

```yml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  Path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#d95a35b
  Uri : out/UriFundamentals.informal.out
  Proto : out/Proto.informal.out
```

Підключається 4-ри підмодуля, 2-ва локальних `out/UriFundamentals.informal.out`, `out/Proto.informal.out` та 2-ва віддалених `git+https:///github.com/Wandalen/wTools.git/out/wTools#master`, `git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#d95a35b`. Віддалені модулі підключаються із вказанням версії ( вітки і номера коміта ).

### Поля ресурсів секції `submodule`

| Поле           | Опис                                           |
|----------------|------------------------------------------------|
| path           | шлях до підмодуля, може бути абсолютним/відносним, локальним/глобальним |
| description    | опис для інших розробників                                 |
| criterion      | умова використання ресурса (див. [критеріон](Criterions.md)) |
| inherit        | наслідування значень полів іншого підмодуля      |
