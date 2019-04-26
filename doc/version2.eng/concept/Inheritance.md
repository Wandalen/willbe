# Inheritance

It is the approach of the module description according to which the <code>will-file</code> can reuse (inherit) field values of another resource(s) of the same type.

By inheritance it is possible to supplement the resource-descendant by the new values of the fields which the ancestor did not have, or these fields of the ancestor had a different value. The inheritance allows reuse the resources of the `will-files`, which simplifies the development and design of the modules.

![resources.inheritability.png](./Images/resources.inheritability.png)

The diagram shows the relation between the resource which is followed by the resource which follows.

### Use of the resources which belong to the same module

For the inheritance within the borders of one `will-file`:
- specify the resource-ancestor which will be followed in the field `inherit` of the resource-descendant. For example `inherit : reflector::some` ;
- if needed, change or supplement the field of resource

### Use of the resources which belong to the different module

For the use of inheritance by resources from another `will-file`:
- connect outside `will-file` as submodule of the section `submodule`;
- specify in field `inherit` the selector to the resource, which will be followed. For example `inherit:submodule::NameOfSubmodule/section::NameOfSection/NameOfResource`, which means that submodule, section and resource are specified clearly;
- if needed, specify criterions and supplement the fields of the resource for the resource-descendant.
