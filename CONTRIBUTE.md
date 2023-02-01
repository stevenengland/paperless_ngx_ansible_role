# Contribution guidelines

TBD

## (optional) Using pre-commit framework

TBD

## Testing

### Complete test

Normally, before pushing any changes, one would run a complete test set:

```console
molecule test --all
```

But it can be extremely helpful to execute only subsets of all commands against all scenarios and all the platforms.

### Test phase by phase (in default scenario)

```console
molecule create
molecule converge
molecule verify
```

### Run converge step only against specific platform(s) (in default scenario)

```
molecule converge -- --limit debian11
```

### Run converge step only against specific tags (in default scenario)

```
# against a complete sub-playbook
molecule converge -- --tags=base_dependencies,base_dependencies_all
# against a tag in a sub-playbook
molecule converge -- --tags=base_dependencies,repo_packages
```

### Run converge against specific scenario
```
molecule converge --scenario-name foo
```

### Run test step only against specific platform(s) (in default scenario)

```
molecule test --platform-name=debian11
```

### Login to a container after converge step

```
molecule login --host debian11
```