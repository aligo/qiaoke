public class Qiaoke.MainWindow : Gtk.Window {

  public Gtk.VBox         main_box        = new Gtk.VBox(false, 0);
  public TerminalManager  qiaoke_manager  = new TerminalManager();
  public Gtk.VPaned       resizer         = new Gtk.VPaned();
  public Gtk.Fixed        resizer_fixed1  = new Gtk.Fixed();
  public Gtk.Fixed        resizer_fixed2  = new Gtk.Fixed();

  public int              height          = 30;

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

    this.resizer.pack1(this.resizer_fixed1, false, true);
    this.resizer.pack2(this.resizer_fixed2, true, true);
    this.resizer.motion_notify_event.connect(this.resize_window_cb);
    this.resizer.show_all();

    this.main_box.pack_start(this.qiaoke_manager, true, true);
    this.main_box.pack_start(this.resizer, false, false);

    this.main_box.show();
    this.add(this.main_box);

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

  private bool resize_window_cb(Gdk.EventMotion event) {
    Gdk.ModifierType mod_type;
    double[] axes = {};
    event.device.get_state(this.window, axes, out mod_type);
    if (mod_type == Gdk.ModifierType.BUTTON1_MASK) {
      this.height = (int)(event.y_root / (this.get_screen().get_height() / 100.0));
      if (this.height < 1) {
        this.height = 1;
      }
      this.set_position_size();
    }
    return true;
  }

  private void realize_cb(Gtk.Widget widget) {
    this.set_position_size();
  }

  private void screen_changed_cb(Gtk.Widget widget, Gdk.Screen old_screen) {
    this.set_colormap(this.get_screen().get_rgba_colormap());
    this.set_position_size();
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
    screen.get_monitor_geometry(monitor, out rect);

    rect.height = rect.height * this.height / 100;
    this.move(rect.x, rect.y);
    this.resize(rect.width, rect.height);
  }

}