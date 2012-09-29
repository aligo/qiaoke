public class Qiaoke.TerminalBox : Gtk.HBox {


  public TerminalManager manager;
  public Terminal        terminal     = new Qiaoke.Terminal();
  public Gtk.HBox        label_box    = new Gtk.HBox(false, 0);
  public Gtk.Label       label        = new Gtk.Label("");
  public Gtk.Button      close_btn    = new Gtk.Button();

  private Gtk.VScrollbar scroll;

  public TerminalBox(TerminalManager manager, string label) {
    this.manager = manager;

    this.scroll = new Gtk.VScrollbar(terminal.get_adjustment());
    this.scroll.set_no_show_all(true);
    this.scroll.show();

    this.pack_start(this.terminal, true, true);
    this.pack_start(this.scroll, false, false);

    this.show();

    // initialize label
    this.init_close_button();

    this.label.set_label(label);

    this.label_box.pack_start(this.label, true, true);
    this.label_box.pack_start(this.close_btn, false, false);

    this.label_box.show_all();
  }

  public void close() {
    this.terminal.kill();
    this.manager.remove_page(this.manager.page_num(this));
  }

  private void init_close_button() {
    this.close_btn.set_name("qiaoke-tab-close-button");

    Gtk.rc_parse_string("style \"qiaoke-tab-close-button-style\"\n" +
                       "{\n" +
                          "GtkButton::inner-border = {0,0,0,0}\n" +
                          "GtkWidget::focus-padding = 0\n" +
                          "GtkWidget::focus-line-width = 0\n" +
                          "xthickness = 0\n" +
                          "ythickness = 0\n" +
                       "}\n" +
                       "widget \"*.GtkButton\" style \"qiaoke-tab-close-button-style\"");

    this.close_btn.set_relief(Gtk.ReliefStyle.NONE);
    this.close_btn.set_focus_on_click(false);
    this.close_btn.add((new Gtk.Image.from_stock(Gtk.Stock.CLOSE, Gtk.IconSize.MENU)));

    int w, h;
    Gtk.icon_size_lookup_for_settings(this.close_btn.get_settings(), Gtk.IconSize.MENU, out w, out h);
    this.close_btn.set_size_request(w + 2, h + 2);

    this.close_btn.clicked.connect(this.close);
  }

}