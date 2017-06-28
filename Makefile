
tool := rfcdiff

sources += rfcdiff.pyht rfcdiff.base rfcdiff.js

include Makefile.common

mlchanges := $(shell sed -n "/^$(tool) ($(version).*)/,/^ -- /p" changelog | awk '{ if (line) print line "\\n"; line=$$0 }' )

# Inline the javascript code from ekr in the distribution binary
$(tool): $(tool).base
	python ekr/merge.py $(tool).base $(tool).js $(tool)

upload::
	echo -e "\n\
	Hi,\n\
	\n\
	This is an automatic notification about a new $(tool) version, v$(version),\n\
	generated when doing 'make upload' for $(tool).\n\
	\n\
	Release notes:\n\
	\n\
	$(mlchanges)\n\
	\n\
	The new version is available for download here:\n\
	  http://$$(hostname).tools.ietf.org/tools/$(tool)/$(tool)-v$(version)\n\
	\n\
	Regards,\n\
	\n\
		Henrik\n\
	" | mail -s "New $(tool) release: v$(version)" henrik@levkowetz.com -c hobbes1069@gmail.com
