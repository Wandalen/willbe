## Швидкий старт

Для швидкого старту [встановіть](<./tutorial/Instalation.md>) утиліту `willbe`, [ознайомтеся](<./tutorial/CLI.md>) із інтрфейсом командного рядка та створіть ваш перший [модуль "Hello World"](<./tutorial/HelloWorld.md>). [Прочитатйе](<./tutorial/Abstract.md>) загальну інформацію якщо вам цікаво дізнатися більше про призначення та філософію утиліти `willbe`.

Для плавного заглиблення в предмет використовуйте туторіали. Для отримання вичерпного розуміння якогось із аспектів використайте перелік концепцій щоб знайти потрібну і ознайомтеся із нею.

## <a name="concepts"></a> Концепції

<details>
  <summary><a href="./concept/WillFile.md"><code>Will-файл</code></a></summary>
  Конфігураційний файл для опису та збірки модуля. Кожен формальний модуль має такий файл.
</details>
<details>
  <summary><a href="./concept/NamedAndSplitWillFile.md">Іменований <code>will-файл</code></a></summary>
  Вид <code>will-файла</code>, що має не стандартне ім'я файлу. Дозволяє мати більше одного модуля із різними іменами файлів в одній дерикторії.
</details>
<details>
  <summary><a href="./concept/NamedAndSplitWillFile.md">Спліт <code>will-файл</code></a></summary>
  Розділення <code>will-файла</code> на два файла - для імпорту та експорту модуля
</details>
<details>
  <summary><a href="./concept/Structure.md#resource">Ресурси</a></summary>
  Структурна і функціональна одиниця <code>will-файла</code>. Ресурси одного типу зібрані в одній секції.
</details>
<details>
  <summary><a href="./concept/Structure.md#resource-type">Тип ресурсу</a></summary>
  Функціональність обмежена призначенням і механізмом виконання.
</details>
<details>
  <summary><a href="./concept/Structure.md#section">Секція <code>will-файла</code></a></summary>
  Вища структурна одиниця <code>will-файла</code>, яка складається з ресурсів одного типу або полів, що описують дану секцію
</details>
<details>
  <summary><a href="./concept/About.section.md">Секція <code>about</code></a></summary>
  Секція містить описову інформація про модуль
</details>
<details>
  <summary><a href="./concept/Path.section.md">Секція <code>path</code></a></summary>
  Секція представляє карту шляхів модуля для швидкого орієнтування в його файловій структурі
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>submodule</code></a></summary>
  Секції містить інформацію про підмодулі
</details>
<details>
  <summary><a href="./concept/Step.section.md">Секція <code>step</code></a></summary>
  Секція містить кроки, які можуть бути застосовані збіркою для побудови модуля
</details>
<details>
  <summary><a href="./concept/Reflector.section.md">Секція <code>reflector</code></a></summary>
  Секція містить рефлектори, ресурси для виконання операцій над групами файлів.
</details>
<details>
  <summary><a href="./concept/Build.section.md">Секція <code>build</code></a></summary>
  Ресурси секції (збірки) описують послідовність і умови виконання процедур створення модуля
</details>
<details>
  <summary><a href="./concept/Exported.section.md">Секція <code>exported</code></a></summary>
  Секція <code>out-will-файла</code>, програмно генерується при експортуванні модуля, містить перелік всіх експортованих файлів та використовується при імпортуванні даного модуля іншим.
</details>
<details>
  <summary><a href="./concept/Export.md#out-will-file">Експортований <code>will-файл</code> (<code>out-will-файл</code>)</a></summary>
  <code>Out-will-файл</code> - різновид <code>will-файла</code> згенерованого утилітою при експортуванні модуля. Інші модулі можуть використати даний модуль імортувавши його <code>out-will-файл</code>.
</details>
<details>
  <summary><a href="./concept/Module.md#module">Модуль</a></summary>
  Модулем називається сукупність файлів, які описані в <code>will-файлi</code>
</details>
<details>
  <summary><a href="./concept/Module.md#submodule">Підмодуль</a></summary>
  Окремий модуль з власним конфігураційним <code>will-файлом</code>, який використовується іншому модулю ( супермодулю )
</details>
<details>
  <summary><a href="./concept/Module.md#supermodule">Супермодуль</a></summary>
  Модуль, який включає в себе інші модулі ( підмодулі )
</details>
<details>
  <summary><a href="./concept/LocalAndRemoteSubmodules.md#local-submodule">Локальний підмодуль</a></summary>
  Підмодуль, який розташовується на машині користувача
</details>
<details>
  <summary><a href="./concept/LocalAndRemoteSubmodules.md#remote-submodule">Віддалений підмодуль</a></summary>
  Модуль, який знаходиться на віддаленому сервері, для використання завантажується на локальну машину
</details>
<details>
  <summary><a href="./concept/CurrentModule.md">Поточний модуль</a></summary>
  <code>Will-модуль</code>, відносно якого виконуються операції в командній оболонці системи.  
