# Використання <code>JavaScript</code> файлів утилітою <code>willbe</code></a></summary>

Як використовувати <code>JavaScript</code> файли в утиліті <code>willbe</code> для виконання складних сценаріїв побудови.

Для виконання деяких функцій побудови модуля, зручніше використовувати зовнішні програми і скрипти. Для цієї мети в утиліті `willbe` використовуються JavaScript файли.   
Створіть директорію `jsUsing` наступної конфігурації:  

<details>
  <summary><u>Структура модуля</u></summary>

```
jsUsing
   ├── index.js
   └── .will.yml

```

</details>

В кожен із файлів внесіть відповідний код:

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
    console.log('Hello, world!')
}

module.exports = hello;

```

</details>

`Willbe` працює лише з експортованими функціями JS-файла тому, функція `hello` експортована.  

Запустіть білд:  

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

Є інший шлях запустити як JS файли, так і інші - використовувати вбудований крок `predefined.shell` для запуску з командного рядку. Цей спосіб більш універсальний, використовуйте який відповідає вашим задачам.

### Підсумок
- `Willbe` може запускати JavaScript файли і використовувати їх в побудові модуля.
- `Willbe` виконує експортовані функції JavaScript файла.

[Повернутись до змісту](../README.md#tutorials)
