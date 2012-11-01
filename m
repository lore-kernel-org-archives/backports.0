Return-Path: <hauke@hauke-m.de>
Message-ID: <5092BF58.1040703@hauke-m.de>
Date: Thu, 01 Nov 2012 19:28:40 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: backports@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Donwload locations and wiki structure
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

Hi Luis,

When I visit the backport wiki [0], I am missing the word download.
The section name "compat-drivers releases" should better be named:
"compat-drivers releases downloads". ;-)

The change from compat-wireless to compat-drivers was more a rename than
a very big change, why don't you link the old stable releases on the
release page, I think most of the stable page should be integrated into
the new release page?

As automatically uploading to https://www.kernel.org does not work, it
is not a suitable place to store the daily snapshots of compat-drivers,
they are better localed at the other positions and the two releases at
kernel.org should be removed.

Putting all the snapshots into one directory on the download server gets
messy with the daily releases, the old structure with /year/month/
folders was better. The cmake reports should go into an own subdirectory
as most of the users are not interested in them. A symlink to the latest
release in the root folder would be nice.

I just want to hear you opinion on this and would try to solve some of
these things by myself.

Hauke

[0]: https://backports.wiki.kernel.org/index.php/Main_Page
