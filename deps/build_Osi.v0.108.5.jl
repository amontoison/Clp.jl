using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libOsi"], :libOsi),
    LibraryProduct(prefix, ["libOsiCommonTests"], :libOsiCommonTests),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaBinaryWrappers/Osi_jll.jl/releases/download/Osi-v0.108.5+2"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.aarch64-linux-gnu-cxx03.tar.gz", "b22132f3806c28cda7f860de9606a2d3cf821846704cf0605fa3d271faf91231"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.aarch64-linux-gnu-cxx11.tar.gz", "85c97895c3087ab9e70ce91d1bf8ebc974b781909b2cd889482e3ba2c5226129"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.aarch64-linux-musl-cxx03.tar.gz", "7564b897047ed37f95d8dafa1109a46851188cd822673c48739df0d1ddfadd4b"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.aarch64-linux-musl-cxx11.tar.gz", "c532560d2e1892ba5ebb8c8392b2642d519dbd4c4f669b31a5b1b4f89bc43777"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.armv7l-linux-gnueabihf-cxx03.tar.gz", "a179769ac9dff73c8a2b53cc0d56b31034cad9618b3e9fd1ec186061df2b1498"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.armv7l-linux-gnueabihf-cxx11.tar.gz", "193e5f5c75877843db3b9c8890c9b53f9c5049bfe1fd55a345f3ecaeff200e53"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.armv7l-linux-musleabihf-cxx03.tar.gz", "ed0113954e87e6335ace16ee5d4a80768538b6a1f19594db6d4bd1b69bd3b7f2"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.armv7l-linux-musleabihf-cxx11.tar.gz", "1071c0aae46951f98997b7afe735fddb01f3cc95fa096d9f25e4dc6476273e56"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.i686-linux-gnu-cxx03.tar.gz", "84dd3e580b4a68457c0a2f2e1d52f24a3ac96254b2dd69029f1fe3adcbe78ae0"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.i686-linux-gnu-cxx11.tar.gz", "7123079b46213a355190a89ba2bbc54cea49b9ea4e9a2dc7a749cace07f32ae4"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.i686-linux-musl-cxx03.tar.gz", "78231a09e6d77d8ba38519aed44cf1d2c8135bf95b5c546522e1981424a4b58d"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.i686-linux-musl-cxx11.tar.gz", "21ddd9a2e31609b126439e2dbdf2e85b29ed233f095322958fec8c562f2a1cca"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.i686-w64-mingw32-cxx03.tar.gz", "485d349d4631ae90f0d50ce16a2771846f5f81514101b0633abceeec26fc73f0"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.i686-w64-mingw32-cxx11.tar.gz", "df32d376da4fb9e69e93cf2b8bf38132437cf2c39e65830539b85e1967c253b3"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.x86_64-apple-darwin14-cxx03.tar.gz", "e0aea3fd07013c8740a48e84bd2d7e9a5bec7755979be27911b085753f68171c"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.x86_64-apple-darwin14-cxx11.tar.gz", "53da6cf3d2c73f0a2bc7ee4d9855894214a1507be744571d859a610e1ee099a6"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.x86_64-linux-gnu-cxx03.tar.gz", "495a529761f2dfa8d494901dda3a1cf575d12a381cf3824a11bcf07a58646d56"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.x86_64-linux-gnu-cxx11.tar.gz", "49003732bc3ad79103ba7c3fdd463b2356d0aedd587a10589943c9e1de591edb"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.x86_64-linux-musl-cxx03.tar.gz", "bc9a1ad02fca2b93a7f4229831de7f0917a09ee00cfb934ae849e46975a6f505"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.x86_64-linux-musl-cxx11.tar.gz", "96855a8175373605401915a8b163fbe97300de1337b006e3284d31b0559480bf"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/Osi.v0.108.5.x86_64-w64-mingw32-cxx03.tar.gz", "f3c436822340c0076c61f220669f67c3d32c6420128b6baa059ba70ea6ae4c70"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/Osi.v0.108.5.x86_64-w64-mingw32-cxx11.tar.gz", "70c1ad0563ac300ec0cbd3c1b3420bd07d33cf06d124d746b2e349b0f0f53769"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
dl_info = choose_download(download_info, platform_key_abi())
if dl_info === nothing && unsatisfied
    # If we don't have a compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
end

# If we have a download, and we are unsatisfied (or the version we're
# trying to install is not itself installed) then load it up!
if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
    # Download and install binaries
    install(dl_info...; prefix=prefix, force=true, verbose=verbose)
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
