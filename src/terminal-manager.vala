public class Qiaoke.TerminalManager : Gtk.Notebook {

  public Gtk.HBox        new_tab_box    = new Gtk.HBox(false, 0);
  private Gtk.Label      new_tab_dummy  = new Gtk.Label("");

  public TerminalManager() {
    this.set_tab_pos(Gtk.PositionType.BOTTOM);
    this.set_tab_button_style();

    this.init_new_tab_button();
    this.new_tab();
    this.show();
  }

  public void init_new_tab_button() {
    this.new_tab_box.pack_start((new Gtk.Image.from_stock(Gtk.Stock.ADD, Gtk.IconSize.MENU)), false, false);

    this.new_tab_box.show_all();
    this.new_tab_dummy.show();

    this.append_page(this.new_tab_dummy, this.new_tab_box);
    this.switch_page.connect_after(this.switch_page_or_new);
    this.page_reordered.connect(this.finish_page_reordered);
  }

  public void new_tab() {
    TerminalBox qiaoke_box = new TerminalBox(this, "Terminal " + this.get_n_pages().to_string());

    this.set_current_page( this.insert_page(qiaoke_box, qiaoke_box.label_box, this.get_n_pages() - 1) );
    this.set_tab_reorderable(qiaoke_box, true);
  }

  public Terminal get_current_terminal() {
    return ((TerminalBox)this.get_nth_page(this.get_current_page())).terminal;
  }

  public void set_terminal_focus() {
    this.get_current_terminal().grab_focus();
  }

  public void set_terminal_background() {
    for (int i = 0; i < (this.get_n_pages() - 1); i++) {
      ((TerminalBox)this.get_nth_page(i)).terminal.set_background();
    }
  }

  private void switch_page_or_new(Gtk.NotebookPage page, uint page_num) {
    if ( page_num == this.get_n_pages() - 1 ) {
      this.new_tab();
    }
  }

  private void finish_page_reordered(Gtk.Widget p0, uint p1) {
    int r_limit = this.get_n_pages() - 2;
    if ( p1 > r_limit) {
      this.reorder_child(p0, r_limit);
    }
  }

  private void set_tab_button_style() {
    Gtk.rc_parse_string("style \"qiaoke-tab-button-style\"\n" +
                       "{\n" +
                          "GtkButton::inner-border = {0,0,0,0}\n" +
                          "GtkWidget::focus-padding = 0\n" +
                          "GtkWidget::focus-line-width = 0\n" +
                          "xthickness = 0\n" +
                          "ythickness = 0\n" +
                       "}\n" +
                       "widget \"*.qiaoke-tab-button\" style \"qiaoke-tab-button-style\""); 
  }

}