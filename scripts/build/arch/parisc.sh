# Compute parisc-specific values

CT_DoArchTupleValues()
{
   # The architecture part of the tuple:
   # For 64-bit parisc, use hppa64 so config.sub produces hppa64-*-*-*
   # rather than canonicalising parisc -> hppa (32-bit only).
   if [ "${CT_ARCH_BITNESS}" = "64" ]; then
       CT_TARGET_ARCH="hppa64"
   else
       CT_TARGET_ARCH="${CT_ARCH}"
   fi
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

    local m31=false
    local m64=false

    for m in "${multi_flags[@]}"; do
        case "${multi_flags}" in
            -m64) m64=true ;;
            -m31) m31=true ;;
        esac
    done

    eval target_=\"\${${target_var}}\"

    # Fix bitness
    case "${target_}" in
        hppa-*)   $m64 && target_=${target_/#hppa-/hppa64-} ;;
        hppa64-*)  $m31 && target_=${target_/#hppa64-/hppa-} ;;
    esac

    # Set the target variable
    eval ${target_var}=\"${target_}\"
}