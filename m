Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <c_manoha@qualcomm.com>
From: Sujith Manoharan <c_manoha@qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <20563.54449.930282.825384@gargle.gargle.HOWL>
Date: Sat, 15 Sep 2012 06:36:57 +0530
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: Bala Shanmugam <bkamatch@qca.qualcomm.com>, Felix Fietkau
	<nbd@openwrt.org>, <linux-wireless@vger.kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH 1/4] compat-drivers: update pending-stable patches.
In-Reply-To: <CAB=NE6UG647WMS7kW=xEFgU=PGMq7fdt7G0k_8sMqkkS9sZkcw@mail.gmail.com>
References: <1347637262-27782-1-git-send-email-bkamatch@qca.qualcomm.com>
	<CAB=NE6WBLusFkQP-a9mCxM2Hu-NyWvUiF8iALY6YvvbV81eKNg@mail.gmail.com>
	<CAB=NE6XYjYrRSA8Xupu21GWoCd-jv63ic32Q3rP7YiVHajTWTg@mail.gmail.com>
	<CAB=NE6UG647WMS7kW=xEFgU=PGMq7fdt7G0k_8sMqkkS9sZkcw@mail.gmail.com>
Return-Path: c_manoha@qca.qualcomm.com
List-ID: <backports@vger.kernel.org>

Luis R. Rodriguez wrote:
> So based on what I think you described you only want these two hunks
> from that patch... to avoid regressions possibly caused by Felix'
> other changes.

This will not cause any regression for AR9462 because the patch does this:

       if (!AR_SREV_9300(ah))
               return;

I think all this confusion would have been avoided if the 3.5.y patches had
just backported Felix's patch. :)

Sujith
