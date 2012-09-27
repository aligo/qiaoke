public class MainWindow : Gtk.Window {

  public MainWindow() {
    this.title = "Qiaoke!";

    var qiaoke_box = new Qiaoke.TerminalBox();

    this.add(qiaoke_box);
    this.destroy.connect (Gtk.main_quit);


    Tomboy.keybinder_init();
    Tomboy.keybinder_bind("<Super>F12", this.key_handler_func, null);
  }

  public void display() {
    this.show();
  }

  private void key_handler_func() {
    print("Super F12");
  }

}