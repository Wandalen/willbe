# Перегляд файлів модуля

Як користуватись вбудованим кроком `predefined.view` для перегляду файлів   

В процесі і після побудови модуля, зазвичай, потрібно перевірити правильність виконання операцій. Одним із способів є запуск файлів в програмі для їх виконання, редагування, перегляду. При побудові модуля запуск файла можна здійснити використавши вбудований крок `predefined.shell`, що потребує визначення програми, яка відкриє файл. До того ж, використання кроку `predefined.shell` в утиліті `willbe` є синхронним, тобто, утиліта, відкривши файл, зупинить виконання побудови модуля до моменту закриття файла. Для вирішення задачі в утиліті є вбудований крок `predefined.view`, який призначений для асинхронного запуску файлів в програмі, що використовується операційною системою за замовчуванням.  

### Конфігурація 
Для дослідження вбудованого кроку `predefined.view`, створіть структуру файлів як приведено нижче та внесіть в файли код:  


<details>
  <summary><u>Структура модуля та код файлів <code>.will.yml</code>, <code>hello.html</code>,<code>hello.txt</code></u></summary>

```
viewStep
    ├── file
    │     ├── hello.html
    │     └── htllo.txt
    └── .will.yml

```

<p>Код <code>.will.yml</code></p>

```yaml
about :

  name : viewStep
  description : "To use predefined.view step"
  version : 0.0.1

path :
  in : '.'
  html : './file/hello.html'
  txt : './file/hello.txt'

step : 

  shell.open :
    shell : xedit {path::txt}

  view.html :
    inherit : predefined.view
    filePath : path::html
    delay : 1000
  
  view.txt :
    inherit : predefined.view
    filePath : path::txt
    delay : 1  

build :
  
  sync :
    criterion :
      default : 1
    steps :
      - step::shell.open
      - step::view.html
      - step::view.txt

  async :
    steps :
      - step::view.html
      - step::view.txt
      - step::shell.open

```

<p>Код <code>hello.html</code> i <code>hello.txt</code></p>

```yaml
<html>
<header>
  <title>Test page</title>
</header>
<body>
  <h1>Hello, world!</h1>
</body>
</html>

```

</details>

В файлі 