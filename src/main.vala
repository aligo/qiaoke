private class Qiaoke.Appliction {

  private static MainWindow window;

  private static void key_handler_func() {
    toggle_window();
  }

  private static void toggle_window() {
    window.toggle();
  }

  public static void main(string[] args) {
    Gtk.init(ref args);

    Tomboy.keybinder_init();
    Tomboy.keybinder_bind("F5", key_handler_func, null); //temporary binding to F5
    window = new MainWindow();
    window.toggle();

    Gtk.main();
  }

}