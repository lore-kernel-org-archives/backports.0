Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51852 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbbLUAKh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:10:37 -0500
Subject: Re: [PATCH v3] backports: add ktime_get_boot_ns()
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1450175230-11297-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5677437A.20502@hauke-m.de> (sfid-20151221_011039_083115_6EB25DFD)
Date: Mon, 21 Dec 2015 01:10:34 +0100
MIME-Version: 1.0
In-Reply-To: <1450175230-11297-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 12/15/2015 11:27 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This small helper inline was added in 3.17, we want to use it now
> so need to backport it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/timekeeping.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Thank you for the patch, it was applied and pushed out.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
