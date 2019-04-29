# Informal submodule

A set of files that are not distributed with <code>will-file</code>. For such submodule it is possible to create <code>will-file</code> independently.

To connect a submodule which is created without using the `willbe` utility, you need to create its export configuration and use generated `out-will-file` as a submodule in your module. The advantage of creating a separate `will file` for an informal submodule is autonomy

### Procedure of import the informal submodule

![submodule.informal.png](./Images/submodule.informal.png)

 The figure shows the general sequence of the informal submodule creation. The `will-file` of the informal submodule combines operations of downloading files from a remote server and exporting of the local submodule. The `will-file` of the module imports the locally generated submodule.
