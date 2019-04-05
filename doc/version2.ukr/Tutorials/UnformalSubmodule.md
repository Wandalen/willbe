# Неформальний підмодуль

Створення неформального підмодуля

Неформальний підмодуль - звичайний підмодуль, завантажений з віддаленого джерела, експортований і підключений як локальний.  

```yaml
about :

  name : Color.informal
  version : 0.0.1

path :

  in : '..'
  out : 'out'
  predefined.remote : 'git+https:///github.com/Wandalen/wColor.git'
  predefined.local : './.module/Color'
  export : '{path::predefined.local}/proto'

reflector :

  download.informal :
    src : path::predefined.remote
    dst : path::predefined.local

step :

  export.module :
    export : path::export
    tar : 0

build :

  export :
    criterion :
      default : 1
      export : 1
    steps :
      - step::download.informal
      - step::export.module
      
```


```yaml
about :
  name : informalSubmodule
  description : "To make submodule from Git-repository"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  Color : out/Color.informal.out

path :

  in : '.'
  out : 'out'
  proto : './proto'
  out.debug : 
    path : './out/module.debug'
    criterion :
      debug : 1

reflector :

  reflect.submodules :
    inherit : submodule::*/exported::*=1/reflector::exportedFiles*=1
    dst :
      basePath : .
      prefixPath : path::out.*=1
    criterion :
      debug : 1

step :

  submodules.informal.export :
    currentPath : path::predefined.dir
    shell : 'node {path::predefined.willbe} .each module .export'

build :

  make.unformal :
    criterion :
      default : 1
      debug : 1
    steps :
      - submodules.download
      - submodules.informal.export
      - submodules.reload
      - reflect.submodules*=1
      
```