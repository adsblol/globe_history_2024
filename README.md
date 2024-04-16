# adsblol/globe_history_2024 (332 GiB)

This database is made available under the Open Database License: http://opendatacommons.org/licenses/odbl/1.0/.

## What is it?

This database is a collection of all the data known to ADSB.lol, uploaded daily.

This includes data from ADSB.lol feeders [and friends](https://www.adsb.lol/docs/acknowledgements/partners/), [FlyItalyADSB](https://flyitalyadsb.com/) and [TheAirTraffic.com](https://theairtraffic.com)

## Technically

A dump of the /var/globe_history directory from adsb.lol planes containers.

The planes containers serve [adsb.lol](https://adsb.lol). Prod is used, unless it is down then staging is used. There are two replicas of prod and one of staging.

These files are accessed by you when you visit [the replay functionality](https://adsb.lol?r), and are used to render traces.

The files are written by [readsb](https://github.com/wiedehopf/readsb) and are stored in gzip compressed json format.

## Releases

All files are downloadable from the [releases tab](https://github.com/adsblol/globe_history_2024/releases) of this repository.

See [RELEASES.md](RELEASES.md) for a formatted list of links.

Each release is 1 day of flight data. In the future, this data could be processed to provide for example 1 file per flight.

Would you like to help? Get in touch!

# Acknowledgements

- **The feeders**, without people like you sharing their data, there would be nothiing to share. Together we make an open dataset of flight records for the public.
- **The existing open source software**, adsb.lol is not much more than a [prod-ready configuration](https://github.com/adsblol/infra) of [readsb](https://github.com/wiedehopf/readsb), [tar1090](https://github.com/wiedehopf/tar1090), [mlat-server](https://github.com/wiedehopf/mlat-server).
- **GitHub**, for storing and serving open source / open data releases of aircraft flights history.
- Most other flight aggregators, with the exception of [ADSBHub](https://www.adsbhub.org/), [OpenSky Network](https://opensky-network.org/), for holding tight onto their data and giving me the motivation to show it is possible! :)
