# Compiling of С++ application

How to use utility <code>willbe</code> for compiling С++ application.

Однією із задач при програмуванні є перетворення одного типу файлів в інший, для виконання якої існує велика кількість різних програм і утліт. Ви ознайомились з [транспіляцією в `willbe`](StepTranspile.md) - використовуючи вбудовані інструменти, утиліта перетворила групу JavaScript-файлів в єдиний, а при реліз-побудові додатково його оптимізувала. В цьому туторіалі показано як `willbe`, агрегуючи можливості операційної системи, зовнішніх програм і вбудованих інструментів, побудує виконуваний файл.

### Програма `Hello World!` на C. Конфігурація  
Для перетворення вихідних файлів в виконувані використовуються компілятори. Компілятори не мають інструментів для слідкування за файлами і файловими зв'язками тому, цю задачу виконують сторонні утиліти. В Linux-дистрибутивах в якості такої утиліти, переважно, використовується [`make`](https://en.wikipedia.org/wiki/Make_%28software%29). Утиліта `willbe` пропонує власні інструменти для автоматизації перетворення файлів.  
Побудуйте структуру файлів для компіляції виконуваного файла:  

<details>
  <summary><u>Структура файлів</u></summary>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     └── main.c
        └── .will.yml

```

</details>

В кожен із файлів внесіть відповідний код:  

<details>
  <summary><u>Код файлa <code>hello.c</code></u></summary>

```c
#include <stdio.h>
void hello()
{
	printf("Hello World!\n");
}

```

</details>
<details>
  <summary><u>Код файлa <code>main.c</code></u></summary>

```c
int main()
{
	hello();
	return 0;
}

```

</details>
<details>
  <summary><u>Код файлa <code>.will.yml</code></u></summary>

```yaml
about :
  name : 'compileCpp'
  description : 'To use willbe as make'
  version : 0.0.1

path :

  in : '.'
  file : 'file'

reflector :
  
  compile :
    filePath :
      '*.c' : 1
      path::file : 1
    src :
      prefixPath : 'file'
    dst :
      filePath : path::file

  build :
    filePath :
      '*.o' : 1
      '*.c' : 0
      path::file : 1
    src :
      prefixPath : 'file'
    dst :
      filePath : path::file
    shell : gcc-6 -o {f::this/dst}/hello {f::this/src}    

step :

  compile :
    shell : gcc-6 -c {f::this/src}
    currentPath : path::file
    forEachDst : compile
    upToDate : preserve

build :

  compile :
    criterion :
      default : 1
    steps :
      - step::compile

  make.hello :
    steps :
      - step::build

```

</details>

Процес створення виконуваних файлів має два етапи: перший - створення об'єктних файлів з вихідних в збірці `compile`; другий - об'єднання об'єктних файлів в виконуваний в збірці `make.hello`.     
Результуюча скомпільована програма повинна вивести фразу `Hello World!` в консоль.

### Компіляція в виконуваний файл  
Виклик компілятора проходить в кроках `compile` i `build`:  

<details>
  <summary><u>Секція <code>step</code></u></summary>

```yaml
step :

  compile :
    shell : gcc-6 -c {this::src}
    currentPath : path::file
    forEachDst : compile
    upToDate : preserve

  build :
    shell : gcc-6 -o hello {this::src}
    currentPath : path::file
    forEachDst : build
    upToDate : preserve

```

</details>

Крок `compile` виконує компіляюцію вихідних файлів з допомогою компілятора `gcc` шостої версії (за необхідності, встановіть [gcc](http://gcc.gnu.org/) і змініть команду в полі `shell` відповідно до версії компілятора). Компіляція проходить в директорії `file` і кожнен скомпільований файл поміщається в директорію визначену полем `dst` рефлектора `compile`. Полем `upToDate` задається функція слідкування за змінами файлів в директорії. Відмінність кроку `build` в тому, що він виконує об'єднання об'єктних файлів в один виконуваний. В ньому використана функція генерації ресурсів - в рефлектор `build` внесена команда `gcc-6 -o {f::this/dst}/hello {f::this/src}`.   
Запустіть побудову збірки `compile`, перевірте директорію `file` після побудови:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::compileCpp / build::compile
 > gcc-6 -c /path_to_file/file/hello.c /path_to_file/file/main.c
...
  Built module::compileCpp / build::compile in 0.974s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     ├── hello.o
        │     ├── main.c
        │     └── main.o        
        └── .will.yml

```

