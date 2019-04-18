# Section <code>submodule</code>

The section has information about submodules of the module.

Підмодуль -  окремий модуль з власним конфігураційним <code>will-файлом</code>, який підпорядковується іншому модулю.  

### Поля ресурсів секції `submodule`

| Поле           | Опис                                           |
|----------------|------------------------------------------------|
| path           | шлях до підмодуля (абсолютний, відносний, URL) |
| description    | опис підмодуля                                 |
| criterion      | умова використання ресурса (див. [критеріон](Criterions.md)) |
| inherit        | наслідування значень полів іншого ресурса      |  

Приклад секції `submodule` з ресурсами `Tools`, `PathFundamental`:  

![submodule.section.png](./Images/submodule.section.png)
