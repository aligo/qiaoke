public class Qiaoke.TerminalKiller {
  private GLib.Pid pid;
  private int num_tries = 30;
  private int status;

  public TerminalKiller (GLib.Pid pid) {
    this.pid = pid;
  }

  public void* thread_func() {
    Posix.kill(this.pid, Posix.SIGTERM);
    while (this.num_tries > 0) {
      try {
        Posix.waitpid(this.pid, out this.status, Posix.WNOHANG);
        if (this.status != 0) {
          break;
        }
      } catch (Error e) {
        break;
      }
      this.num_tries -= 1;
    }
    if (this.num_tries == 0) {
      try {
        Posix.kill(this.pid, Posix.SIGKILL);
        Posix.waitpid(this.pid, out this.status, 0);
      } catch (Error e) {
        return null;
      }
    }
    return null;
  }
}