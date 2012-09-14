MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1347637262-27782-1-git-send-email-bkamatch@qca.qualcomm.com>
References: <1347637262-27782-1-git-send-email-bkamatch@qca.qualcomm.com>
Date: Fri, 14 Sep 2012 15:28:24 -0700
Message-ID: <CAB=NE6WBLusFkQP-a9mCxM2Hu-NyWvUiF8iALY6YvvbV81eKNg@mail.gmail.com>
Subject: Re: [PATCH 1/4] compat-drivers: update pending-stable patches.
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Bala Shanmugam <bkamatch@qca.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Sep 14, 2012 at 8:40 AM, Bala Shanmugam
<bkamatch@qca.qualcomm.com> wrote:
> Signed-off-by: Bala Shanmugam <bkamatch@qca.qualcomm.com>
> ---

Thanks but these patches do not apply on to the branch
origin/origin/linux-3.6.y. They do however apply on top of the branch
origin/linux-3.5.y... did you intend for these patches to be applied
on top of that branch?

Please be sure to do to be on top of commit
4f298ae180e84c6857af803177f82724ba6cf97c from the origin/linux-3.6.y
branch if you want to send patches for that branch.

Also, we now have a new mailing list, backports@vger.kernel.org,
please subscribe and send future patches there.

  Luis
