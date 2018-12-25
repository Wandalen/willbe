# Creating a build configuration
This tutorial shows how to create build configuration that runs npm to install dependecies.

## Module structure

```
.
├── package.json
├── .will.yml
```
___

## Creating first build configuration

### Preparing package.json:

Create `package.json` in root directory with content:
``` json
{
  "name": "second",
  "dependencies": {
    "express": ""
  }
}
```

### Preparing will file:

In previous tutorial we created basic confing with `about` field.
Current goal is to extend it with a build configuration.

#### First we need to learn two new components of will config:

`step` - describes build steps, step can be a shell command or predefined operation, like file(s) reflecting( copying ).

`build` - describes build configurations, [build](../Build.md) configuration is a sequence of build steps.

#### Add new step with name `npm.install`, in this example its execution of shell command:

```yaml
step :

  npm.install :
    currentPath : '.'
    shell : npm install
```

`npm.install` - name of the step.

`currentPath` - path to directory from where command will be executed, current working directory in this case.

`shell` - command to execute.

#### Add build configuration:

```yaml
build :

  debug :
    criterion :
      default : 1
    steps :
      - npm.install
```

`debug` - name of configuration.

`criterion` - defines criteria which helps to select necessary configuration,sage of criterions will be described later.

`steps` - list of steps to execute in current build configuration

### Testing build configuration:

The final version of `.will.yml`:

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

#### To launch current( default ) build configuration run:

> Command should be executed from root directory of the module.

```
will .build
```

Dependecies defined in `package.json` will be installed:

```
  Building debug
    > npm install
  added 48 packages from 36 contributors and audited 121 packages in 2.302s

  Built debug in 2.875s
```
---
[Back to main page](../README.md)






