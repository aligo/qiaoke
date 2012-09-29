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

  public void set_background() {
    int transparency = 30;
    Gdk.Color bgcolor = {0, 0x0000, 0x0000, 0x0000};
    Gdk.Color fgcolor = {0, 0xffff, 0xffff, 0xffff};
    this.set_colors(fgcolor, bgcolor, Qiaoke.Colors.tango_palette);
    this.set_opacity((uint16)((100.0 - transparency) / 100.0 * 65535));
  }

}