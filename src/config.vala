public class Qiaoke.Config : GLib.Object {
  /* Groups */
  private const string GENERAL          = "General";
  private const string TERMINAL         = "Terminal";
  private const string HOTKEY           = "Hotkey";
  /* Keys */
  private const string WINDOW_HEIGHT    = "window_height";
  private const string BACKGROUND_COLOR = "background_color";
  private const string FOREGROUND_COLOR = "foreground_color";
  private const string TRANSPARENCY     = "transparency";
  private const string TOGGLE           = "toggle";
  private const string FULLSCREEN       = "fullscreen";
  private const string QUIT             = "quit";


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
      return file.get_integer_key(GENERAL, WINDOW_HEIGHT, 30);
    }
    set {
      file.set_integer(GENERAL, WINDOW_HEIGHT, value);
      signal.window_height_changed(value);
    }
  }

  public static Gdk.Color background_color {
    get {
      Gdk.Color black = { 0, 0, 0, 0 };
      return file.get_color_key(TERMINAL, BACKGROUND_COLOR, black);
    }
    set {
      file.set_string(TERMINAL, BACKGROUND_COLOR, value.to_string());
    }
  }

  public static Gdk.Color foreground_color {
    get {
      Gdk.Color white = { 0, 0xffff, 0xffff, 0xffff };
      return file.get_color_key(TERMINAL, FOREGROUND_COLOR, white);
    }
    set {
      file.set_string(TERMINAL, FOREGROUND_COLOR, value.to_string());
    }
  }

  public static uint transparency {
    get {
      return file.get_uint_key(TERMINAL, TRANSPARENCY, 30);
    }
    set {
      file.set_uint(TERMINAL, TRANSPARENCY, value);
    }
  }

  public static string toggle {
    owned get {
      return file.get_string_key(HOTKEY, TOGGLE, "F12");
    }
    set {
      file.set_string(HOTKEY, TOGGLE, value);
    }
  }

  public static string fullscreen {
    owned get {
      return file.get_string_key(HOTKEY, FULLSCREEN, "F11");
    }
    set {
      file.set_string(HOTKEY, FULLSCREEN, value);
    }
  }

  public static string quit {
    owned get {
      return file.get_string_key(HOTKEY, QUIT, "<Control><Shift>q");
    }
    set {
      file.set_string(HOTKEY, QUIT, value);
    }
  }
}