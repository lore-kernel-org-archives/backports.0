Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36495 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbbGTRcM (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 13:32:12 -0400
Received: by obnw1 with SMTP id w1so105927526obn.3
        for <backports@vger.kernel.org>; Mon, 20 Jul 2015 10:32:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1507201924530.2475@hadrien>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
 <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com>
 <alpine.DEB.2.10.1507201826320.2475@hadrien> <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com>
 <alpine.DEB.2.10.1507201913370.2475@hadrien> <CAB=NE6UdMhy1WP+apzMKmCwe2eevwRy72h_5f0cx4_aYtQNofQ@mail.gmail.com>
 <alpine.DEB.2.10.1507201924530.2475@hadrien>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 20 Jul 2015 10:31:52 -0700
Message-ID: <CAB=NE6WWVSNUWyZThBe+eXoUCV+RrDuDPjUqa8bJ5Uf0Dw93NQ@mail.gmail.com> (sfid-20150720_193219_479189_AC6A3525)
Subject: Re: [Cocci] [PATCH v2 0/4] pycocci: index opts, SmPL patch proof support
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jul 20, 2015 at 10:25 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Ah, so it should be safe to just check for the glimpse index on the
>> target directory, use it if its there, otherwise default to using
>> --use-gitgrep as a second step should be safe, regardless of whether
>> or not the target (directory or file) is part of a git tree?
>
> Yep.

Great thanks, can you confirm if that safe for Coccinelle 1.0.1 or
will that only be a safe bet for 1.0.2 ? If only safe for 1.0.2 then I
can have it default only for 1.0.2 and for 1.0.2 leave the check in
place?

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
