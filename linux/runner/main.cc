#include "my_application.h"

#ifdef GDK_WINDOWING_X11
#include <X11/Xlib.h>
#endif

int main(int argc, char** argv) {
  // Initialize X11 threading support before any other X11 calls
#ifdef GDK_WINDOWING_X11
  XInitThreads();
#endif

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
