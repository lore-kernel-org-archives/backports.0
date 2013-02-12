Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51816 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758637Ab3BLVSv (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 12 Feb 2013 16:18:51 -0500
Message-ID: <511AB1B3.7090909@hauke-m.de>
Date: Tue, 12 Feb 2013 22:18:43 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] compat-drivers: Add possibility to build every subsystem
 separately
References: <1359916425-2377-1-git-send-email-ozancag@gmail.com> <510EB634.3080704@hauke-m.de> <CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
In-Reply-To: <CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/03/2013 08:19 PM, Ozan Çağlayan wrote:
>>
>> Why are you removing the ifeq ($(BT),) here?
> 
> Well I didn't get what it does. (It seems to switch on/off bluetooth
> but not in an intuitive way) Also it was always set to True without
> user's intervention so I removed it to provoke a discussion about its
> functionality :p

I do not get it neither. ;-)
Could you remove it in a separate patch., in the long term it be nice to
deactivate it like gpu and network independently from the other network
stuff.

>> I think it is better to add all (gpu and network) when nothing specific
>> was given, this way the script does the same when the same parameters
>> are given than it did before.
> 
> Well yes you are right but then we have to change the parameter logic
> to support disabling subsystems, e.g.
> 
> admin-update.sh --disable-network.

Isn't there a away to treat everything as selected if nothing is given
and if something was given just build that particular subsystem.

Hmm, the longer I think about it this also does not sound very nice. I
think your first approach is better, just add the selected subsystems
But a help page should be displayed when nothing was given explaining
what to do.

Hauke

