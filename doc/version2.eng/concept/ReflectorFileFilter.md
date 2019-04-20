# File filter

Technique to describe conditions of selection required files for some operation on group of files. Reflector has two file filters: <code>src</code> and <code>dst</code>.

<<<<<<< HEAD
Files can be selected:
- by simple file filters;
- by mask of file operations;
- by time filters;
- by globes in the map of the paths.
=======
Файли можуть бути відібрані:
- простими файловими фільтрами;
- масками файлових операцій;
- часовими фільтрами;
- ґлобами в мапі шляхів.
>>>>>>> 5be7b85482dffb8963c6728e004be753d63cc02d

### Simple file filters

Simple filters are filters that select files by name. They have string values.

- `begins` -excludes from the build all files whose name does not begin with the word specified in the filter.
- `ends` - excludes from the build all files whose name does not end on the word specified in the filter.
- `hasExtension` - excludes from the build all files whose names do not have the specified extensions. The file extension can be composed and consist of several parts. The `willbe` utility will read it starting from the first point in the filename. For example, the `somefile.txt.md` file has two extensions -` txt` i `md`.
### example of writing of a simple filter:

```yaml
src:
  begins : 'file'
  hasExtension : 'js'

```

### Masks of the reflector

For regular expressions when selecting files use masks.

Reflectors `willbe` have three groups of masks, depending on which types of files they are applied:
- `maskDirectory` - directory masks, apply only to directories;
- `maskTerminal` - masks of terminal files, apply only to terminal (normal) files, to directories do not apply;
- `maskAll` - masks that apply to all file types.

Each out of these three mask groups has the following fields :
- `includeAny` - exclude files that have no coincidence with any of the regular expressions of this filter;
- `includeAll` - exclude files that do not have a coincidence with all regular expressions of the filter;
- `excludeAny` - exclude files that have at least one coincidence with the regular expressions of the filter;
- `excludeAll` - exclude files that have a coincidence with all regular expressions of the filter.

### Example of reflector masks:

```yaml
src :
  maskDirectory :
    includeAll : !!js/regexp '/\.js$/'  
    excludeAny : !!js/regexp '/\.debug/'  

```
This writing means to include in build  all files with the extension '.js'  and exclude any files containing '.debug' in the name.

### Time filters

Filters are necessary to limit time-based selection. Reflectors have four time filters: `notOlder`,` notNewer`, `notOlderAge`,` notNewerAge`. Шт аield parameters the values are entered in milliseconds (1 s = 1000 ms, 1 hour = 3600000 ms).


There are the following time filters:
- `notOlder` - all files are not older than the build date set;
- `notNewer` - all files are not newer than the one set at the time of construction;
- `notOlderAge` - the age of individual files, no more than the date set at the time of construction;
- `notNewerAge` - the age of individual files, is not smaller than the date set at the time of construction.

### An example of using time filters
```yaml
src :
  notOlderAge : 10000

```

The time filter `notOlderAge` selects files that have an age of no more than 10 seconds.

<<<<<<< HEAD
### Using globes in the map of paths.
=======
### Використання ґлобів в мапі шляхів.
>>>>>>> 5be7b85482dffb8963c6728e004be753d63cc02d

Excluding files from the build is possible not only with file filters, but also by means of [Map of the paths](<./ResourceReflector.md#>).
