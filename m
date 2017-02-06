Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39754 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbdBFMhy (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Feb 2017 07:37:54 -0500
Message-ID: <1486384668.5430.3.camel@sipsolutions.net> (sfid-20170206_133858_640666_EE3086A4)
Subject: Re: [Cocci] matching a modified identifier?
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: cocci <cocci@systeme.lip6.fr>,
        backports <backports@vger.kernel.org>
Date: Mon, 06 Feb 2017 13:37:48 +0100
In-Reply-To: <alpine.DEB.2.20.1702061321500.8663@hadrien>
References: <1486380902.5430.1.camel@sipsolutions.net>
         <alpine.DEB.2.20.1702061321500.8663@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> Use python between the two rules to construct the identifier you
> want.

Indeed, that works and is simpler than I thought (had briefly
considered, but then found the workaround)

Thanks :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
