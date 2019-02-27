# Секція _'exported'_ `will`-файла

В цьому туторіалі розглянуто секція `exported` `will`-модуля

В попередньому туторіалі створений експорт модуля `second`. Дослідимо його.

Початковий `will`-файл мав 4 секції. Покроково порівняємо секції в `.will.yml` та `second.out.will.yml`.  
Введемо фразу `will .about.list` в кореневих директоріях відповідних файлів
```
| Секція в `.will.yml`            | Лістинг  з `second.out.will.yml`         | 
|---------------------------------|------------------------------------------|
| About                           | About                                    | 
|   name : 'second'               |   name : 'second'                        | 
|   description : 'Second module' |   description : 'Second module'          | 
|   version : '0.0.2'             |   version : '0.0.2'                      | 
|   enabled : 1                   |   enabled : 1                            | 

```

Відмінність від початкового файлу лише в полі _'enabled'_, яке `willbe` автоматично генерує для секції `about` будь-якого файлу.  
Порівняємо секції `path` (фраза `will .paths.list`):
