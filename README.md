# mirage-dashboard

A dashboard displaying useful data from
[MirageOS](https://mirage.io/) project and its related
repositories.

View the [mirage-dashboard](http://rudenoise.github.io/mirage-dashboard/)

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
[repos.js](https://raw.githubusercontent.com/rudenoise/mirage-dashboard/master/data/in/all.json)
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
./mirage_dashboard.native -c mirage-dashboard -r data/in/all.json -o data/out/all.json
# it'll take a while, hitting each repo in sequence to keep below the rate limit
```

## TO DO:

* compare tag and release date, then choose most recent
  (e.g. [ocaml-ipaddr/releases](https://github.com/mirage/ocaml-ipaddr/releases))
  is this the right thing to do?
* improve contributors data (events may not be the best source)
* break down event data
  * commits since release with dates
  * open PRs
  * open issues
* include repo description
* get licence
* add filtering/sorting to web UI
  * recent activity
  * open issues
  * branch count
* add filtering/sorting to CLI app
* Get build status from
  [travis api](https://api.travis-ci.org/repositories/mirage/ocaml-cohttp.json?branch=master)
  use [ocaml-cohttp](https://github.com/mirage/ocaml-cohttp)?
* remove all usage of _Core.Std_
* Wrap in Mirage Unikernel
* Serve publicly
* Cache data (and/or background process github interrogation) to limit GitHub API calls

## Done:

* README
* Create web-accessible HTML/JS dashboard (static)
* Start with CLI app
* Dump data to JSON
* Use [ocaml-github](https://github.com/mirage/ocaml-github) to
  gather basic data about the _MirageOS_ ecosystem.
* Crawl dependencies
* handle rate limit from API in OCaml app
* tag repos with relevant meta-data for filtering in web-UI
* add created_at field to data
* get CI status, if any
* add filtering/sorting to web UI
  * tags
* improve releases data (straight to opam or use tags)

## Sources of inspiration/theft:

* [The github gist program from the ocaml-github repo](https://github.com/mirage/ocaml-github/blob/master/gist/gist.ml)
