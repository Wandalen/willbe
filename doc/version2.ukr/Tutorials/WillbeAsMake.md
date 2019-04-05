# Компіляція програм з утилітою `willbe`

Використання утиліти для компіляції файлів

В туторіалах ["Побудова модуля командою `.build`"](ModuleCreationByBuild.md), ["Розділені `will-файли`"](SplitWillFile.md), ["Перелік ресурсів через командний рядок"](HowToList.md) приводились приклади застосування утиліти `willbe` як такої, що використовує можливості інших програм для автоматизації роботи програмістів.  
Однією із задач при програмуванні є перетворення одного типу файлів в інший, для виконання якої існує велика кількість різних програм і утліт. З транспіляцією ви ознайомились в туторіалі ["Транспіляція файлів"](TranspileStep.md) - з допомогою вбудованих інструментів утиліта перетворила групу JavaScript-файлів в єдиний, а при реліз-побудові додатково його оптимізувала, в цьому туторіалі буде показано, як утиліта побудує виконуваний файл з допомогою сторонніх програм.

### Програма `Hello World!` на C. Конфігурація  
Для перетворення вихідних файлів в виконувані використовуються компілятори, а автоматизація перетворення проходить з допомогою сторонніх утиліт. Якщо говорити про Linux-дистрибутиви, то в якості такої утиліти, переважно, використовується `make` (<https://en.wikipedia.org/wiki/Make_%28software%29>).  
Побудуйте структуру файлів для використання `willbe` в автоматичній побудові виконуваного файла:  

<details>
  <summary><u>Структура файлів</u></summary>

```
compileCProgram
        ├── file
        │     ├── hello.c
        │     └── main.c
        └── .will.yml

```

</details>

В кожен із файлів внесіть відповідний код:  

<details>
  <summary><u>Код файлів <code>hello.c</code>, <code>main.c</code> i <code>.will.yml</code></u></summary>
    
<p>Код <code>hello.c</code></p>

```c
#include <stdio.h>
void hello()
{
	printf("Hello World!\n");
}

```

<p>Код <code>main.c</code></p>

```c
int main()
{
	hello();
	return 0;
}

```

<p>Код <code>.will.yml</code></p>

```yaml
about :

  name : 'compileCProgram'
  description : 'To use willbe as make'
  version : 0.0.1

path :

  in : '.'
  out : 'out'
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
      path::temp : path::out
  
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
    shell : gcc-6 -c {this::dst} {this::src}
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

Програма на С виводить фразу `Hello World!` в консоль при її запуску. Для створення виконуваного файла спочатку створюються об'єктні, а потім вони об'єднуються в виконуваний. В `will-файлі` проходить таке розділення операцій:  
\- збірка `compile` виконує копіювання файлів з розширенням `.c` в тимчасову директорію `temp`, де проходить їх компіляція - крок для розділення директорії вихідних файлів і директорії побудови, завдяки  налаштуванням рефлекторів відбір можна здійснити по багатьом параметрам (туторіали ["Фільтри рефлектора"](ReflectorFilters.md), ["Часові фільтри рефлектора"](ReflectorTimeFilters.md), ["Формування шляхів в рефлекторі. Управління файловими операціями"](ReflectorFSControl.md));  
\- збірка `build.hello` об'єднує об'єктні файли в виконуваний і копіює результат в директорію `out`.  
Для виконання побудови потрібно мати встановлений в операційну систему компілятор `gcc`. В прикладі використовується компілятор `gcc-6`


```
[user@user ~]$ will .build
...
  Building module::compileCProgram / build::compile
   + copy.temp reflected 3 files /path_to_file/ : temp <- file in 0.490s
 > gcc-6 -c /path_to_file/temp/*.c /path_to_file/temp/hello.c /path_to_file/temp/main.c
/path_to_file/temp/main.c: In function ‘main’:
/path_to_file/temp/main.c:3:2: warning: implicit declaration of function ‘hello’ [-Wimplicit-function-declaration]
  hello();
  ^~~~~
/path_to_file/temp/main.c: In function ‘main’:
/path_to_file/temp/main.c:3:2: warning: implicit declaration of function ‘hello’ [-Wimplicit-function-declaration]
  hello();
  ^~~~~
  Built module::compileCProgram / build::compile in 1.031s

[user@user ~]$ will .build make2
...

  Building module::compileCProgram / build::make2
 > gcc-6 -o hello.s /path_to_file/temp/hello.o /path_to_file/temp/main.o
   + copy.out reflected 2 files /path_to_file/ : out <- temp in 0.412s
  Built module::compileCProgram / build::make2 in 1.071s



[user@user ~]$ will .build
...
Building module::compileCProgram / build::make2
   + copy.out reflected 2 files /path_to_file/ : out <- temp in 0.380s
  Built module::compileCProgram / build::make2 in 1.020s
  
```

dmytry@dmytry:~/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/Wil$ will .build build
Command ".build build"
 . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/WillbeAsMake/.will.yml
 . Read 1 will-files in 0.561s 

  Building module::compileCProgram / build::build
 > gcc-6 -o hello /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/WillbeAsMake/temp/hello.o /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/WillbeAsMake/temp/main.o
   + copy.out reflected 2 files /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/WillbeAsMake/ : out <- temp in 0.412s
  Built module::compileCProgram / build::build in 1.057s

dmytry@dmytry:~/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/Wil$ will .build build
Command ".build build"
 . Read : /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/WillbeAsMake/.will.yml
 . Read 1 will-files in 0.567s 

  Building module::compileCProgram / build::build
   + copy.out reflected 2 files /home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe_src/pract2/WillbeAsMake/ : out <- temp in 0.388s
  Built module::compileCProgram / build::build in 0.999s


