The ``self.info`` object has also a ``requires`` object. It is a dictionary containing the necessary information for each requirement, all direct
and transitive dependencies. For example, ``self.info.requires["MyOtherLib"]`` is a ``RequirementInfo`` object.

- Each ``RequirementInfo`` has the following `read only` reference fields:

    - ``full_name``: Full require's name, e.g., **MyOtherLib**
    - ``full_version``: Full require's version, e.g., **1.2**
    - ``full_user``: Full require's user, e.g., **my_user**
    - ``full_channel``: Full require's channel, e.g., **stable**
    - ``full_package_id``: Full require's package ID, e.g., **c6d75a...**

- The following fields are used in the ``package_id()`` evaluation:

    - ``name``: By default same value as full_name, e.g., **MyOtherLib**.
    - ``version``: By default the major version representation of the ``full_version``.
      E.g., **1.Y** for a **1.2** ``full_version`` field and **1.Y.Z** for a **1.2.3**
      ``full_version`` field.
    - ``user``: By default ``None`` (doesn't affect the package ID).
    - ``channel``: By default ``None`` (doesn't affect the package ID).
    - ``package_id``: By default ``None`` (doesn't affect the package ID).

When defining a package ID for model dependencies, it is necessary to take into account two factors:

- The versioning schema followed by our requirements (semver?, custom?).
- The type of library being built or reused (shared (*.so*, *.dll*, *.dylib*), static).