</details>
<details>
  <summary><a href="./concept/Export.md#module-export">Експорт модуля</a></summary>
  Особливий вид збірки, котрий призначений для перенесення конфігурації поточного модуля
</details>
<details>
  <summary><a href="./concept/InformalSubmodule.md">Неформальний підмодуль</a></summary>
  Група файлів, що не розповсюджується із <code>will-файлом</code>. Для такого підмодуля можливо створити <code>will-файл</code> та експортувати його самостійно.
</details>
<details>
  <summary><a href="./concept/Command.md#command">Команда</a></summary>
  Рядок що містить фраза для позначення наміру розробинка і дії, котрі будуть виконані утилітою по її введенні. Вводиться в інтерфейсь командного рядка розробником.
</details>
<details>
  <summary><a href="./concept/Command.md#will-phrase">Фраза</a></summary>
  Слово або декілька слів, відокремлених крапкою, позначає команду, яку має виконати утиліта.
</details>
<details>
  <summary><a href="./concept/Selectors.md#selector">Селектор</a></summary>
  Рядок-посилання на ресурс або декілька ресурсів в <code>will-файлі</code>
</details>
<details>
  <summary><a href="./concept/Selectors.md#selector-with-glob">Селектор з ґлобом</a></summary>
  Селектор, який для вибору ресурсу використовує пошукові шаблони - ґлоби
</details>
<details>
  <summary><a href="./concept/Asserts.md">Ґлоб з ассертом</a></summary>
  Обмеження кількості ресурсів в вибірці селектором з ґлобом
</details>
<details>
  <summary><a href="./concept/Criterions.md">Критеріон</a></summary>
  Елемент порівняння для відбору ресусрів
</details>
<details>
  <summary><a href="./concept/Inheritability.md">Наслідування ресурсами</a></summary>
  Принцип опису модуля, згідно якого ресурс <code>will-файла</code> здатний використовувати (наслідувати) значення полів інших ресурсів того ж типу.
</details>
<details>
  <summary><a href="./concept/FileFilter.md">Файловий фільтр</a></summary>
  Спосіб опису критеріїв відобору необхідних файлів для виконання якоїсь операції над групою файлів. Рефлектор містить два фільтра файлів: <code>src</code> та <code>dst</code>.
</details>

## <a name="tutorials"></a> Туторіали

<details>
  <summary><a href="./tutorial/Abstract.md">Загальна інформація</a></summary>
  Загальна інформація. Чим утиліта <code>willbe</code> є і чим вона не являється
</details>
<details>
  <summary><a href="./tutorial/Instalation.md">Встановлення</a></summary>
  Процедура встановлення утиліти <code>willbe</code>
</details>
<details>
  <summary><a href="./tutorial/CLI.md">Інтерфейс командного рядка</a></summary>
  Як користуватися інтерфейсом командного рядка утиліти <code>willbe</code></a></summary>. Застосування команд <code>.help</code> та <code>.list</code>.
</details>
<details>
  <summary><a href="./tutorial/HelloWorld.md">Модуль "Hello, World!"</a></summary>
  Створення модуля "Hello, World!" з утилітою <code>willbe</code>. Завантаження віддаленого підмодуля
</details>
<details>
  <summary><a href="./tutorial/SubmodulesAdministration.md">Оновлення та видалення підмодулів</a></summary>
  Команди оновлення підмодулів, апгрейду підмодулів автоматизовним перезаписом <code>will-файла</code> та очищення модуля.
</details>
<details>
  <summary><a href="./tutorial/Build.md">Побудова модуля командою <code>.build</code></a></summary>
  Запуск окремих збірок модуля для його побудови.
</details>
<details>
  <summary><a href="./tutorial/PredefinedSteps.md">Вубдовані кроки</a></summary>
  Як користуватись вбудованими кроками для роботи з віддаленими підмодулями
</details>
<details>
  <summary><a href="./tutorial/Criterions.md">Критеріони</a></summary>
  Як використовувати критеріони для відбору ресурсів
</details>
<details>
  <summary><a href="./tutorial/DefaultCriterionInWillFile.md">Збірка модуля за замовчуванням</a></summary>
  Як побудувати збірку, що запускається без явного указання аргумента команди <code>.build</code>
</details>
<details>
  <summary><a href="./tutorial/ExportedWillFile.md">Експортування модуля</a></summary>
  Процедура експортування <code>will-модуля</code> для перевикористання його іншим модулем
</details>
<details>
  <summary><a href="./tutorial/LocalSubmodulesImporting.md">Імпорт локального підмодуля</a></summary>
  Використання локального підмодуля
</details>
<details>
  <summary><a href="./tutorial/HowToUseSelectorsWithGlob.md">Селектори із ґлобами</a></summary>
  Як користуватись селекторами з ґлобами
