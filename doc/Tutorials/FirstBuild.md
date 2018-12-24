# Building: Creating a build configuration
In this tutorial we will create build configuration that uses npm to install dependecies.

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
    "wTools": ""
  }
}
```

### Preparing will file:

In previous tutorial we created basic will file with `about` field.
Now will we extend it to implement build configuration.

To create build configuration, first we need to learn two new fields: `step` and `build`.

`step` - describes build steps, step can be a shell command or predefined operation, like files reflecting( copying ).
`build`- describes build configurations, build configuration is a sequence of build steps.

More about [build process](Build.md)

Lets define our first build step with name `npm.install`, in this example it will be execution of shell command:

```yaml
step :

  npm.install :
    currentPath : '.'
    shell : npm i wTools
```

`npm.install` - name of the build step.

`currentPath` - path to directory from where command will be executed, current working directory in this case.

`shell` - command to execute.

The second step is to add build configuration.

```yaml
build :

  debug :
    criterion :
      default : 1
    steps :
      - npm.install
```

`debug` - name of build configuration.
`criterion` - defines criteria which helps to select necessary configuration,step or other component during build process.
Usage of criterions will be described later.
`steps` - list of steps to execute in current build configuration

### Launching build configuration:

The final version of `.will.yml` should look like:

```yaml

about :

  name : second
  description : "Second module"
  version : 0.0.1

step :

  npm.install :
    currentPath : '.'
    shell : npm i wTools

build :

  debug:
    criterion :
      default : 1
    steps :
      - npm.install
```

To launch current( default ) build configuration run:

```
will .build
```

Dependecies defined in `package.json` will be installed. `willbe` should print output, like:

```
  Building debug
 > npm i wTools

+ wTools@0.8.389
added 1 package from 3 contributors and audited 1 package in 1.215s
found 0 vulnerabilities

  Built debug in 1.595s
```







