PREFIX = /usr/local

lupan-clock: lupan-clock.c
	${CC} -o $@ $< -lX11 -Wall

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f lupan-clock ${DESTDIR}${PREFIX}/bin
