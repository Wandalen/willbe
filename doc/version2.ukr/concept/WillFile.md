# <code>Will-file</code>  

Config for describing and building a module. Each formal module has such file.  

`Will-file` must be created for [informal submodules](SubmoduleInformal.md). It is convenient to use informal submodules.  
`Will file` has following properties:  
\- describes the module files;  
\- the document consists of sections and resources;  
\- [section](Structure.mdSection-will-file) is the highest structural element of `will-file`;  
\- [resource](Structure.mdResources) is structural and functional element of `will-file`;  
\- resources describe the functionality of the module;  
\- section consists of single type resources.  

`Will-file` supported `.yml`,` .json` and `cson` extensions.  
The figure shows the list of files in the module directory (the `ls -al` command output). `Will-file` marked by rectangle:    

![will.file.png](./Images/will.file.png)  

Example of `will-file`:  

![will.file.inner.png](./Images/will.file.inner.png)
