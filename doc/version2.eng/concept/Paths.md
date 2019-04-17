## Path 

<code>Path</code> section resource which points to the placement of module elements and used in routing for other resources.  

В утиліті є три вбудовані шляхи: `in`, `out` та `temp`. Директорія на яку вказує `in` - точка відліку для відносних шляхів модуля - утиліта зчитує шлях до ресурсу відносно каталогу `in`, `out` - директорія для експортованих файлів модуля, `temp` - поміщаються тимчасові файли. Якщо `in` не вказаний, то `willbe` починає відлік від кореневої директорії `will-файла`. 

### Поля ресурсів секції `path`     

| Поле           | Опис                                        |
|----------------|---------------------------------------------|
| path           | шлях до директорії (абсолютний, відносний)  |
| description    | опис директорії                             |
| criterion      | умова використання ресурса (див. [критеріон](Criterions.md)) |
| inherit        | наслідування значень полів іншого ресурса   | 


## Section <code>path</code>

The section has map of paths for fast understanding of files structure of the module.    

Приклад секції `path` з ресурсами `in`, `out`, `toDelete`:  

![section.path.png](./Images/section.path.png)