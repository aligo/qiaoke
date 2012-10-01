public class Qiaoke.Hotkey : Gtk.Widget {

  public static Gtk.AccelGroup accel_group;

  public static void init() {
    Hotkey.accel_group = new Gtk.AccelGroup();
  }

  public static void bind(string hotkey, owned Gtk.AccelGroupActivate closure) {
    uint              accel_key;
    Gdk.ModifierType  accel_mods;
    Gtk.accelerator_parse(hotkey, out accel_key, out accel_mods);
    if (accel_key != 0) {
      accel_group.disconnect_key(accel_key, accel_mods);
      
      accel_group.connect(accel_key, accel_mods, Gtk.AccelFlags.VISIBLE, closure);
    }
  }
}