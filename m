MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Tue, 18 Sep 2012 17:57:36 -0700
Message-ID: <CAB=NE6VKbsLaLwYYpc3xFNkhMWgZnvefz7zssGG7fBNR9EnmTQ@mail.gmail.com>
Subject: compat-driver releases now on kernel.org
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Konstantin Ryabitsev <mricon@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Starting today we now have linux-next.git based snapshots of
compat-drivers which have completed compilation through ckmake for all
supported kernels on kernel.org:

http://www.kernel.org/pub/linux/kernel/projects/backports/

The first set of releases are for today:

http://www.kernel.org/pub/linux/kernel/projects/backports/2012/09/18/

These all have have been signed. I'll look to compress next, the fact
that they are not compressed was an overlook assuming that kup, the
kernel uploader script we use, would do the job for me. For now I'm
doing these manually as I have to sign these. The respective stable
releases will be eventually uploaded once we get v3.7-rc1 kicked out.

Thanks to Konstantin for his help with this setup.

  Luis
