Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54483 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbbIRNKB (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 18 Sep 2015 09:10:01 -0400
Message-ID: <1442581797.2168.12.camel@sipsolutions.net> (sfid-20150918_151003_741136_D55F11B0)
Subject: Re: [PATCH RFC 1/2] Add required changes for audio packports
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Fri, 18 Sep 2015 15:09:57 +0200
In-Reply-To: <55FC0AFD.9010409@linux.intel.com>
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	 <1442526437-22392-2-git-send-email-pierre-louis.bossart@linux.intel.com>
	 (sfid-20150917_234741_112317_5CC135D1) <1442560549.2168.5.camel@sipsolutions.net>
	 <55FC0AFD.9010409@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-09-18 at 08:00 -0500, Pierre-Louis Bossart wrote:
> 
> This was a first-order ugly backport to revert to what existed 
> before.

Fair enough.

> I have no idea what an spatch is,

A semantic patch (coccinelle)

>  if there is an example of such a 
> 'suitable data structure manipulation' I am all ears.

I don't have an example, but imagine you have this:

old code:
 my_read_data(struct my *my, void *out_buf, int len)

new code:
 my_read_data_sg(struct my *my, struct scatterlist *sg)


Then on old kernels you could do

backport_my_read_data(struct my *my, void *out_buf, int len)
{
 struct scatterlist sg;
 struct sg_ent ent;

 sg.nents = 1;
 sg.ents = &ent;
 ent.data = out_buf;
 ent.len = len;
 my_read_data_sg(&my, &sg);
}

(this absolutely won't compile, just to illustrate the idea)

That basically reduces the old function pointer to the new one with
static code inbetween, and then that can be embedded in an spatch that
automatically adds the wrapper where needed.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
