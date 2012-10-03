public class Qiaoke.MainWindow : Gtk.Window {

  public  TerminalManager   qiaoke_manager  = new TerminalManager();
  private Gtk.VBox          main_box        = new Gtk.VBox(false, 0);
  private Gtk.VPaned        resizer         = new Gtk.VPaned();
  private Gtk.Fixed         resizer_fixed1  = new Gtk.Fixed();
  private Gtk.Fixed         resizer_fixed2  = new Gtk.Fixed();

  private bool              is_fullscreen   = false;

  public  static Gtk.Window        instance;

  public MainWindow() {
    this.title = "Qiaoke!";
    this.set_border_width(0);
    this.set_decorated(false);
    this.set_keep_above(true);
    this.set_skip_taskbar_hint(true);
    this.set_skip_pager_hint(true);
    this.set_urgency_hint(true);
    this.set_gravity(Gdk.Gravity.STATIC);
    this.set_colormap(this.get_screen().get_rgba_colormap());

    Hotkey.bind(Config.fullscreen, accel_fullscreen_cb);
    this.add_accel_group(Hotkey.accel_group);

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

    Config.signal.window_height_changed.connect(set_position_size);

    instance = this;
  }

  public void toggle() {
    if ( this.get_visible() ) {
      this.hide();
    } else {
      this.show();
    }
  }

  private bool accel_fullscreen_cb(Gtk.AccelGroup accel_group, GLib.Object acceleratable, uint keyval, Gdk.ModifierType modifier) {
    if (this.is_fullscreen) {
      this.resizer.show();
      this.unfullscreen();
      this.is_fullscreen = false;
    } else {
      this.resizer.hide();
      this.fullscreen();
      this.is_fullscreen = true;
    }
    return true;
  }

  private bool resize_window_cb(Gdk.EventMotion event) {
    Gdk.ModifierType mod_type;
    double[] axes = {};
    event.device.get_state(this.window, axes, out mod_type);
    if (mod_type == Gdk.ModifierType.BUTTON1_MASK) {
      int height = (int)(event.y_root / (this.get_screen().get_height() / 100.0));
      if (height < 1) {
        height = 1;
      }
      Config.window_height = height;
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
    this.set_position_size();
    this.qiaoke_manager.set_terminal_focus();
    return false;
  }

  private void set_position_size() {
    Gdk.Rectangle rect;
    var screen  = this.get_screen();
    int monitor = Config.monitor;
    if ( monitor >= screen.get_n_monitors()) {
      monitor = 0;
      Config.monitor = 0;
    }
    screen.get_monitor_geometry(monitor, out rect);

    rect.height = rect.height * Config.window_height / 100;
    this.move(rect.x, rect.y);
    this.resize(rect.width, rect.height);
  }

  public static Gtk.Window get_instance() {
    return instance;
  }

}