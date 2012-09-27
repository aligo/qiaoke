public class Qiaoke.Terminal : Vte.Terminal {

  public Terminal() {
    this.set_audible_bell(false);
    this.set_visible_bell(false);
    this.set_sensitive(true);

    this.set_background_transparent(true);
    this.set_opacity(int((100 - 15) / 100.0 * 65535));

    this.grab_focus();
    var pid = this.fork_command(null, null, null, GLib.Environment.get_home_dir(), false, false, false);
    this.show();
  }

}