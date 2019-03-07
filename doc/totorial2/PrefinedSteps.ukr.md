# Знайомство з вбудованими кроками системи

В туторіалі дається пояснення вбудованих кроків та приведено приклади використання

При побудові модуля переважно використовуються одні і ті ж операції - завантаження, переміщення, копіювання, видалення... Опис окремих сценаріїїв для них трудомісткий, а вбудовані функції пакету спрощують цю задачу. Особливістю таких функцій є простота використання - запис назви вбудованої функції та її аргумент, якщо функція приймає аргументи.   
Ми уже вже використовували вбудований крок для використання командної оболонки операційної системи - запис декількох рядків в конфігураційному файлі автоматично виконують задані дії при побудові модуля. Тут ознайомимось з вбудованими кроками для управління підмодулями.  
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

Вбудовані кроки з управління підмодулями мають таке ж формулювання як команди в консолі операційної системи тому їх буде легше запам'ятати. Вони поміщені в секцію `build`. Порівняємо з вбудованим кроком використання командної оболонки системи:

```yaml
step :

  echo :
    shell : echo "Debug is done"
    currentPath : '.'
      
```

Для виводу команди необхідно вказати додатковий аргумент - директорію виконання команди, а кроки управління підмодулями не приймають ніяких аргументів тому їх краще записати їх в полі `steps` сценарію побудови, що скоротить розмір файла і зробить його зручнішим.  
Виконаємо відповідні побудови (команди вводяться в кореневій директорії `will`-файла):

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
  ...
   - Clean deleted 346 file(s) in 1.159s
  Built clean in 1.207s
  
```

```
[user@user ~]$ will .build upgrade
Request ".build upgrade"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.089s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

  Building upgrade
     . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
     + module::WTools was upgraded in 17.024s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was upgraded in 4.256s
   + 2/2 submodule(s) of module::first were upgraded in 21.288s
  Built upgrade in 21.330s

  ```
  
Послідовність виконання дій не випадкова - останній лістинг з фразою `will .build upgrade` показує, що в випадку відсутності підмодулів процедура оновлення також виконує завантаження. Тому, якщо ви видалите підмодуль, пакет його завантажить при наступному оновленні.  
  
> Вбудовані функції і кроки полегшують створення модульної системи.  
> Кроки можуть записуються в секцію `step` i `build`

[Наступний туторіал](CriterionsInWillFile.ukr.md)  
[Повернутись до змісту](Topics.ukr.md)