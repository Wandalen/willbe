# Creating a build configuration
This tutorial shows how to create a build configuration that runs npm to install dependencies.

## Module structure

```
.
├── package.json
├── .will.yml
```

## Creating our first build configuration

### Preparing the package.json file:

Create a `package.json` file in the root directory, with content:
``` json
{
  "name": "second",
  "dependencies": {
    "express": ""
  }
}
```

### Preparing the will file:

In the previous tutorials, we created a basic configuration with the `about` field.
Our current goal is to extend it with a build configuration.

#### First we need to learn about two new components of the will config:

`step` - describes the build steps: a step can be a shell command or predefined operation, like file(s) reflecting( copying ).

`build` - describes the build configuration: a [build](../Build.md) configuration is a sequence of build steps.

#### Add a build step:

This step executes the shell command: `npm install`.

```yaml
step :

  npm.install :
    currentPath : '.'
    shell : npm install
```

`npm.install` - name of the step.

`currentPath` - path to the directory from where the command will be executed, current working directory in this case.

`shell` - command to execute.

#### Add a build configuration:

```yaml
build :

  debug :
    criterion :
      default : 1
    steps :
      - npm.install
```

`debug` - name of the configuration.

`criterion` - defines criteria which help to select the necessary configuration, sage of criterions will be described later.

`steps` - list of steps to execute in the current build configuration.


## Testing the build configuration:

The final version of the `.will.yml` file would be:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml

about :

  name : second
  description : "Second module"
  version : 0.0.1

step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  debug:
    criterion :
      default : 1
    steps :
      - npm.install
```
</details>

#### To launch the current ( default ) build configuration, run:

> Command should be executed from the root directory of the module.

```
will .build
```

Dependecies defined in the `package.json` will be installed:

```
  Building debug
    > npm install
  added 48 packages from 36 contributors and audited 121 packages in 2.302s

  Built debug in 2.875s
```
#
[Back to content](../README.md)
