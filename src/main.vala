private class Qiaoke.Appliction {

  private static MainWindow window;

  private static void toggle_window() {
    window.toggle();
  }

  public static int main(string[] args) {
    Gtk.init(ref args);
    Unique.App app = new Unique.App("org.qiaoke.terminal", null);
    if (app.is_running) {
      app.send_message(Unique.Command.ACTIVATE, new Unique.MessageData());
    } else {
      app.message_received.connect(message_received_cb);
      Config.init();
      Hotkey.init();
      Tomboy.keybinder_init();
      Tomboy.keybinder_bind(Config.toggle, toggle_window, null);
      window = new MainWindow();
      window.toggle();

      Gtk.main();
    }
    return 0;
  }

  public static void quit() {
    Config.write();
    Gtk.main_quit();
  }

  private static Unique.Response message_received_cb(int command, Unique.MessageData message_data, uint time) {
    if ( (Unique.Command)command == Unique.Command.ACTIVATE ) {
      window.show();
    }
    return Unique.Response.OK;
  }

}