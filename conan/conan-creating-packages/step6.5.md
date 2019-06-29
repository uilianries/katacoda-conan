It is possible to change the default ``semver_direct_mode`` package-id mode, in the
*conan.conf* file:

   \# *conan.conf* configuration file

   [general]
   default_package_id_mode=full_package_mode

Possible values are the names of the above methods: ``full_recipe_mode``, ``semver_mode``, etc.

Note that the default package-id mode is the mode that is used when the package is initialized
and **before** ``package_id()`` method is called. You can still define ``full_package_mode``
as default in *conan.conf*, but if a recipe declare that it is header-only, with:

    def package_id(self):
      self.info.header_only() # clears requires, but also settings if existing
      # or if there are no settings/options, this would be equivalent
      self.info.requires.clear() # or self.info.requires.unrelated_mode()

That would still be executed, changing the "default" behavior, and leading to a package
that only generates 1 package-id for all possible configurations and versions of dependencies.

Remember that *conan.conf* can be shared and installed with `conan_config_install`.
