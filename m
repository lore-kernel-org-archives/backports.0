MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Fri, 30 Nov 2012 20:18:43 -0800
Message-ID: <CAB=NE6WU2sRrG-Qf-8397HwkHn199-HO0quL-jUyV5G64993HQ@mail.gmail.com>
Subject: A few updates to compat-drivers based on next-20121130
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Adrian Chadd <adrian@freebsd.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

I've pushed out a few changes to compat / compat-drivers worth mentioning:

  * all patches are now under patches/ including:

    - pending-stable/
    - linux-next-cherry-picks/
    - linux-next-pending/
    - crap/

  * backport patches are now called collateral-evolutions/ under patches/

  * ./scripts/admin-update.sh supports -b for a basic update

  * ./scripts/admin-update.sh now supports drivers in a unified driver format.
    Patches for such drivers are placed under patches/unified-drivers/. If you
    want these drivers you can supply -u option to admin-update.sh and
the -u tag
    will be added. This is to help with killing proprietary drivers
and an attempt
    me and Adrian have been dreaming up. At this point there is
nothing formal but a
    template and you can find the example driver we're trying to work on here:

    - git://github.com/mcgrof/alx.git

    This should help with a few things. For starters it means we don't
need to carry
    the alx driver as crap/ patches. It also provides a template for
working on a
    unified driver strategy that we can help review / participate in.

compat-drivers goes now compile tested against next-20121130, here are
the results:

mcgrof@drvbp1 ~/devel/compat-drivers (git::master)$ time ckmake
Trying kernel 3.6.5-030605-generic [OK]
Trying kernel 3.5.7-030507-generic [OK]
Trying kernel 3.4.17-030417-generic [OK]
Trying kernel 3.3.8-030308-generic [OK]
Trying kernel 3.2.33-030233-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.50-030050-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063513-generic [OK]
Trying kernel 2.6.34-02063413-generic [OK]
Trying kernel 2.6.33-02063320-generic [OK]
Trying kernel 2.6.32-02063260-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

real    5m3.205s
user    9m16.115s
sys     3m39.166s


  Luis
