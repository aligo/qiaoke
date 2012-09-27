public class MainWindow : Gtk.Window {

  public bool is_toggled = false;

  public MainWindow() {
    this.title = "Qiaoke!";

    var qiaoke_box = new Qiaoke.TerminalBox();

    this.add(qiaoke_box);
    this.destroy.connect (Gtk.main_quit);

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
}