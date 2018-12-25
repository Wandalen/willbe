# Declaring a submodule
This tutorial shows how to create a trivial module.

## Module structure

A basic module structure looks like this:
```
.
├── * - any files
├── .will.yml
```
`.will.yml` - [will file](../Will-files.md) is kind of config file, which describe a [module](../Module.md) and how to use it.
Possible config file formats: YAML, JSON, CSON.

___

## Declaring the module

### Writing will config:

1.  Create an empty will file: `.will.yml`.
2.  Add basic information about the module in the field `about`:

    The most important property is a `name`. Also possible properties are: description,version, keywords, etc.
    ``` yaml
    about :
        name : first
        description : "Out first module"
        version : 0.0.1
        keywords :
            - willbe
    ```
## Checking the result

### Using willbe to get info about the module:

> Command should be executed from root directory of the module.

```
will .about.list
```
`willbe` should print information from `about` field, like:
```
About
name : 'first'
description : 'Out first module'
version : '0.0.1'
enabled : 1
keywords :
    'willbe'
```

#[Back to content](../README.md)




