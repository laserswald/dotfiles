.POSIX:

.SUFFIXES:
.SUFFIXES: .m4 .yml

all: config.yml displayport.yml
	river-bar config displayport

config.yml: shared.m4 selenized.m4
displayport.yml: shared.m4 selenized.m4

.m4.yml:
	m4 $< > $@

clean:
	rm config.yml displayport.yml
