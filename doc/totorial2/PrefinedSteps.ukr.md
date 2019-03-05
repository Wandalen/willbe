# Використання вбудованих кроків

В туторіалі дається пояснення вбудованих кроків та приведено приклади використання

При побудові модуля переважно використовуються одні і ті ж операції - завантаження, переміщення, копіювання, видалення... Опис окремих сценаріїїв для них трудомісткий тому, щоб спростити використання пакету, він має ряд вбудованих фунцій. Особливістю таких функцій є простота використання.   
Ми уже вже використовували деякі вбудовані кроки, серед яких, експортування модуля, видалення файлів та використання командного рядка. Як бачите декілька рядків в конфігураційному файлі виконували складні дії. Тут ознайомимось з вбудованими кроками для управління підмодулями та деякими іншими функціями.  
Створіть новий `will`-файл та додайте:

```yaml
about :

    name : predefinedSteps
    description : "To use predefined submodule control steps"
    version : 0.0.1

submodule :

    WTools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

build :

    download :
        steps :
           - submodules.download

    upgrade :
        steps :
           - submodules.upgrade

    clean :
        steps :
           - submodules.clean
           
```

Вбудовані кроки з управління підмодулями мають таке ж формулювання як команди в консолі операційної системи тому їх буде легше запам'ятати. Вони поміщені в секцію `build`. Порівняємо з вбудованим кроком видалення файлів:

```yaml
step  :

  delete.debug :
      inherit : predefined.delete
      filePath : path::fileToDelete*
      
```

Для видалення файлів необхідно вказати додатковий аргумент - шлях до файлів, а кроки управління підмодулями не приймають ніяких аргументів тому їх краще записати їх в полі `steps` сценарію побудови, що скоротить розмір файла і зробить його зручнішим.  

Випробуємо його виконавши відповідні побудови:

```
[user@user ~]$ will .build download
...
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was downloaded in 12.741s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 4.903s
   + 2/2 submodule(s) of module::first were downloaded in 17.652s
  Built download in 17.698s

```

```
[user@user ~]$ will .build clean
  Building clean
   - Clean deleted 346 file(s) in 1.159s
  Built clean in 1.207s
  
```

```
[user@user ~]$ will .build upgrade
Request ".build upgrade"
   . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/PredefinedSteps/.will.yml
 . Read 1 will-files in 0.089s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

  Building upgrade
     . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/PredefinedSteps/.module/WTools/out/wTools.out.will.yml
     + module::WTools was upgraded in 17.024s
     . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/PredefinedSteps/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was upgraded in 4.256s
   + 2/2 submodule(s) of module::first were upgraded in 21.288s
  Built upgrade in 21.330s

  ```
  
  Послідовність виконання дій не випадкова - останній лістинг з фразою `will .build upgrade` показує, що в випадку відсутності підмодулів процедура оновлення також завантажує їх.  
  