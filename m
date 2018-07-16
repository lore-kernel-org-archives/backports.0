Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:46832 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPUOl (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 16 Jul 2018 16:14:41 -0400
Message-ID: <1531770284.3265.0.camel@sipsolutions.net> (sfid-20180716_214549_827796_EA950017)
Subject: Re: What distro can run recent backports?
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, backports@vger.kernel.org
Date: Mon, 16 Jul 2018 21:44:44 +0200
In-Reply-To: <1ea772b3-612a-aa1e-8088-069864dc0920@candelatech.com> (sfid-20180716_194913_613717_B65B5B73)
References: <1ea772b3-612a-aa1e-8088-069864dc0920@candelatech.com>
         (sfid-20180716_194913_613717_B65B5B73)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-07-16 at 10:49 -0700, Ben Greear wrote:
> Hello,
> 
> I'm trying to make backports work with my 4.16-ct kernel.  I tried Fedora-27, but it has
> some bug relate to spatch so it cannot run there.

I think it's an upstream spatch bug. You could use an older version and
revert the recent genl_const patch.

I'm on F27 but haven't gotten it to work recently (and am out for the
next ~4 weeks)

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
