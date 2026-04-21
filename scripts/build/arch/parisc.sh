# Compute parisc-specific values

CT_DoArchTupleValues()
{
    # The architecture part of the tuple:
    CT_TARGET_ARCH="${CT_ARCH}${target_bits_64}"
}

CT_DoArchUClibcConfig()
{
    local cfg="${1}"

    CT_DoArchUClibcSelectArch "${cfg}" "parisc"
}

CT_DoArchMultilibTarget ()
{
    local target_var="${1}"; shift
    local -a multi_flags=( "$@" )
    local target_

    local m32=false
    local m64=false

    for m in "${multi_flags[@]}"; do
        case "$m" in
            -m32)     m32=true ;;
            -m64)     m64=true ;;
        esac
    done

    eval target_=\"\${${target_var}}\"

    # Fix up bitness
    case "${target_}" in
        hppa-*)      $m64 && target_=${target_/#hppa-/hppa64-} ;;
        hppa64-*)    $m32 && target_=${target_/#hppa64-/hppa-} ;;
    esac

    # Set the target variable
    eval ${target_var}=\"${target_}\"
}