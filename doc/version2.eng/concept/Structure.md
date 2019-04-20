# Внутрішня будова

### Секція <code>will-файла</code>  

Вища структурна одиниця <code>will-файла</code>, яка складається з ресурсів одного типу або полів, що описують даний модуль.

Для побудови модуля існує 6-ть секцій: `about`, `path`, `submodule`, `step`, `reflector`, `build` та одна секція, яка лише генерується при експорті модуля - секція `exported`.   

#### Схематична структура `will-файла` 

```
will-file
    ├── about
    ├── submodule
    ├── path
    ├── reflector
    ├── step
    ├── build
    └── exported

```

На схемі зображені всі секції `will-файла`. Жодна із секцій не є обов'язковою для використання `will-файла`. Втім для виконання окремих команд необхідна присутність деяких. Наприклад, для експортування модуля `will-файл` повинен мати ім'я і версію, котрі вказуються в секції `about`.

### Призначення секцій `will-файла`

<details>
  <summary><a href="./concept/SectionAbout.md">Секція <code>about</code></a></summary>
  Секція містить описову інформація про модуль.
</details>
<details>
  <summary><a href="./concept/ResourcePath.md#Секція-path">Секція <code>path</code></a></summary>
  Секція містить перелік шляхів модуля для швидкого орієнтування в його файловій структурі.
</details>
<details>
  <summary><a href="./concept/Submodule.section.md">Секція <code>submodule</code></a></summary>
  Секція містить інформацію про підмодулі.
</details>
<details>
  <summary><a href="./concept/ResourceStep.md#Секція-step">Секція <code>step</code></a></summary>
  Секція містить кроки, які можуть бути застосовані збіркою для побудови модуля.
</details>
<details>
  <summary><a href="./concept/ResourceReflector.md#Секція-reflector">Секція <code>reflector</code></a></summary>
  Секція містить рефлектори - ресурси для виконання операцій над групами файлів.
</details>
<details>
  <summary><a href="./concept/ResourceBuild.md#Секція-build">Секція <code>build</code></a></summary>
  Ресурси секції (збірки) описують послідовність і умови виконання процедур створення модуля.
</details>
<details>
  <summary><a href="./concept/SectionExported.md">Секція <code>exported</code></a></summary>
  Секція <code>out-will-файла</code>, програмно генерується при експортуванні модуля, містить перелік всіх експортованих файлів та використовується при імпортуванні даного модуля іншим.
</details>

### An example of `will-file`    

![will.file.inner.png](./Images/will.file.inner.png)  

The figure shows the `will-file` with four sections and several resources.

### Resources

Structural and functional element of <code>will-file</code>. Resources of the same type collected in a section.

Resources of sections are designated declaratively. This means that the desired result is specified but there is no sequence or instructions for obtaining this result.

The type of resources representation of individual sections is different.

![resource.png](./Images/resource.png)  

In the figure the resource `Tools` of submodule type  located in the section `submodule`. It is written in a shortened form of the record. The resource `npm. install` of step type located in the section `step` is written in a full (extended) record form.

### Type of resource

The functionality associated with group of resources is restricted by its purpose. Examples of types of resources: path, submodule, step, build. Each type of resources has its own purpose and is treated by the utility differently.

### Ресурси по типам

<details><summary><a href="./concept/ResourcePath.md#Path">
    Recource of <code>path</code> type
  </a></summary>
  This is a resource for describing the file structure of a module that contains file paths. Paths are located in the <code>path</code> section.
</details>
<details><summary><a href="./ResourceStep.md#Resource-step">
    Resource of <code>step</code> type
  </a></summary>
  This is the resource of the  <code>step</code> section which is an instruction for executing by the utility when constructing the module. Step resource describes the operations and the desired result. The builds consist of steps. 
</details>
<details><summary><a href="./concept/ResourceReflector.md#Resource-reflector">
    Resource of <code>reflector</code> type
  </a></summary>
  This is the resource of the <code>reflector</code> section. It is a way to describe a set of files to perform some operation on them.
</details>
<details><summary><a href="./SubmodulesLocalAndRemote.md">
      Resource of <code>submodule
  </code> type</a></summary>
  There are links to other modules that can be used as submodules of this module. 
</details>
<details><summary><a href="./ResourceBuild.md#Resource-build">
      Resource of <code>build</code> type</a></summary>
  Contains a list of steps that required to build a module. 
</details>
<details><summary><a href="./ResourceBuild.md#Resource-export">
      Resource of <code>export</code> type
  </a></summary>
  This is a special kind of build. The result of export is the generated `out-will-file` that can be used by another module.
</details>
<details><summary><a href="./SectionExported.md#Section-exported">
      Resource of <code>exported</code> type
  </a></summary>
  When the module is exported this resource is generated. The export resource available only in the generated files. The <code> out-will-file </code> has exactly the same amount of <code> exported </code> resources as  the number of different exports was done. Resources of this type include descriptive fields and a list of exported files.
</details>
