Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:49453 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526AbaDXPuO (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 24 Apr 2014 11:50:14 -0400
Received: by mail-lb0-f178.google.com with SMTP id s7so2120580lbd.23
        for <backports@vger.kernel.org>; Thu, 24 Apr 2014 08:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5358F8AE.6080009@kpanic.de>
References: <53579593.40306@kpanic.de> <1398249715.4173.3.camel@jlt4.sipsolutions.net>
 <5357A065.3020400@kpanic.de> <1398251810.4173.6.camel@jlt4.sipsolutions.net>
 <CAB=NE6W2FqvbkwiTeV-aoOOqzmRqwbjpYkF05sosF4+wg7gY1Q@mail.gmail.com> <5358F8AE.6080009@kpanic.de>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 24 Apr 2014 08:49:53 -0700
Message-ID: <CAB=NE6UVOrxCe+r9kFnCVNe0LdTAVyhgqbhomt0q34QCBwjppA@mail.gmail.com> (sfid-20140424_175019_034603_46CD24E6)
Subject: Re: cocci: multiple versions of function with different arguments
To: Stefan Assmann <sassmann@kpanic.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Apr 24, 2014 at 4:42 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> Here's an example.
> 80d5c3689b886308247da295a228a54df49a44f6 introduces the following change
> to struct net_device_ops.
>         int                     (*ndo_vlan_rx_add_vid)(struct net_device *dev,
> -                                                      unsigned short vid);
> +                                                      __be16 proto, u16 vid);


Yeah that seems reasonable to use Coccinelle for!

  Luis
