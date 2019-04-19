## Швидкий старт

Для швидкого старту [встановіть](<./tutorial/Instalation.md>) утиліту `willbe`, [ознайомтеся](<./tutorial/CLI.md>) із інтрфейсом командного рядка та створіть ваш перший [модуль "Hello World"](<./tutorial/HelloWorld.md>). [Прочитатйе](<./tutorial/Abstract.md>) загальну інформацію якщо вам цікаво дізнатися більше про призначення та філософію утиліти `willbe`.

Для плавного заглиблення в предмет використовуйте туторіали. Для отримання вичерпного розуміння якогось із аспектів використайте перелік концепцій щоб знайти потрібну і ознайомтеся із нею.

## Концепції

<details><summary><a href="./concept/WillFile.md">
      <code>Will-файл</code>
  </a></summary>
  Конфігураційний файл для опису та збірки модуля. Кожен формальний модуль має такий файл.
</details>
<details><summary><a href="./concept/WillFileNamedAndSplit.md#Іменований-will-файл">
      Іменований <code>will-файл</code>
  </a></summary>
  Вид <code>will-файла</code>, що має не стандартне ім'я файлу. Дозволяє мати більше одного модуля із різними іменами файлів в одній директорії.
</details>
<details><summary><a href="./concept/WillFileNamedAndSplit.md#Спліт-will-файл">
      Спліт <code>will-файл</code>
  </a></summary>
  Розділення <code>will-файла</code> на два файла - для імпорту та експорту модуля. Дозволяє розробнику розділити дані для побудови модуля і дані для використання цього модуля іншими модулями.
</details>
<details><summary><a href="./concept/Structure.md#Ресурси">
      Ресурси
  </a></summary>
  Структурна і функціональна одиниця <code>will-файла</code>. Ресурси одного типу зібрані в одній секції.
</details>
<details><summary><a href="./concept/Structure.md#Тип-ресурсу">
      Тип ресурсу
  </a></summary>
  Функціональність пов'язана із групою ресурсів, обмежена призначенням. Приклад того які бувать типи ресурів: шлях, підмодуль, крок, збірка. Кожен тип ресурів має власне призначення і обробляється утилітою по-різному.
</details>
<details><summary><a href="./concept/Inheritance.md">
      Наслідування
  </a></summary>
  Принцип опису модуля, згідно якого ресурс <code>will-файла</code> здатний використовувати (наслідувати) значення полів інших ресурсів того ж типу.
</details>
<details><summary><a href="./concept/ResourcePath.md#Ресурс-шлях">
      Ресурс шлях
  </a></summary>
  Ресурс для визначення файлової структури модуля, що містить файлові шлях до файлів. Шляхи розміщаються в секції <code>path</code>.
</details>
<details><summary><a href="./concept/ResourceReflector.md#Ресурс-рефлектор">
      Ресурс рефлектор
  </a></summary>
  Ресурс секції <code>reflector</code>, спосіб опису множини файлів для виконання якоїсь операції над ними.
</details>
<details><summary><a href="./concept/ReflectorFileFilter.md">
      Файлові фільтри
  </a></summary>
  Спосіб опису умов відбору необхідних для виконання деякої операції файлів. Рефлектор містить два фільтра файлів: <code>src</code> та <code>dst</code>.
</details>
<details><summary><a href="./concept/ResourceReflector.md#Мапа-шляхів">
      Мапа шляхів
  </a></summary>
  Поле рефлектора та спосіб опису множини файлів, котрий дозволяє включити в неї безліч файлів і виключити із неї не потрібні файли за допомогою умов виключення та глобів. рефлектора.
</details>
<details><summary><a href="./concept/ResourceStep.md#Ресурс крок">
      Ресурс крок
  </a></summary>
  Ресурс секції <code>step</code>, який представляє собою інструкцію для виконання утилітою при побудові модуля.
</details>
<details><summary><a href="./concept/ResourceBuild.md#Ресурс-збірка">
      Ресурс збірка
  </a></summary>
  Послідовність і умови виконання процедур побудови модуля. При виконанні команди <code>.build</code> розробник має вказати збірку, яку хоче зібрати, однозначно вибравши одну по імені або по умовам вибірки.
