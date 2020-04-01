# Default build of the module

How to construct the build without explicit specification of the argument for command <code>.build</code>.

### How to set the default build

If the `willfile` has a build that executes more often than others, then it is convenient to assign this build by default. The default build runs by the phrase `will .build` without specifying the argument. This eliminates the need to find the correct build name in the `willfile` and makes the call command shorter.

The `willfile` can only have one default build. To define the default build, specify the `default: 1` criterion in the appropriate resource. 

### The module with default build    

<details>
  <summary><u>File structure</u></summary>

```
defaultBuild
      └── .will.yml

```

</details>

Create the file structure shown above.

<details>
  <summary><u>Code of file <code>.will.yml</code></u></summary>

```yaml
about :

  name : 'defaultBuild'
  description : 'Default build with criterion'
  version : 0.0.1

step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  install:
    criterion :
      default : 1
    steps :
      - npm.install

```

</details>

Enter the code in the file `.will.yml`.  

The `willbe` utility works with both the operating system and external applications. For example, `NodeJS` dependencies are downloaded using the `NPM` package manager in the `npm.install` step.

Add the `package.json` file to the `defaultBuild` directory. Put the appropriate code in this file. 

<details>
  <summary><u>The file <code>package.json</code> with NodeJS dependencies</u></summary>

``` json
{
  "name": "npmUsing",
  "dependencies": {
    "express": ""
  }
}

```

</details>

Simple `npm-file` with `express` package.

<details>
  <summary><u>File structure with npm-file</u></summary>

```
defaultBuild
     ├── package.json
     └── .will.yml
```

</details>

Entering the `.build` command runs the build scenario `install`. This scenario contains only one step that installs the `npm-packages`.

<details>
  <summary><u>Command output <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
Command ".build"
...
  Building install
 > npm install
...
added 48 packages from 36 contributors and audited 121 packages in 4.863s
found 0 vulnerabilities

  Built debug in 8.456s

```

</details>

Enter the `will .build` command in the `willfile` directory. Compare the output of the console.

<details>
  <summary><u>Post-build file structure</u></summary>

```
defaultBuild
     ├── node_modules
     │         ├── ...
     │         ├── ...
     │
     ├── package.json
     ├── package-lock.json
     └── .will.yml
```

</details>

Compare the changes in the `defaultBuild` directory. `npm-packages` has been installed.

### Summary   

- The default build runs by `will .build` command.
- To set the default build, specify the `default: 1` criterion for it.
- `Willfile` can have one default build.
- The utility interacts with the operating system and can run external programs.

[Back to content](../README.md#tutorials)
