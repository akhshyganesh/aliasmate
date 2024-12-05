# AliasMate

AliasMate is a simple command management tool that allows users to store shell commands with custom aliases and their default paths. It also lets you run these commands from the terminal with the alias name and an optional custom path.

## Features:

- Save shell commands with an alias and a default path.
- Run commands using their aliases from the terminal.
- List all saved commands and their default paths.
- Handle custom paths when running commands.

## Installation:

To download and run the `installer.sh` script directly from your GitHub repository using a single command, you can use `curl` or `wget` to fetch the script from the raw GitHub URL and pipe it into the shell.

Here's the single line command to do that:

### Using `curl`:

```bash
curl -sSL https://raw.githubusercontent.com/akhshyganesh/aliasmate/develop/installer.sh | bash
```

### Using `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/akhshyganesh/aliasmate/develop/installer.sh | bash
```

### Explanation:

- `curl -sSL` or `wget -qO-` fetches the raw content of the `installer.sh` script from the provided URL.
- `| bash` pipes the script directly into the bash shell for execution.

## Usage:

### Commands:

1. **Save a command with an alias:**
   This allows you to store a command with a specific alias name and a default path.

   ```bash
   aliasmate save <alias> "<command>"
   ```

   - `<alias>`: The alias name for the command.
   - `<command>`: The command you want to store.

   Example:

   ```bash
   aliasmate save greet "echo Hello, World!"
   ```

   This will save the command `echo Hello, World!` under the alias `greet` and the current directory will be stored as its default path.

   **Expected Output:**

   ```
   Command saved as alias 'greet' with default path '/home/user'.
   ```

2. **Run a command using an alias:**
   This allows you to run a saved command by its alias. Optionally, you can specify a custom path.

   ```bash
   aliasmate run <alias> [custom_path]
   ```

   - `<alias>`: The alias name of the command you want to run.
   - `[custom_path]`: Optional. The custom directory to run the command in. If not provided, the command will run in its default path.

   Example:

   ```bash
   aliasmate run greet
   ```

   This will run the command associated with the alias `greet` in its default path.

   If you want to specify a custom path:

   ```bash
   aliasmate run greet /tmp
   ```

   **Expected Output:**

   ```
   Hello, World!
   ```

3. **List all saved commands:**
   This shows all stored commands along with their aliases and default paths.

   ```bash
   aliasmate list
   ```

   Example:

   ```bash
   aliasmate list
   ```

   **Expected Output:**

   ```
   Saved commands and their default paths:
   Alias: greet
     Command: echo Hello, World!
     Default Path: /home/user
   ----------------------------
   ```

4. **Check the version:**
   This command will display the version of the aliasmate script.

   ```bash
   aliasmate --version
   ```

   Example:

   ```bash
   aliasmate --version
   ```

   **Expected Output:**

   ```
   aliasmate version x.x.x
   ```

## Example Workflow:

1. **Saving commands:**

   ```bash
   aliasmate save greet "echo Hello, World!"
   aliasmate save list_files "ls -l"
   ```

2. **Listing saved commands:**

   ```bash
   aliasmate list
   ```

   **Expected Output:**

   ```
   Saved commands and their default paths:
   Alias: greet
     Command: echo Hello, World!
     Default Path: /home/user
   ----------------------------
   Alias: list_files
     Command: ls -l
     Default Path: /home/user
   ----------------------------
   ```

3. **Running commands:**

   - Run the `greet` command:

     ```bash
     aliasmate run greet
     ```

     **Expected Output:**

     ```
     Hello, World!
     ```

   - Run the `list_files` command with a custom path:

     ```bash
     aliasmate run list_files /home/user/Documents
     ```

     **Expected Output:**

     ```
     (List of files in /home/user/Documents)
     ```

## Error Handling:

- If you try to run a command that has not been saved yet, the script will display an error message:

  ```bash
  aliasmate run unknown_alias
  ```

  **Expected Output:**

  ```
  Error: Alias 'unknown_alias' not found!
  ```

- If required parameters are missing when saving or running a command, the script will prompt for correct usage:

  ```bash
  aliasmate save
  ```

  **Expected Output:**

  ```
  Usage: aliasmate save <alias> <command>
  ```

## Customization:

- The directory to store the commands is set by the `COMMAND_STORE` variable in the script. By default, it is `$HOME/.alias_mate`. You can change this to any directory you prefer, but ensure it exists before running the script.

## Local Build Command

- You can use the below command to uninstall any version of aliasmate in your local and build this new version and install

```bash
sudo dpkg -r aliasmate && dpkg --build . aliasmate.deb && sudo dpkg -i aliasmate.deb
```

## Uninstallation

- I really don't want you to do this, but just incase if you want to try uninstalling this application, you can run the below command

```bash
sudo dpkg -r aliasmate
```

## Create Release Tag

- To create release tag we can simply run the below command

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"

git push origin v1.0.0
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For further questions, feel free to reach out! Happy aliasing!
