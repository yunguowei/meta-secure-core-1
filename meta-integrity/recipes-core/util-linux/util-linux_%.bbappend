CFLAGS_remove += "-pie -fpie"

# We need -no-pie in case the default is to generate pie code.
#
do_compile_append_class-target() {
    ${CC} ${CFLAGS} ${LDFLAGS} -no-pie -static \
        sys-utils/switch_root.o \
        -o switch_root.static

    ${CC} ${CFLAGS} ${LDFLAGS} -no-pie -static \
        sys-utils/pivot_root.o \
	 -o pivot_root.static
}

do_install_append_class-target() {
    install -d "${D}${sbindir}"
    install -m 0700 "${B}/switch_root.static" \
        "${D}${sbindir}/switch_root.static"
   
    install -m 0700 "${B}/pivot_root.static" \
        "${D}${sbindir}/pivot_root.static"
}

PACKAGES =+ "${PN}-switch-root.static"
PACKAGES =+ "${PN}-pivot-root.static"

FILES_${PN}-switch-root.static = "${sbindir}/switch_root.static"
FILES_${PN}-pivot-root.static = "${sbindir}/pivot_root.static"
