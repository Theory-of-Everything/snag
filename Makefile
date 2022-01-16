ifndef PREFIX
	PREFIX = ~/.local/share
endif
ifndef MANPREFIX
	MANPREFIX = $(PREFIX)/man
endif

install:
ifneq ($(shell id -u), 0)
	@# Make directories
	mkdir -p $(DESDIR)$(PREFIX)/bin
	mkdir -p $(DESDIR)$(MANPREFIX)/man/man1

	@# Install files
	install snag.zsh $(DESDIR)$(PREFIX)/bin/snag
	install snag.1 $(DESDIR)$(MANPREFIX)/man1/snag.1.gz

	@# Manage Permissions
	chmod 755 $(DESDIR)$(PREFIX)/bin/snag
	chmod 644 $(DESDIR)$(MANPREFIX)/man1/snag.1.gz
else
	@echo "You are root, please run as an unprivileged user."
endif

uninstall:
ifneq ($(shell id -u), 0)

	@# Remove files
	rm -f $(DESDIR)$(PREFIX)/bin/snag
	rm -f $(DESDIR)$(PREFIX)/man1/snag.1.gz
else
	@echo "You are root, please run as anunprivileged user."
endif

man:
ifneq ($(shell id -u), 0)
	@# Make directories
	mkdir -p $(DESDIR)$(MANPREFIX)/man/man1

	@# Install files
	install snag.1 $(DESDIR)$(MANPREFIX)/man1/snag.1.gz

	@# Manage Permissions
	chmod 644 $(DESDIR)$(MANPREFIX)/man1/snag.1.gz
else
	@echo "You are root, please run as an unprivileged user."
endif


.PHONY: install uninstall man
