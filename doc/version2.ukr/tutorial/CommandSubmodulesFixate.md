# Команда <code>.submodules.fixate</code>

Команда встановлення версії підмодулів автоматизовним перезаписом <code>вілфайла</code>.

Стабільне функціонування модуля можливе при 

  

Команда `.submodules.fixate` призначена для автоматизованого запису (фіксації) поточної версії підмодуля в `вілфайл`. Фіксація проводиться для підмодулів, які не мають версії, тобто, посилання не містить вказаної версії програми чи коміту. 

Команда має опцію `dry` для ввімкнення перезапису `вілфайла`. Опція `dry` приймає значення `0` i `1`. При `dry:0` (значення за замовчуванням) фраза замінить URI-посилання на актуальні. При значенні `dry:1` команда `will .submodules.fixate dry:1` виводить список доступних оновлень не змінюючи `вілфайл`. Команда `.submodules.fixate` пропускає підмодулі з вказаними версіями підмодуля або комміту.    

### Структура файлів

<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesFixate
        └── .will.yml

```

</details>

Для дослідження команди створіть приведену структуру файлів в директорії `submodulesFixate`. 

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test submodule control commands"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

Внесіть в файл `.will.yml` приведений код.

<details>
  <summary><u>Вивід команди <code>will .submodules.fixate dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.fixate dry:1
...
Remote path of module::submodulesCommands / module::Tools will be fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::PathFundamentals will be fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::Files will be fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/.will.yml

```

</details>

Перейдіть в директорію `submodulesFixate` та виконайте пошук оновлень для підмодулів командою `.submodules.fixate` з опцією `dry:1` - без заміни значень. 

Вивід з указанням `will be fixated` говорить про те, що при опції `dry:0` ресурс буде змінено.  

<details>
  <summary><u>Секція <code>submodule</code> зі змінами в підмодулі <code>Tools</code></u></summary>

```yaml    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```

</details>
<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml

```

</details>

Відкрийте файли `.will.yml` в директоріях `submodulesFixate` і `submodulesUpgrade` та змініть ресурс `Tools` в секції `submodule` на приведений вище.    

<details>
  <summary><u>Вивід команди <code>will .submodules.fixate</code></u></summary>

```
[user@user ~]$ will .submodules.fixate
...
Remote path of module::submodulesCommands / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/submodulesFixate/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/submodulesFixate/.will.yml

```

</details>

Застосуйте команду `.submodules.fixate` без аргументів.

Утиліта змінила ресурси в секції `submodule` `вілфайлa` згідно останніх коммітів на віддаленому сервері. При цьому команда `.submodules.fixate` не змінила ресурс `Tools`, в якому вказано версію.  


Утиліта `willbe` дозволяє розробнику зафіксувати версії віддалених підмодулів в `вілфайлі` командою `.submodules.fixate`, здійснювати автоматизований перезапис ресурсів командою `.submodules.upgrade.refs`, оновлювати підмодулі командою `.submodules.update` i видаляти - `.submodules.clean`. 

### Підсумок

- Команда `.submodules.fixate` -  фіксує версію віддаленого підмодуля, а команда `.submodules.upgrade` оновлює ресурси `вілфайла` до останньої версії віддаленого підмодуля.  
- Використання команд `.submodules.fixate` i `.submodules.upgrade` разом з командою `.submodules.update`, розділяє оновлення підмодулів на два етапи - оновлення посилань і завантаження підмодулів, що забезпечує безпечне оновлення підмодулів і надійність роботи модуля.   

[Повернутись до змісту](../README.md#tutorials)
