# Contribution guidelines

TBD

## (optional) Using pre-commit framework

TBD

## Using python virtual environments

To be as close as possible to the environment that the CI pipeline will create you can use a [helper script](./create_venv.sh) to setup a fresh python virtual environment. Then call `source .venv/bin/activate` and you can call molecule etc.

## Maintenance scripts

In the dir maintenance/ are scripts that shall help to keep the code clean. Like to keep track of new variables introduced by paperless-ngx that are not yet reflected in this role or to check if all molecule scenarios are placed at the corresponding place (matrix) in the test workflow for github.

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

### Run test step against specific scenario
```
molecule test --scenario-name foo
```

### Login to a container after converge step

```
molecule login --host debian11
```