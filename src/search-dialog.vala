public class Qiaoke.SearchDialog : Gtk.Dialog {

  private Gtk.HBox        search_box              = new Gtk.HBox(false, 12);
  private Gtk.Label       search_label            = new Gtk.Label("Search for:");
  private Gtk.Entry       search_entry            = new Gtk.Entry();

  private Gtk.CheckButton match_case_check        = new Gtk.CheckButton.with_label("Match case");
  private Gtk.CheckButton entire_word_check       = new Gtk.CheckButton.with_label("Match entire word only");
  private Gtk.CheckButton regex_check             = new Gtk.CheckButton.with_label("Match as regular expression");
  private Gtk.CheckButton search_backwards_check  = new Gtk.CheckButton.with_label("Search backwards");
  private Gtk.CheckButton wrap_around_check       = new Gtk.CheckButton.with_label("Wrap around");

  public static string search_text       = "";
  public static bool   match_case        = false;
  public static bool   entire_word       = false;
  public static bool   regex             = false;
  public static bool   search_backwards  = true;
  public static bool   wrap_around       = true;

  public SearchDialog() {
    this.title = "Find";
    this.set_modal(false);
    this.set_resizable(false);
    this.set_border_width(10);
    this.vbox.set_spacing(2);
    this.add_button(Gtk.Stock.CANCEL, Gtk.ResponseType.REJECT);
    this.add_button("Find", Gtk.ResponseType.ACCEPT);

    this.search_box.pack_start(this.search_label, false, false);
    this.search_box.pack_start(this.search_entry, false, false);

    this.search_entry.set_text(search_text);
    this.match_case_check.set_active(match_case);
    this.entire_word_check.set_active(entire_word);
    this.regex_check.set_active(regex);
    this.search_backwards_check.set_active(search_backwards);
    this.wrap_around_check.set_active(wrap_around);

    this.vbox.pack_start(this.search_box, false, false);
    this.vbox.pack_start(this.match_case_check, false, false);
    this.vbox.pack_start(this.entire_word_check, false, false);
    this.vbox.pack_start(this.regex_check, false, false);
    this.vbox.pack_start(this.search_backwards_check, false, false);
    this.vbox.pack_start(this.wrap_around_check, false, false);

    this.vbox.show_all();
  }

  public GLib.Regex get_regex() {
    string pattern = search_text;
    GLib.RegexCompileFlags comilpe_flags = GLib.RegexCompileFlags.OPTIMIZE;
    if (! match_case ) {
      comilpe_flags |= GLib.RegexCompileFlags.CASELESS;
    }
    if (regex) {
      comilpe_flags |= GLib.RegexCompileFlags.MULTILINE;
    } else {
      pattern = GLib.Regex.escape_string(pattern, -1);
    }
    if (entire_word) {
      pattern = pattern.printf("\\b%s\\b");
    }
    GLib.Regex regex = new GLib.Regex(pattern, comilpe_flags, 0);
    return regex;
  }

  public void save() {
    search_text       = this.search_entry.get_text();
    match_case        = this.match_case_check.get_active();
    entire_word       = this.entire_word_check.get_active();
    regex             = this.regex_check.get_active();
    search_backwards  = this.search_backwards_check.get_active();
    wrap_around       = this.wrap_around_check.get_active();
  }

}