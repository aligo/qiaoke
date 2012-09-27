public class Qiaoke.MainWindow : Gtk.Window {

  public bool is_toggled = false;
  public TerminalBox qiaoke_box = new TerminalBox();

  public MainWindow() {
    this.title = "Qiaoke!";
    // this.set_decorated(false);

    this.add(this.qiaoke_box);
    this.destroy.connect(Gtk.main_quit);
  }

  public void toggle() {
    if ( this.is_toggled ) {
      this.hide();
      this.is_toggled = false;
    } else {
      this.show();
      this.set_terminal_focus();
      this.is_toggled = true;
    }
  }

  public void set_terminal_focus() {
    this.qiaoke_box.terminal.grab_focus();
  }
}