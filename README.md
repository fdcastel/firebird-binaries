# firebird-binaries

Minimal set of files to use Firebird Embedded. Ideal for build test environments. 



## How to install

Simply `git checkout` this repository. All necessary files are included.

```powershell
git clone --quiet --depth 1 --branch x86 --single-branch https://github.com/fdcastel/firebird-binaries 
```



## Usage 

Just configure your application to use `fbclient.dll` of the desired Firebird version. The configuration file `firebird.conf` is already configured to use the embedded server.

These are 32-bit binaries. For 64-bit please use the [`master` branch](https://github.com/fdcastel/firebird-binaries) of this repository.



## Rebuild-Databases

You can use `Rebuild-Databases.ps1` script to build empty databases for each Firebird version.

```powershell
Rebuild-Databases.ps1 [[-DbPath] <string>] [[-DbPrefix] <string>] [[-Engines] <string[]>] [[-PageSize] <int>] [[-Charset] <string>] [<CommonParameters>]
```

### Parameters

| Parameter   | Description                                                  | Default                        |
| ----------- | ------------------------------------------------------------ | ------------------------------ |
| `-DbPath`   | Folder where databases will be created.                      | `$env:TEMP\firebird-databases` |
| `-DbPrefix` | String prepended to database name.                           | `test`                         |
| `-Engines`  | Versions (set of `[fb25`, `fb30`, `fb40`, `fb50]`) to create | `All`                          |
| `-PageSize` | Database page size                                           | `8192`                         |
| `-Charset`  | Database default `CHARACTER SET`                             | `UTF8`                         |



### Example

```powershell
.\Rebuild-Databases.ps1 -DbPath 'C:\Temp' -DbPrefix 'Foo' -Verbose
VERBOSE: Creating 'C:\Temp\Foo.fb25.fdb' (PageSize=8192, Charset='UTF8')...
VERBOSE: Creating 'C:\Temp\Foo.fb30.fdb' (PageSize=8192, Charset='UTF8')...
VERBOSE: Creating 'C:\Temp\Foo.fb40.fdb' (PageSize=8192, Charset='UTF8')...
VERBOSE: Creating 'C:\Temp\Foo.fb50.fdb' (PageSize=8192, Charset='UTF8')...
```
