Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51460 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016Ab3K2V0y (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 29 Nov 2013 16:26:54 -0500
Message-ID: <52990695.5000203@hauke-m.de> (sfid-20131129_222656_828905_C7982C53)
Date: Fri, 29 Nov 2013 22:26:45 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Matt Walker <matt.g.d.walker@gmail.com>
CC: backports@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [Patch] Fix for so that recent Elantech touchpads are recognized
 as such
References: <CA+X2d=AuAm3ENDbrfk7L5fXoSiLwVU5xxKVo+MbbCf_aWu=cyg@mail.gmail.com>
In-Reply-To: <CA+X2d=AuAm3ENDbrfk7L5fXoSiLwVU5xxKVo+MbbCf_aWu=cyg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/29/2013 01:00 AM, Matt Walker wrote:
> Hello,
> 
> Attached is a patch for drivers/input/mouse/elantech.c.  It allows
> recent Elantech touchpads to be detected.  I have tested it on the
> touchpad that comes with the Acer Aspire S7-392 (released ~August
> 2013)
> 
> I figure it could be backported with little effort and no danger,
> since all it does it add one to the number of values that were
> previously recognized as valid "firmware version numbers".
> 
> Begin Patch:
> 1315a1316
>>         case 8:
> End Patch
> 
> Best,
> Matt
> 
This is not a patch, I do not know what you want to do.

This is the documentation for hacking on backprts:
https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking

This is the guideline for patch submission to the linux kernel which
mostly also applies for backports:
https://www.kernel.org/doc/Documentation/SubmittingPatches

Hauke
