## Path

<code>Path</code> section resource which points to the placement of module elements and used in routing for other resources.  

The utility has three built-in paths. This is `in`,` out` and `temp` paths. The directory to which `in` is a reference point for the relative paths of the module - the utility reads the path to the resource relative to the` in` directory, `out` is the directory for the exported module files,` temp` is placed temporary files. If `in` is not specified then` willbe` starts counting from the root directory `will-file`.

В утиліті є три вбудовані шляхи: `in`, `out` та `temp`. Директорія на яку вказує `in` - точка відліку для відносних шляхів модуля - утиліта зчитує шлях до ресурсу відносно каталогу `in`, `out` - директорія для експортованих файлів модуля, `temp` - поміщаються тимчасові файли. Якщо `in` не вказаний, то `willbe` починає відлік від кореневої директорії `will-файла`.


### Resource fields of `path` section   

| | Field | Description |
| ---------------- | -------------------------------- ------------- |
| | path | path to the directory (absolute, relative) |
| | description | description of the directory |
| | criterion | condition for the use of the resource (see [criterion] (Criterions.md)) |
| | inherit | imitation of the values of the fields of another resource

| Поле           | Опис                                        |
|----------------|---------------------------------------------|
| path           | шлях до директорії (абсолютний, відносний)  |
| description    | опис директорії                             |
| criterion      | умова використання ресурса (див. [критеріон](Criterions.md)) |
| inherit        | наслідування значень полів іншого ресурса   |


## Section <code>path</code>

The section has map of paths for fast understanding of files structure of the module.    

The example of `path` section with `in`, `out` and `toDelete` resources:  

![section.path.png](./Images/section.path.png)
