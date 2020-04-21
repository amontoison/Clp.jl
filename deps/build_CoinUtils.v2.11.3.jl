using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libCoinUtils"], :libCoinUtils),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaBinaryWrappers/CoinUtils_jll.jl/releases/download/CoinUtils-v2.11.3+2"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.aarch64-linux-gnu-cxx03.tar.gz", "bdf03e9d0151b2a36774f50b2ed062809f6c04eb213baeed988a34c3ac86dcdb"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.aarch64-linux-gnu-cxx11.tar.gz", "281d406c299fe4921f526b112bf5c2143740ad622e479d770c61f49dbcd9aa14"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.aarch64-linux-musl-cxx03.tar.gz", "b397be857cffa42b1e0d68a24a4d388e82c68bf88943f5e162d74b350924842f"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.aarch64-linux-musl-cxx11.tar.gz", "d2c5bda683a28994c570bb95709e25144b5249aac0b6a38c1d99033dc7f58858"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.armv7l-linux-gnueabihf-cxx03.tar.gz", "1a72e3f85586fe6547c94f1d11eb8ccef7cceeec105ea7c9680ed3106bb45ba1"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.armv7l-linux-gnueabihf-cxx11.tar.gz", "c99df716b6e04dc9cd0014d7f868f878a6522200dfd13d8599faf41f72f2d5f7"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.armv7l-linux-musleabihf-cxx03.tar.gz", "df024a1162a1881b1e1ba5bef8b668edb218a19afe3b4e7666555b47608f4e0d"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.armv7l-linux-musleabihf-cxx11.tar.gz", "476beb1b75ce5fbbe64bdcfd68b62db113c189a1e66fd2fa5b7d8d85198da018"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.i686-linux-gnu-cxx03.tar.gz", "6ce3f033a2d25c15313640df017bc0cf9eed1b66905a52b5e651ad05bf5970ad"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.i686-linux-gnu-cxx11.tar.gz", "191ca3d57d2cb16bc350bfffc3ab40768921e76c3784ed05ad4c10e194e0d49f"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.i686-linux-musl-cxx03.tar.gz", "83f94924658e648dd0f320eccffc645d7cba32ced25b7b40eaaca671c22dfbc9"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.i686-linux-musl-cxx11.tar.gz", "b180fa8261f9a911fce6210d0cc7caeb7a3937fc754cac6409511cee89c9568d"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.i686-w64-mingw32-cxx03.tar.gz", "3a6f3accc91ea61bc06a6eeab172ca56ac696fe2bb2b5b7bb57bdbc529d0bea3"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.i686-w64-mingw32-cxx11.tar.gz", "b645610f3fc9238eb36acd90a1ab9fe6a1b430dd52f762903b976ae04982e140"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-apple-darwin14-cxx03.tar.gz", "5834f659c246273dea641134febb958f53e76c4fe1f39957dea4f857d5dac60f"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-apple-darwin14-cxx11.tar.gz", "429f5c6fc1ab0e2fc5c764e9e3dc2888b2f50d0341bd1c89b6978bfc268bf5af"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-linux-gnu-cxx03.tar.gz", "b8b9d837d41744e4e246ca0a693feae562eb5b9c0f216f555d0d555a40dbe485"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-linux-gnu-cxx11.tar.gz", "084895866f69ef916828a87aba824adbd74b1b2b12b1e510d8449efef990391e"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-linux-musl-cxx03.tar.gz", "cd26b305bb509f2195e53fb808b138e4582058fd073efbccc8a64f459ac15433"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-linux-musl-cxx11.tar.gz", "cd10e052e2426c228af4d3cb76f30fd3de97c0c0c6596b5aec0603f98f716b63"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-w64-mingw32-cxx03.tar.gz", "8c61b7844d4e3cab25195aba244aed4a0f6b13d62fba50607ee71174deb89172"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("$bin_prefix/CoinUtils.v2.11.3.x86_64-w64-mingw32-cxx11.tar.gz", "a56ea6bab489bd40e9ff13bf61714b34c18c2b739710ffdb74cfe97ebf16a866"),
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