</details>
<details><summary><a href="./concept/Structure.md#Секція-will-файла">
      Секція <code>will-файла</code>
  </a></summary>
  Вища структурна одиниця <code>will-файла</code>, яка складається з ресурсів одного типу або полів, що описують даний модуль.
</details>
<details><summary><a href="./concept/SectionAbout.md">
      Секція <code>about</code>
  </a></summary>
  Секція містить описову інформація про модуль.
</details>
<details><summary><a href="./concept/ResourcePath.md#Секція-path">
      Секція <code>path</code>
  </a></summary>
  Секція містить перелік шляхів модуля для швидкого орієнтування в його файловій структурі.
</details>
<details><summary><a href="./concept/SectionSubmodule.md">
      Секція <code>submodule</code>
  </a></summary>
  Секція містить інформацію про підмодулі.
</details>
<details><summary><a href="./concept/ResourceReflector.md#Секція-reflector">
      Секція <code>reflector</code>
  </a></summary>
  Секція містить рефлектори - ресурси для виконання операцій над групами файлів.
</details>
<details><summary><a href="./concept/ResourceStep.md#Секція-step">
      Секція <code>step</code>
  </a></summary>
  Секція містить кроки, які можуть бути застосовані збіркою для побудови модуля.
</details>
<details><summary><a href="./concept/ResourceBuild.md#Секція-build">
      Секція <code>build</code>
  </a></summary>
  Ресурси секції (збірки) описують послідовність і умови виконання процедур створення модуля.
</details>
<details><summary><a href="./concept/SectionExported.md">
      Секція <code>exported</code>
  </a></summary>
  Секція <code>out-will-файла</code>, програмно генерується при експортуванні модуля, містить перелік всіх експортованих файлів та використовується при імпортуванні даного модуля іншим.
</details>
<details><summary><a href="./concept/Export.md#експортований-will-файл-out-will-файл">
      Експортований <code>will-файл</code> (<code>out-will-файл</code>)
  </a></summary>
  <code>Out-will-файл</code> - різновид <code>will-файла</code> згенерованого утилітою при експортуванні модуля. Інші модулі можуть використати даний модуль імортувавши його <code>out-will-файл</code>.
</details>
<details><summary><a href="./concept/Module.md#Модуль">
      Модуль
  </a></summary>
  Модулем називається сукупність файлів, які описані в <code>will-файлi</code>.
</details>
<details><summary><a href="./concept/Module.md#Підмодуль">
      Підмодуль
  </a></summary>
  Окремий модуль з власним конфігураційним <code>will-файлом</code>, який використовується іншим модулем (супермодулем).
</details>
<details><summary><a href="./concept/Module.md#Супермодуль">
      Супермодуль
  </a></summary>
  Модуль, який включає в себе інші модулі (підмодулі).
</details>
<details><summary><a href="./concept/SubmodulesLocalAndRemote.md#Локальний-підмодуль">
      Локальний підмодуль
  </a></summary>
  Підмодуль, який розташовується на машині користувача.
</details>
<details><summary><a href="./concept/SubmodulesLocalAndRemote.md#Віддалений-підмодуль">
      Віддалений підмодуль
  </a></summary>
  Модуль, який знаходиться на віддаленому сервері, для використання завантажується на локальну машину.
</details>
<details><summary><a href="./concept/ModuleCurrent.md">
      Поточний модуль
  </a></summary>
  Модуль відносно якого виконуються операції. За замовчуванням цей модуль завантажується із файла <code>.will.yml</code> поточної директорії.
</details>
<details><summary><a href="./concept/Export.md#Експорт-модуля">
      Експорт модуля
  </a></summary>
  Особливий вид збірки необхідний для використання даного модуля іншими розробниками та модулями. Результатом експортування модуля є аретфакти, зокерма <code>out-will-file</code>.
</details>
<details><summary><a href="./concept/SubmoduleInformal.md">
      Неформальний підмодуль
  </a></summary>
  Група файлів, що не розповсюджується із <code>will-файлом</code>. Для такого підмодуля можливо створити <code>will-файл</code> та експортувати його самостійно.
