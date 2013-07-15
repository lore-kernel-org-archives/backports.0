Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:39822 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757910Ab3GOO3N (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Jul 2013 10:29:13 -0400
To: Ben Guthro <ben@guthro.net>
Subject: Re: problems building backports-3.10-2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 15 Jul 2013 17:28:28 +0300
From: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, backports-owner@vger.kernel.org
In-Reply-To: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com>
 (sfid-20130715_150813_416070_8649FA88)
References: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com>
 (sfid-20130715_150813_416070_8649FA88)
Message-ID: <ea1994fe7088be3dcc5e03aad6ae3c75@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2013-07-15 16:08, Ben Guthro wrote:
> I'm struggling to integrate the backports-3.10-2 release into my
> build, and I'm hoping this is the proper venue to get some answers.

> Am I doing something wrong - or is something broken in this release?

I (partially) built it today, so it's probably on your end.

I suspect you copied it across systems and didn't copy the file 
".local-symbols", make sure you have that.

johannes
