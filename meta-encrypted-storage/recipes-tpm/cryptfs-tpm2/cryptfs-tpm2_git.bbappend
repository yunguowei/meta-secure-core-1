SRC_URI += "\
    file:///tmp/0001-add-luks-service.patch \
"

do_install_append() {
    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'luks', '1', '0', d)}" = "1" ]; then
	install -d ${D}${systemd_unitdir}/system/
	install -d ${D}${sbindir}
        install -m 0755 "${S}/scripts/init.luks" "${D}${sbindir}"
	install -m 0644 "${S}/scripts/luks.service" "${D}${systemd_unitdir}/system/"
    fi
}

inherit systemd

RPROVIDES_${PN} += "${PN}-systemd"
RREPLACES_${PN} += "${PN}-systemd"
RCONFLICTS_${PN} += "${PN}-systemd"
SYSTEMD_SERVICE_${PN} = "luks.service"

