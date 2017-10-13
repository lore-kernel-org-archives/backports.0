Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48878 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdJMJJ3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:09:29 -0400
Message-ID: <1507885767.2551.37.camel@sipsolutions.net> (sfid-20171013_110931_156207_94EFFE7B)
Subject: Re: [PATCH 5/5] backports: add signature verification code
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Fri, 13 Oct 2017 11:09:27 +0200
In-Reply-To: <ce53b46c-e75c-3a37-606b-e40be0ae063f@broadcom.com> (sfid-20171013_110218_691131_412EC474)
References: <20171012210025.7490-1-johannes@sipsolutions.net>
         <20171012210025.7490-5-johannes@sipsolutions.net>
         <ce53b46c-e75c-3a37-606b-e40be0ae063f@broadcom.com>
         (sfid-20171013_110218_691131_412EC474)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

Please trim quotes, your email was 469K :)
(and evolution gets slow replying to that :P)

On Fri, 2017-10-13 at 11:02 +0200, Arend van Spriel wrote:
> On 12-10-17 23:00, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Uh, this was awful. Because the crypto/ things are completely
> > impossible to backport, I've actually implemented this by using
> > mbedtls and embedding the relevant functions it has...
> 
> Interesting approach. I guess the crypto/ things would simply pull
> in  too much new kernel stuff in the compat layer. So how much does
> mbedtls add to compat.ko?

Good question, let's try to compile:

add/remove: 246/0 grow/shrink: 1/0 up/down: 49050/0 (49050)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
