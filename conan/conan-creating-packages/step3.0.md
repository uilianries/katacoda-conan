Sometimes it is more convenient to have the recipe and source code together in the same repository.
This is true especially if you are developing and packaging your own library, and not one from a third-party.

There are two different approaches:

- Using the `exports sources attribute` of the conanfile to
  export the source code together with the recipe. This way the recipe is self-contained and will
  not need to fetch the code from external origins when building from sources. It can be considered
  a "snapshot" of the source code.

-  Using the `scm attribute` of the conanfile to capture the remote and
   commit of your repository automatically.