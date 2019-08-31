It is possible to change the default ``semver_direct_mode`` package-id mode, in the *conan.conf* file:

`conan config set general.default_package_id_mode=full_package_mode`{{execute}}

Note that the default package-id mode is the mode that is used when the package is initialized
and **before** ``package_id()`` method is called. You can still define ``full_package_mode``
as default in *conan.conf*, but if a recipe declare that it is header-only, with:

```
    def package_id(self):
      self.info.header_only() # clears requires, but also settings if existing
      # or if there are no settings/options, this would be equivalent
      self.info.requires.clear() # or self.info.requires.unrelated_mode()
```

That would still be executed, changing the "default" behavior, and leading to a package
that only generates 1 package-id for all possible configurations and versions of dependencies.

Remember that *conan.conf* can be shared and installed with `conan config install`{{execute}}.


#### Instructions

Let's change the package ID our recipe:

2. Let's create a new Conan project: `conan new package/6.5`{{execute}}
1. In your `conanfile.py`{{open}}, add `package_id` method as demonstrated above
2. Configure the package to use `header_only` method.
3. Build your package `conan create . conan/testing -s build_type=Release`{{execute}}
4. Check the Package ID generated.
5. Build your package again, but in debug mode `conan create . conan/testing -s build_type=Debug`{{execute}}
6. Compare the Package ID generated.
