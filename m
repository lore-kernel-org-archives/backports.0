Return-path: <mcgrof@gmail.com>
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1362477886.8224.0.camel@jlt4.sipsolutions.net>
References: <1362477886.8224.0.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 7 Mar 2013 14:12:40 -0800
Message-ID: <CAB=NE6U-Y9f+X2H94cHf9=3NygMbKysMzzG31e_yuBZmxn8eaA@mail.gmail.com> (sfid-20130307_231303_448552_BE7AC42B)
Subject: Re: [PATCH] compat-wireless: fix netlink portid patch for nl80211
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Mar 5, 2013 at 2:04 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  patches/0005-netlink-portid.patch | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/patches/0005-netlink-portid.patch b/patches/0005-netlink-portid.patch
> index ee9bc85..ebf10b6 100644
> --- a/patches/0005-netlink-portid.patch
> +++ b/patches/0005-netlink-portid.patch

Seems you are running on an old branch where patches were just under
patches. I've massaged this to conform to the new layout on the master
branch. I also modified the subject to indicate compat-drivers instead
of compat-wireless.

Thanks, applied and pushed!

  Luis
