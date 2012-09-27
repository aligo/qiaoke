public class Qiaoke.TerminalBox : Gtk.HBox {

  public Qiaoke.Terminal terminal = new Qiaoke.Terminal();
  private Gtk.VScrollbar scroll;

  public TerminalBox() {
    this.scroll = new Gtk.VScrollbar(terminal.get_adjustment());
    this.scroll.set_no_show_all(true);
    this.scroll.show();

    this.pack_start(this.terminal, true, true);
    this.pack_start(this.scroll, false, false);

    this.show();
  }

}