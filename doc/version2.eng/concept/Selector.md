### Selector
String-reference on the resource or the group of the module resources.

### Selector with globs
Selector which uses searching patterns (globs) for selection of the resources.

[Globbing](https://linuxhint.com/bash_globbing_tutorial/) - it is an analog of regular expressions for searching files in the bash-terminal.

![selector.png](../../images/selector.png)

At the figure in the build `build::export` the two types of selectors are used. The `step::export.*` selector is the selector with the glob because it contains `*`, it reads: "select all steps that begin with `export`". This selector can select `step:: export.single` and `step :: export.multi` steps (indicated by blue arrows).The choice of the step is carried out by [comparing the map of criterion](Criterions.md) and only one `step::export.multi` step coincide. Similarly, the paths are selected by selector `path::fileToExport.*` in the step `step::export.multi`.

The selectors `step::delete.out` in the build` export` and `path::out` in the` delete.out` step are simple. Simple selectors are the selectors which have a direct link to the resource. In `willfile` selectors of the form `Section name::Resource name` are used.

### Glob with assertion
A special syntactic construct that is added to the globe to limit the number of resources which have to be found by the selector with this glob.

```yml
path :

  out.debug :
    path : './out/debug'
    criterion :
      debug : 1
  out.release :
    path : './out/release'
    criterion :
      debug : 0

step :

  export :
    export : path::out.*=1
    criterion :
      debug : 0
```

The `step::export` step must choose one way `path::out.debug`. The developer can put in selector `path::out.*=1` assertion `=1` due to the fact that it is the predictable and expectable result. This will ensure that the error is shown. If it happens then by this selector will be found more or less of one path. For example, if in paths you do not specify a debug criterion, both paths will be found and an assertion will show the error.

It is possible to find more than one or even none of the resource by a selector with the globe. If the developer knows how many selectors with the globe can find the resources, he can specify this number as an assertion in the selector. Then while performing the utility notices that the developer's forecast is not confirmed and consequently will show the error. The good practice of software development is to leave assertions everywhere, where  the result of execution is exactly known. Globe with assertion is the especially enforced implementation by the developer to prevent unpredictable consequences. If the selector is simple and has no globe, then assertion is not needed.

#### Algorithm of verification assertions in selectors

![criterions.and.assertion.png](../../images/criterions.and.assertions.png)

The algorithm performs a verification of the resources on the coincidence of the [criterions](Criterions.md). When they coincide, the utility increments the counter of resources. After verifying all resources, the value of the counter is compared to the one which is set in the assertion. In the case of non-matching values, the utility shows an error message.

### Use of assertions

![assertions.png](../../images/assertions.png)  

The figure on the left shows a variant of the resource's erroneous writing. Because of the [lack of criterions](Criterions.md) in the `export.multi` step the `step::export.*=1` the selector in the  `build::export` build will choose `step::export.single` and `step::export.multi` steps, which is contrary to the developer's expectation. Thanks to assertion `= 1` the error will be localized.

![assertion.message.png](../../images/assertion.message.png)  

Error message in resources selection for the `willfile` due to the assertion's triggering.
