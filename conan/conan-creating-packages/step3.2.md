You can use the `scm` attribute with the ``url`` and ``revision`` field set to ``auto``.
When you export the recipe (or when `conan create` is called) the exported recipe will capture the
remote and commit of the local repository:

```python
from conans import ConanFile, CMake, tools

class HelloConan(ConanFile):
        scm = {
        "type": "git",  # Use "type": "svn", if local repo is managed using SVN
        "subfolder": "hello",
        "url": "auto",
        "revision": "auto"
        }
```

You can commit and push the *conanfile.py* to your origin repository, which will always preserve the ``auto``
values. But when the file is exported to the Conan local cache, the copied recipe in the local cache
will point to the captured remote and commit:

```python
from conans import ConanFile, CMake, tools

class HelloConan(ConanFile):
        scm = {
        "type": "git",
        "subfolder": "hello",
        "url": "https://github.com/conan-io/hello.git",
        "revision": "19380c373eae768b432417058cea2c22980e4b15"
        }
```

So when you upload the recipe to a Conan remote, the recipe will contain
the "resolved" URL and commit.

When you are requiring your ``HelloConan``, the `conan install` will retrieve the recipe from the
remote. If you are building the package, the source code will be fetched from the captured url/commit.

As SCM attributes are evaluated in the workspace context, you can write more complex functions to
retrieve the proper values, this source *conanfile.py* will be valid too:

```python
import os
from conans import ConanFile, CMake, tools

def get_remote_url():
    """ Get remote url regardless of the cloned directory """
    here = os.path.dirname(__file__)
    svn = tools.SVN(here)
    return svn.get_remote_url()

class HelloConan(ConanFile):
    scm = {
        "type": "svn",
        "subfolder": "hello",
        "url": get_remote_url(),
        "revision": "auto"
    }
```

#### Instructions

1. Add `scm` attribute in `conanfile.py`{{open}} with `conan-io/hello`
2. The `scm` attribute must contain a specific `revision`
3. Remove `source()` method from `conanfile.py`{{open}}
4. Create a new package using the reference `Hello/0.1@scm/testing`

#### Hints

When doing a `conan create` of a recipe using ``scm``, Conan will save the path to the local source repository. Every time the
`conan create` command is invoked, the sources will not be downloaded from the remote repository but copied from the local directory.

This allows building packages making changes to the source code without the need of committing them and pushing them to the remote
repository. This convenient to speed up the development of your packages when cloning from a local repository.

**Warning:** This optimization can lead to non-reproducible packages if changes in the source code are not committed and the recipe is
uploaded with its packages to a remote.