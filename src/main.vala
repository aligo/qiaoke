void main(string[] args) {
  Gtk.init(ref args);

  var window = new MainWindow();
  window.display();

  Gtk.main();
}

public unowned string tr(string str) {
  return str;
}