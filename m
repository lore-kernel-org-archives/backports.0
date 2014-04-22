Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33301 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaDVTJc (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 22 Apr 2014 15:09:32 -0400
MIME-Version: 1.0
In-Reply-To: <20140422184908.GA16477@omega>
References: <1397784176-15809-1-git-send-email-mcgrof@do-not-panic.com>
 <1397784176-15809-2-git-send-email-mcgrof@do-not-panic.com>
 <1398159886.4211.1.camel@jlt4.sipsolutions.net> <20140422095300.GA9241@omega>
 <20140422175818.GN27882@wotan.suse.de> <1398192315.4211.25.camel@jlt4.sipsolutions.net>
 <20140422184908.GA16477@omega>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 22 Apr 2014 12:09:09 -0700
Message-ID: <CAB=NE6UW23sjr0kNMtDLashm-=N6+Pekiw58rSdt5UcJXhG=5w@mail.gmail.com> (sfid-20140422_211050_420143_D328D779)
Subject: Re: [PATCH 1/3] 6lowpan: add helper to get 6lowpan namespace
To: Alexander Aring <alex.aring@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 22, 2014 at 11:49 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> On Tue, Apr 22, 2014 at 08:45:15PM +0200, Johannes Berg wrote:
>> On Tue, 2014-04-22 at 19:58 +0200, Luis R. Rodriguez wrote:
>>
>> > > > > +#if IS_ENABLED(CONFIG_IEEE802154_6LOWPAN)
>> > > > > [...]
>> > > > > +#else
>> > > > > +static inline struct netns_ieee802154_lowpan *
>> > > > > +net_ieee802154_lowpan(struct net *net)
>> > > > > +{
>> > > > > +     return NULL;
>> > > > > +}
>> > > > > +#endif
>> > > >
>> > > > Why would that be needed? If nobody compiles 802.15.4 then it seems
>> > > > nothing should reference it?
>> > > >
>> > > Indeed I think this is unnecessary, also.
>> >
>> > I wanted to be sure, and I was not. Right now 6lowpan does not depend
>> > on CONFIG_NET_NS, is this intentional? I think its fine without it
>> > but I was not sure.
>>
>> I fail to see how !CONFIG_LOWPAN is related CONFIG_NET_NS?
>>
>
> mhh, IEEE802154_6LOWPAN depends on IPV6 and I think IPV6 is related to
> CONFIG_NET_NS.

Just test compiled IEEE802154_6LOWPAN without NET_NS and then also
disabled IPV6 and it compiles, IEEE802154_6LOWPAN already depends on
IPV6.

  Luis
