# mirage-dashboard

A dashboard displaying useful data from
[MirageOS](https://mirage.io/) project and its related
repositories.

## Overview

MirageOS is continually updating/improving, keeping track of these
changes is tricky.

As part of the [2016 MirageOS Hackathon](http://canopy.mirage.io),
I'm starting this project as a learning exercise.

### What will the dashboard show?

* A list the core MirageOS libraries, on GitHub.
* Data related to each library:
  * Name
  * License
  * Last release (version + date)
  * Commits to master since last release
  * Open issues (maybe more detailed numbers from labels)
  * Open PRs
  * Branches (maybe active only? Some mirage repos have way too many stale branches)
  * Top 3 contributors
  * CI status
  * Last activity: commit / issue

### How are the libraries chosen?

To get things going there is a JSON file
[repos.js](https://raw.githubusercontent.com/rudenoise/mirage-dashboard/master/data/repos.json)
that lists all relevant repositories.

Each repo has tags to help categorise them. Tags could include:
_depricated, core, network, build, etc..._

Please add/remove/update/edit/tag via pull requests.

## Work in progress:

Build.

```sh
oasis setup
./configure
make
```

Set up ocaml-git to list [Mirage repositories](https://github.com/mirage).

Setup [git jar](https://github.com/mirage/ocaml-github#git-jar).

```sh
# install ocaml-github from opam
opam install ocaml-github
# make an access token/cookie
git-jar make {{your github username }} mirage-dashboard
# list events for this repo
git-list-events -c mirage-dashboard rudenoise/mirage-dashboard
```

Use the app (with its extremely limited form):

```sh
./mirage-dashboard -c mirage-dashboard
```

## TO DO:

* Use [ocaml-github](https://github.com/mirage/ocaml-github) to
  gather basic data about the _MirageOS_ ecosystem.
* Crawl dependencies
* Create web-accessible HTML/JS dashboard (static)
* Wrap in Mirage Unikernel
* Cache data to limit GitHub API calls
* Serve publicly

## Done:

* README
* Start with CLI app
* Dump data to JSON

## Sources of inspiration/theft:

* [The github gist program from the ocaml-github repo](https://github.com/mirage/ocaml-github/blob/master/gist/gist.ml)
