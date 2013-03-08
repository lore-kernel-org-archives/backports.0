MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <20130307211452.3C6EB40AC0@repository3.orbit-lab.org>
References: <20130307211452.3C6EB40AC0@repository3.orbit-lab.org>
Date: Thu, 7 Mar 2013 16:32:30 -0800
Message-ID: <CAB=NE6Xba3M8QTDpL+2y6uWFxx8_4BZEMJERrLoNkVnnPRwGug@mail.gmail.com>
Subject: Re: Compat-wireless release for 2013-03-07 is baked
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

I've disabled this cronjob, it was faulty given that it would make a
release without checking for the digital signature on tags. I started
then to work on getting the releases to be made if all git trees' HEAD
are signed but given that we manually have to digitally sign a tag for
a new release it seems easy to just rely on the current maintainer to
push out new releases once compilation is verified via ckmake.

Daily snapshots then will be available via:

https://www.kernel.org/pub/linux/kernel/projects/backports/

On the dated directories. Once we get a web page up for the releases
on it there will be a link to the latest release so you don't have to
go hunting for it.

  Luis
