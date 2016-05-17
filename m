Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52034 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbcEQJJC (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 17 May 2016 05:09:02 -0400
Message-ID: <1463476136.2265.0.camel@sipsolutions.net> (sfid-20160517_110905_186512_722859B2)
Subject: Re: wireless_nlevent_flush backported to stable kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Emmanuel Grumbach <egrumbach@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 17 May 2016 11:08:56 +0200
In-Reply-To: <573ADEF3.8030408@broadcom.com> (sfid-20160517_110608_933524_91834CD9)
References: <CANUX_P1i8MYwsbcnvjbqrHZ77aMOZHZ6ug3VzHvn=3pUU_czyw@mail.gmail.com>
	 <5738467E.4020005@broadcom.com> <1463426768.2179.3.camel@sipsolutions.net>
	 <573ADEF3.8030408@broadcom.com> (sfid-20160517_110608_933524_91834CD9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2016-05-17 at 11:05 +0200, Arend Van Spriel wrote:
> 
> I remember and so the suggestion was to maintain a list of functions
> to check. Or did you pursue that as well with same result?

Well I had it set up that way, compiling a little test thing for each
function. Each one took quite a while, I don't remember the data
though.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
