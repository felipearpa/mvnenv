# Easily manage and switch between multiple Maven versions

It allows you to easily switch between multiple Maven versions.

After you install mvnenv, running the "mvn" command will execute a script from mvnenv's bin directory. This script checks your configuration, automatically sets `M2_HOME` to the selected Maven installation, sets `MAVEN_OPTS` to your desired options, and then runs the actual Maven command.

## Installation

1. **Clone mvnenv into your home directory:**

   ```bash
   git clone https://github.com/themnd/mvnenv.git ~/.mvnenv
   ```

2. **Add mvnenv to your `$PATH`:**

   ```bash
   echo 'export PATH="$HOME/.mvnenv/bin:$PATH"' >> ~/.zprofile
   ```

   - **If you use [jenv](http://www.jenv.be):**  
     Make sure this line appears *before* `eval "$(jenv init -)"` in your shell configuration.
   - **If Maven’s `bin` directory is in your `$PATH`:**  
     It must be listed *after* mvnenv, or you can remove it entirely.  
     `mvn`, `mvnDebug`, and `mvnyip` are automatically handled by mvnenv.

3. **Initialize mvnenv in your shell:**

   ```bash
   echo 'eval "$(mvnenv init)"' >> ~/.zprofile
   ```

4. **Reload your shell configuration:**

   ```bash
   source ~/.zprofile
   ```

5. **Verify mvnenv installation:**

   ```bash
   mvnenv --version
   ```

6. **Add your required Maven versions:**

   ```bash
   mvnenv add /path/to/maven
   ```

7. **Select which Maven version to use:**

   - **Globally:**
     ```bash
     mvnenv global <version>
     ```
   - **For the current directory:**
     ```bash
     mvnenv local <version>
     ```
   - **For the current shell session:**
     ```bash
     mvnenv shell <version>
     ```

8. **Verify Maven is set up correctly:**

   ```bash
   mvn -version
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
