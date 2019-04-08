# Компіляція програм з утилітою `willbe`

Використання утиліти для компіляції файлів

Однією із задач при програмуванні є перетворення одного типу файлів в інший, для виконання якої існує велика кількість різних програм і утліт. З транспіляцією ви ознайомились в туторіалі ["Транспіляція файлів"](TranspileStep.md) - використовуючи вбудовані інструменти, утиліта перетворила групу JavaScript-файлів в єдиний, а при реліз-побудові додатково його оптимізувала. В цьому туторіалі показано як `willbe`, агрегуючи можливості операційної системи, зовнішніх програм і вбудованих інструментів, побудує виконуваний файл.

### Програма `Hello World!` на C. Конфігурація  
Для перетворення вихідних файлів в виконувані використовуються компілятори. Компілятори не мають інструментів для слідкування за файлами і файловими зв'язками тому, цю задачу виконують сторонні утиліти. Якщо говорити про Linux-дистрибутиви, то в якості такої утиліти, переважно, використовується `make` (<https://en.wikipedia.org/wiki/Make_%28software%29>). Утиліта `willbe` пропонує власні інструменти для автоматизації перетворення файлів.  
Побудуйте структуру файлів для компіляцію виконуваного файла:  

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
  final : 'out'
  file : 'file'
  temp : 'temp'

reflector :

  copy.temp :
    filePath :
      '*.c' : 1
      path::file : path::temp
  
  copy.out :
    filePath :
      '*.*' : 0
      path::temp : path::final
  
  compile :
    filePath :
      '*.c' : 1
    src :
      prefixPath : 'temp'

  build :
    filePath :
      '*.o' : 1
      '*.c' : 0
      path::temp : 1

step :

  compile :
    shell : gcc-6 -c {this::src}
    currentPath : path::temp
    forEachDst : compile
    upToDate : preserve
  
  build :
    shell : gcc-6 -o hello {this::src}
    currentPath : path::temp
    forEachDst : build
    upToDate : preserve

build :

  compile :
    criterion :
      default : 1
    steps :
      - step::copy.temp
      - step::compile

  build.hello :
    steps :
      - step::build
      - step::copy.out

```

</details>

Процес створення виконуваних файлів має два етапи: перший - створення об'єктних файлів з вихідних; другий - об'єднання об'єктних файлів в виконуваний.  
В `will-файлі` проходить таке розділення операцій побудови модуля:  
\- збірка `compile` виконує копіювання файлів з розширенням `.c` в тимчасову директорію `temp`, де проходить їх компіляція - крок для розділення директорії вихідних файлів і директорії побудови. Завдяки  налаштуванням рефлекторів відбір можна здійснити по багатьом параметрам (туторіали ["Фільтри рефлектора"](ReflectorFilters.md), ["Часові фільтри рефлектора"](ReflectorTimeFilters.md), ["Формування шляхів в рефлекторі. Управління файловими операціями"](ReflectorFSControl.md));  
\- збірка `build.hello` об'єднує об'єктні файли в виконуваний і копіює результат в директорію `out` ресурса `final`.  
Результуюча скомпільована програма повинна вивести фразу `Hello World!` в консоль. 

### Компіляція в виконуваний файл  
Виклик компілятора проходить в кроках `compile` i `build`:  

<details>
  <summary><u>Секція <code>step</code></u></summary>

```yaml
step :

  compile :
    shell : gcc-6 -c {this::src}
    currentPath : path::temp
    forEachDst : compile
    upToDate : preserve
  
  build :
    shell : gcc-6 -o hello {this::src}
    currentPath : path::temp
    forEachDst : build
    upToDate : preserve

```

</details>

Крок `compile` виконує компіляюцію вихідних файлів з допомогою компілятора `gcc` шостої версії (за необхідності, встановіть [gcc](http://gcc.gnu.org/) і змініть команду в полі `shell` відповідно до версії компілятора). Компіляція проходить в директорії `temp` і здійснюється для кожного елемента згідно рефлектора `compile`. Полем `upToDate` задається функція слідкування за змінами файлів в директорії. Відмінність кроку `build` в тому, що він виконує об'єднання об'єктних файлів в виконуваний.   
Запустіть побудову збірки `compile`, перевірте директорію `temp` після побудови:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building module::compileCpp / build::compile
   + copy.temp reflected 3 files /path_to_file/ : temp <- file in 0.490s
 > gcc-6 -c /path_to_file/temp/hello.c /path_to_file/temp/main.c
/path_to_file/temp/main.c: In function ‘main’:
/path_to_file/temp/main.c:3:2: warning: implicit declaration of function ‘hello’ [-Wimplicit-function-declaration]
  hello();
  ^~~~~
  Built module::compileCpp / build::compile in 0.974s

```

<p>Модуль після побудови</p>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     └── main.c
        ├── temp
        │     ├── hello.c
        │     ├── hello.o
        │     ├── main.c
        │     └── main.o
        └── .will.yml

```

</details>

Компіляція пройшла успішно, компілятор видав попередження про виклик функції, яку явно не вказано в файлі.  
Виконайте побудову збірки `build.hello`:  

<details>
  <summary><u>Вивід команди <code>will .build build.hello</code></u></summary>
    
```
[user@user ~]$ will .build build.hello
...
  Building module::compileCpp / build::build.hello
 > gcc-6 -o hello /path_to_file/hello.o /path_to_file/temp/main.o
   + copy.out reflected 2 files /path_to_file/ : out <- temp in 0.412s
  Built module::compileCpp / build::build.hello in 1.057s
  
