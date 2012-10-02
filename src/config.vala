public class Qiaoke.Config : GLib.Object {
  /* Groups */
  private const string GENERAL          = "General";
  private const string TERMINAL         = "Terminal";
  private const string HOTKEY           = "Hotkey";
  /* Keys */
  private const string MONITOR          = "monitor";
  private const string WINDOW_HEIGHT    = "window_height";
  private const string BACKGROUND_COLOR = "background_color";
  private const string FOREGROUND_COLOR = "foreground_color";
  private const string TRANSPARENCY     = "transparency";
  private const string TOGGLE           = "toggle";
  private const string FULLSCREEN       = "fullscreen";
  private const string QUIT             = "quit";
  private const string NEW_TAB          = "new_tab";
  private const string CLOSE_TAB        = "close_tab";
  private const string RENAME_TAB       = "rename_tab";
  private const string TERMINAL_RESET   = "terminal_reset";
  private const string COPY             = "copy";
  private const string PASTE            = "paste";
  private const string FIND             = "find";
  private const string FIND_NEXT        = "find_next";
  private const string FIND_PREVIOUS    = "find_previous";


  private static ConfigFile   file;
  public  static ConfigSignal signal;

  public static void init() {
    Config.file     = new ConfigFile();
    Config.signal   = new ConfigSignal();
  }

  public static void write() {
    file.write();
  }

  public static int monitor {
    get {
      return file.get_integer_key(GENERAL, MONITOR, 0);
    }
    set {
      file.set_integer(GENERAL, MONITOR, value);
      signal.window_height_changed(value);
    }
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

  public static string new_tab {
    owned get {
      return file.get_string_key(HOTKEY, NEW_TAB, "<Control><Shift>t");
    }
    set {
      file.set_string(HOTKEY, NEW_TAB, value);
    }
  }

  public static string close_tab {
    owned get {
      return file.get_string_key(HOTKEY, CLOSE_TAB, "<Control><Shift>w");
    }
    set {
      file.set_string(HOTKEY, CLOSE_TAB, value);
    }
  }

  public static string rename_tab {
    owned get {
      return file.get_string_key(HOTKEY, RENAME_TAB, "F2");
    }
    set {
      file.set_string(HOTKEY, RENAME_TAB, value);
    }
  }

  public static string terminal_reset {
    owned get {
      return file.get_string_key(HOTKEY, TERMINAL_RESET, "<Control>k");
    }
    set {
      file.set_string(HOTKEY, TERMINAL_RESET, value);
    }
  }

  public static string copy {
    owned get {
      return file.get_string_key(HOTKEY, COPY, "<Control><Shift>c");
    }
    set {
      file.set_string(HOTKEY, COPY, value);
    }
  }

  public static string paste {
    owned get {
      return file.get_string_key(HOTKEY, PASTE, "<Control><Shift>v");
    }
    set {
      file.set_string(HOTKEY, PASTE, value);
    }
  }

  public static string find {
    owned get {
      return file.get_string_key(HOTKEY, FIND, "<Control><Shift>f");
    }
    set {
      file.set_string(HOTKEY, FIND, value);
    }
  }

  public static string find_next {
    owned get {
      return file.get_string_key(HOTKEY, FIND_NEXT, "<Control><Shift>h");
    }
    set {
      file.set_string(HOTKEY, FIND_NEXT, value);
    }
  }

  public static string find_previous {
    owned get {
      return file.get_string_key(HOTKEY, FIND_PREVIOUS, "<Control><Shift>g");
    }
    set {
      file.set_string(HOTKEY, FIND_PREVIOUS, value);
    }
  }
}