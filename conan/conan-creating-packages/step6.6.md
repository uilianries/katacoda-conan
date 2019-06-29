Let's see some examples, corresponding to common scenarios:

- ``MyLib/1.0`` is a shared library that links with a static library ``MyOtherLib/2.0`` package.
  When a new ``MyOtherLib/2.1`` version is released: Do I need to create a new binary for
  ``MyLib/1.0`` to link with it?

  Yes, always, as the implementation is embedded in the ``MyLib/1.0`` shared library. If we
  always want to rebuild our library, even if the channel changes (we assume a channel change could
  mean a source code change):

      def package_id(self):
          # Any change in the MyOtherLib version, user or
          # channel or Package ID will affect our package ID
          self.info.requires["MyOtherLib"].full_package_mode()

- ``MyLib/1.0`` is a shared library, requiring another shared library ``MyOtherLib/2.0`` package.
  When a new ``MyOtherLib/2.1`` version is released: Do I need to create a new binary for
  ``MyLib/1.0`` to link with it?

  It depends. If the public headers have not changed at all, it is not necessary. Actually it might
  be necessary to consider transitive dependencies that are shared among the public headers, how
  they are linked and if they cross the frontiers of the API, it might also lead to
  incompatibilities. If the public headers have changed, it would depend on what changes and how are
  they used in ``MyLib/1.0``. Adding new methods to the public headers will have no impact, but
  changing the implementation of some functions that will be inlined when compiled from
  ``MyLib/1.0`` will definitely require re-building. For this case, it could make sense to have this configuration:

      def package_id(self):
          # Any change in the MyOtherLib version, user or channel
          # or Package ID will affect our package ID
          self.info.requires["MyOtherLib"].full_package_mode()

          # Or any change in the MyOtherLib version, user or
          # channel will affect our package ID
          self.info.requires["MyOtherLib"].full_recipe_mode()

- ``MyLib/1.0`` is a header-only library, linking with any kind (header, static, shared) of library
  in ``MyOtherLib/2.0`` package. When a new ``MyOtherLib/2.1`` version is released: Do I need to
  create a new binary for ``MyLib/1.0`` to link with it?

  Never. The package should always be the same as there are no settings, no options, and in any way a
  dependency can affect a binary, because there is no such binary. The default behavior should be
  changed to:

      def package_id(self):
          self.info.requires.clear()

- ``MyLib/1.0`` is a static library linking to a header only library in ``MyOtherLib/2.0``
  package. When a new ``MyOtherLib/2.1`` version is released: Do I need to create a new binary for
  ``MyLib/1.0`` to link with it? It could happen that the ``MyOtherLib`` headers are strictly used
  in some ``MyLib`` headers, which are not compiled, but transitively included. But in general,
  it is more likely that ``MyOtherLib`` headers are used in ``MyLib`` implementation files, so every
  change in them should imply a new binary to be built. If we know that changes in the channel never
  imply a source code change, as set in our workflow/lifecycle, we could
  write:

      def package_id(self):
          self.info.requires["MyOtherLib"].full_package()
          self.info.requires["MyOtherLib"].channel = None # Channel doesn't change out package ID