</details>
<details>
  <summary><a href="./tutorial/HowToUseAsserts.md">Як користуватись ассертами</a></summary>
  Як ассерти допомогають зменшити кількість помилок при розробці.
</details>
<details>
  <summary><a href="./tutorial/MinimizationOfWillFile.md">Мінімізація <code>will-файла</code></a></summary>
  Як мінімізувати <code>will-файл</code> за допомогою розгортання критеріонами із множинними значеннями.
</details>
<details>
  <summary><a href="./tutorial/SplitWillFile.md">Розділені <code>will-файли</code></a></summary>
  Як створити та використовувати модуль із розділеними <code>will-файлами</code>.
</details>
<details>
  <summary><a href="./tutorial/NamedWillFile.md">Команда <code>.with</code> та іменований <code>will-файл</code>. </a></summary>
  Як використовувати команду <code>.with</code>? Що таке іменований <code>will-файл</code>?
</details>
<details>
  <summary><a href="./tutorial/UsingEachCommand.md">Як користуватись командою <code>.each</code></a></summary>
  Команда <code>.each</code> для виконання одної дії для багатьох модулів чи підмодулів.
</details>
<details>
  <summary><a href="./tutorial/UsingOfJSInWillbe.md">Використання JavaScript файлів утилітою <code>willbe</code></a></summary>
  Як використовувати JavaScript-файлів в утиліті <code>willbe</code> для виконання складних сценаріїв побудови.
</details>
<details>
  <summary><a href="./tutorial/UsingSetCommand.md">Команда <code>.set</code></a></summary>
  Як корстуватись командою <code>.set</code> для зміни станів утиліти, наприклад для зміни рівня вербальності.
</details>
<details>
  <summary><a href="./tutorial/HowToUseComplexSelector.md">Складні селектори</a></summary>
  Використання складних селекторів для відбору ресурсів із підмодулів.
</details>
<details>
  <summary><a href="./tutorial/HowToList.md">Перелік ресурсів через застосовуючи фільтри та глоби</a></summary>
  Як побудувати запиш до утиліти та отримати перелік ресурсів застосовуючи фільтри та глоби.
</details>
<details>
  <summary><a href="./tutorial/SubmodulesVersionControl.md">Командами <code>.submodules.fixate</code> і <code>.submodules.upgrade</code></a></summary>
  Перевірка, оновлення і фіксування версій підмодулів в <code>will-файлі</code>
</details>
<details>
  <summary><a href="./tutorial/ReflectorUsing.md">Копіювання файлів за допомогою рефлектора</a></summary>
  Копіювання файлів за допомогою рефлекта, поле <code>recursive</code> рефлектора.
</details>
<details>
  <summary><a href="./tutorial/ReflectorFilters.md">Фільтри рефлектора</a></summary>
  Використання фільтрів рефлектора для відбору файлів для копіювання.
</details>
<details>
  <summary><a href="./tutorial/ReflectorTimeFilters.md">Часові фільтри рефлектора</a></summary>
  Як користуватись фільтрами відбору файлів по часу.
</details>
<details>
  <summary><a href="./tutorial/ReflectorFSControl.md">Формування шляхів в рефлекторі. Управління файловими операціями</a></summary>
  В туторіалі показано як формуються шляхи рефлекторів та як управляти кількістю файлових операцій
</details>
<details>
  <summary><a href="./tutorial/PredefinedReflectorsUsing.md">Вбудовані рефлектори</a></summary>
  Використання вбудованих рефлекторів та побудова мультизбірок
</details>
<details>
  <summary><a href="./tutorial/ResourceInheritability.md">Наслідування ресурсів</a></summary>
  Як користуватись наслідуванням ресурсів
</details>
<details>
  <summary><a href="./tutorial/ViewStep.md">Вбудований крок <code>predefined.view</code></a></summary>
  Використання вбудованого кроку <code>predefined.view</code> для перегляду файлів.
</details>
<details>
  <summary><a href="./tutorial/TranspileStep.md">Транспіляція файлів</a></summary>
  Використання вбудованого кроку <code>predefined.transpile</code> для трансформації JavaScript-файлів
</details>
<details>
  <summary><a href="./tutorial/HowToUseCommandShell.md">Команда <code>.shell</code> </a></summary>
  Команда для виклику зовнішніх програм утилітою <code>willbe</code> для вибраних модулів.
</details>
<details>
  <summary><a href="./tutorial/WillbeAsMake.md">Компіляція С++ програми</a></summary>
  Використання утиліти <code>willbe</code> для компіляції С++ програми
</details>
<details>
  <summary><a href="./tutorial/InformalSubmodule.md">Неформальні підмодулі</a></summary>
  Імпортування неформальних підмодулів
</details>
<details>
  <summary><a href="./tutorial/CleanCommandUsing.md">Команда очистки <code>.clean</code></a></summary>
  Використання команди для очистки <code>.clean</code> для того щоб видалити згенеровані та тимчасові файли.
</details>
