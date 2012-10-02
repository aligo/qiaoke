public class Qiaoke.TerminalMenu : Gtk.Menu {

  private TerminalManager manager;

  private Gtk.MenuItem copy           = new Gtk.MenuItem.with_label("Copy");
  private Gtk.MenuItem paste          = new Gtk.MenuItem.with_label("Paste");
  private Gtk.MenuItem find           = new Gtk.MenuItem.with_label("Find...");
  private Gtk.MenuItem find_next      = new Gtk.MenuItem.with_label("Find Next");
  private Gtk.MenuItem find_previous  = new Gtk.MenuItem.with_label("Find Previous");
  private Gtk.MenuItem terminal_reset = new Gtk.MenuItem.with_label("Terminal Reset");
  private Gtk.MenuItem close_tab      = new Gtk.MenuItem.with_label("Close Tab");
  private Gtk.MenuItem quit           = new Gtk.MenuItem.with_label("Quit");

  public TerminalMenu (TerminalManager manager) {
    this.manager = manager;

    this.copy.activate.connect(this.copy_cb);
    this.paste.activate.connect(this.paste_cb);
    this.find.activate.connect(this.find_cb);
    this.find_next.activate.connect(this.find_next_cb);
    this.find_previous.activate.connect(this.find_previous_cb);
    this.terminal_reset.activate.connect(this.terminal_reset_cb);
    this.close_tab.activate.connect(this.close_tab_cb);
    this.quit.activate.connect(this.quit_cb);

    this.append(this.copy);
    this.append(this.paste);
    this.append(new Gtk.SeparatorMenuItem());
    this.append(this.find);
    this.append(this.find_next);
    this.append(this.find_previous);
    this.append(new Gtk.SeparatorMenuItem());
    this.append(this.terminal_reset);
    this.append(this.close_tab);
    this.append(this.quit);
    this.show_all();
    this.show.connect(this.show_cb);

    Hotkey.bind(Config.copy,            accel_copy_cb);
    Hotkey.bind(Config.paste,           accel_paste_cb);
    Hotkey.bind(Config.find,            accel_find_cb);
    Hotkey.bind(Config.find_next,       accel_find_next_cb);
    Hotkey.bind(Config.find_previous,   accel_find_previous_cb);
    Hotkey.bind(Config.terminal_reset,  accel_terminal_reset_cb);
    Hotkey.bind(Config.new_tab,         accel_new_tab_cb);
    Hotkey.bind(Config.close_tab,       accel_close_tab_cb);
    Hotkey.bind(Config.quit,            accel_quit_cb);
  }

  private void copy_cb() {
    Terminal terminal = this.manager.get_current_terminal_box().terminal;
    if (terminal.get_has_selection()) {
      terminal.copy_clipboard();
    }
  }

  private void show_cb() {
    bool search_sensitive = this.manager.get_current_terminal_box().terminal.search_sensitive;
    this.find_next.set_sensitive(search_sensitive);
    this.find_previous.set_sensitive(search_sensitive);
  }

  private void paste_cb() {
    this.manager.get_current_terminal_box().terminal.paste_clipboard();
  }

  private void find_cb() {
    this.manager.get_current_terminal_box().terminal.run_search_dialog();
  }

  private void find_next_cb() {
    this.manager.get_current_terminal_box().terminal.search_find_next();
  }

  private void find_previous_cb() {
    this.manager.get_current_terminal_box().terminal.search_find_previous();
  }

  private void terminal_reset_cb() {
    this.manager.get_current_terminal_box().terminal.reset(true, true);
  }

  private void close_tab_cb() {
    this.manager.get_current_terminal_box().close();
  }

  private void quit_cb() {
    Qiaoke.Appliction.quit();
  }

  private bool accel_copy_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.copy_cb();
    return true;
  }

  private bool accel_paste_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.paste_cb();
    return true;
  }

  private bool accel_find_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.find_cb();
    return true;
  }

  private bool accel_find_next_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.find_next_cb();
    return true;
  }

  private bool accel_find_previous_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.find_previous_cb();
    return true;
  }

  private bool accel_new_tab_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.manager.new_tab();
    return true;
  }

  private bool accel_close_tab_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.close_tab_cb();
    return true;
  }

  private bool accel_terminal_reset_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.terminal_reset_cb();
    return true;
  }

  private bool accel_quit_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    this.quit_cb();
    return true;
  }

}