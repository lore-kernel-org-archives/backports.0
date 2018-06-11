Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:33954 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932894AbeFKMZK (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Jun 2018 08:25:10 -0400
Message-ID: <1528719907.10346.0.camel@sipsolutions.net> (sfid-20180611_142512_279738_06D0F7EF)
Subject: Re: [PATCH] Updating id field in backports genl family
From: Johannes Berg <johannes@sipsolutions.net>
To: Wan-Hua Chang <winnie.chang@cypress.com>,
        backports@vger.kernel.org,
        Aaron Komisar <aaron.komisar@tandemg.com>
Cc: Chi-Hsien.Lin@cypress.com
Date: Mon, 11 Jun 2018 14:25:07 +0200
In-Reply-To: <20180611102947.GA188023@aremote01.aus.cypress.com> (sfid-20180611_123004_861733_D37D3B95)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
         (sfid-20180611_123004_861733_D37D3B95)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-06-11 at 05:29 -0500, Wan-Hua Chang wrote:
> Hi,
> 
> I see the patch causes compiling error becasue family->family is not
> found when LINUX_VERSION >= 3.13
> 
> backports/backport/backport-include/genetlink.h
> struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13
> 
> 
> And in backports/backport/compat/backport-3.13.c line 127 
> 
> family->id = family->family.id
> 
> it looks like this line has done what the patch want to do. Is the
> comprehension correct?

I guess we have to put an ifdef around this ...

Aaron?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
