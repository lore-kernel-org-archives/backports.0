Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:32890 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCUISG (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 21 Mar 2018 04:18:06 -0400
Message-ID: <1521620284.2645.13.camel@sipsolutions.net> (sfid-20180321_091810_607661_D630A213)
Subject: Re: Backports gentree fail with v4.12
From: Johannes Berg <johannes@sipsolutions.net>
To: Wan-Hua Chang <winnie.chang@cypress.com>, backports@vger.kernel.org
Cc: chln@cypress.com
Date: Wed, 21 Mar 2018 09:18:04 +0100
In-Reply-To: <20180314094425.GA169496@aremote01.aus.cypress.com> (sfid-20180314_104444_324871_60016084)
References: <20180314094425.GA169496@aremote01.aus.cypress.com>
         (sfid-20180314_104444_324871_60016084)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-03-14 at 04:44 -0500, Wan-Hua Chang wrote:
>  
> ./gentree.py --gitdebug --clean --git-revision v4.12 --copy-list
> ./copy-list.brcmfmac --verbose ~/linux-stable ~/output/v4.12-backports

You can't fix that. You might be able to go back to an older backports
version, but I don't even know if we have one for 4.12.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
