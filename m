Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49112 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbdJMJig (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:38:36 -0400
Message-ID: <1507887514.2551.40.camel@sipsolutions.net> (sfid-20171013_113837_720986_87C1D508)
Subject: Re: [PATCH 5/5] backports: add signature verification code
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Fri, 13 Oct 2017 11:38:34 +0200
In-Reply-To: <2f943e21-1a4f-0863-dc7b-93640f9c4149@broadcom.com> (sfid-20171013_113631_961954_E067CB12)
References: <20171012210025.7490-1-johannes@sipsolutions.net>
         <20171012210025.7490-5-johannes@sipsolutions.net>
         <ce53b46c-e75c-3a37-606b-e40be0ae063f@broadcom.com>
         <1507885767.2551.37.camel@sipsolutions.net>
         <2f943e21-1a4f-0863-dc7b-93640f9c4149@broadcom.com>
         (sfid-20171013_113631_961954_E067CB12)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-10-13 at 11:36 +0200, Arend van Spriel wrote:

> > add/remove: 246/0 grow/shrink: 1/0 up/down: 49050/0 (49050)
> 
> Not sure what tool output this is so I assume it means 49k increase? 
> That looks good I would say.

This was from scripts/bloat-o-meter (kernel sources). And yeah, that's
a hair under 48KiB :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
