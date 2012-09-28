public class Qiaoke.MainWindow : Gtk.Window {

  public bool is_toggled = false;
  public TerminalBox qiaoke_box = new TerminalBox();

  public MainWindow() {
    this.title = "Qiaoke!";
    this.set_decorated(false);
    this.set_keep_above(true);
    this.set_terminal_background();

    this.add(this.qiaoke_box);
    this.screen_changed.connect(screen_changed_cb);
    this.realize.connect(realize_cb);
    this.expose_event.connect(expose_cb);
  }

  public void toggle() {
    if ( this.is_toggled ) {
      this.hide();
      this.is_toggled = false;
    } else {
      this.show();
      this.is_toggled = true;
    }
  }

  private void realize_cb(Gtk.Widget widget) {
    this.set_position_size();
  }

  private void screen_changed_cb(Gtk.Widget widget, Gdk.Screen old_screen) {
    this.set_position_size();
  }

  private bool expose_cb(Gdk.EventExpose event) {
    this.focus(0);
    this.set_terminal_focus();
    return true;
  }

  private void set_position_size() {
    Gdk.Rectangle rect;
    var screen  = this.get_screen();
    int monitor = screen.get_primary_monitor();
    // int monitor = 0;
    int height  = 30;
    screen.get_monitor_geometry(monitor, out rect);

    rect.height = rect.height * height / 100;
    this.move(rect.x, rect.y);
    this.resize(rect.width, rect.height);
  }

  private void set_terminal_focus() {
    this.qiaoke_box.terminal.grab_focus();
  }

  private void set_terminal_background() {
    int transparency = 15;
    this.qiaoke_box.terminal.set_background_transparent(true);
    this.qiaoke_box.terminal.set_background_saturation(transparency / 100.0);
    this.qiaoke_box.terminal.set_opacity((100 - transparency) / 100 * 65535);
  }

}