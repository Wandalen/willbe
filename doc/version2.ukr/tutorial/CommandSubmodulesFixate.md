# Команда <code>.submodules.fixate</code>

Команда встановлення версії підмодулів в <code>вілфайлі</code> його автоматизовним перезаписом.

Стабільність роботи модуля з віддаленими підмодулями залежить від якості останніх. Оновлення віддалених підмодулів може призвести до поломки або нестабільного функціонування модуля. Для уникнення такої проблеми при розробці та супровождженні зафіксуйте версії підмодулів командою [`.submodules.fixate`](../concept/Command.md#Таблиця-команд-утиліти-willbe).

Команда призначена для автоматизованого перезапису URI-адрес віддалених підмодулів  в `вілфайлі` на URI найновіших версій підмодулів. При цьому завантаження файлів цих підмодулів автоматично не відбувається. Команда `.submodules.fixate` переписує лише ті підмодулі, для яких явно не вказана версія (коміт).

Команда має опцію `dry` для ввімкнення перезапису `вілфайла`, яка приймає значення `0` i `1`. При `dry:0` команда здійснює перезапис URI-посилань. При значенні `dry:1` команда `will .submodules.fixate dry:1` виконує всі операції, виводить список доступних оновлень не змінюючи, при цьому, жодного файла. Значення за замовчуванням `dry:0`.

### Структура файлів

<details>
  <summary><u>Файлова структура</u></summary>

```
submodulesFixate
        └── .will.yml

```

</details>

Для дослідження команди створіть модуль з вказаною структурою файлів та внесіть код в `вілфайл`.

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.fixate command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master
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
  git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::Files will be fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/.will.yml

```

</details>

Перейдіть в директорію `submodulesFixate` та виконайте пошук оновлень для підмодулів командою `.submodules.fixate` з опцією `dry:1`.

Перезапис URI-посилань підмодулів не відбувався, файл `.will.yml` залишився без змін, а на консоль було виведено перелік підмодулів із найновішими із доступних версій.

Вивід має три рядочки із словами`will be fixated`. В наявності є новіші версії для всіх троьох підмодулів. При виконанні команди `will .submodules.fixate` із `dry:0` `вілфайл` буде перезаписано цими версіями.

<details>
  <summary><u>Секція <code>submodule</code> зі змінами в підмодулі <code>Tools</code></u></summary>

```yaml    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master
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
  git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/submodulesFixate/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/submodulesFixate/.will.yml

```

</details>

Застосуйте команду `.submodules.fixate` без аргументів.

Утиліта замінила версії підмодулів в `вілфайлі`. При цьому команда `.submodules.fixate` не замінила підмодуль `Tools`, для якого явно вказано версію. 

Команда `.submodules.fixate` здійснює перезапис версій в [неформальних підмодулях](SubmoduleInformal.md), якщо вони присутні в `вілфайлі`.

Використовуйте команду `.submodules.fixate` перед побудовою модуля або одразу після. Це зафіксує версії підмодулів. Вихід наступних версій підмодулів не зможе зламати роботу модуля, а розробник матиме змогу оновити їх в зручний момент.

Для перезапису URI-посилань підмодулів на найновіші, незалежно від того чи була вказано версія підмодуля, використовується [команду `.submodules.upgrade`](CommandSubmodulesUpgrade.md), для завантаження файлів використовується [команда `.submodules.update`](CommandSubmodulesUpdate.md).

### Підсумок

- Команда `.submodules.fixate` забезпечує стабільність роботи модуля з віддаленими підмодулями.
- Команда `.submodules.fixate` призначена для перезапису URI-посилань підмодулів.  
- Команда `.submodules.fixate` автоматично змінює вміст `вілфайла` для розробника.
- Команда `.submodules.fixate` не здійснює завантаження файлів підмодулів.
- Команда `.submodules.fixate` не змінює посилання в яких явно вказано версію (коміт).
- Команду `.submodules.fixate` краще використовувати перед побудовою модуля або одразу після. Таким чином фіксуються версії віддалених підмодулів на момент побудови і забезпечується надійна робота модуля.

[Повернутись до змісту](../README.md#tutorials)
