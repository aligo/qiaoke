public class Qiaoke.TerminalBox : Gtk.HBox {

  public TerminalManager manager;
  public Terminal        terminal     = new Qiaoke.Terminal();
  public Gtk.HBox        label_box    = new Gtk.HBox(false, 0);
  public Gtk.Label       label        = new Gtk.Label("");
  public Gtk.Button      close_btn    = new Gtk.Button();

  private Gtk.VScrollbar scroll;

  public TerminalBox(TerminalManager manager, string label) {
    this.manager = manager;
    
    this.terminal.child_exited.connect(this.close);

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
    int page_pos = this.manager.page_num(this);
    if (page_pos == 0 && this.manager.get_n_pages() == 2) {
      // quit when close last tab
      Qiaoke.Appliction.quit();
    } else {
      if (page_pos == 0) {
        this.manager.set_current_page(1);
      } else {
        this.manager.set_current_page(page_pos - 1);
      }
      this.terminal.kill();
      this.manager.remove_page(page_pos);
    }
  }

  public void run_rename_dialog() {
    RenameDialog dialog = new RenameDialog(this);
    dialog.run();
  }

  private void init_close_button() {

    //???: Gtk.Widget.set_name() does not work
    this.close_btn.name = "qiaoke-tab-button";

    this.close_btn.set_relief(Gtk.ReliefStyle.NONE);
    this.close_btn.set_focus_on_click(false);
    this.close_btn.add((new Gtk.Image.from_stock(Gtk.Stock.CLOSE, Gtk.IconSize.MENU)));

    int w, h;
    Gtk.icon_size_lookup_for_settings(this.close_btn.get_settings(), Gtk.IconSize.MENU, out w, out h);
    this.close_btn.set_size_request(w + 2, h + 2);

    this.close_btn.clicked.connect(this.close);
  }

}