# Команда <code>.submodules.fixate</code>

Команда встановлення версії підмодулів автоматизовним перезаписом <code>вілфайла</code>.

Стабільність роботи модуля з віддаленими підмодулями залежить від якості останніх. Після побудови модуля, оновлення (зміна версії) віддалених підмодулів може призвести до поломки або нестабільного функціонування модуля. Тому, для побудови модуля краще зафіксувати версії підмодулів з командою `.submodules.fixate`.

Команда призначена для автоматизованого зчитування та перезапису URI-адрес віддалених підмодулів (без завантаження файлів)  в `вілфайлі` на найновіші URI (останній комміт). Командою `.submodules.fixate` переписуються лише ті підмодулі, для яких явно не вказана версія (коміт). Команда має опцію `dry` для ввімкнення перезапису `вілфайла`, яка приймає значення `0` i `1`. При `dry:0` (значення за замовчуванням) команда здійснює перезапис URI-посилань. При значенні `dry:1` команда `will .submodules.fixate dry:1` виводить список доступних оновлень не змінюючи `вілфайл`.    

### Структура файлів

<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesFixate
        └── .will.yml

```

</details>

Для дослідження команди побудуйте модуль за вказаною структурою файлів та внесіть код в `вілфайл`. 

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.fixate command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

### Використання команди `.submodules.fixate`

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

Перейдіть в директорію `submodulesFixate` та виконайте пошук оновлень для підмодулів командою `.submodules.fixate` з опцією `dry:1`, тобто, без перезапису URI-посилань підмодулів. 

Вивід з указанням `will be fixated` говорить про те, що URI-посилання всіх трьох підмодулів буде змінено при опції `dry:0`.  

<details>
  <summary><u>Секція <code>submodule</code> зі змінами в підмодулі <code>Tools</code></u></summary>

```yaml    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```

</details>

Відкрийте файл `.will.yml` та змініть ресурс `Tools` на приведений вище. 

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

Утиліта змінила ресурси в секції `submodule` `вілфайлa` згідно останніх коммітів на віддаленому сервері. При цьому команда `.submodules.fixate` не змінила ресурс `Tools`, в якому явно вказано коміт.  

Таким чином, команду `.submodules.fixate` корисно використовувати перед побудовою модуля або одразу після неї (побудови). Це дозволить зафіксувати версію підмодулів і забезпечить надійну роботу модуля. Вихід наступних версій підмодулів не зможе зламати роботу модуля, а розробник матиме змогу оновити їх в зручний час.

Для перезапису URI-посилань підмодулів на найновіші використовується [команда `.submodules.upgrade`](CommandSubmodulesUpgrade.md), для завантаження оновлень (файлів підмодуля) використовується [команда `.submodules.update`](CommandSubmodulesUpdate.md).

### Підсумок

- Команда `.submodules.fixate` 
    - забезпечує стабільність роботи модуля з віддаленими підмодулями.
    - призначена для перезапису URI-посилань підмодулів.  
    - змінює `вілфайл` без завантаження файлів підмодулів.
    - не змінює посилання в яких явно вказано версію (коміт).
- Команду `.submodules.fixate` краще використовувати перед побудовою модуля або одразу після побудови. Таким чином фіксуються версії віддалених підмодулів на момент побудови і забезпечується надійна робота модуля.

[Повернутись до змісту](../README.md#tutorials)
