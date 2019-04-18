# `Will-file` structure

### Section <code>will-file</code>   

Higher structural element of <code>will-file</code>, which consists of resources of single type or fields, which describe the module.

Для побудови модуля існує 6-ть необов'язкових секцій: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка генерується утилітою `willbe` при експорті модуля - секція `exported`.   

Повна структура `will-файла` з секціями:  

```
will-file
    ├── about
    ├── submodule
    ├── path
    ├── reflector
    ├── step
    ├── exported
    └── build

```

Порядок розташування і кількість секцій в `will-файлі` визначається його призначенням. Наприклад, можлива така структура:  

```
will-file
    ├── step
    ├── about
    ├── build
    └── submodule

```

### Призначення секцій `will-файла`

<details>
  <summary><a href="./concept/SectionAbout.md">Секція <code>about</code></a></summary>
  Секція містить описову інформація про модуль.
</details>
<details>
  <summary><a href="./concept/Paths.md#Секція-path">Секція <code>path</code></a></summary>
  Секція представляє карту шляхів модуля для швидкого орієнтування в його файловій структурі.
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>submodule</code></a></summary>
  Секція містить інформацію про підмодулі.
</details>
<details>
  <summary><a href="./concept/Steps.md#Секція-step">Секція <code>step</code></a></summary>
  Секція містить кроки, які можуть бути застосовані збіркою для побудови модуля.
</details>
<details>
  <summary><a href="./concept/Reflectors.md#Секція-reflector">Секція <code>reflector</code></a></summary>
  Секція містить рефлектори - ресурси для виконання операцій над групами файлів.
</details>
<details>
  <summary><a href="./concept/Builds.md#Секція-build">Секція <code>build</code></a></summary>
  Ресурси секції (збірки) описують послідовність і умови виконання процедур створення модуля.
</details>
<details>
  <summary><a href="./concept/SectionExported.md">Секція <code>exported</code></a></summary>
  Секція <code>out-will-файла</code>, програмно генерується при експортуванні модуля, містить перелік всіх експортованих файлів та використовується при імпортуванні даного модуля іншим.
</details>

Приклад `will-файла`:  

![will.file.inner.png](./Images/will.file.inner.png)  

### Resources
Structural and functional element of <code>will-file</code>. Resources of the same type collected in a section.   

Ресурси секцій позначаються декларативно, тобто, вказується лише результат, який потрібно отримати, а послідовність дій для отримання результату опускається.  
Вигляд ресурсів окремих секцій відрізняється. На рисунку підмодуль `Tools` секції `submodule` має скорочену форму запису, а ресурс `npm.install` секції `step` - повну (розширену):

![resource.png](./Images/resource.png)  

### Type of resource

Functionality associated with group of resources restricted by its purpose. Examples of types of resources: path, submodule, step, build. Each type of resources has its own purpose and is treated by the utility differently.

В секції `path` об'єднані ресурси типу `шлях` - ресурс указує на шлях до файла (директорії) і використовується в роутингу для інших ресурсів. Секція `step` об'єднує ресурси типу "функція побудови [модуля](Module.md#Модуль)" (скорочена назва "крок") - ресурс вказує процедуру побудови і умови її виконання. Секція `reflector` - ресурс типу "рефлектор" - виконання операцій з файлами. Секція `submodule` об'єднує ресурси "підмодулі" - допоміжні частини модуля, окремі модулі. Секція `build` поміщає ресурси типу "збірка" - послідовність виконання побудови модуля. Секція `exported` включає описові поля і посилання на ресурси інших секцій. Секція `about` не має ресурсів, а містить описову інформацію про модуль.
