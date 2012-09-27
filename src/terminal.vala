public class Qiaoke.Terminal : Vte.Terminal {

  public Terminal() {
    this.set_audible_bell(false);
    this.set_visible_bell(false);
    this.set_sensitive(true);
    this.set_size_request(1,1);

    this.grab_focus();
    var pid = this.fork_command(null, null, null, GLib.Environment.get_home_dir(), false, false, false);
    this.show();
  }

}