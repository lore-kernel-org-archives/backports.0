Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48786 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756708AbdJMI5D (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 04:57:03 -0400
Message-ID: <1507885021.2551.35.camel@sipsolutions.net> (sfid-20171013_105707_629766_B0B63F8B)
Subject: Re: [PATCH 1/5] backports: move headers to be clearer
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Fri, 13 Oct 2017 10:57:01 +0200
In-Reply-To: <353bd455-2253-886a-b0ca-9c3777a739e4@broadcom.com> (sfid-20171013_105624_278491_A3259FA4)
References: <20171012210025.7490-1-johannes@sipsolutions.net>
         <353bd455-2253-886a-b0ca-9c3777a739e4@broadcom.com>
         (sfid-20171013_105624_278491_A3259FA4)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-10-13 at 10:56 +0200, Arend van Spriel wrote:
> 
> On 12-10-17 23:00, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Those uapi header files are always needed, so don't mark them as
> > being for wwwan drivers.
> 
> Just nit picking but your finger seem to have stuck on the 'w' key :-
> p

Heh :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
