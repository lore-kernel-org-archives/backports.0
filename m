MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Mon, 11 Mar 2013 20:27:15 -0700
Message-ID: <CAB=NE6V44Xau-KD6LS6qXxJ3QhuMQ5DphcOh+uM=Qj5bAoCzZg@mail.gmail.com>
Subject: Temporary compat-drivers release page
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

We are working on a shiny release page somewhere for compat-drivers on
kernel.org, but in the meantime here is one based on the rel-html
project:

http://drvbp1.linux-foundation.org/~mcgrof/rel-html/compat-drivers/

I've updated the wiki to use that for now. A cronjob will update this
every hour. We should later figure out a way to make git hook to kick
page generation after some commits have been pushed somehow.

  Luis