</details>

Компіляція пройшла успішно. Виконайте побудову збірки `make.hello`:  

<details>
  <summary><u>Вивід команди <code>will .build make.hello</code></u></summary>

```
[user@user ~]$ will .build make.hello
...
  Building module::compileCpp / build::build.hello
 > gcc-6 -o hello /path_to_file/hello.o /path_to_file/temp/main.o
  Built module::compileCpp / build::make.hello in 0.357s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
compileCpp
        ├── file
        │     ├── hello
        │     ├── hello.c
        │     ├── hello.o
        │     ├── main.c
        │     └── main.o
        └── .will.yml

```

</details>

В директорії `file` поміщено виконуваний файл `hello`. Запустіть його вказавши в консолі шлях до файла. В виводі нижче показано запуск в Linux-дистрибутиві:  

<details>
  <summary><u>Запуск файла <code>hello</code></u></summary>

```
[user@user ~]$ ./out/hello
Hello World!

```

</details>


Повторіть ввід фрази `will .build`:

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::compileCpp / build::compile
  Built module::compileCpp / build::compile in 0.495s

```  
</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
compileCpp
        ├── file
        │     ├── hello
        │     ├── hello.c
        │     ├── hello.o
        │     ├── main.c
        │     └── main.o
        └── .will.yml

```

</details>

На відміну від попереднього виконання команди, утиліта не провела компіляцію файлів в новий, оскільки файли `hello.с` i `main.с` не змінились. Як і утиліта `make` `willbe` слідкує за змінами файлів.  
Процес побудови був розбитий на частини, а після побудови залишились тимчасові файли, які потрібно видалити - зайва робота. Внесіть в секцію `build` мультизбірку, яка виконає всі операції за один запуск побудови та в секцію `step` крок для видалення тимчасових файлів:  

<details>
  <summary><u><code>Will-файл</code> зі змінами в секціях <code>build</code> i <code>step</code></u></summary>

```yaml
about :
  name : 'compileCpp'
  description : 'To use willbe as make'
  version : 0.0.1

path :

  in : '.'
  file : 'file'

reflector :
  
  compile :
    filePath :
      '*.c' : 1
      path::file : 1
    src :
      prefixPath : 'file'
    dst :
      filePath : path::file

  build :
    filePath :
      '*.o' : 1
      '*.c' : 0
      path::file : 1
    src :
      prefixPath : 'file'
    dst :
      filePath : path::file
    shell : gcc-6 -o {f::this/dst}/hello {f::this/src}    

step :

  compile :
    shell : gcc-6 -c {f::this/src}
    currentPath : path::file
    forEachDst : compile
    upToDate : preserve
  
  clean.temp :
    inherit: predefined.shell
    shell : rm -Rf *.o
    currentPath : path::file

build :

  compile :
    criterion :
      default : 1
    steps :
      - step::compile

  make.hello :
    steps :
      - step::build
  
  all :
    steps :
      - compile
      - make.hello
      - clean.temp

```

</details>

Крок `clean.temp` видаляє об'єктні файли в директорії `file`.
Видаліть зайві файли та виконайте побудову збірки `all`:  

<details>
  <summary><u>Вивід команди <code>will .build all</code></u></summary>

```
[user@user ~]$ will .build all
...
  Building module::compileCpp / build::all
 > gcc-6 -c /path_to_file/temp/hello.c /path_to_file/temp/main.c
 ...
 > gcc-6 -o hello /path_to_file/temp/hello.o /path_to_file/temp/main.o
 > rm -Rf *.o
  Built module::compileCpp / build::all in 3.772s


```  

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
compileCpp
        ├── file
        │     ├── hello
        │     ├── hello.c
        │     └── main.c
        └── .will.yml

```

</details>

Всі незручності попередніх етапів усунено при збереженні результату.  

### Підсумок
- Утиліта `willbe` агрегує можливості операційної системи, зовнішніх програм і власних інструментів для автоматизації процесів розробки, в тому числі, створення виконуваних файлів.  
- З допомогою рефлекторів утиліти можна здійснити вибірку файлів компіляції за багатьма параметрами, що робить вимоги до структури файлів менш жорсткими.
- Утиліта слідкує за зміною файлів. Якщо вхідні і вихідні файли залишились без змін, то повторні операції з файлами (компіляція, об'єднання) не виконуються.

[Повернутись до змісту](../README.md#tutorials)
