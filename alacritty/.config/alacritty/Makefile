M4 := m4
M4_DEFINITIONS =

.PHONY: light
light: alacritty.yml

.PHONY: dark
dark: M4_DEFINITIONS="-D _DARK_MODE=1" alacritty.yml

alacritty.yml: theme.m4 alacritty.yml.m4
	$(M4) $(M4_DEFINITIONS) $^ > $@
