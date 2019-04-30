# Команди оновлення, апгрейду та очищення підмодулів

Команди оновлення підмодулів, апгрейду підмодулів автоматизовним перезаписом <code>вілфайла</code> та очищення модуля.

### Команда `.submodules.clean`    

Для видалення підмодулів з директорією `.module` використовуйте команду `will .submodules.clean`.

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 551 file(s) in 1.753s

```

</details>

<details>
  <summary><u>Файлова структура після видалення підмодулів</u></summary>

```
submodulesCommands
        ├── submodulesFixate
        │           └── .will.yml
        └── submodulesUpgrade
                    └── .will.yml    

```

</details>

Введіть в директорії `submodulesFixate` команду `will .submodules.clean`.

### Підсумок

- `Willbe` виконує операції з віддаленими підмодулями з командної оболонки системи.  
- Команда `.submodules.fixate` -  фіксує версію віддаленого підмодуля, а команда `.submodules.upgrade` оновлює ресурси `вілфайла` до останньої версії віддаленого підмодуля.  
- Використання команд `.submodules.fixate` i `.submodules.upgrade` разом з командою `.submodules.update`, розділяє оновлення підмодулів на два етапи - оновлення посилань і завантаження підмодулів, що забезпечує безпечне оновлення підмодулів і надійність роботи модуля.   
- Команда `.submodules.clean` очищає модуль від завантажених підмодулів разом з директорією `.module`.

[Повернутись до змісту](../README.md#tutorials)
