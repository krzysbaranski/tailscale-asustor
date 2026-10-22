#!/bin/sh

NAME="Tailscale"

case "$1" in
  start)
    echo "Starting $NAME"
    # Tailscale is usually configured by the user with `tailscale up`.
    # Do not force a connection here without explicit user configuration.
    ;;
  stop)
    echo "Stopping $NAME"
    ;;
  reload)
    echo "Reloading $NAME"
    ;;
  restart|force-reload)
    echo "Restarting $NAME"
    ;;
  *)
    echo "Usage: $0 {start|stop|reload|force-reload|restart}"
    exit 2
    ;;
esac

exit 0
