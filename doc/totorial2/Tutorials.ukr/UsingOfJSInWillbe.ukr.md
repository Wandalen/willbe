# Використання JavaScript файлів пакетом willbe

В туторіалі показано як використовувати JavaScript-скрипти в пакеті `willbe`

Для виконання деяких функцій системи, зручніше використовувати побудову скриптів і програм іншими мовами програмування. В пакеті `willbe` такою мовою програмування є JavaScript. Скажімо, потрібно виконати декілька таких програм і ви по черзі їх запускаєте в інтерпретаторі, але ж автоматизувати виконання програм в `willbe` простіше.  
Створимо `.will.yml` для запуску JS-скрипта.
<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

```yaml
about :

  name : usingJS
  description : "To use JS in willbe"
  version : 0.0.1

path :

  js.path :
    path : 'index.js'

step  :

  run.js :
      js : path::js.*

build :

  run.js :
      criterion :
          default : 1
      steps :
          - run.*

```

</details>

Додамо JS-файл з назвою `index.js`

<details>
    <summary><u><em>Лістинг `index.js`</em></u></summary>

```js
function hello(){
    console.log('Hello, world!')
}

module.exports = hello;

```

</details>

Ми експортували функцію `hello`, оскільки `willbe` працює лише з експортованими функціями JS-файла.  
Після створення файлів директорія матиме вигляд:

```
.
├── index.js
├── .will.yml

```

Запустіть білд:

```
[user@user ~]$ will .build
...
  Building run.js
Hello, world!
  Built run.js in 0.057s

```

Є інший шлях запустити файли як JS, так і інших інтерпретаторів і компіляторів - використовувати командний рядок.  
У вас встановлений NodeJS тому, змінимо секцію `step`:

```yaml
step  :

  run.js :
      shell : node index.js

```

та файл `index.js`:

```js
var hello = 'Hello, world!';
console.log(hello);

```

Запустимо побудову:

```
[user@user ~]$ will .build
...
  Building run.js
 > node index.js
Hello, world!
  Built run.js in 0.224s

```
Другий спосіб запускати файли більш універсальний, використовуйте який відповідає вашим задачам.

- `Willbe` безпосередньо працює з JavaScript-файлами, але може виконувати будь-які файли з допомогою стороннього програмного забезпечення.

[Наступний туторіал]()  
[Повернутись до змісту](../README.md#tutorials)