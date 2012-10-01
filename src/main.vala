private class Qiaoke.Appliction {

  private static MainWindow window;

  private static void toggle_window() {
    window.toggle();
  }

  public static void main(string[] args) {
    Gtk.init(ref args);

    Config.init();
    Hotkey.init();
    Tomboy.keybinder_init();
    Tomboy.keybinder_bind(Config.toggle, toggle_window, null);
    window = new MainWindow();
    window.toggle();

    Gtk.main();
  }

  public static void quit() {
    Config.write();
    Gtk.main_quit();
  }

}