Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39425 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbbDCVeV (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 17:34:21 -0400
Message-ID: <551F075A.4050900@hauke-m.de> (sfid-20150403_233423_488430_BE1794B6)
Date: Fri, 03 Apr 2015 23:34:18 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Mathieu Olivari <mathieu@qca.qualcomm.com>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH] headers: support pre-3.9 (5-args) hashtable macros
References: <1427418083-7987-1-git-send-email-mathieu@qca.qualcomm.com>
In-Reply-To: <1427418083-7987-1-git-send-email-mathieu@qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/27/2015 02:01 AM, Mathieu Olivari wrote:
> Last ath10k makes use of hash tables, which changed in the upstream
> commit:
>  * commit 0bbacca7c3911451cea923b0ad6389d58e3d9ce9
>  * Author: Sasha Levin <sasha.levin@oracle.com>
>  * Date:   Thu Feb 7 12:32:18 2013 +1100
>  *
>  *     hlist: drop the node parameter from iterators
> 
> The list portion of this commit has already been backported, but the
> hashtable part has not. So this change evens it up. It fixes a build
> issue when selecting ath10k on a kernel before 3.9
> 
> Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>

Thank you for the patch it was applied to backports.

Hauke
