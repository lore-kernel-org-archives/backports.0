Return-path: <backports-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:61472 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbcHHTIx convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Aug 2016 15:08:53 -0400
In-Reply-To: <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com>
References: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12> <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: gentree fails at no such file compat/crypto-skcipher.c
From: Peter Huewe <peterhuewe@gmx.de>
Date: Mon, 08 Aug 2016 12:05:52 -0700
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <01C20278-FFC0-4346-848F-C3B92F031B4E@gmx.de> (sfid-20160808_210856_020302_42FD4CE3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



Am 8. August 2016 10:35:47 GMT-07:00, schrieb "Luis R. Rodriguez" <mcgrof@kernel.org>:
>On Mon, Aug 8, 2016 at 12:52 AM, Peter Huewe <PeterHuewe@gmx.de> wrote:
>>
>> I'm currently looking into the backports project to figure out how
>hard it would be to add the tpm drivers.
>> However unfortunately the gentree.py script fails, and I cannot
>really explain why:
>>
>> ./gentree.py --clean --git-revision v4.0 /home/peter/linux-next/
>/home/peter/linux-4.0-backport
>> Get original source files from git ...
>> Traceback (most recent call last):
>>   File "./gentree.py", line 1091, in <module>
>>     ret = _main()
>>   File "./gentree.py", line 724, in _main
>>     logwrite=logwrite)
>>   File "./gentree.py", line 862, in process
>>     disable_list = add_automatic_backports(args)
>>   File "./gentree.py", line 276, in add_automatic_backports
>>     automatic_backport_mangle_c_file(f)), 'r'):
>> IOError: [Errno 2] No such file or directory:
>'/home/peter/linux-4.0-backport/compat/crypto-skcipher.c'
>
>If you are trying to use a target v4.0 kernel then you need to
>checkout the linux-4.0.y branch from the backports tree as well.
>
>git checkout -b linux-4.0.y origin/linux-4.0.y
>
>And try again.

Thanks, this was not clear to me.
Should we add that to the wiki maybe?

>But if you are trying to add new drivers, best is to just try the
>master branch of backports against the latest respective linux-next
>tag that backports works against, so in this case backports is at
>backports-20160324, so you can set you linux-next tree to
>next-20160324:
>
>git reset --hard next-20160324
>
>This is because contributions would go to the master branch of
>backports.

About adding new drivers,
if I make only a patch against the master branch,
how do you then get support for older versions? E.g. 4.0.9?

How does the maintenance work? (As I then would also sign up to do the maintenance of the tpm drivers in the backports)

Thanks
Peter
-- 
Sent from my mobile
--
To unsubscribe from this list: send the line "unsubscribe backports" in
