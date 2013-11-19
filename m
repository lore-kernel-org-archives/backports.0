Return-path: <backports-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:57748 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab3KSWxo convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2013 17:53:44 -0500
From: "Malinen, Jouni" <jouni@qca.qualcomm.com>
To: Hauke Mehrtens <hauke@hauke-m.de>, Jason Mobarak <jam@cozybit.com>
CC: "wcn36xx@lists.infradead.org" <wcn36xx@lists.infradead.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] backports: add support for wcn36xx
Date: Tue, 19 Nov 2013 22:53:39 +0000
Message-ID: <CEB1B7E3.2FE54%jouni@qca.qualcomm.com> (sfid-20131119_235346_399770_A87F020A)
In-Reply-To: <528BDDF9.7080400@hauke-m.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 19/11/13 11:54 pm, "Hauke Mehrtens" <hauke@hauke-m.de> wrote:

>On 11/19/2013 09:45 PM, Jason Mobarak wrote:
>>  backport/defconfigs/wcn36xx |   13 +++++++++++++

>Could you add CPTCFG_CFG80211_WEXT=y please otherwise we will get bug
>reports where people are complaining that iwconfig does not work.

Which device has wcn36xx and includes iwconfig in the build? Android moved
to nl80211-based design quite some time ago.. Would someone really look at
using wcn36xx in something else than Android and to do that with WEXT?
Making iwconfig not work sounds more like a feature than bug in this
specific case.

- Jouni

