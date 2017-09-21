# goCrossplatformCompileSCcript
Script for windows which helps to compile program to a different platforms.

## Usage
Put compile.bat into go app folder and run it.  
The script will create a folder "bin" and put all binaries there.
If 7zip is installed and added to PATH variable the script will detect and use it to compress binaries.  

If you wish to specify output name of binaries you should pass this name as a parameter  
## Example

1. Verify you moved **compile.bat** to project folder  
   * If you don't need to specify output name just double click on ```compile.bat```
   * Goto to item 5
2. Open **cmd.exe**  
3. Change directory to Project Folder using command ```cd```
4. Type ```compile.bat <prefered_name>``` if you wish output binaries should contain your <prefered_name>
5. Wait until script finish
6. Find your binaries at ./bin/ folder.
## License

MIT