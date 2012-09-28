public class Qiaoke.Terminal : Vte.Terminal {

  private GLib.Pid? child_pid = null;
  private string shell = Vte.get_user_shell();

  public Terminal() {
    this.set_audible_bell(false);
    this.set_visible_bell(false);
    this.set_sensitive(true);
    this.set_size_request(1,1);

    this.grab_focus();
    var args = new string[0];
    GLib.Shell.parse_argv(this.shell, out args);
    this.fork_command_full(Vte.PtyFlags.DEFAULT, GLib.Environment.get_home_dir(), args, null, GLib.SpawnFlags.SEARCH_PATH, null, out this.child_pid);
    this.show();
  }

}