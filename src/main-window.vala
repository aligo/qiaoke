public class Qiaoke.MainWindow : Gtk.Window {

  public bool is_toggled = false;
  public TerminalBox qiaoke_box = new TerminalBox();

  public MainWindow() {
    this.title = "Qiaoke!";
    this.set_decorated(false);
    this.set_keep_above(true);

    this.add(this.qiaoke_box);
    this.destroy.connect(Gtk.main_quit);
  }

  public void toggle() {
    if ( this.is_toggled ) {
      this.hide();
      this.is_toggled = false;
    } else {
      var window_rect = this.get_final_window_rect();
      this.move(window_rect.x, window_rect.y);
      this.resize(window_rect.width, window_rect.height);
      this.show();
      this.focus(0);
      this.set_terminal_background();
      this.set_terminal_focus();
      this.is_toggled = true;
    }
  }

  public void set_terminal_focus() {
    this.qiaoke_box.terminal.grab_focus();
  }

  public void set_terminal_background() {
    int transparency = 15;
    this.qiaoke_box.terminal.set_background_transparent(true);
    this.qiaoke_box.terminal.set_background_saturation(transparency / 100.0);
    this.qiaoke_box.terminal.set_opacity((100 - transparency) / 100 * 65535);
  }

  public Gdk.Rectangle get_final_window_rect() {
    var screen  = this.get_screen();
    int monitor = screen.get_primary_monitor();
    // int monitor = 0;
    int height  = 30;

    Gdk.Rectangle dest;

    screen.get_monitor_geometry(monitor, out dest);

    dest.height = dest.height * height / 100;

    return dest;
  }
}