public class Qiaoke.TerminalManager : Gtk.Notebook {

  public TerminalManager() {
    this.set_tab_pos(Gtk.PositionType.BOTTOM);
    this.new_tab();
    this.new_tab();
    this.new_tab();
    this.show();
  }

  public void new_tab() {
    TerminalBox qiaoke_box = new TerminalBox("Terminal " + this.get_n_pages().to_string());

    this.append_page(qiaoke_box, qiaoke_box.label_box);
    this.set_current_page(this.get_n_pages() - 1);
  }

  public Terminal get_current_terminal() {
    return ((TerminalBox)this.get_nth_page(this.get_current_page())).terminal;
  }

  public void set_terminal_focus() {
    this.get_current_terminal().grab_focus();
  }

  public void set_terminal_background() {
    int transparency = 30;
    Gdk.Color bgcolor = {0, 0x0000, 0x0000, 0x0000};
    Gdk.Color fgcolor = {0, 0xffff, 0xffff, 0xffff};
    for (int i = 0; i < this.get_n_pages(); i++) {
      TerminalBox qiaoke_box = (TerminalBox)this.get_nth_page(i);
      qiaoke_box.terminal.set_colors(fgcolor, bgcolor, Qiaoke.Colors.tango_palette);
      qiaoke_box.terminal.set_opacity((uint16)((100.0 - transparency) / 100.0 * 65535));
    }
  }

}