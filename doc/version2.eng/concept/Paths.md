## Recource path

<code>Path</code> section resource which points to the placement of module elements and used in routing for other resources.

The utility has three built-in paths. This is `in`,` out` and `temp` paths. The `in` path is a reference point for the relative paths of the module. The utility reads the other path relative to `in` directory. `out` path is the directory for the exported module files. `temp` is placed temporary module files. If `in` path is not specified then` willbe` start routing from the root directory of `will-file`.  

### Поля ресурсів секції `path`     

| Field          | Description                                                       |
|----------------|-------------------------------------------------------------------|
| path           | path to the directory (absolute, relative)                        |
| description    | description of the directory                                      |
| criterion      | condition for the resource using (see [criterion](Criterions.md)) |
| inherit        | reusing (inheritance) of another resource fields                  |

## Section <code>path</code>

The section has map of paths for fast understanding of files structure of the module.   

The example of `path` section with `in`, `out` and `toDelete` resources:  

![section.path.png](./Images/section.path.png)
