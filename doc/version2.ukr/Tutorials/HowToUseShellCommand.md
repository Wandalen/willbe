# How to use `.shell` command

Використання команди `.shell`  

Для роботи з модулем часто доводиться використовувати сторонні інструменти - командну оболонку операційної системи чи зовнішні програми. Наприклад, вивести список файлів після побудови, запустити створений файл... Це можна здійснити помістивши в збірку `will-файла` крок `predefined.shell` з потрібною командою, а для повторного використання таких дій потрібно будувати окремі збірки. Якщо ви працюєте з готовим модулем, вносити такі зміни незручно тому, є команда `.shell`, яка дозволяє запускати сторонні команди в терміналі операційної системи. Її основне призначення - виконання зовнішніх команд при взаємодії з модулем.   

### Використання команди
Команда `.shell` може бути використана окремо в вигляді `will .shell ls`, де `ls` - команда виводу списку файлів, яку утиліта `willbe` виконає з допомогою `.shell`. При такому способі різниці між запуском `ls` самостійно і разом з `will .shell` не буде, оскільки, команда `.shell` безпосередньо не взаємодіє з компонентами модуля. Для ефективного використання команди `.shell` застосовуйте її разом з командою `.each`, котра виконує команди як над групою `will-файлів`, так і над окремими ресурсами модуля.  
Побудуйте модуль згідно представленої структури:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```
shellCommand
    ├── module.test
    │        └── one.will.yml
    │ 
    └── .will.yml       

```

</details>

В файл `.will.yml` та `one.will.yml` внесіть код: 

<details>
  <summary><u>Код <code>will-файлів</code></u></summary>
    <p>Код <code>.will.yml</code></p>

```yaml
about :

  name : shellCommand
  description : "To use .shell command"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  One : module.test/one

build :
  
  download :
    criterion :
      default : 1
    steps :
      - submodules.download

```

<p>Код <code>one.will.yml</code></p>

```yaml
about :

  name : noWorkedFile
  description : "Only example of will-file"

```

</details>

Запустіть побудову: 

<details>
  <summary><u>Вивід фрази <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::shellCommand / build::download
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 12.011s
     . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
     + module::PathFundamentals version master was downloaded in 4.239s
   + 2/3 submodule(s) of module::shellCommand were downloaded in 16.262s
  Built module::shellCommand / build::download in 16.313s

```

<p>Модуль після побудови</p>

```
shellCommand
    ├── .module 
    │      ├── Tools
    │      └── PathFundamentals
    ├── module.test
    │        └── one.will.yml
    │ 
    └── .will.yml       

```

</details>

З командою `.shell` можна виконати 