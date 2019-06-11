# Module building by command <code>.build</code>

Build of some builds of the module for construction of it.

The resources of the `build` section are called builds. Builds are the sequence and conditions for performing the steps to build the module. Build scenario is a sequence of steps in a build.  

### Run command

<details>
  <summary><u>Module structure</u></summary>

```
buildModule
     └── .will.yml
```

</details>

Create a new `willfile` in the` buildModule` directory.

<details>
  <summary><u>Code of file <code>.will.yml</code></u></summary>

```yaml
about :

    name : buildModule
    description : "Using build command"
    version : 0.0.1
    keywords :
        - willbe

step :

  echo :
    shell : echo "Hello, World!"

build :

  echo:
    steps :
       - echo

```

</details>

Enter the code above in this file. 

The `step` section contains steps that describe the instructions for creating a module. In the example, you can see one step `echo`. This step has a field `shell` to run the command in the console of the operating system.

Also, `willfile` has a build `echo`. This build contains the `echo` step.

<details>
  <summary><u>Command output <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
Please specify exactly one build scenario, none satisfies passed arguments

```

</details>

To run a build in the directory of `willfile`, enter the command `will .build` in the console. Compare the result with the above output. 

The utility did not find the build scenario.

<details>
  <summary><u>Command output <code>will .build echo</code></u></summary>

```
[user@user ~]$ will .build echo
Command ".build echo"
...
  Building echo
 > echo "Hello, World"
Hello, World
  Built echo.debug in 0.089s

```

</details>

In the previous command entering, the name of the build was not specified, so explicitly indicate the name of the build in this input, please. Enter the `will .build echo` command and compare it with the resulted output. The build was built for 0.089s. The output of the console shows that the `echo` collection was started. After executing the `echo` step, the line "Hello, World" appeared in the console. More complex builds can perform file operations.

### Build scenarios

Combining the steps you can create a multi-step build scenario.

<details>
  <summary><u>Code of file <code>.will.yml</code></u></summary>

```yaml
about :

    name : buildModuleWithCriterion
    description : "Output of various phrases using criterions"
    version : 0.0.1
    keywords :
        - willbe

step :

  echo :
    shell : echo "Hello, World"

  echo.two :
    shell : echo "Utility Willbe"

build :

  echo:
    steps :
       - echo.two

  echo.two:
    steps :
      - echo
      - echo.two

```

</details>

Replace the content of `.will.yml` with the code above.

Step `echo.two` is added to the file, it displays the phrase "Utility Willbe" in the console. The `echo.two` collection with two steps was added.

<details>
  <summary><u>Command output <code>will .build echo</code></u></summary>

```
[user@user ~]$ will .build echo
...
  Building echo
 > echo "Hello, World"
Hello, World
 > echo "Utility Willbe"
Utility Willbe
  Built echo in 0.175s

```

</details>

Enter `will .build echo` and compare with the output above.

To implement the two steps was used 0.175s. First, the utility released the phrase “Hello, World”, and then “Utility Willbe".

<details>
  <summary><u>Command output <code>will .build echo.two</code></u>


```
[user@user ~]$ will .build echo.two
...

  Building module::buildModuleWithCriterion / build::echo.two
 > echo "Hello, World"
"Hello, World"
 > echo "Utility Willbe"
"Utility Willbe"
  Built module::buildModuleWithCriterion / build::echo.two in 0.086s

```
</details>
<details>
  <summary><u>Post-build file structure</u></summary>

```
buildModule              
     └── .will.yml     
```

</details>

Run the build `echo.two` by entering the `will .build echo.two` command. Compare the output results with the above.

The `echo.two` build contains an extra step and therefore when it constructed the output displays lines "Hello, World" and "Utility Willbe". The analysis of the outputs of `will .build echo` and `will .build echo.two` allows concluding that the steps in the builds are performed sequentially.

### Summary

- The build runs by `.build` command.
- Running the build can be done by its name. For this, the name is specified as the argument of `.build` command.
- Steps in the build scenario are performed sequentially.
- The sequence of steps is determined by the algorithm for building the module.
- The utility is looking for a `willfile` in the current directory.

[Next tutorial](StepSubmodules.md)  
[Back to content](../README.md#tutorials)
