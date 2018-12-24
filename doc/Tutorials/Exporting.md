This tutorial shows how to create a module and export it.

1. Preparation:

    - Installing "willbe":
        ```
        npm install -g willbe
        ```
    - Preparing module files:

        Module consists of files and config( s ).
        - Create a file in the root of module folder, in this case it will be "Single.js".
        - Create an empty will config file with name "single.will.yml"
2. Writing will config file:

    Will config is a YAML file that describes the module and its behaviour.

  - First of all we need to setup basic information about the module. The most important is a name.
    Also wee can add fields like description,version, etc. All this kinds of information are stored in block called "about":

    ``` yaml
    about :
        name : single
        description : "Single file module"
        version : 0.0.1
    ```
  - Module needs to be exported to use it from the other place. Lets setup export scenario:

    ``` yaml
    path :
        in : '.'
        out : '.'
        export : './Single.js'

    step  :
        export.single :
            inherit : export
            tar : 0
            export : path::export

    build :
        export :
            criterion :
                default : 1
                export : 1
            steps :
                - export.single
    ```

    - path -
    - step -
    - build -

  - Lets execute some will commands to check that everything works fine.
    All commands should be executed from the root directory of the module.
    - Getting info about the module:
        ```
        will .about.list
        ```
    - Exporting the module:
        ```
        will .export
        ```
      During export process willbe generates *.out.will.yml file that contains information that is needed to import current module.

Sample of the module can be found in ./doc/Tutorials/modules/single






