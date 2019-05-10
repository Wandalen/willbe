# Використання <code>JavaScript</code> файлів утилітою <code>willbe</code>

Як використовувати <code>JavaScript</code> файли в утиліті <code>willbe</code> для виконання складних сценаріїв побудови.

Для виконання деяких особливих дій над модулем, зручніше використовувати зовнішні програми і скрипти. Для запуску зовнішніх програм в утиліті використовується вбудований крок `shell.run`. Якщо ж говорити про скрипти, то для цієї мети в утиліті `willbe` використовуються вбудований крок `js.run` та JavaScript файли.   

### Використання JavaScript файлів. Конфігурація 

<details>
  <summary><u>Структура модуля</u></summary>

```
jsUsing
   ├── index.js
   └── .will.yml

```

</details>

Створіть директорію `jsUsing` з приведеною конфігурацією. В кожен із файлів внесіть відповідний код. 

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : usingJS
  description : "To use JS in willbe"
  version : 0.0.1

path :

  js.path :
    path : 'index.js'

step  :

  use.js :
    js : path::js.*

build :

  run.js :
    criterion :
      default : 1
    steps :
      - run.*

```

</details>
<details>
    <summary><u>Код файла <code>index.js</code></u></summary>

```js
function hello(){
  console.log('Hello, world!');
}

module.exports = hello;

```

</details>

В кроці `use.js` використовується вбудований крок `js.run`. Вбудований крок записано без явного указання [наслідування](ResourceInheritance.md) в полі `inherit`. Це можливо тому, що поле `js` присутнє тільки в цьому [вбудованому кроці](../concept/ResourceStep.md). 

В полі `js` вбудованого кроку `js.run` вказуються шляхи до JS-файлів, які будуть виконані. Для того, щоб функція була виконана при побудові, вона повинна бути експортованою. Тому, функція `hello` в файлі `index.js` експортована.    

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
  Building run.js
Hello, world!
  Built run.js in 0.057s

```

</details>

Запустіть побудову командою `will .build` та порівняйте вивід з приведеним вище. 

Збірка `run.js` з кроком `use.js` успішно виконала функцію `hello` та вивела фразу в консоль. 

Також, ви можете використовувати зовнішні програми для запуску як JS файлів, так і інших файлів, з допомогою вбудованого кроку `shell.run`.  

### Підсумок

- `Willbe` може запускати JavaScript файли і використовувати їх в побудові модуля.
- `Willbe` виконує експортовані функції JavaScript файла.

[Повернутись до змісту](../README.md#tutorials)
