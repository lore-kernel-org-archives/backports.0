Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51912 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab3KSXNO (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 19 Nov 2013 18:13:14 -0500
Message-ID: <528BF081.5060201@hauke-m.de> (sfid-20131120_001316_586945_5D0D734A)
Date: Wed, 20 Nov 2013 00:13:05 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Malinen, Jouni" <jouni@qca.qualcomm.com>,
	Jason Mobarak <jam@cozybit.com>
CC: "wcn36xx@lists.infradead.org" <wcn36xx@lists.infradead.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] backports: add support for wcn36xx
References: <CEB1B7E3.2FE54%jouni@qca.qualcomm.com>
In-Reply-To: <CEB1B7E3.2FE54%jouni@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/19/2013 11:53 PM, Malinen, Jouni wrote:
> 
> 
> On 19/11/13 11:54 pm, "Hauke Mehrtens" <hauke@hauke-m.de> wrote:
> 
>> On 11/19/2013 09:45 PM, Jason Mobarak wrote:
>>>  backport/defconfigs/wcn36xx |   13 +++++++++++++
> 
>> Could you add CPTCFG_CFG80211_WEXT=y please otherwise we will get bug
>> reports where people are complaining that iwconfig does not work.
> 
> Which device has wcn36xx and includes iwconfig in the build? Android moved
> to nl80211-based design quite some time ago.. Would someone really look at
> using wcn36xx in something else than Android and to do that with WEXT?
> Making iwconfig not work sounds more like a feature than bug in this
> specific case.
> 
> - Jouni
> 
Hi Jouni,

I am not familiar with Android. If this driver is mostly used in Android
and WEXT isn't used there any more then I am fine with not setting
CPTCFG_CFG80211_WEXT, someone building his own wifi driver in Android
should also be able to activate such an option.

Hauke
