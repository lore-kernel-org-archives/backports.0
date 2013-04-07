Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39209 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161252Ab3DGCYY (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:24:24 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so1625507wib.16
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:24:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365281972.8313.2.camel@jlt4.sipsolutions.net>
References: <1365196842-12992-4-git-send-email-thierry.escande@linux.intel.com>
 <1365281972.8313.2.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Sat, 6 Apr 2013 19:24:03 -0700
Message-ID: <CAB=NE6UxtscSgxN6J-YjiBk3zh5whxDxOM3D+244vcr9FGcFUw@mail.gmail.com> (sfid-20130407_042426_399399_86AD40D2)
Subject: Re: [PATCH v3 4/8] backport module_i2c_driver helper macro
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Apr 6, 2013 at 1:59 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Fri, 2013-04-05 at 23:20 +0200, Thierry Escande wrote:
>
>> --- a/backport/include/linux/compat-3.7.h
>> +++ b/backport/include/linux/compat-3.7.h
>
>> +/* This backports:
>> + *
>> + * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
>
> That commit seems to have gone into 3.3, yet you backport for anything <
> 3.7?

This is why I think it would help if we always had the git describe
--contains output for the sha1sum and also the commit log entry on the
upstream kernel.

  Luis
