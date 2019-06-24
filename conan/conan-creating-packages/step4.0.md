There are specific scenarios in which it is necessary to create packages from existing binaries, for example from 3rd
parties or binaries previously built by another process or team that are not using Conan. Under these circumstances building from sources is
not what you want. You should package the local files in the following situations:

 - When you cannot build the packages from sources (when only pre-built binaries are available).
 - When you are developing your package locally and you want to export the built artifacts to the local
   cache.
   As you don't want to rebuild again (clean copy) your artifacts, you don't want to call `conan create`.
   This method will keep your build cache if you are using an IDE or calling locally to the `conan build` command.