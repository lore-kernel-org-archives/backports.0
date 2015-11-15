Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35653 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbbKOSmh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 13:42:37 -0500
Subject: Re: [PATCH v2] backports: add of_find_property_value_of_size()
To: eliad@wizery.com, emmanuel.grumbach@intel.com
References: <1447588042-27281-1-git-send-email-emmanuel.grumbach@intel.com>
 <1447602799-11759-1-git-send-email-hauke@hauke-m.de>
Cc: backports@vger.kernel.org, eliadx.peller@intel.com
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5648D21A.5020507@hauke-m.de> (sfid-20151115_194239_389779_82C0865D)
Date: Sun, 15 Nov 2015 19:42:34 +0100
MIME-Version: 1.0
In-Reply-To: <1447602799-11759-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/15/2015 04:53 PM, Hauke Mehrtens wrote:
> From: Eliad Peller <eliad@wizery.com>
> 
> commit 2e98a32a274274fca0e6e ("backport: add
> of_property_read_u64_array()") added a call
> to of_find_property_value_of_size(), which is a
> static function, causing compilation error.
> 
> Implement it locally as well.
> 
> Signed-off-by: Eliad Peller <eliadx.peller@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> [remove of_find_property_value_of_size() from backport-3.10.c]
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> 
> I did some changes to this patch, I hope they are ok.
> 
>  backport/backport-include/linux/of.h |  6 +++---
>  backport/compat/backport-3.10.c      | 28 ----------------------------
>  backport/compat/backport-3.18.c      | 28 ++++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 31 deletions(-)
> 

Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
