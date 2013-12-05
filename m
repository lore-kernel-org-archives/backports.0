Return-path: <backports-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53330 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750737Ab3LEH6V (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 5 Dec 2013 02:58:21 -0500
Message-Id: <1386230300.25703.55774821.4CE09797@webmail.messagingengine.com> (sfid-20131205_085828_456916_D86E7B29)
From: "Nikita N." <nikitan@operamail.com>
To: Daniel Schultze <kinglag@gmail.com>, backports@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: menuconfig
Date: Wed, 04 Dec 2013 23:58:20 -0800
In-Reply-To: <CAEsx0Y_RwZSks_EqBYY7XxUgiRaX4qP-yrSK4Lx4Mbdi1iqNtQ@mail.gmail.com>
References: <CAEsx0Y_RwZSks_EqBYY7XxUgiRaX4qP-yrSK4Lx4Mbdi1iqNtQ@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Daniel :) Im not a backports maintainer, but I got similar issue with
encryption dependent devices, in fact my kernel was missing ccm option..
maybe you could try to cross-check your kernel options with kconfig
dependance?

On Wed, Dec 4, 2013, at 03:12 PM, Daniel Schultze wrote:
> Hello Developers,
> 
> I'm trying to use backports for its updated Bluetooth drivers on
> Kernel 2.6.31. When I make menu config in LTIB the line for Bluetooth
> support does not appear, however when I make menuconfig for the host
> the line for Bluetooth appears, I'm using the same source archive from
> backports-3.13-rc2-1 and I also tried backports-3.11.8-1 with the same
> result. What should I check to make the Bluetooth line appear?
> 
> -Dan
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
http://www.fastmail.fm - mmm... Fastmail...