</details>
<details><summary><a href="./concept/Command.md#Команда">
      Команда
  </a></summary>
  Рядок що містить фразу для позначення наміру розробника і дії, котрі будуть виконані утилітою по її введенні. Вводиться в інтерфейс командного рядка розробником.
</details>
<details><summary><a href="./concept/Command.md#Фраза">
      Фраза
  </a></summary>
  Слово або декілька слів, відокремлених крапкою, позначає команду, яку має виконати утиліта.
</details>
<details><summary><a href="./concept/Selectors.md#Селектор">
      Селектор
  </a></summary>
  Рядок-посилання на ресурс або декілька ресурсів модуля.
</details>
<details><summary><a href="./concept/Selectors.md#Селектор-з-ґлобом">
      Селектор з ґлобом
  </a></summary>
  Селектор, який для вибору ресурсу використовує пошукові шаблони - ґлоби.
</details>
<details><summary><a href="./concept/Criterions.md">
      Критеріон
  </a></summary>
  Елемент порівняння для відбору ресурсів.
</details>
<details><summary><a href="./concept/Asserts.md">
      Ґлоб з ассертом  
  </a></summary>
  Обмеження кількості ресурсів, що мають бути знайдені селектором з ґлобом.
</details>

## Туторіали

<details><summary><a href="./tutorial/Abstract.md">
      Загальна інформація
  </a></summary>
  Загальна інформація. Чим утиліта <code>willbe</code> є і чим вона не являється.
</details>
<details><summary><a href="./tutorial/Installation.md">
      Встановлення
  </a></summary>
  Процедура встановлення утиліти <code>willbe</code>.
</details>
<details><summary><a href="./tutorial/CLI.md">
      Інтерфейс командного рядка
  </a></summary>
  Як користуватися інтерфейсом командного рядка утиліти <code>willbe</code>. Застосування команд <code>.help</code> та <code>.list</code>.
</details>
<details><summary><a href="./tutorial/HelloWorld.md">
      Модуль "Hello, World!"
  </a></summary>
  Створення модуля "Hello, World!". Завантаження віддаленого підмодуля.
</details>
<details><summary><a href="./tutorial/CommandsSubmodules.md">
      Команди оновлення, апгрейду та очищення підмодулів
  </a></summary>
  Команди оновлення підмодулів, апгрейду підмодулів автоматизовним перезаписом <code>will-файла</code> та очищення модуля.
</details>
<details><summary><a href="./tutorial/Build.md">
      Побудова модуля командою <code>.build</code>
  </a></summary>
  Запуск окремих збірок модуля для його побудови.
</details>
<details><summary><a href="./tutorial/StepsPredefined.md">
      Вбудовані кроки
  </a></summary>
  Як користуватись вбудованими кроками для роботи з віддаленими підмодулями.
</details>
<details><summary><a href="./tutorial/Criterions.md">
      Критеріони
  </a></summary>
  Як використовувати критеріони для відбору ресурсів.
</details>
<details><summary><a href="./tutorial/CriterionDefault.md">
      Збірка модуля за замовчуванням
  </a></summary>
  Як побудувати збірку, що запускається без явного указання аргумента команди <code>.build</code>.
</details>
<details><summary><a href="./tutorial/ModuleExport.md">
      Експортування модуля
  </a></summary>
  Експортування модуля для перевикористання його іншим розробником або модулем.
</details>
<details><summary><a href="./tutorial/SubmodulesLocal.md">
      Імпорт локального підмодуля
  </a></summary>
  Використання локального підмодуля із іншого модуля (супермодуля).
</details>
<details><summary><a href="./tutorial/SelectorsWithGlob.md">
      Селектори із ґлобами
  </a></summary>
  Як користуватись селекторами з ґлобами.
</details>
<details><summary><a href="./tutorial/AssertsUsing.md">
      Як користуватись ассертами
  </a></summary>
  Як ассерти допомогають зменшити кількість помилок при розробці.
</details>
<details><summary><a href="./tutorial/WillFileMinimization.md">
      Мінімізація <code>will-файла</code>
  </a></summary>
  Як мінімізувати <code>will-файл</code> за допомогою розгортання критеріонами із множинними значеннями.
</details>
<details><summary><a href="./tutorial/WillFileSplit.md">
      Розділені <code>will-файли</code>
  </a></summary>
  Як створити та використовувати модуль із розділеними <code>will-файлами</code>.
