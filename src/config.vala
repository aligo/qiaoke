public class Qiaoke.Config : GLib.Object {
  /* Groups */
  private const string GENERAL        = "General";
  private const string TERMINAL       = "Terminal";

  private static ConfigFile   file;
  public  static ConfigSignal signal;

  public static void init() {
    Config.file     = new ConfigFile();
    Config.signal   = new ConfigSignal();
  }

  public static void write() {
    file.write();
  }

  public static int window_height {
    get {
      return file.get_integer_key(GENERAL, "window_height", 30);
    }
    set {
      file.set_integer(GENERAL, "window_height", value);
      signal.window_height_changed(value);
    }
  }
}