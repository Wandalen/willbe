# Знайомство з вбудованими кроками системи

В туторіалі дається пояснення вбудованих кроків та приведено приклади використання

При побудові модуля переважно використовуються одні і ті ж операції - завантаження, переміщення, копіювання, видалення... Опис окремих збірок для них трудомісткий, а вбудовані функції пакету спрощують цю задачу. Особливістю таких функцій є простота використання - вказується назва вбудованої функції та її аргумент, якщо функція приймає аргументи.   
Ми використовували вбудований крок для запуску команд в консолі операційної системи - запис декількох рядків в конфігураційному файлі автоматично виконує задані дії при побудові модуля. Тут ознайомимось з вбудованими кроками для управління підмодулями.  
Створіть новий `will`-файл та додайте:

```yaml
about :

    name : predefinedSteps
    description : "To use predefined submodule control steps"
    version : 0.0.1

submodule :

    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
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

Вбудовані кроки з управління підмодулями мають таке ж формулювання як команди в консолі операційної системи тому їх буде легше запам'ятати (для більшості команд пакету `willbe` є вбудовані кроки). Вони поміщені відразу в поле `steps` секції `build`. Порівняємо з вбудованим кроком використання командної оболонки системи:

```yaml
step :

  echo :
    shell : echo "Done"
    currentPath : '.'
      
```

Для використання командної оболонки в полі `shell` необхідно вказати аргумент - команду, також додаткове поле з директорією виконання `currentPath`, а кроки управління підмодулями не приймають ніяких аргументів тому їх записують в полі `steps` сценарію збірки, що зменшує розмір файла і робить його зручнішим.  
Створимо комплексну збірку для чистого встановлення підмодулів, яка виведе в консоль фразу `Done` по завершенні:

```yaml
    clean.download :
        steps :
           - submodules.clean
           - submodules.download
           - echo

```

Складіть `will`-файл додавши крок `echo` та збірку `clean.download` в відповідні секції. Виконайте відповідні побудови (команди вводяться в кореневій директорії `will`-файла):

```
[user@user ~]$ will .build download
...
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was downloaded in 12.741s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was downloaded in 4.903s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 17.652s
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
...
  Building upgrade
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was upgraded in 17.024s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals was upgraded in 4.256s
   + 2/2 submodule(s) of module::predefinedSteps were upgraded in 21.288s
  Built upgrade in 21.330s

  ```
  
  ```
[user@user ~]$ will .build clean.download
...
  Building clean.download
   - Clean deleted 344 file(s) in 1.205s
     + module::Tools was downloaded in 13.699s
     + module::PathFundamentals was downloaded in 2.903s
   + 2/2 submodule(s) of module::predefinedSteps were downloaded in 16.610s
 > echo "Done"
Done
  Built clean.download in 17.907s


  ```
  
  
Послідовність виконання дій показує, що фраза `will .build upgrade` в випадку відсутності підмодулів також виконує завантаження. Тому, якщо ви видалите підмодуль, пакет його завантажить при наступному оновленні. Для повного видалення підмодуля відредагуйте також `will`-файл.  
  
- Вбудовані функції і кроки полегшують створення модульної системи.  
- Вбудовані кроки можуть записуються в секцію `step` i `build`

[Наступний туторіал](CriterionsInWillFile.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)