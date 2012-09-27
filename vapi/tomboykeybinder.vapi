
namespace Tomboy {

	[CCode (cname = "tomboy_keybinder_init", cheader_filename = "tomboykeybinder.h")]
	public static void keybinder_init ();
	[CCode (cname = "tomboy_keybinder_bind", cheader_filename = "tomboykeybinder.h")]
	public static void keybinder_bind (string keystring, Tomboy.BindkeyHandler handler, void* user_data);
	
	[CCode (cname = "tomboy_keybinder_unbind", cheader_filename = "tomboykeybinder.h")]
	public static void keybinder_unbind (string keystring, Tomboy.BindkeyHandler handler);

	[CCode (has_target = false)]
	public delegate void BindkeyHandler(string keystring);
}

