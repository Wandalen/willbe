## Build assembly

Sequence and conditions of procedures execution for module constructing.

Сценарій збірки - послідовність виконання кроків в збірці. 

### Поля ресурсів секції `build`  

| Поле          | Опис                                                             |
|---------------|------------------------------------------------------------------|
| description   | опис збірки                                                      |  
| criterion     | умова побудови модуля (див. [критеріон](Criterions.md))          |
| steps         | побудова сценарію збірки - послідовність кроків                  |
| inherit       | наслідування значень полів іншого ресурса                        |

## Section <code>build</code> 

Resources of the section describe sequence and conditions of building the module.  

Приклад секції `build` з ресурсом `export`: 

![section.build.png](./Images/section.build.png)