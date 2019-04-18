## Reflector  

<code>Reflector</code> section resource which defines the direction and criteria for performing operations over a group of files.   

### Resource fields of `reflector` section     

| Field          | Description                                                                       |
|----------------|-----------------------------------------------------------------------------------|
| description    | reflector description                                                             |
| recursive      | option that determines the level of reading the file structure of the directory   |
| filePath       | specifies the paths to the module directories, file operations and the management of the directories  |
| src            | specifies the paths to the source directories and file selection conditions       |
| dst            | the destination directory in which the files will be placed                       |
| criterion      | condition for the resource using (see [criterion](Criterions.md))                 |
| inherit        | reusing (inheritance) of another resource fields                                  |

The `src` and ` dst` fields have resources structurally divided into paths and [file filters](ReflectorFileFilter.md).    

### Мапа шляхів

Спосіб опису множини файлів, котрий дозволяє включити в множину безліч файлів і виключити через умови виключення та глоби не потрібні файли.

Мапа шляхів може
- задавати розміщення файлів над якими необхідно виконати, якусь операцію;
- задавати розміщення файлів в які потрібно записати результат операції;
- може вказувати безліч дерикторій;
- безліч умов виключення файлів із вибірки;
- виключення файлів із вибірки, що співпадають із глобом через `false` чи `0`;
- виключення файлів із вибірки, що не співпадають із глобом через `true` чи `1`;


Мапа шляхів задається в полі `filePath` рефлектора, при наслідуванні умови виключення успадковуються( ті котрі `0`, `1`, `false`, `true` ), переліки дерикторій в яких вести пошук переписуються осатннім предком або безпосередньо нащадком.

Виключати файли із вибірки можливо не лише мапою шлхяів, але і [фільтрами файлів](<./ReflectorFileFilter.md#>).

### Приклад складної мапи шляхів

```yaml
src:
  filePath:
    'some/dir1' : null
    'some/dir2' : null
    '**.debug**' : 0
    '**.js' : 1
```

Читаєтьсят так: переглянути всі файли в дерикторіях `some/dir1` та `some/dir1`, відкинувши всі файли, що мають в шляху `.debug` або не зкінчуються розширенням `.js`.

### Поле рефлектора `mandatory`

### Kos: бракує!

### Reflector field `recursive`

File filters have a certain range of visibility. Visibility is determined by the field `recursive` of a reflector. So, if you use them pay attention to its value.  
The `recursive` field accepts three values:  
'0' - reads the file (directory) specified in the path;  

![recursive.0.png](./Images/recursive.0.png)

'1' - reads the files (directories) that are placed in the specified path (the contents of next level directories are not read);  

![recursive.1.png](./Images/recursive.1.png)

"2" - зчитуються файли і директорії на всіх рівнях, що нижче від вказаного в шляху.  

![recursive.2.png](./Images/recursive.2.png)

За замовчуванням значення поля `recursive` - "2" - копіювання всієї структури.

#### Шляхи  
В рефлекторах використовуються поля `basePath`, `prefixPath` i `filePath`.  
`basePath` - базовий, основний шлях до файлів рефлектора. Подібно до шляху `in` в секції `step`, задає початкову точку відліку для шляхів. Може включати декілька базових шляхів для різних файлів. Зазвичай позначає поточну директорію і не вказується полі `src`.   
`prefixPath` - шлях, який додається до `basePath` при створенні модуля.  

```yaml
src :
  basePath : '.'
  prefixPath : 'out/out.debug'
dst :
  filePath : '..'

```

Приклад показує, що файли будуть братись в директорії за шляхом `./out/out.debug/`, а поміщені в директорію на рівень вище від кореневої директорії `will`-файла.  
`filePath` - поле може бути незалежним або включеним в ресурси `src` i `dst` та позначає шляхи до файлів модуля відносно `basePath`. Поле може керувати доступом до ресурсів використовуючи значення `true` i `false`, `1` i `0`.

```yaml
filePath :
  some/file1 : true
  file2 : false

```

В секцію поміщено шляхи до двох файлів відносно `basePath`. `file1` включений і буде використовуватись при створенні модуля, а `file2` - ні.
З допомогою `filePath` можна записати операцію копіювання не розбиваючити її між полями `src` i `dst`:

```yaml
filePath :
  path::filesToCopy : path::destinationDir

```

## Секція <code>reflector</code>  

Секція містить рефлектори - ресурси для виконання операцій над групами файлів.
Основними операціями є вибір файлів (директорій) та копіювання. 

Приклад секції `reflector` з ресурсом `reflect.project`:

![section.reflector.png](./Images/section.reflector.png)
