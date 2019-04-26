# File filter

Technique of describing the conditions for selecting the required files for some operation on a group of files. Reflector has two file filters: <code>src</code> and <code>dst</code>.

Files can be selected:
- by simple file filters;
- by mask of file operations;
- by time filters;
- by globes in the map of the paths.

### Simple file filters

Simple filters select files by name. They have a string values.
- `begins` - excludes from the build all files whose name does not begin with the word specified in the filter.
- `ends` - excludes from the build all files whose name does not end on the word specified in the filter.
- `hasExtension` - excludes from the build all files whose names do not have the specified extensions. The file extension can be composed and consist of several parts. The `willbe` utility read it starting from the first point in the filename. For example, the `somefile.txt.md` file has two extensions -` txt` and `md`.

### Example of writing of a simple filter:

```yaml
src:
  begins : 'file'
  hasExtension : 'js'

```

### Masks of the reflector

Use masks for regular expressions while filter selection.

Reflectors have three groups of masks. Depending on the group the different types of files can be applied:
- `maskDirectory` - directory masks, apply only to directories;
- `maskTerminal` - masks of terminal files, they apply only to terminal (normal) files, to directories they do not apply;
- `maskAll` - masks that apply to all file types.

Each out of these three mask's groups can include following fields:
- `includeAny` - exclude files that have no coincidence with any of the regular expressions of the filter;
- `includeAll` - exclude files that do not have the coincidence with all regular expressions of the filter;
- `excludeAny` - exclude files that have at least one coincidence with the regular expressions of the filter;
- `excludeAll` - exclude files that have the coincidence with all regular expressions of the filter.

### Example of reflector masks:

```yaml
src :
  maskDirectory :
    includeAll : !!js/regexp '/\.js$/'  
    excludeAny : !!js/regexp '/\.debug/'  

```

This example means to include in build all files with the extension `.js`  and exclude any files containing `.debug` in the name.

### Time filters

Filters are necessary to limit time-based selection. Reflectors have four time filters: `notOlder`,` notNewer`, `notOlderAge`,` notNewerAge`. In the field parameters, the values are entered in milliseconds (1 s = 1000 ms, 1 hour = 3600000 ms).

Time filters excludes:
- `notOlder` - all files if at least one older than the set time limit;
- `notNewer` - all files if at least one newer than the time limit;
- `notOlderAge` - files which age is older than the set time limit;
- `notNewerAge` - files which age is newer than the set time limit.

### An example of using time filters

```yaml
src :
  notOlderAge : 10000

```

The time filter `notOlderAge` selects files that have an age of no more than 10 seconds.

### Using globes in the map of paths.

Excluding files from the build is possible not only with file filters, but also by means of [Map of the paths](<./ResourceReflector.md#>).
