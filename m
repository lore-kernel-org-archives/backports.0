Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56147 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934426Ab3GWWvw (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 23 Jul 2013 18:51:52 -0400
Received: by mail-lb0-f180.google.com with SMTP id t13so1205708lbd.11
        for <backports@vger.kernel.org>; Tue, 23 Jul 2013 15:51:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374388626.8376.2.camel@jlt4.sipsolutions.net>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
 <1374272009-26152-11-git-send-email-mcgrof@do-not-panic.com> <1374388626.8376.2.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 23 Jul 2013 15:51:29 -0700
Message-ID: <CAB=NE6USWtvHiN=9TLFqT3r-LxTaE5kDygpUXKwSXvDrh1CFLw@mail.gmail.com> (sfid-20130724_005210_217520_27843654)
Subject: Re: [PATCH v2 10/10] backports: lib/kconfig.py - fix src line regexp
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"jani.nikula" <jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jul 20, 2013 at 11:37 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2013-07-19 at 15:13 -0700, Luis R. Rodriguez wrote:
>
>> -src_line = re.compile(r'^source\s+"?(?P<src>[^\s"]*)"?\s*$')
>> +src_line = re.compile(r'^[\s]*source\s+"?(?P<src>[^\s"]*)"?\s*$')
>
> Looks fine, not that I understand why you added [] when you have just a
> single character in there? Might be better to just write "\s*" (without
> the quotes, obviously)

Will update, thanks for the review.

  Lis
