# Section <code>about</code>

The section contains descriptive information about the module.

The section has no resources. Furthermore is can have any structure from arrays and maps having any form of nesting. If a build parameter is not the path and if a user does not know where it should be written, then he writes it to the `about` section. The data in this section can be used in steps, for example, the `about::keyword/0` selector will use the first keywords.

### Example

```yaml
about :

    name : aboutSection
    description : "Example of about section"
    version : 0.0.1
    keyword :
      - willbe

```

The `about` section has 4 fields among which are the module name, description, version and one keyword.

### Fields of the `about` section, which can be used by default

| Field          | Description                                    |
|----------------|-----------------------------------------|
| name           | name of the module                           |
| description    | description of the module                             |
| version        | version of the module release                    |
| enabled        | whether the module is active, by default `1` |
| interpreters   | interpreters on which the module should run     |
| keywords       | keywords                          |  
