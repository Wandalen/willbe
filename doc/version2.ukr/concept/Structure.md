# Внутрішня будова

### <a name="section"></a>Секція
**Секція** - Вища структурна одиниця <code>will-файла</code>, яка складається з ресурсів одного типу або полів, що писують дану секцію. Є шість секцій для побудови модуля користувачем: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка генерується утилітою `willbe` при експорті модуля - секція `exported`.   
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
  В секції поміщено основну інформація про модуль
</details>
<details>
  <summary><a href="./concept/Path.section.md">Секція <code>path</code></a></summary>
  Секція представляє карту шляхів модуля для швидкого орієнтування в його структурі
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>submodule</code></a></summary>
  В секції вказуються підмодулі
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>step</code></a></summary>
  В секції описуються процедури побудови модуля
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>reflector</code></a></summary>
  Основними функціями ресурсів секції (рефлекторів) є файлові операції
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>exported</code></a></summary>
  Секція <code>will-файла</code>, автоматично згенерованого при експортуванні модуля
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>build</code></a></summary>
  Ресурси секції (збірки) описують послідовність і умови виконання процедур створення модуля
</details>

Приклад `will-файла`:  

![will.file.inner.png](./Images/will.file.inner.png)  

### <a name="resource"></a>Ресурси

**Ресурси** - елементи `will-файла`, які позначають певну функціональність. Ресурси секцій позначаються декларативно, тобто, вказується лише результат, який потрібно отримати, а послідовність дій для отримання результату опускається.  
Вигляд ресурсів окремих секцій відрізняється. На рисунку ресурс `Tools` секції `submodule` має скорочену форму запису, а ресурс `npm.install` секції `step` - повну (розширену):

![resource.png](./Images/resource.png)
