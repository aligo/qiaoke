public class MainWindow : Gtk.Window {

  public MainWindow() {
    this.title = "Qiaoke!";

    var qiaoke_box = new Qiaoke.TerminalBox();

    this.add(qiaoke_box);
    this.destroy.connect (Gtk.main_quit);
  }

  public void display() {
    this.show();
  }

}