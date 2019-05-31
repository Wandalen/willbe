# Компіляція С програми

Використання утиліти <code>willbe</code> для компіляції С програми.

Однією із задач при програмуванні є перетворення одного типу файлів в інший, для виконання якої існує велика кількість різних програм і утліт. Ви вже ознайомились з [транспіляцією в `willbe`](StepTranspile.md) - використовуючи вбудовані інструменти, утиліта перетворила групу `JavaScript`-файлів в єдиний. В цьому туторіалі показано як з допомогою `willbe` можна побудувати виконуваний файл.

### Програма `Hello World!` на C
### Конфігурація  

Для перетворення вихідних файлів в виконувані використовуються компілятори. Компілятори не мають функцій для слідкування за файлами і файловими зв'язками тому, цю задачу виконують сторонні утиліти. В Linux-дистрибутивах в якості такої утиліти, переважно, використовується [`make`](https://en.wikipedia.org/wiki/Make_%28software%29). Утиліта `willbe` пропонує власні інструменти для автоматизації перетворення файлів.   

<details>
  <summary><u>Файлова структура</u></summary>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     └── main.c
        └── .will.yml

```

</details>

Побудуйте структуру файлів для компіляції виконуваного файла, яка приведена вище.

В файлах `hello.c` i `main.c` поміщається вихідний код програми. Для автоматизації перетворення вихідного коду в виконуваний файл використовується `вілфайл`.  

<details>
  <summary><u>Код файлa <code>hello.c</code></u></summary>

```c
#include<stdio.h>

void hello()
{
	printf( "Hello, World!\n" );
}

```

</details>

В файлі `hello.c` поміщена функція виводу рядка "Hello, World!" в консоль.

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

Файл `main.c` містить виклик функції `hello()`, котра розміщена в файлі `hello.c`. В цьому файлі використовується властивість мови С, що дозволяє неявно об'явити функцію, котра буде додана при компіляції виконуваного файла.

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
    shell : gcc -o {f::this/dst}/hello {f::this/src}    

step :

  compile :
    shell : gcc -c {f::this/src}
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

Процес створення виконуваних файлів має два етапи: 
- перший - створення об'єктних файлів з вихідних в збірці `compile`;
- другий - об'єднання об'єктних файлів в виконуваний в збірці `make.hello`.     
Результуюча скомпільована програма повинна вивести фразу `Hello World!` в консоль.

### Компіляція в виконуваний файл  

Виклик компілятора проходить в кроках `compile` i `build`:  

<details>
  <summary><u>Секція <code>step</code></u></summary>

```yaml
step :

  compile :
    shell : gcc -c {this::src}
    currentPath : path::file
    forEachDst : compile
    upToDate : preserve

```

</details>

В прикладі, компіляція вихідних файлів здійснюється з допомогою `gcc`-компілятора (за необхідності, встановіть [gcc](http://gcc.gnu.org/). Ви можете використовувати інший компілятор замінивши рядки `gcc -c {f::this/src}` i `gcc -o {f::this/dst}/hello {f::this/src}` на команди встановленого компілятора.

Компіляція проходить в директорії `file` і кожнен скомпільований файл поміщається в директорію визначену полем `dst` рефлектора `compile`.  
Полем `upToDate` встановлюється можливість повторного запуску команди над файлами. При значенні `preserve` утиліта не виконує крок, якщо файли не змінились з попередньої побудови, а при значенні `rebuild` виконує побудову незалежно від змін у файлах.

Відмінність кроку `build` в тому, що він виконує об'єднання об'єктних файлів в виконуваний. Крок `build` визначений неявно, він генерується утилітою згідно назви рефлектора і вказаного поля `shell`.   

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

Запустіть побудову збірки `compile`, перевірте директорію `file` після побудови.

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

Компіляція пройшла успішно і в директорії з вихідними файлами з'явились об'єктні. 

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

Виконайте побудову збірки `make.hello`.

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

Компілятор згенерував виконуваний файл `hello` в директорії `file`. Запустіть його вказавши в консолі відносний шлях до файла. В виводі нижче показано запуск відносно директорії `вілфайла`:  

<details>
  <summary><u>Запуск файла <code>hello</code></u></summary>

```
[user@user ~]$ ./file/hello
Hello, World!

```

</details>

При створенні виконуваного файла компілятор додав об'явлену функцію `hello()` тому, в виводі консолі отримано відповідний рядок.

### Повторна побудова

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::compileCpp / build::compile
  Built module::compileCpp / build::compile in 0.495s

```  
</details>

Повторіть компіляцію файлів виконавши ввід команди `will .build`.

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

### Мультизбірка компіляції вихідного файла

Процес побудови був розбитий на частини, а після побудови залишились тимчасові файли, які потрібно видалити. Цих недоліків можна позбутись створивши комплесний сценарій побудови.

<details>
  <summary><u><code>Вілфайл</code> зі змінами в секціях <code>build</code> i <code>step</code></u></summary>

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
    inherit: shell.run
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

Внесіть в секцію `step` крок `clean.temp` для видалення об'єктних файлів в директорії `file` після побудови, а в секцію `build` мультизбірку, яка виконає всі операції. Код з указаними змінами приведений вище.

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

Видаліть зайві файли командою `rm hello.o main.o hello`, після цього змініть вихідні файли, щоб програма прочитала їх як нові. Виконайте побудову збірки `all`.  

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

Всі незручності попередніх етапів усунено. Весь цикл створення виконуваного файла здійснено за одну побудову.  

### Підсумок

- Утиліта `willbe` агрегує можливості операційної системи, зовнішніх програм і власних інструментів для автоматизації процесів розробки, в тому числі, компіляції виконуваних файлів.  
- З допомогою рефлекторів утиліти можна здійснити вибірку файлів компіляції за багатьма параметрами, що робить вимоги до структури файлів менш жорсткими.
- Утиліта слідкує за зміною файлів. Якщо вхідні і вихідні файли залишились без змін, то повторні операції з файлами (компіляція, об'єднання) не виконуються.

[Повернутись до змісту](../README.md#tutorials)
