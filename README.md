# squirrelmail-docker
Docker image for Squirrel WebMail with German translation enabled.

Squirrelmail is a little picky about locales configuration. To accomplish the goal, php-gettext extension had to be enabled, locales installed and de_DE.UTF-8 compiled (see Dockerfile with debconf-set-selections). Fork and adopt to suit your need.

Forked shamelessly from metaxmx to add missing php-mdb2.
