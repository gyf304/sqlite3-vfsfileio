# VFS File IO for SQLite

This is an extension library for SQLite3 that implements 2 SQL functions:

* `vfsreadfile(path, [vfsname])`: Read the contents of a file using
   VFS.
* `vfswritefile(path, data, [vfsname])`: Write the contents of a file
  using VFS.

This extension is implemented differently compared to the official fileio
extension. In particular, this extension does not use the C standard
library to read and write files. Instead, it uses the VFS interface
provided by SQLite3 to read and write files. This allows the extension
to work with custom VFS implementations and to work on platforms where
the C standard library is not available.
