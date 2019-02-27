# Створення модуля з командою `build`

<a name="submodules-by-build">
    
При складанні власного модуля, де використовуються зовнішні підмодулі, зручніше внести в секцію `build` кроки операцій з підмодулями.  
Додайте в `.will.yml` наступний фрагмент:
    
```yaml

build :

  submodules.download:
           criterion :
             default : 1
           steps :
             - submodules.download

```

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    WTools :
      path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
      description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

build :

  submodules.download:
           criterion :
             default : 1
           steps :
             - submodules.download

```

</details>

Секція `build` має одну процедуру під назвою `submodules.download`, яка за замовчуванням завантажує підмодулі використовуючи `submodules.download`.  
Очистимо директорію ввівши `will .submodules.clean` та виконаємо `will .build`:

```
[user@user ~]$ will .build
Request ".build"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.063s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

  Building submodules.download
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.828s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 1.424s
   + 2/2 submodule(s) of module::first were downloaded in 14.259s
  Built submodules.download in 14.300s

```

Результат подібний до використання команди `will .submodules.download`, проте, далі ми можемо удосконалити модуль і така структура запису буде доречною.