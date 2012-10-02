public class Qiaoke.RenameDialog : Gtk.Dialog {

  private Gtk.Entry       entry            = new Gtk.Entry();

  private TerminalBox     terminal_box;

  public RenameDialog(TerminalBox terminal_box) {
    this.terminal_box = terminal_box;
    this.title = "Rename tab";
    this.set_transient_for(MainWindow.get_instance());
    this.set_modal(true);
    this.set_resizable(false);
    this.set_border_width(10);
    this.vbox.set_spacing(2);
    this.add_button(Gtk.Stock.CANCEL, Gtk.ResponseType.REJECT);
    this.add_button(Gtk.Stock.OK, Gtk.ResponseType.ACCEPT);

    this.entry.set_text(this.terminal_box.label.get_label());

    this.vbox.pack_start(this.entry, false, false);
    this.vbox.show_all();

    this.entry.activate.connect(entry_activate_cb);
    this.response.connect(response_cb);
  }

  private void entry_activate_cb() {
    this.response_cb(Gtk.ResponseType.ACCEPT);
  }

  private void response_cb(int response_id) {
    if (response_id == Gtk.ResponseType.ACCEPT) {
      this.terminal_box.label.set_label(this.entry.get_text());
    }
    this.destroy();
    this.terminal_box.terminal.grab_focus();
  }

}
