# Docker version of Crunchy (https://github.com/Godzil/Crunchy)

# Crunchy: a fork of Deathspike/CrunchyRoll.js

[![Issue Stats](http://issuestats.com/github/Godzil/Crunchy/badge/issue)](http://issuestats.com/github/Godzil/Crunchy) [![Travis CI](https://travis-ci.org/Godzil/Crunchy.svg?branch=master)](https://travis-ci.org/Godzil/Crunchy) [![Maintainability](https://api.codeclimate.com/v1/badges/413c7ca11c0805b1ef3e/maintainability)](https://codeclimate.com/github/Godzil/Crunchy/maintainability) 

*Crunchy* is capable of downloading *anime* episodes from the popular *CrunchyRoll* streaming service. An episode is stored in the original video format (often H.264 in a MP4 container) and the configured subtitle format (ASS or SRT).The two output files are then merged into a single MKV file.

## Motivation

*CrunchyRoll* has been providing an amazing streaming service and offers the best way to enjoy *anime* in a *convenient* and *legal* way. As a streaming service, video files cannot be downloaded and watched offline. Understandable from a business perspective and considering possible contract implications, but annoying for users. This application enables episodes to be downloaded for offline convenience. Please do not abuse this application; download episodes for **personal use** and **delete them** if you do not have an active premium account. Continue to support *CrunchyRoll*; without our financial backing their service cannot exist!

## Legal Warning

This application is not endorsed or affliated with *CrunchyRoll*. The usage of this application enables episodes to be downloaded for offline convenience which may be forbidden by law in your country. Usage of this application may also cause a violation of the agreed *Terms of Service* between you and the stream provider. A tool is not responsible for your actions; please make an informed decision prior to using this application.

**_ONLY_ USE THIS TOOL IF YOU HAVE A _PREMIUM ACCOUNT_**

## Configuration

You need to authentication (`-p` and `-u`) to use Crunchy so you need to have an account on *CrunchyRool*. It is not possible to download non-free material without an account and premium subscription.


## Prerequisites

* Docker

### Install
1. Run in *Terminal*: `sudo docker pull juezfenix/crunchy


#### Updating:
1. Run in *Terminal*: `sudo docker pull juezfenix/crunchy

Use the applicable instructions for the interface of your choice (currently limited to command-line).

### Run

    Usage: docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy [options]

    Options:

        -p, --pass <s>        The password.
        -u, --user <s>        The e-mail address or username.
        -e, --episodes <s>    Episode list. Read documentation on how to use
        -f, --format <s>      The subtitle format. (default: ass)
        -o, --output <s>      The output path.
        -s, --series <s>      The series name override.
        -r, --resolution <s>  The video resolution. (valid: 360, 480, 720, 1080) (default: 1080)
        -b, --batch <s>       Batch file (default: CrunchyRoll.txt)

#### Batch-mode

When no sequence of series addresses is provided, the batch-mode source file will be read (which is *CrunchyRoll.txt* in the current work directory. Each line in this file is processed contain the URL of a series and can support some of the command line parameter (like `-e`). This makes it ideal to manage a large sequence of series addresses.

Crunchy will also create a `.cookie.jar` file in the output folder (by default the current folder) it is the file used by Crunchy to store the web cookies.

#### Examples

Download in batch-mode:

 You will need to create the batch file (default name is `CrunchyRoll.txt`):

    http://www.cr.com/tail-fairy
    http://www.cr.com/gin-mama
    http://www.cr.com/two-parts
    // Just download episodes 3 to 42
    http://www.cr.com/defense-of-dwarfs -e 3-42

 Then launch crunchy:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password http://www.cr.com/tail-fairy

Download *Tail Fairy* to the current work directory:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password http://www.cr.com/tail-fairy

Download *Tail Fairy* to `C:\Anime`:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password --output C:\Anime http://www.cr.com/tail-fairy

Download episode 42 of *Tail Fairy* to `C:\Anime`:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password --output C:\Anime @http://www.cr.com/tail-fairy/episode-42-the-episode-which-dont-exist-665544

  *Notice the '@' in front of the URL, it is there to tell Crunchy that the URL is an episode URL and not a series URL.*

 or 

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password --output C:\Anime http://www.cr.com/tail-fairy -e 42

Download episode 10 to 42 (both included) of *Tail Fairy*:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password http://www.cr.com/tail-fairy -e 10-42

Download episode up to 42 (included) of *Tail Fairy*:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password http://www.cr.com/tail-fairy -e -42

Download episodes starting from 42 to the last available of *Tail Fairy*:

    docker run --rm -it -v /path/to/downloads/:/downloads juezfenix/crunchy -u login -p password http://www.cr.com/tail-fairy -e 42-
