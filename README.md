# Easily manage and switch between multiple Maven versions

It allows you to easily switch between multiple Maven versions.

After you install mvnenv, running the "mvn" command will execute a script from mvnenv's bin directory. This script checks your configuration, automatically sets `M2_HOME` to the selected Maven installation, sets `MAVEN_OPTS` to your desired options, and then runs the actual Maven command.


## Installation

1. Check out mvnenv into `~/.mvnenv`.

```bash
git clone https://github.com/themnd/mvnenv.git ~/.mvnenv
```

2. Add `~/.mvnenv/bin` to your `$PATH`.

```bash
echo 'export PATH="~/.mvnenv/bin:$PATH"' >> ~/.zprofile
```
    
**Note:** If you use [jenv](http://www.jenv.be), ensure that the command from step 2 appears *before* `eval "$(jenv init -)"` in your shell configuration.

**Note:** If the Maven `bin` directory is in your `$PATH`, it must be listed *after* mvnenv. You can also remove Maven's `bin` from your `$PATH` entirely, since `mvn`, `mvnDebug`, and `mvnyip` are automatically handled by mvnenv.


3. Add `mvnenv init` to your shell.

```bash
$ echo 'eval "$(mvnenv init)"' >> ~/.zprofile
```
    
4. Start a new shell.

```bash
source ~/.zprofile
```

5. Verify that mvnenv works.
 
```bash
mvnenv --version
```

6. Add the needed maven versions.

```bash
$ mvnenv add /path/to/maven
```

7. Configure which maven version to use.

- Globally
  
```bash
$ mvnenv global maven
```
    
- In the current directory
    
```bash
$ mvnenv local maven2
```
    
- In the current shell
    
```bash
$ mvnenv shell maven2
```

8. Verify that works.

```bash
$ mvn -version
```

## Commands Available

### `mvnenv --version`

Display the current mvnenv version.

### `mvnenv add`

Add a maven installation to the list of available versions.

```bash
mvnenv add /path/to/maven
```

### `mvnenv current`

Display the Maven version and options that will be used in the current context.

```bash
mvnenv current
```

### `mvnenv global`

Show or set the global Maven version.

- To display the current global version:
  ```bash
  mvnenv global
  ```
- To set the global version:
  ```bash
  mvnenv global <version>
  ```

### `mvnenv global options`

Show, set, or unset global Maven options.

- To display the current global options:
  ```bash
  mvnenv global options
  ```
- To set global options:
  ```bash
  mvnenv global options "<options>"
  ```
- To unset global options:
  ```bash
  mvnenv global options --unset
  ```

**Note:** The `MAVEN_OPTS` environment variable always takes precedence over global options.

### `mvnenv init`

Initialize mvnenv in your shell configuration.

```bash
eval "$(mvnenv init)"
```

### `mvnenv local`

Show or set the Maven version for the current directory.

- To display the current local version:
  ```bash
  mvnenv local
  ```
- To set the local version:
  ```bash
  mvnenv local <version>
  ```
- To unset the local version:
  ```bash
  mvnenv local --unset
  ```

### `mvnenv local options`

Show, set, or unset Maven options for the current directory.

- To display the current local options:
  ```bash
  mvnenv local options
  ```
- To set local options:
  ```bash
  mvnenv local options "<options>"
  ```
- To unset local options:
  ```bash
  mvnenv local options --unset
  ```

**Note:** The `MAVEN_OPTS` environment variable always takes precedence over local options._


### `mvnenv remove`

Remove a Maven version from the list of available versions.

```bash
mvnenv remove <version>
```

### `mvnenv shell`

Show or set the Maven version for the current shell session.

- To display the current shell version:
  ```bash
  mvnenv shell
  ```
- To set the shell version:
  ```bash
  mvnenv shell <version>
  ```
- To unset the shell version:
  ```bash
  mvnenv shell --unset
  ```

### `mvnenv versions`

List all available Maven versions that have been added.

```bash
mvnenv versions
```

## Thanks

It's based on https://github.com/themnd/mvnenv.git
