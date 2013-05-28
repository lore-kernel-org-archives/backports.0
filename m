Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57778 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3E1TZa (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 15:25:30 -0400
Message-ID: <1369769122.8548.7.camel@jlt4.sipsolutions.net> (sfid-20130528_212531_921012_9500F06E)
Subject: Re: Problem with backports git repo
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	backports@vger.kernel.org
Date: Tue, 28 May 2013 21:25:22 +0200
In-Reply-To: <51A502AD.1060104@lwfinger.net> (sfid-20130528_211707_085177_DE2DD9E0)
References: <51A502AD.1060104@lwfinger.net>
	 (sfid-20130528_211707_085177_DE2DD9E0)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Larry,

> I just used 'git clone' to get a fresh copy of the repo. When I try 'make 
> menuconfig', I get the following error:
> 
> finger@larrylap:~/backports/backport> make menuconfig

The docs haven't been updated, but this is just the skeleton, you're not
supposed to run anything in there. Go to the top-level first, and run

./gentree.py /path/to/linux-next /tmp/output

then in /tmp/output you can run the make/menuconfig whatever. The
versions file and some others are auto-generated.

johannes

