Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:33983 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbaDGNXE (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 09:23:04 -0400
Message-ID: <1396876968.6270.1.camel@jlt4.sipsolutions.net> (sfid-20140407_152322_100164_8378512C)
Subject: Re: coccinelle-1.0.0-rc20 compile issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
Date: Mon, 07 Apr 2014 15:22:48 +0200
In-Reply-To: <alpine.DEB.2.10.1404071511510.2187@hadrien> (sfid-20140407_151346_253698_6843B59A)
References: <534268E2.6060305@kpanic.de>
	 <alpine.DEB.2.10.1404071128260.3433@hadrien> <53427B88.50606@kpanic.de>
	 <alpine.DEB.2.10.1404071511510.2187@hadrien>
	 (sfid-20140407_151346_253698_6843B59A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2014-04-07 at 15:13 +0200, Julia Lawall wrote:

> > I didn't spot any errors. Here's a paste.
> > http://fpaste.org/92207/39686580/
> 
> Did you get it from github?  I think there is a problem that github
> doesn't preserve empty directories.

git in general doesn't, I believe - you should put a dummy file into the
directory or so.

johannes


