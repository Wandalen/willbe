# Making a submodule
This tutorial shows how to create a module simplest module.

## Module structure

A basic module structure looks like this:
```
.
├── * - any amount of files
├── .will.yml
```
.will.yml - config is a [YAML](https://en.wikipedia.org/wiki/YAML) file that describes the module and its behaviour.

More about [modules](Module.md) and [will files](Will-files.md).

___

## Creating the module

### Writing will config:

1.  Create an empty will config file with name "first.will.yml"
2.  Setup basic information about the module in the field "about".

    The most important property is a name. Also wee can add fields like description,version, keywords, etc.
    ``` yaml
    about :
        name : first
        description : "Out first module"
        version : 0.0.1
        keywords :
            - willbe
    ```

3.  Lets make a request to check that will properly reads our config file.

All commands should be executed from the root directory of the module.
- Getting info about the module:
    ```
    will .about.list
    ```
    willbe should print information from "about" field, like:
    ```
    About
    name : 'first'
    description : 'Out first module'
    version : '0.0.1'
    enabled : 1
    keywords :
        'willbe'
    ```






