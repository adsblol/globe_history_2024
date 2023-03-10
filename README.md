# adsblol/globe_history

This database is made available under the Open Database License: http://opendatacommons.org/licenses/odbl/1.0/.

# What is it?

A daily dump of the /var/globe_history directory from adsb.lol planes containers.

The planes containers serve [globe.adsb.lol](https://globe.adsb.lol). Test is used, unless it is down then staging is used. There are two replicas of test and one of staging.

These files are accessed by you when you visit [globe.adsb.lol](https://globe.adsb.lol), and are used to render traces.

The files are written by [readsb](https://github.com/wiedehopf/readsb) and are stored in gzip compressed json format.

# Releases

See [RELEASES.md](RELEASES.md)
