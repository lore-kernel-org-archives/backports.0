Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49647 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbbDYOBd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 10:01:33 -0400
Message-ID: <553B9E3B.8050100@hauke-m.de> (sfid-20150425_160135_150628_03672053)
Date: Sat, 25 Apr 2015 16:01:31 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: use spatch for __genl_const change
References: <1428404334-32289-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1428404334-32289-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/07/2015 12:58 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As newer versions of spatch are now capable of declaring an
> attribute, use that feature to create an spatch for the change
> that changes const to __genl_const.
> 
> This bumps the required version of coccinelle to 1.0.0-rc23
> (which was released over three months ago.)
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  gentree.py                                         |  2 +-
>  .../network/0027-genl-const/genl-const.cocci       | 10 +++++
>  .../network/0027-genl-const/hwsim.patch            | 20 ---------
>  .../network/0027-genl-const/ieee802154.patch       | 20 ---------
>  .../network/0027-genl-const/nfc.patch              | 20 ---------
>  .../network/0027-genl-const/nl80211.patch          | 50 ----------------------
>  6 files changed, 11 insertions(+), 111 deletions(-)
>  create mode 100644 patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
>  delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
>  delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/nfc.patch
>  delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
> 
Thank you for the patch, I applied and pushed it out.

Hauke
