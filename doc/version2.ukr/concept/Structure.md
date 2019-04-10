# Внутрішня будова

### <a name="section"></a>Секція

Вища структурна одиниця <code>will-файла</code>, яка складається з ресурсів одного типу або полів, що описують дану секцію. Є шість секцій для побудови модуля користувачем: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка генерується утилітою `willbe` при експорті модуля - секція `exported`.   
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


### <a name="sections"></a> Призначення секцій `will-файла`

<details>
  <summary><a href="./concept/About.section.md">Секція <code>about</code></a></summary>
  Секція містить описову інформація про модуль
</details>
<details>
  <summary><a href="./concept/Path.section.md">Секція <code>path</code></a></summary>
  Секція представляє карту шляхів модуля для швидкого орієнтування в його структурі
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>submodule</code></a></summary>
  Секції містить підмодулі
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>step</code></a></summary>
  Секція містить кроки, які можуть бути застосовані збіркою для побудови модуля
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>reflector</code></a></summary>
  Основними функціями ресурсів секції (рефлекторів) є файлові операції
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>exported</code></a></summary>
  Секція <code>out-will-файла</code>, програмно генерується при експортуванні модуля
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>build</code></a></summary>
  Ресурси секції (збірки) описують послідовність і умови виконання процедур створення модуля
</details>

Приклад `will-файла`:  

![will.file.inner.png](./Images/will.file.inner.png)  

### <a name="resource"></a> Ресурси
Структурна і функціональна одиниця <code>will-файла</code>. В файлі ресурси одного типу зібрані в одній секції.

Ресурси секцій позначаються декларативно, тобто, вказується лише результат, який потрібно отримати, а послідовність дій для отримання результату опускається.

Вигляд ресурсів окремих секцій відрізняється. На рисунку підмодуль `Tools` секції `submodule` має скорочену форму запису, а ресурс `npm.install` секції `step` - повну (розширену):

![resource.png](./Images/resource.png)  

### <a name="resource-type"></a> Тип ресурса
Функціональність обмежена призначенням і механізмом виконання. Для ресурсів одного типу існує секція, яка їх об'єднує.  
Для прикладу, в секції `path` об'єднані ресурси типу "шлях" - ресурс указує на шлях до файла (директорії) і використовується в роутингу для інших ресурсів, а секція `step` об'єднує ресурси типу "функція побудови модуля" (скорочено використовується назва "крок") - ресурс вказує процедуру побудови і умови її виконання. Секція `about` не має ресурсів - поля описують модуль.
