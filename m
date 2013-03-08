MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Thu, 7 Mar 2013 18:24:50 -0800
Message-ID: <CAB=NE6WNgEUO7mn5VbJ2AgGfv7H9bJfTJmHWUxWnp+9cDD8JmA@mail.gmail.com>
Subject: alx stable Linux branches and tags
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Adrian Chadd <adrian@freebsd.org>
Cc: unified-drivers@lists.infradead.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Linus has kicked out linux v3.9-rc1 and as such I've created
respective linux-3.9.y branches for compat, compat-drivers and alx.
What I'll do for alx is maintain the linux-3.9.y branch myself in
which I'll only pull in patches from master if they are stable
material. Obviously I'd only take in patches to the linux-3.9.y branch
if the patch is merged upstream into Adrian's master branch already.

The linux-3.9.y branch allows us to synchronize releases along with
the Linux releases given that the master branch of alx runs in synch
always with linux-next and FreeBSD HEAD.

Adrian if you'd like to carry / publish my branch:

git remote add mcgrof
git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/alx.git
git fetch mcgrof

I didn't need to make any changes, so I just created the linux-3.9.y
branch and added the alx-linux-v3.9-rc1-1 digitally signed tag. This
branch / tag is what will go out in the compat-driver-v3.9-rc1-1
release.

  Luis
