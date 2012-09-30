public class Qiaoke.TerminalMenu : Gtk.Menu {

  private TerminalManager manager;

  private Gtk.MenuItem close_tab  = new Gtk.MenuItem.with_label("Close Tab");
  private Gtk.MenuItem quit       = new Gtk.MenuItem.with_label("Quit");

  public TerminalMenu (TerminalManager manager) {
    this.manager = manager;

    this.close_tab.activate.connect(this.close_tab_cb);
    this.quit.activate.connect(this.quit_cb);

    this.append(new Gtk.SeparatorMenuItem());
    this.append(this.close_tab);
    this.append(this.quit);
    this.show_all();
  }

  private void close_tab_cb() {
    this.manager.get_current_terminal_box().close();
  }

  private void quit_cb() {
    Qiaoke.Appliction.quit();
  }

}