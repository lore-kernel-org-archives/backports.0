Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26991 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755182AbaDGN0o (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 09:26:44 -0400
Date: Mon, 7 Apr 2014 15:26:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
Subject: Re: coccinelle-1.0.0-rc20 compile issue
In-Reply-To: <1396876968.6270.1.camel@jlt4.sipsolutions.net>
Message-ID: <alpine.DEB.2.10.1404071525480.2187@hadrien> (sfid-20140407_152646_464809_102389F6)
References: <534268E2.6060305@kpanic.de>  <alpine.DEB.2.10.1404071128260.3433@hadrien> <53427B88.50606@kpanic.de>  <alpine.DEB.2.10.1404071511510.2187@hadrien>  (sfid-20140407_151346_253698_6843B59A) <1396876968.6270.1.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Mon, 7 Apr 2014, Johannes Berg wrote:

> On Mon, 2014-04-07 at 15:13 +0200, Julia Lawall wrote:
>
> > > I didn't spot any errors. Here's a paste.
> > > http://fpaste.org/92207/39686580/
> >
> > Did you get it from github?  I think there is a problem that github
> > doesn't preserve empty directories.
>
> git in general doesn't, I believe - you should put a dummy file into the
> directory or so.

Luis already proposed to change the makefile to make the directory, if
needed.  I have made that change and sent Stefan a pointer to a patch.

julia
