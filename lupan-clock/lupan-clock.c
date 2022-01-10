#include <X11/Xlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>

static void die(const char *errstr);

void die(const char *errstr) {
	fputs(errstr, stderr);
	exit(EXIT_FAILURE);
}

void show(Display *dpy, int root, struct tm *tm)
{
	char s[6];
	strftime(s, sizeof(s), "%H:%M", tm);
        XStoreName(dpy, root, s);
	XSync(dpy, True);
}

int main() {
	Display *dpy;
	int root, h, m, init = 60;
	time_t t;
	struct tm *tm;

	if (!(dpy = XOpenDisplay(NULL)))
		die("lupan-clock: cannot open display\n");
	root = DefaultRootWindow(dpy);
	while (1) {
		t = time(NULL);
		tm = localtime(&t);
		if (tm->tm_hour != h || tm->tm_min != m || init > 0) {
			show(dpy, root, tm);
			h = tm->tm_hour;
			m = tm->tm_min;
			init = (init > 0) ? init - 1 : 0;
		}
		sleep(1);
	}
	return 1;
}
