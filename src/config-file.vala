public class Qiaoke.ConfigFile : GLib.Object {
  private GLib.KeyFile file = new GLib.KeyFile();
  private bool has_errors = false;

  public ConfigFile() {
    try {
      this.file.load_from_file(this.filename(), KeyFileFlags.NONE);
    } catch(GLib.Error error) {
      if (!(error is GLib.KeyFileError.PARSE)) {
        this.has_errors = true;
      }
      Errors.print_configfile(error);
    }
  }

  ~ConfigFile() {
    this.write();
  }

  public string get_string_key(string group, string key, string default_value) {
    try {
      return this.file.get_string(group, key);
    } catch(GLib.KeyFileError error) {
      Errors.print_configfile(error);
    }
    this.file.set_string(group, key, default_value);
    return default_value;
  }

  public int get_integer_key(string group, string key, int default_value) {
    try {
      return this.file.get_integer(group, key);
    } catch(GLib.KeyFileError error) {
      Errors.print_configfile(error);
    }
    this.file.set_integer(group, key, default_value);
    return default_value;
  }

  public bool get_boolean_key(string group, string key, bool default_value) {
    try {
      return this.file.get_boolean(group, key);
    } catch(GLib.KeyFileError error) {
      Errors.print_configfile(error);
    }
    this.file.set_boolean(group, key, default_value);
    return default_value;
  }

  public Gdk.Color get_color_key(string group, string key, Gdk.Color default_value){
    try {
      string color_string = this.file.get_string(group, key);
      Gdk.Color color;
      if (Gdk.Color.parse(color_string, out color) == false) {
        throw new GLib.ConvertError.FAILED("\"%s\" couldn't be parsed as color", color_string);
      }
      return color;
    } catch(GLib.Error error) {
      Errors.print_configfile(error);
    }
    this.file.set_string(group, key, default_value.to_string());
    return default_value;
  }

  public uint get_uint_key(string group, string key, uint default_value) {
    try {
      return (uint)this.file.get_uint64(group, key);
    } catch(GLib.Error error) {
      Errors.print_configfile(error);
    }
    this.file.set_uint64(group, key, default_value);
    return default_value;
  }

  public void write() {
    if (!this.has_errors) {
      try {
        FileUtils.set_contents(this.filename(), this.file.to_data());
      } catch(GLib.FileError error) {
        Errors.print_configfile(error);
      }
    }
  }

  public void set_string(string group_name, string key, string str) {
    this.file.set_string(group_name, key, str);
  }

  public void set_boolean(string group_name, string key, bool value) {
    this.file.set_boolean(group_name, key, value);
  }

  public void set_integer(string group_name, string key, int value) {
    this.file.set_integer(group_name, key, value);
  }

  public void set_uint(string group_name, string key, uint value) {
    this.file.set_uint64(group_name, key, value);
  }


  private string filename() {
    string path = GLib.Environment.get_user_config_dir() + "/qiaoke/";
    this.verify_dir(path);

    string filename = path + "config.ini";
    this.verify_file(filename);

    return filename;
  }

  private void verify_dir(string dir){
    if(!FileUtils.test(dir, FileTest.EXISTS)) {
      // Create the dir
      DirUtils.create(dir, 0700);
    }
  }

  private void verify_file(string filename){
    if(!FileUtils.test(filename, FileTest.EXISTS)) {
      // Create the file
      FileStream.open(filename, "w");
    }
  }
}