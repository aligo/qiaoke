public class Qiaoke.Terminal : Vte.Terminal {
  
  private TerminalKiller killer;
  private GLib.Pid pid;
  private string shell = Vte.get_user_shell();

  public Terminal() {
    this.set_audible_bell(false);
    this.set_visible_bell(false);
    this.set_sensitive(true);
    this.set_size_request(1,1);

    this.grab_focus();
    var args = new string[0];
    GLib.Shell.parse_argv(this.shell, out args);
    this.fork_command_full(Vte.PtyFlags.DEFAULT, GLib.Environment.get_home_dir(), args, null, GLib.SpawnFlags.SEARCH_PATH, null, out this.pid);
    this.killer = new TerminalKiller(this.pid);
    this.show();
  }

  public void kill() {
    unowned Thread<void*> thread_killer = GLib.Thread.create<void*> (this.killer.thread_func, true);
    thread_killer.join();
  }

}