Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:38777 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3FCDRK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 23:17:10 -0400
Received: by mail-bk0-f45.google.com with SMTP id je10so1165470bkc.18
        for <backports@vger.kernel.org>; Sun, 02 Jun 2013 20:17:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130603070014.57b6119c@icy>
References: <1370214733-29993-1-git-send-email-thomas@cozybit.com> <20130603070014.57b6119c@icy>
From: Thomas Pedersen <thomas@cozybit.com>
Date: Sun, 2 Jun 2013 20:16:48 -0700
Message-ID: <CAG6hwVNs0w5we5fkg4j742Oq0uVkhEE4j5Uppcigbs=b3gE_mw@mail.gmail.com> (sfid-20130603_051713_995580_B1BF1ACA)
Subject: Re: [PATCH] backports: specify python2.7 for gentree.py
To: "Anh K. Huynh" <kyanh@viettug.org>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

On Sun, Jun 2, 2013 at 5:00 PM, Anh K. Huynh <kyanh@viettug.org> wrote:
> On Sun,  2 Jun 2013 16:12:13 -0700
> Thomas Pedersen <thomas@cozybit.com> wrote:
>
>> Apparently gentree.py uses some python2.7 specific syntax. Fixes:
>>
>> ./gentree.py -h
>>   File "./gentree.py", line 72
>>     except OSError, e:
>>                   ^
>> SyntaxError: invalid syntax
>>
>> On distros where /usr/bin/python points to python3.
>
> FYI, on ArchLinux, `/usr/bin/python` is 3.0, and the old Python
> (installed by the package `python2`) uses `/usr/bin/python2`.

python2.7 is also provided by the python2 package. Do you think asking
for python2 is a more portable solution?

--
Thomas
