# Making a submodule
This tutorial shows how to create a module simplest module.

## Module structure

A basic module structure looks like this:
```
.
├── * - any amount of files
├── .will.yml
```
`.will.yml` - config is a [YAML](https://en.wikipedia.org/wiki/YAML) file that describes the module and its behaviour.

More about [modules](Module.md) and [will files](Will-files.md).

___

## Creating the module

### Writing will config:

1.  Create an empty will config file with name `.will.yml`
2.  Setup basic information about the module in the field `about`.

    The most important property is a `name`. Also wee can add fields like `description`,`version`, `keywords`, etc.
    ``` yaml
    about :
        name : first
        description : "Out first module"
        version : 0.0.1
        keywords :
            - willbe
    ```
### Using willbe to get about info:
Lets make a ".about.list" request to check that will properly reads our config file.

> Command should be executed from root directory.

Getting info about the module:

```
will .about.list
```
`willbe` should print information from "about" field, like:
```
About
name : 'first'
description : 'Out first module'
version : '0.0.1'
enabled : 1
keywords :
    'willbe'
```






