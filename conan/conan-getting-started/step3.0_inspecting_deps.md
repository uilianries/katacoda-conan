The retrieved packages are installed to your local user cache (typically *.conan/data*), and can be reused from this location for other
projects. This allows to clean your current project and continue working even without network connection. To search for packages in the local cache run:

`conan search "*"`{{execute}}

To inspect the different binary packages of a reference run:

`conan search Poco/1.9.0@pocoproject/stable`{{execute}}

There is also the possibility to generate a table for all package binaries available in a remote:

`conan search zlib/1.2.11@conan/stable --table=file.html -r=conan-center`{{execute}}
`file file.html`{{execute}}

![binary-table](https://docs.conan.io/en/latest/_images/search_binary_table.png)

To inspect all your current project's dependencies use the `conan info` command by pointing it to the location of the *conanfile.txt* folder:

`conan info ..`{{execute}}

Or generate a graph of your dependencies using Dot or HTML formats:

`conan info .. --graph=file.html`{{execute}}
`file file.html`

![info-graph](https://docs.conan.io/en/latest/_images/info_deps_html_graph.png)

#### Instructions

1. Search for the package `fmt/5.3.0@bincrafters/stable`
2. Get `fmt/5.3.0@bincrafters/stable` package info
