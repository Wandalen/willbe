
# utility::willbe [![status](https://github.com/Wandalen/willbe/actions/workflows/StandardPublish.yml/badge.svg)](https://github.com/Wandalen/willbe/actions/workflows/StandardPublish.yml) [![unstable](https://img.shields.io/badge/stability-unstable-yellow.svg)](https://github.com/emersion/stability-badges#unstable)

Utility for development which helps to manage modularity of complex modular systems.

### What `willbe` is

`Willbe` is utility for development. It helps to manage modularity of complex modular systems. Utility `willbe` reaches it's purpose utilizing functionality of modern file systems, extending it, aggregating functionality of other open source utilities of such kind.

The building of application is part of any software development process. There are building blocks which are required for many building scenarios, no matter what language, platform or project you have. `Willbe` encapsulates such building blocks and offers them to a developer.

Utility `willbe` is cross-platform. It hides differences between platforms making development cheaper and more pleasant.

A loose definition of concept module imposes minimum restrictions on development and application of the utility. Any set of files could be treated as a module.

`Will-file` has comfortable to read format which encourages a developer to stick to the best practices. For example, `will-file` has section `path`, developer collects all paths ( local and remote files ) in one place analysis of which gives teammates clear look on a module from the perspective of files.

Declarative programming paradigm is heavily used in `will-files`.

### What `willbe` is not

Utility willbe is not a replacement of Git, NPM or other utilities with narrow purpose. It aggregates functionality of all that utilities in the single utility and under the single philosophy.

### Try out
```
npm install -g willbe@delta
cd sample/submodules
will .build
```
