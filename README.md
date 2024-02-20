# VendorKill
VendorKill is a command-line utility that helps developers manage and clean up vendor directories in their Composer projects. It scans a specified path for vendor directories, displays their sizes and the corresponding project names, and allows you to select which ones to delete.

## Features
- Search for vendor directories: VendorKill searches for vendor directories within a specified path and lists them with their sizes and corresponding project names.
- Delete selected directories: After reviewing the list of vendor directories, you can select which ones to delete, and VendorKill will remove them from the file system.
- Path flexibility: VendorKill can be run from any directory, and if no path is provided, it will default to the current directory.
- System-wide search: By default, VendorKill searches recursively through all subdirectories, but you can limit the search depth to avoid listing subdirectories of a project already listed.
## Usage
To use VendorKill, simply run the script from your terminal. You can provide a path as an argument, or if no path is provided, the script will default to the current directory.

```bash
./vendorkill.sh /path/to/search

```
After running the script, you will be prompted to enter the numbers of the directories you wish to delete. You can enter multiple numbers separated by spaces.

## Installation
VendorKill is a standalone script and does not require any installation. Simply clone this repository or download the script file, and you're ready to use it.

## Contributing
If you have suggestions for improvements or find any issues, feel free to open an issue or submit a pull request.

## License
VendorKill is open-source software licensed under the MIT License.