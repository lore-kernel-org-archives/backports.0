Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:61508 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161031Ab3BGVpG (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 7 Feb 2013 16:45:06 -0500
Received: by mail-ve0-f178.google.com with SMTP id db10so2761828veb.37
        for <backports@vger.kernel.org>; Thu, 07 Feb 2013 13:45:05 -0800 (PST)
Message-ID: <51141EBE.9030202@gmail.com>
Date: Thu, 07 Feb 2013 16:38:06 -0500
From: Richard Farina <sidhayn@gmail.com>
MIME-Version: 1.0
To: Graham Burnside <graham@somethingshocking.com>
CC: backports@vger.kernel.org
Subject: Re: 'modprobe -l' usage in Makefile
References: <5112C9FA.7040207@somethingshocking.com>
In-Reply-To: <5112C9FA.7040207@somethingshocking.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/06/2013 04:24 PM, Graham Burnside wrote:
> Hi,
> 
> I tried to use the compat-wireless backport to compile a newer rt2800pci
> diver for my rt3290 device under wheezy (b4).
> 
> The Makefile is horribly broken due to the use of 'modprobe -l'
> throughout, as are a number of the scripts in the scripts/.

I submitted a patch for that which was applied last year some time...
what version are you trying to compile?

-Zero
> 
> Wheezy has moved to kmod, and uses a symlink from modprobe. kmod sees
> '-l' as an invalid arguement.
> 
> 
> -Graham
> 

