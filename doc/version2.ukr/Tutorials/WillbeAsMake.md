# Компіляція програм з утилітою `willbe`

Використання утиліти для компіляції файлів

В туторіалах [Побудова модуля командою `.build`](ModuleCreationByBuild.md), [Розділені `will-файли`](SplitWillFile.md), [Перелік ресурсів через командний рядок](HowToList.md) приводились приклади застосування утиліти `willbe` як такої, що використовує можливості інших програм для поліпшення роботи програмістів. Однією із задач при програмуванні на компільованих мовах є компіляція вихідних файлів в виконуваний.


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