```  

<p>Модуль після побудови</p>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     └── main.c
        ├── out
        │     └── hello
        ├── temp
        │     ├── hello
        │     ├── hello.c
        │     ├── hello.o
        │     ├── main.c
        │     └── main.o
        └── .will.yml

```

</details>

В директорії `out` поміщено виконуваний файл `hello`. Запустіть його вказавши в консолі повний шлях до файла. В виводі нижче показано запуск в Linux-дистрибутиві:  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>
    
```
[user@user ~]$ /home/user/Documents/test/compileCpp/out/hello 
Hello World!

```

</details>


Повторіть ввід фрази `will .build build.hello`:

<details>
  <summary><u>Вивід команди <code>will .build build.hello</code></u></summary>
    
```
[user@user ~]$ will .build build.hello
...
  Building module::compileCpp / build::build.hello
   + copy.out reflected 2 files /path_to_file/ : out <- temp in 0.388s
  Built module::compileCpp / build::build.hello in 0.999s
  
```  

<p>Модуль після побудови</p>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     └── main.c
        ├── out
        │     └── hello
        ├── temp
        │     ├── hello
        │     ├── hello.c
        │     ├── hello.o
        │     ├── main.c
        │     └── main.o
        └── .will.yml

```

</details>

На відміну від попереднього виконання команди, утиліта не провела об'єднання файлів в новий оскільки файли `hello.o` i `main.o` не змінились. Як і утиліта `make` `willbe` слідкує за змінами файлів.  
Процес побудови був розбитий на частини, а після побудови залишилась директорія з тимчасовими файлами - зайва робота. Внесіть в секцію `build` мультизбірку, яка виконає всі операції за один запуск побудови:  

<details>
  <summary><u><code>Will-файл</code> зі змінами в секції <code>build</code> після змін</u></summary>

```yaml
about :
  name : 'compileCpp'
  description : 'To use willbe as make'
  version : 0.0.1

path :

  in : '.'
  final : 'out'
  file : 'file'
  temp : 'temp'

reflector :

  copy.temp :
    filePath :
      '*.c' : 1
      path::file : path::temp
  
  copy.out :
    filePath :
      '*.*' : 0
      path::temp : path::final
  
  compile :
    filePath :
      '*.c' : 1
    src :
      prefixPath : 'temp'

  build :
    filePath :
      '*.o' : 1
      '*.c' : 0
      path::temp : 1

step :

  compile :
    shell : gcc-6 -c {this::src}
    currentPath : path::temp
    forEachDst : compile
    upToDate : preserve
  
  build :
    shell : gcc-6 -o hello {this::src}
    currentPath : path::temp
    forEachDst : build
    upToDate : preserve

build :

  compile :
    criterion :
      default : 1
    steps :
      - step::copy.temp
      - step::compile

  build.hello :
    steps :
      - step::build
      - step::copy.out
  
  all :
    steps :
      - build::compile
      - build::build.hello
      - clean

```

</details>

Вбудований крок `clean` видаляє завантажені підмодулі, тимчасові файли в ресурсі `temp` та експортовані файли модуля в ресурсі `out` (відсутні в модулі).
Видаліть зайві файли (`rm -Rf temp/ out/`) та виконайте побудову збірки `all`:  

<details>
  <summary><u>Вивід команди <code>will .build all</code></u></summary>
    
```
[user@user ~]$ will .build all
...
  Building module::compileCpp / build::all
   + copy.temp reflected 3 files /path_to_file/ : temp <- file in 0.652s
 > gcc-6 -c /path_to_file/temp/hello.c /path_to_file/temp/main.c
/path_to_file/temp/main.c: In function ‘main’:
/path_to_file/temp/main.c:3:2: warning: implicit declaration of function ‘hello’ [-Wimplicit-function-declaration]
  hello();
  ^~~~~
 > gcc-6 -o hello /path_to_file/temp/hello.o /path_to_file/temp/main.o
   + copy.out reflected 2 files /path_to_file/ : out <- temp in 0.463s
   - Clean deleted 6 file(s) in 0.138s
   - Clean deleted 0 file(s) in 0.094s
  Built module::compileCpp / build::all in 3.772s

  
```  

<p>Модуль після побудови</p>

```
compileCpp
        ├── file
        │     ├── hello.c
        │     └── main.c
        ├── out
        │     └── hello
        └── .will.yml

```

</details> 

Всі незручності попередніх етапів усунено при збереженні результату і високій безпеці побудови файла.  

### Підсумок
- Утиліта `willbe` агрегує можливості операційної системи, зовнішніх програм і власних інструментів для автоматизації процесів розробки, в тому числі, створення виконуваних файлів.  
- З допомогою рефлекторів утиліти можна здійснити вибірку файлів за багатьма параметрами, що робить вимоги до структури файлів менш жорсткими.
- Утиліта слідкує за зміною файлів. Якщо вхідні і вихідні файли залишились без змін, то повторні операції з файлами (компіляція, об'єднання) не виконуються. 

[Повернутись до змісту](../README.md#tutorials)