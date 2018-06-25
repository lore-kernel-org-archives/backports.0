Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:45942 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755335AbeFYQkP (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 25 Jun 2018 12:40:15 -0400
Message-ID: <1529944813.10347.3.camel@sipsolutions.net> (sfid-20180625_184034_777654_D030021A)
Subject: Re: [PATCH] Updating id field in backports genl family
From: Johannes Berg <johannes@sipsolutions.net>
To: Wan-Hua Chang <winnie.chang@cypress.com>, backports@vger.kernel.org
Cc: Chi-Hsien.Lin@cypress.com,
        Aaron Komisar <aaron.komisar@tandemg.com>
Date: Mon, 25 Jun 2018 18:40:13 +0200
In-Reply-To: <20180611102947.GA188023@aremote01.aus.cypress.com> (sfid-20180611_123004_861733_D37D3B95)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
         (sfid-20180611_123004_861733_D37D3B95)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Looking at this again ...

> I see the patch causes compiling error becasue family->family is not
> found when LINUX_VERSION >= 3.13

Yeah, that seems right.

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

I don't think so. We call this function - via
__real_bp_extack_genl_register_family() - on copy->family, so we do need
to copy like Aaron said, we just need to make it conditional for kernel
< 3.13 because on 3.13 we don't use this sub-family thing.

I've committed a fix - does that work for both of you? Aaron?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
