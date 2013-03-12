MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Mon, 11 Mar 2013 20:40:26 -0700
Message-ID: <CAB=NE6Vj1P0fDDvuVqsDcvOhHYJf4=WvGnzM1963RrLvtd6XHg@mail.gmail.com>
Subject: compat-drivers based on v3.9-rc2
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

I've kicked out compat-drivers releases based on v3.9-rc2 [0], be sure
to use the temporary release page [1] while we get one in place on
kernel.org. We are on rc2 now... please test and report any issues!
Please submit your patches for anything you think is critical but not
'stable' material for inclusion of those patches into their respective
directory, if unclear please read the additional-patches documentation
[2]. This should allow us developers to focus on convincing PHBs to
always work upstream without having them to persuade their own
'private' releases to customers / your mom that typically do carry
these patches but they never get merged back upstream.

[0] https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.9-rc2/
[1] http://drvbp1.linux-foundation.org/~mcgrof/rel-html/compat-drivers/
[2] https://backports.wiki.kernel.org/index.php/Documentation/compat-drivers/additional-patches

  Luis
