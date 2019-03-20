# Вбудовані кроки пакета willbe

Керівництво користувача по вбудованим крокам для побудови модуля

### Зміст  
[Вбудовані кроки](#predefined-steps)  
[Приклади запису вбудованих кроків:](#examples)  
\- [Функція `predefined.delete`](#predefined-delete)  
\- [Функція `predefined.reflect`](#predefined-reflect)  
\- [Функція `predefined.js`](#predefined-js)  
\- [Функція `predefined.shell`](#predefined-shell)  
\- [Функція `predefined.export`](#predefined-export)  
\- [Функції, що вносяться в секцію `build`](#in-steps-build) 
 
<a name="predefined-steps"></a>  
### Вбудовані кроки  
Вбудовані функції пакета покликані спростити процес створення модуля. Вбудовані кроки `willbe` передбачені для функцій, які найчастіше використовуються при створенні модуля.  

| Вбудований крок      | Опис                                                 | Структура полів (unique)        |
|----------------------|------------------------------------------------------|--------------------------------|
| predefined.delete    | Для видалення файлів і директорій за вказаним шляхом | filePath                       |
| predefined.reflect   | Виконує виклик рефлектора                            | reflector, verbosity           |
| timelapse.begin      | (ред.)                                               | -                               |
| timelapse.end        | (ред.)                                               | -                               |
| predefined.js        | Виконання JavaScript-файлів                          | js; (js)                       |
| predefined.shell     | Використання командної оболонки операційної системи  | shell, currentPath; (shell) |
| predefined.concat.js | (ред.)                                               | reflector                       |
| submodules.download  | Завантаження підмодулів                              | -                               |
| submodules.upgrade   | Оновлення підмодулів                                 | -                               |
| submodules.clean     | Очищення підмодулів                                  | -                               |
| clean                | Видалення з директорії в якій знаходиться модуль 3-х типів файлів 1) завантажені підмодулі (папка `./.module`); 2) out дерикторія; 3) path::temp дерикторія, якщо вона прописана в will-файлі                                                        | -                               |
| predefined.export    | Для виконання експорту модуля                        | export, tar; (export)           |  

В третій колонці в дужках вказано `unique` - при наявності цієї опції достатньо вказати зазначене поле для виконання кроку.  

Для використання вбудованих кроків потрібно внести їх в ресурс секції `step`. Вбудовані кроки `submodules.download`, `submodules.upgrade`, `submodules.clean`, `clean` вносяться в секцію `build` (в полі `steps`).

### <a name="examples"></a> Приклади запису вбудованих кроків  
> Всі вказані приклади записані без критеріонів. Критеріони додаються згідно правил використання.  

<a name="predefined-delete"></a> Функція `predefined.delete`:

```yaml
step:                                   # Назва секції
  predefined:                           # Назва кроку
    inherit: predefined.delete          # Наслідування вбудованого кроку видалення файлів
    filePath: path::fileToDelete        # Файл чи директорія 'fileToDelete' в секції 'path'

```

<a name="predefined-reflect"></a> Функція `predefined.reflect`:

```yaml
step:                                         # Назва секції
  predefined:                                 # Назва кроку
    inherit: predefined.reflect               # Наслідування вбудованого кроку виклика рефлектора
    reflector: reflector::reflect.some.files  # Виклик рефлектора із секції 'reflector'  
    verbosity: 3                              # Деталізація логу виконання побудови модуля (значення                                             # від 0 до 8)

```

<a name="predefined-js"></a> Функція `predefined.js`:

```yaml
step:                                   # Назва секції
  predefined:                           # Назва кроку
    inherit: predefined.js              # Наслідування вбудованого кроку використання терміналу ОС
    js: path::jsFileToRun               # Шлях до JS-файла в секції 'path'

```

Функція може бути записана в скороченій формі:  

```yaml
step:                                   
  predefined:                           
    js: path::jsFileToRun               

```

<a name="predefined-shell"></a> Функція `predefined.shell`:

```yaml
step:                                   # Назва секції
  predefined:                           # Назва кроку
    inherit: predefined.shell           # Наслідування вбудованого кроку використання терміналу ОС
    shell: [some_command]               # Команда для вводу в термінал ОС
    currentPath: path::dirToRun         # Вказується директорія в якій виконується файл

```

Функція може бути записана в скороченій формі. При відсутності поля `currentPath` за замовчуванням встановлюється значення поточної директорії `will`-файла.  

```yaml
step:                                   
  predefined:                         
    shell: [some_command] 
    currentPath: path::dirToRun         

```

<a name="predefined-export"></a> Функція `predefined.export`:

```yaml
step:                                   # Назва секції
  predefined:                           # Назва кроку
    inherit: predefined.export          # Наслідування вбудованого кроку експорту модуля
    export: path::fileToExport          # Шлях до файлів модуля, що експортуються
    tar: 0                              # Архівування експортованої конфігурації. '1' - ввімкнена,
                                        # '0' - вимкнена. За замовчуванням '1'

```

Функція може бути записана в скороченій формі.

```yaml
step:                                   
  predefined:                           
    export: path::fileToExport          

```

<a name="in-steps-build"></a> Фунції, що вносяться в секцію `build`, поміщені в один сценарій збірки, але використовуються окремо:  

```yaml
build:                                  # Назва секції
  predefined:                           # Назва кроку
    steps:                              # Кроки - сценарій збірки
    - submodules.download               # Вбудовані кроки, що поміщаються в секцію `build`
    - submodules.upgrade                
    - submodules.clean
    - clean                             

```
</br>
- Вбудовані кроки описують основні функції при створенні модуля.  
- Вбудовані кроки з аргументами вказуються в секції `step`.  
- Вбудовані кроки без аргументів вказуються в секції `build`.  

[Повернутись до змісту](../README.md#manuals)