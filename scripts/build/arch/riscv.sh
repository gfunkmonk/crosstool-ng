# Compute RISC-V-specific values

CT_DoArchTupleValues() {
    CT_TARGET_ARCH="riscv${CT_ARCH_BITNESS}${target_endian_be}"
}

CT_DoArchUClibcConfig() {
    local cfg="${1}"
    CT_DoArchUClibcSelectArch "${cfg}" "riscv${CT_ARCH_BITNESS}"
}
