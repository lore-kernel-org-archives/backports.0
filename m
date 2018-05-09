Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:51144 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964972AbeEIT1N (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 15:27:13 -0400
Message-ID: <1525894030.6910.12.camel@sipsolutions.net> (sfid-20180509_212715_368395_9465770B)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Steve deRosier <derosier@gmail.com>
Cc: masashi.honma@gmail.com, backports@vger.kernel.org
Date: Wed, 09 May 2018 21:27:10 +0200
In-Reply-To: <5AF342A2.1030801@broadcom.com> (sfid-20180509_204909_089738_9E2BF01F)
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
         <1525770549.14830.1.camel@sipsolutions.net>
         <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
         <1525770503.14830.2.camel@sipsolutions.net>
         <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
         <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com>
         <1525850665.6910.0.camel@sipsolutions.net>
         <1525852495.6910.2.camel@sipsolutions.net>
         <2f59e893-da45-f3e7-430b-1377518727bb@gmail.com>
         <1525853548.6910.3.camel@sipsolutions.net>
         <d54cd7c5-fb33-59dc-afd0-d48f36a7a06d@gmail.com>
         <1525856616.6910.7.camel@sipsolutions.net>
         <ba98f466-b6c0-4498-0597-57174b4f7fe5@gmail.com>
         <1525857931.6910.8.camel@sipsolutions.net>
         <CALLGbR+20QS3dpG0xMae+4gtw4osdaucT0OYj_6qj3TMKtp6ag@mail.gmail.com>
         <5AF342A2.1030801@broadcom.com> (sfid-20180509_204909_089738_9E2BF01F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-05-09 at 20:49 +0200, Arend van Spriel wrote:
> 
> Do we have docs :-p Anyway, the gentree script checks the spatch version 
> and seems Johannes already took care of the script as well [1]

Yeah I didn't apply it to any other branches though.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
