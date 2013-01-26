Return-path: <hauke@hauke-m.de>
Message-ID: <510320C8.6010407@hauke-m.de>
Date: Sat, 26 Jan 2013 01:18:16 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless@vger.kernel.org, backports@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] compat: backport nla_put_be{16,32,64}()
References: <1359024296-17724-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1359024296-17724-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

On 01/24/2013 11:44 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> I intend to use these in nl80211.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/linux/compat-3.5.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Thank you for your patch.
I added a missing #include <net/netlink.h> to it.

Hauke
