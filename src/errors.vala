namespace Qiaoke.Errors {
  public void print(GLib.Error error) {
      Errors.print_string(error.message);
  }

  public void print_configfile(GLib.Error error) {
    Errors.print_string(error.message + ". Using the default value");
  }

  public void print_string(string message) {
    GLib.stderr.printf("Error: %s.\n", message);
  }
}
