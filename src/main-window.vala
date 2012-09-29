public class Qiaoke.MainWindow : Gtk.Window {

  public TerminalManager qiaoke_manager = new TerminalManager();

  public MainWindow() {
    this.title = "Qiaoke!";
    this.set_decorated(false);
    this.set_keep_above(true);
    this.set_skip_taskbar_hint(true);
    this.set_skip_pager_hint(true);
    this.set_urgency_hint(true);
    this.set_gravity(Gdk.Gravity.STATIC);
    this.set_colormap(this.get_screen().get_rgba_colormap());
    this.qiaoke_manager.set_terminal_background();

    this.add(this.qiaoke_manager);
    this.screen_changed.connect(screen_changed_cb);
    this.realize.connect(realize_cb);
    this.expose_event.connect(expose_cb);
  }

  public void toggle() {
    if ( this.get_visible() ) {
      this.hide();
    } else {
      this.show();
    }
  }

  private void realize_cb(Gtk.Widget widget) {
    this.set_position_size();
  }

  private void screen_changed_cb(Gtk.Widget widget, Gdk.Screen old_screen) {
    // this.set_colormap(this.get_screen().get_rgba_colormap());
    // this.set_position_size();
  }

  private bool expose_cb(Gdk.EventExpose event) {
    this.qiaoke_manager.set_terminal_focus();
    return false;
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

}