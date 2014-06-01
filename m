Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59663 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbaFAWgT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 18:36:19 -0400
Message-ID: <538BAADE.1010502@hauke-m.de> (sfid-20140602_003621_440208_360E6656)
Date: Mon, 02 Jun 2014 00:36:14 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org
CC: Jonathan DE CESCO <jonathan.de.cesco@intel.com>
Subject: Re: [PATCH] backports: Avoid multiple definition of DEVICE_ATTR_RW
 for older kernels
References: <1401113736-13562-1-git-send-email-emmanuel.grumbach@intel.com>
In-Reply-To: <1401113736-13562-1-git-send-email-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/26/2014 04:15 PM, Emmanuel Grumbach wrote:
> From: Jonathan DE CESCO <jonathan.de.cesco@intel.com>
> 
> This definition may exists on non-vanilla kernels.
> 
> Change-Id: Ie72a291e7a5690d2509520a0440cca9926386a9c
> Signed-off-by: Jonathan DE CESCO <jonathan.de.cesco@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  backport/backport-include/linux/device.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
Thank you for the patch, it was applied, pushed and is included in the
backports-20140501 release.

Hauke