</details>
<details><summary><a href="./tutorial/WillFileNamed.md">
      Команда <code>.with</code> та іменований <code>will-файл</code>
  </a></summary>
  Як використовувати команду <code>.with</code>? Що таке іменований <code>will-файл</code>?
</details>
<details><summary><a href="./tutorial/CommandEach.md">
      Як користуватись командою <code>.each</code>
  </a></summary>
  Команда <code>.each</code> для виконання одної дії для багатьох модулів чи підмодулів.
</details>
<details><summary><a href="./tutorial/StepJS.md">
      Використання <code>JavaScript</code> файлів утилітою <code>willbe</code>
  </a></summary>
  Як використовувати <code>JavaScript</code> файли в утиліті <code>willbe</code> для виконання складних сценаріїв побудови.
</details>
<details><summary><a href="./tutorial/CommandSet.md">Команда <code>.set</code></a></summary>
  Як користуватись командою <code>.set</code> для зміни станів утиліти, наприклад, для зміни рівня вербальності.
</details>
<details><summary><a href="./tutorial/SelectorComposite.md">
      Складні селектори
  </a></summary>
  Використання складних селекторів для відбору ресурсів із підмодулів.
</details>
<details><summary><a href="./tutorial/CommandsListSearch.md">
      Перелік ресурсів застосовуючи фільтри та глоби
  </a></summary>
  Як побудувати запит до утиліти та отримати перелік ресурсів застосовуючи фільтри та глоби.
</details>
<details><summary><a href="./tutorial/ReflectorUsing.md">
      Копіювання файлів за допомогою рефлектора
  </a></summary>
  Копіювання файлів за допомогою рефлектора, поле <code>recursive</code> рефлектора.
</details>
<details><summary><a href="./tutorial/ReflectorFilters.md">
      Фільтри рефлектора
  </a></summary>
  Використання фільтрів рефлектора для відбору файлів для копіювання.
</details>
<details><summary><a href="./tutorial/ReflectorTimeFilters.md">
      Часові фільтри рефлектора
  </a></summary>
  Як користуватись фільтрами відбору файлів по часу.
</details>
<details><summary><a href="./tutorial/ReflectorFSControl.md">
      Формування шляхів в рефлекторі. Управління файлами
  </a></summary>
  Як формуються шляхи рефлекторів та як управляти доступом до файлів і директорій в рефлекторі.
</details>
<details><summary><a href="./tutorial/ReflectorsPredefined.md">
      Вбудовані рефлектори
  </a></summary>
  Використання вбудованих рефлекторів для розбиття на версію для відлагодження і для релізу. Побудова мультизбірок.
</details>
<details><summary><a href="./tutorial/ResourceInheritance.md">
      Наслідування ресурсів
  </a></summary>
  Як користуватись наслідуванням ресурсів для перевикористання даних.
</details>
<details><summary><a href="./tutorial/StepView.md">
      Вбудований крок <code>predefined.view</code>
  </a></summary>
  Використання вбудованого кроку <code>predefined.view</code> для перегляду файлів.
</details>
<details><summary><a href="./tutorial/StepTranspile.md">
      Транспіляція
  </a></summary>
  Використання вбудованого кроку <code>predefined.transpile</code> для транспіляції <code>JavaScript</code> файлів або їх конкатенації.
</details>
<details><summary><a href="./tutorial/CommandShell.md">
      Команда <code>.shell</code>
  </a></summary>
  Команда для виклику зовнішніх програм утилітою <code>willbe</code> для вибраних модулів чи підмодулів.
</details>
<details><summary><a href="./tutorial/WillbeAsMake.md">
      Компіляція С++ програми
  </a></summary>
  Використання утиліти <code>willbe</code> для компіляції С++ програми.
</details>
<details><summary><a href="./tutorial/SubmoduleInformal.md">
      Неформальні підмодулі
  </a></summary>
  Імпортування неформальних підмодулів.
</details>
<details><summary><a href="./tutorial/CommandClean.md">
      Команда очистки <code>.clean</code>
  </a></summary>
  Використання команди <code>.clean</code> для очистки згенерованих та тимчасових файлів.
</details>
