Let's define a simple scenario whereby there are two packages: ``MyOtherLib/2.0`` and ``MyLib/1.0`` which depends on
``MyOtherLib/2.0``. Let's assume that their recipes and binaries have already been created and uploaded to a Conan remote.

Now, a new release for ``MyOtherLib/2.1`` is released with an improved recipe and new binaries. The ``MyLib/1.0`` is modified and is required to be upgraded to ``MyOtherLib/2.1``.

This scenario will be the same in the case that a consuming project of ``MyLib/1.0`` defines a dependency to ``MyOtherLib/2.1``, which
takes precedence over the existing project in ``MyLib/1.0``.

The question is: **Is it necessary to build new MyLib/1.0 binary packages?** or are the existing packages still valid?

The answer: **It depends**.

Let's assume that both packages are compiled as static libraries and that the API exposed by ``MyOtherLib`` to ``MyLib/1.0`` through the
public headers, has not changed at all. In this case, it is not required to build new binaries for ``MyLib/1.0`` because the final consumer will
link against both ``Mylib/1.0`` and ``MyOtherLib/2.1``.

On the other hand, it could happen that the API exposed by **MyOtherLib** in the public headers has changed, but without affecting the
``MyLib/1.0`` binary for any reason (like changes consisting on new functions not used by **MyLib**).
The same reasoning would apply if **MyOtherLib** was only the header.

But what if a header file of ``MyOtherLib`` -named *myadd.h*- has changed from ``2.0`` to ``2.1``:

   \# *myadd.h* header file in version 2.0

    int addition (int a, int b) { return a - b; }

   \# *myadd.h* header file in version 2.1

    int addition (int a, int b) { return a + b; }

And the ``addition()`` function is called from the compiled *.cpp* files of ``MyLib/1.0``?

Then, **a new binary for MyLib/1.0 is required to be built for the new dependency version**. Otherwise, it will maintain the old, buggy
``addition()`` version. Even in the case that ``MyLib/1.0`` doesn't have any change in its code lines neither in the recipe, the resulting
binary rebuilding ``MyLib`` requires ``MyOtherLib/2.1`` and the package to be different.
