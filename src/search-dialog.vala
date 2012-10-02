public class Qiaoke.SearchDialog : Gtk.Dialog {

  private Gtk.HBox        search_box              = new Gtk.HBox(false, 12);
  private Gtk.Label       search_label            = new Gtk.Label("Search for:");
  private Gtk.Entry       search_entry            = new Gtk.Entry();

  private Gtk.CheckButton match_case_check        = new Gtk.CheckButton.with_label("Match case");
  private Gtk.CheckButton entire_word_check       = new Gtk.CheckButton.with_label("Match entire word only");
  private Gtk.CheckButton regex_check             = new Gtk.CheckButton.with_label("Match as regular expression");
  private Gtk.CheckButton search_backwards_check  = new Gtk.CheckButton.with_label("Search backwards");
  private Gtk.CheckButton wrap_around_check       = new Gtk.CheckButton.with_label("Wrap around");

  private Terminal        terminal;

  public SearchDialog(Terminal terminal) {
    this.terminal = terminal;
    this.title = "Find";
    this.set_transient_for(MainWindow.get_instance());
    this.set_modal(true);
    this.set_resizable(false);
    this.set_border_width(10);
    this.vbox.set_spacing(2);
    this.add_button(Gtk.Stock.CANCEL, Gtk.ResponseType.REJECT);
    this.add_button("Find", Gtk.ResponseType.ACCEPT);

    this.search_box.pack_start(this.search_label, false, false);
    this.search_box.pack_start(this.search_entry, false, false);

    this.search_entry.set_text(this.terminal.search_text);
    this.match_case_check.set_active(this.terminal.search_match_case);
    this.entire_word_check.set_active(this.terminal.search_entire_word);
    this.regex_check.set_active(this.terminal.search_regex);
    this.search_backwards_check.set_active(this.terminal.search_backwards);
    this.wrap_around_check.set_active(this.terminal.search_wrap_around);

    this.vbox.pack_start(this.search_box, false, false);
    this.vbox.pack_start(this.match_case_check, false, false);
    this.vbox.pack_start(this.entire_word_check, false, false);
    this.vbox.pack_start(this.regex_check, false, false);
    this.vbox.pack_start(this.search_backwards_check, false, false);
    this.vbox.pack_start(this.wrap_around_check, false, false);

    this.vbox.show_all();

    this.search_entry.activate.connect(entry_activate_cb);
    this.response.connect(response_cb);
  }

  private GLib.Regex get_regex() {
    string pattern = this.terminal.search_text;
    GLib.RegexCompileFlags comilpe_flags = GLib.RegexCompileFlags.OPTIMIZE;
    if (! this.terminal.search_match_case ) {
      comilpe_flags |= GLib.RegexCompileFlags.CASELESS;
    }
    if ( this.terminal.search_regex ) {
      comilpe_flags |= GLib.RegexCompileFlags.MULTILINE;
    } else {
      pattern = GLib.Regex.escape_string(pattern, -1);
    }
    if (this.terminal.search_entire_word) {
      pattern = "\\b" + pattern + "\\b";
    }
    GLib.Regex regex = new GLib.Regex(pattern, comilpe_flags, 0);
    return regex;
  }

  private void update_terminal_search() {
    this.terminal.search_text              = this.search_entry.get_text();
    this.terminal.search_match_case        = this.match_case_check.get_active();
    this.terminal.search_entire_word       = this.entire_word_check.get_active();
    this.terminal.search_regex             = this.regex_check.get_active();
    this.terminal.search_backwards         = this.search_backwards_check.get_active();
    this.terminal.search_wrap_around       = this.wrap_around_check.get_active();
  }

  private void entry_activate_cb() {
    this.response_cb(Gtk.ResponseType.ACCEPT);
  }

  private void response_cb(int response_id) {
    this.update_terminal_search();
    if (response_id == Gtk.ResponseType.ACCEPT) {
      this.terminal.search_sensitive = true;
      this.terminal.search_set_gregex(this.get_regex());
      this.terminal.search_set_wrap_around(this.terminal.search_wrap_around);
      if (this.terminal.search_backwards) {
        this.terminal.search_find_previous();
      } else {
        this.terminal.search_find_next();
      }
    }
    this.destroy();
    this.terminal.grab_focus();
  }

}