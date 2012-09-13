MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Wed, 12 Sep 2012 17:53:40 -0700
Message-ID: <CAB=NE6Ui1sbvoufjsdgrpUB=CQ=cGe=ztn94Ervn29QEj5UFAA@mail.gmail.com>
Subject: netlink pid --> port id rename
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Just a heads up that I have some work to backport the currently
pending collateral evolution from this patch:

    Author: Eric W. Biederman <ebiederm@xmission.com>
    Date:   Fri Sep 7 20:12:54 2012 +0000

        netlink: Rename pid to portid to avoid confusion

        It is a frequent mistake to confuse the netlink port identifier with a
        process identifier.  Try to reduce this confusion by renaming fields
        that hold port identifiers portid instead of pid.

        I have carefully avoided changing the structures exported to
        userspace to avoid changing the userspace API.

        I have successfully built an allyesconfig kernel with this change.

        Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
        Acked-by: Stephen Hemminger <shemminger@vyatta.com>
        Signed-off-by: David S. Miller <davem@davemloft.net>

I think I'll be done by the end of the day.

  Luis
