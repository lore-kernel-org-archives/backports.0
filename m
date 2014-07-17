Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33681 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbaGQUiz (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Jul 2014 16:38:55 -0400
Received: by mail-la0-f42.google.com with SMTP id pv20so1700956lab.29
        for <backports@vger.kernel.org>; Thu, 17 Jul 2014 13:38:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140717040223.GA3420@qca.qualcomm.com>
References: <20140715154756.GB11952@qca.qualcomm.com> <CAB=NE6U2p+mXW4kLaRkVtL0ytk+eMarsOHhzJh8VEeCjr5M8pg@mail.gmail.com>
 <20140717040223.GA3420@qca.qualcomm.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 17 Jul 2014 13:38:33 -0700
Message-ID: <CAB=NE6W8dMMXCSrFw5i+XvHjZxo44Cc67SUhp0cxdJa3yDJmKw@mail.gmail.com> (sfid-20140717_223857_385522_FAFE04A9)
Subject: Re: Backports based on 3.16.0-rc4
To: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Jul 16, 2014 at 9:02 PM, Rajkumar Manoharan
<rmanohar@qti.qualcomm.com> wrote:
> On Wed, Jul 16, 2014 at 04:25:25PM -0700, Luis R. Rodriguez wrote:
>> On Tue, Jul 15, 2014 at 8:47 AM, Rajkumar Manoharan
>> <rmanohar@qti.qualcomm.com> wrote:
>> > I am in need of the latest backports release based on 3.16.0-rc4. I do
>> > not find it in public server. Please help me to get latest backports
>> > build.
>>
>> I'm afraid backports-3.16-rc1-1 is the latest release. Hopefully Hauke
>> or I can get to an update soon.
>>
> Thanks Luis. multichannel concurrency support in ath9k is merged in
> 3.16.0-rc4. For upgrading backports package in QSDK, we need the latest
> backports build.

Pushed out a 3.16-rc5-1 release just now.

 Luis
