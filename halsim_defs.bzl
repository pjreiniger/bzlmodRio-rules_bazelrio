
def __prepare_halsim(halsim_deps):
    extension_names = []
    for dep in halsim_deps:
        lbl = Label(dep)
        extension_names.append(lbl.name)

    return extension_names


def halsim_cc_binary(
    name,
    deps = [],
    halsim_deps = [],
    **kwargs
):
    print(deps)
    extension_names = __prepare_halsim(halsim_deps)
    env = select({
        "@bazel_tools//src/conditions:windows": {"HALSIM_EXTENSIONS": ";".join(extension_names)},
        "//conditions:default": {"HALSIM_EXTENSIONS": ":".join(extension_names)},
    })

    print(env)

    native.cc_binary(
        name = name,
        deps = deps + halsim_deps,
        env = env,
        **kwargs
    )