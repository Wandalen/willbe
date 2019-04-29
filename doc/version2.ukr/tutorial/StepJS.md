# Використання <code>JavaScript</code> файлів утилітою <code>willbe</code>

Як використовувати <code>JavaScript</code> файли в утиліті <code>willbe</code> для виконання складних сценаріїв побудови.

Для виконання деяких функцій побудови модуля, зручніше використовувати зовнішні програми і скрипти. Для цієї мети в утиліті `willbe` використовуються JavaScript файли.   

### Використання JavaScript файлів. Конфігурація 

<details>
  <summary><u>Структура модуля</u></summary>

```
jsUsing
   ├── index.js
   └── .will.yml

```

</details>

Створіть директорію `jsUsing` з приведеною конфігурацією.

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
<details>
    <summary><u>Код файла <code>index.js</code></u></summary>

```js
function hello(){
  console.log('Hello, world!');
}

module.exports = hello;

```

</details>

В кожен із файлів внесіть відповідний код. 

В `will-файлі` використовується вбудований крок `predefined.js`, який записано без явного указання наслідування (`inherit : predefined.js`), оскыльки поле `js` присутнє тільки в цьому вбудованому кроці.  В полі `js`  кроку вказуються шляхи до JS-файлів, які будуть виконані. `Willbe` працює лише з експортованими функціями JS-файла тому, функція `hello` в файлі `index.js` експортована.    

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

Запустіть побудову та перевірте вивід.

Утиліта успішно виконала вивід фрази з файлу `index.js`. Також, ви можете використовувати зовнішні програми для запуску як JS файлів, так і інших файлів, з допомогою вбудованого кроку `predefined.shell`.  

### Підсумок

- `Willbe` може запускати JavaScript файли і використовувати їх в побудові модуля.
- `Willbe` виконує експортовані функції JavaScript файла.

[Повернутись до змісту](../README.md#tutorials)
