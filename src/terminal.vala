public class Qiaoke.Terminal : Vte.Terminal {
  
  private TerminalKiller killer;
  private GLib.Pid pid;
  private string shell = Vte.get_user_shell();

  public bool   search_sensitive         = false;
  public string search_text              = "";
  public bool   search_match_case        = false;
  public bool   search_entire_word       = false;
  public bool   search_regex             = false;
  public bool   search_backwards         = true;
  public bool   search_wrap_around       = true;

  public Terminal() {
    this.set_audible_bell(false);
    this.set_visible_bell(false);
    this.set_sensitive(true);
    this.set_size_request(1,1);

    this.set_background();

    this.grab_focus();
    var args = new string[0];
    GLib.Shell.parse_argv(this.shell, out args);
    this.fork_command_full(Vte.PtyFlags.DEFAULT, GLib.Environment.get_home_dir(), args, null, GLib.SpawnFlags.SEARCH_PATH, null, out this.pid);
    this.killer = new TerminalKiller(this.pid);
    this.show();

    this.button_press_event.connect(this.button_press_event_cb);
  }

  public void kill() {
    unowned Thread<void*> thread_killer = GLib.Thread.create<void*> (this.killer.thread_func, true);
    thread_killer.join();
  }

  public void run_search_dialog() {
    SearchDialog dialog = new SearchDialog(this);
    dialog.run();
  }

  private void set_background() {
    this.set_colors(Config.foreground_color, Config.background_color, Qiaoke.Colors.tango_palette);
    this.set_opacity((uint16)((100.0 - Config.transparency) / 100.0 * 65535));
  }

  private bool button_press_event_cb(Gdk.EventButton event) {
    // press middle button
    if (event.button == 2) {
      if (this.get_has_selection()) {
        this.copy_clipboard();
      } else {
        this.paste_clipboard();
      }
    }
    return false;
  }

}