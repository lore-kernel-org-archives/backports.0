Return-Path: <SRS0=LA5M=NC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA46C67863
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 11:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A7820658
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 11:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A7820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJVUD5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:03:57 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47712 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeJVUDz (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Oct 2018 16:03:55 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gEYeT-0000cM-Ee; Mon, 22 Oct 2018 13:45:41 +0200
Message-ID: <1be0fb185e04dd80f57fcf1fe04ddf5491601f3d.camel@sipsolutions.net>
Subject: Re: [Cocci] New release after 1.0.7?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Date:   Mon, 22 Oct 2018 13:45:24 +0200
In-Reply-To: <cf992997-868d-56dc-bd1e-1d2064af4def@broadcom.com> (sfid-20181022_134441_691066_8C44DEE7)
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
         <alpine.DEB.2.20.1808141515280.3371@hadrien>
         <1536564277.3224.7.camel@sipsolutions.net>
         <alpine.DEB.2.20.1809121214160.31876@hadrien>
         <1536747369.3678.11.camel@sipsolutions.net>
         <cf992997-868d-56dc-bd1e-1d2064af4def@broadcom.com>
         (sfid-20181022_134441_691066_8C44DEE7)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2018-10-22 at 13:44 +0200, Arend van Spriel wrote:
> On 9/12/2018 12:16 PM, Johannes Berg wrote:
> > On Wed, 2018-09-12 at 12:14 +0200, Julia Lawall wrote:
> > 
> > > > I see now that the website advertises the 1.0.7 release, however
> > > > 
> > > >  * it's not tagged in git(hub) - all previous releases have a tag
> > > >  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
> > > >    the website
> > > >  * it *looks* like the actual 1.0.7 release was cut from a much newer
> > > >    git commit, likely with the fix?
> > > 
> > > There is now a tag for the official release of 1.0.7 in github.
> > 
> > Great, thanks!
> 
> Were you able to build this tag? I probably have dependency issues on 
> our build server. I tried following the install.txt in coccinelle repo, 
> but still getting failures. Some hints might be useful. The server runs 
> ubuntu trusty which is pretty old of course.

Hmm. I built something, either that tag or the tarball?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
