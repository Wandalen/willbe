# Section <code>exported</code>

Section of <code>out-will-file</code>, programatically generated with exporting of the module. It has list of exported files and it used by other modules for importing the module.

Головне призначення - інформаційна карта для імпорту.   

### Поля ресурсів секції `exported`   

| Поле                     | Опис                                   |
|--------------------------|----------------------------------------|
| version                  | версія модуля, експортується з секції `about`                         |
| description              | опис експортованого модуля - призначення, ліцензія, автори та ін.     |
| criterion                | критеріони, експортовані з секції `build` при виконанні збірки експорту (див. [критеріон](Criterions.md)) |
| inherit                  | наслідування, яке експортується з секції `build` при виконанні збірки |
| exportedReflector        | рефлектор, за яким побудовано експорт модуля, генерується утилітою    |
| exportedFilesReflector   | рефлектор на експортовані файли, генерується утилітою                 |  
| exportedDirPath          | експортовані директорії, що експотуються                              |
| exportedFilesPath        | шляхи до файлів, генерується утилітою                                 |
| archiveFilePath          | шлях до архівованих файлів створеного модулю                          |

Приклад секції `exported`:

![section.exported.png](./Images/section.exported.png)